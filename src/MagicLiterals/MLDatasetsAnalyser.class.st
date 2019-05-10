"
I analyse a collection of datasets and provide statistics about them.
"
Class {
	#name : #MLDatasetsAnalyser,
	#superclass : #Object,
	#instVars : [
		'loaders'
	],
	#category : #MagicLiterals
}

{ #category : #analyzing }
MLDatasetsAnalyser class >> allClauseTypes [
	^ #('ALL' 'DISTINCT' 'EXCEPT' 'FETCH' 'FOR' 'FROM' 'GROUPBY' 'HAVING' 'INTERSECT' 'INTO' 'LIMIT' 'OFFSET' 'ONCONFLICT' 'ORDERBY' 'RETURNING' 'SELECT' 'SET' 'UNION' 'USING' 'VALUES' 'WHERE' 'WITH')
]

{ #category : #analyzing }
MLDatasetsAnalyser >> allClauseTypes [
	^ self class allClauseTypes
]

{ #category : #analyzing }
MLDatasetsAnalyser >> analyze [
	^ self loaders flatCollect: [ :loader |
		self analyzeDataset: loader load ]
]

{ #category : #analyzing }
MLDatasetsAnalyser >> analyzeDataset: aMLDataset [
	| clauseTypeToLiteralsCount |
	^ aMLDataset items
		collect: [ :aMLDatasetItem | 
			| ast literals |
			ast := aMLDatasetItem ast.
			literals := ast literalNodes.
			clauseTypeToLiteralsCount := (literals
				groupedBy: #nameOfClauseInWhichItIs) collect: #size.
			self allClauseTypes
				do:
					[ :clauseType | clauseTypeToLiteralsCount at: clauseType ifAbsentPut: 0 ].
			{aMLDatasetItem queryString ifNotNil: [ :s | s asByteArray base64Encoded ].
			ast queryType}
				,
					((clauseTypeToLiteralsCount associations sorted: #key asSortFunction)
						collect: #value) ]
]

{ #category : #accessing }
MLDatasetsAnalyser >> loaders [
	^ loaders
]

{ #category : #accessing }
MLDatasetsAnalyser >> loaders: anObject [
	loaders := anObject
]

{ #category : #writing }
MLDatasetsAnalyser >> writeToCSVFile: aFileReference [
	aFileReference writeStreamDo: [ :stream |
		(NeoCSVWriter on: stream)
			nextPut: { 'Base64-encoded UTF8 Query'. 'Query type' } , self allClauseTypes;
			nextPutAll: self analyze ]
]
