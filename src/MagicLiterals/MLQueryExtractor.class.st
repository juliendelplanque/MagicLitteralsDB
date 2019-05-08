"
I use an heuristic to extract queries from a SQL script.
"
Class {
	#name : #MLQueryExtractor,
	#superclass : #Object,
	#instVars : [
		'sourceFile',
		'targetFile',
		'pattern',
		'parserSelector'
	],
	#category : #MagicLiterals
}

{ #category : #extraction }
MLQueryExtractor >> extractASTFrom: aString [
	^ PostgreSQLParser new perform: self parserSelector withArguments: { aString . false }
]

{ #category : #extraction }
MLQueryExtractor >> extractIndexesToQueriesAssociations [
	^ self extractMatchingIndexesForPattern collect: [ :index |
		self sourceFile readStreamDo: [ :stream |
		stream skip: index.
		[ |astNode|
			astNode := self extractASTFrom: (stream next: 2000).
			astNode sourceCode: (astNode sourceCode copyFrom: astNode startPosition to: astNode endPosition).
			index -> astNode
		] on: Error, Warning do: [ :err | index -> err ] ] ]	.
]

{ #category : #extraction }
MLQueryExtractor >> extractMatchingIndexesForPattern [
	^ (self sourceFile contents allRangesOfRegexMatches: self pattern)
		collect: [ :interval | interval first - 1 ]
]

{ #category : #extraction }
MLQueryExtractor >> extractToTargetFile [
	self targetFile writeStreamDo: [ :s |
		|csvWriter|
		csvWriter := NeoCSVWriter on: s.
		csvWriter nextPut: #('Start character position' 'End character position' 'Base64-encoded UTF8 Query' 'Pattern used for extraction').
		self extractIndexesToQueriesAssociations collect: [ :assoc |
			|index ast|
			index := assoc key.
			ast := assoc value.
			(ast isKindOf: Exception)
				ifFalse: [ 
					csvWriter nextPut: { index . index + (ast endPosition - (ast startPosition - 1)) . ast sourceCode asByteArray base64Encoded . self pattern } ]
				ifTrue: [ csvWriter nextPut: { index . -1 . '' . self pattern } ] ] ].
]

{ #category : #guessing }
MLQueryExtractor >> guessParserSelector [
	(#(SELECT INSERT UPDATE DELETE) includes: self pattern)
		ifFalse: [ self error: 'Could not guess parser selector, please set it manually using #parserSelector: message.' ].
		
	^ ('parse{1}Query:upToEnd:' format: { self pattern asLowercase  asCamelCase }) asSymbol
]

{ #category : #accessing }
MLQueryExtractor >> parserSelector [
	^ parserSelector ifNil: [ parserSelector := self guessParserSelector ]
]

{ #category : #accessing }
MLQueryExtractor >> parserSelector: anObject [
	parserSelector := anObject
]

{ #category : #accessing }
MLQueryExtractor >> pattern [
	^ pattern
]

{ #category : #accessing }
MLQueryExtractor >> pattern: anObject [
	pattern := anObject
]

{ #category : #accessing }
MLQueryExtractor >> sourceFile [
	^ sourceFile
]

{ #category : #accessing }
MLQueryExtractor >> sourceFile: anObject [
	sourceFile := anObject
]

{ #category : #accessing }
MLQueryExtractor >> targetFile [
	^ targetFile
]

{ #category : #accessing }
MLQueryExtractor >> targetFile: anObject [
	targetFile := anObject
]
