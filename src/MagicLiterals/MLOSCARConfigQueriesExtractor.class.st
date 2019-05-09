Class {
	#name : #MLOSCARConfigQueriesExtractor,
	#superclass : #MLBasicQueryExtractor,
	#instVars : [
		'regexForQueryCleaning'
	],
	#category : #MagicLiterals
}

{ #category : #csv }
MLOSCARConfigQueriesExtractor class >> csvReaderOn: aStream [
	^ (NeoCSVReader on: aStream)
			recordClass: MLDatasetItem;
			addField: #queryString: converter: [ :base64String | base64String base64Decoded asString ];
			addIgnoredField;
			yourself
]

{ #category : #extraction }
MLOSCARConfigQueriesExtractor >> extractRawQueries [
	^ (self sourceFile contents parseXML allElementsNamed: 'ap-sql') collect: [ :xml | 
		xml strings asArray joinUsing: String space ]
]

{ #category : #extraction }
MLOSCARConfigQueriesExtractor >> extractToTargetFile [
	self targetFile writeStreamDo: [ :s |
		|csvWriter|
		csvWriter := NeoCSVWriter on: s.
		csvWriter nextPut: #('Base64-encoded UTF8 Query' 'Original Base64-encoded UTF8 Query').
		self extractRawQueries do: [ :originalQuery |
			|transformedQuery|
			transformedQuery := self regexForQueryCleaning copy: originalQuery replacingMatchesWith: 'replaced_identifier'.
			csvWriter nextPut: { transformedQuery asByteArray base64Encoded . originalQuery  asByteArray base64Encoded } ] ]
]

{ #category : #initialization }
MLOSCARConfigQueriesExtractor >> initialize [
	super initialize.
	self regexForQueryCleaning: '\$\{.+\}' asRegex.
]

{ #category : #accessing }
MLOSCARConfigQueriesExtractor >> regexForQueryCleaning [
	^ regexForQueryCleaning
]

{ #category : #accessing }
MLOSCARConfigQueriesExtractor >> regexForQueryCleaning: anObject [
	regexForQueryCleaning := anObject
]
