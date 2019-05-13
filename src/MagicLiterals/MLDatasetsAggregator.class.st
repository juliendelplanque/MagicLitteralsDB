"
I aggregate a collection of datasets to allow to store them all in a single csv file.
"
Class {
	#name : #MLDatasetsAggregator,
	#superclass : #Object,
	#instVars : [
		'loaders'
	],
	#category : #MagicLiterals
}

{ #category : #analyzing }
MLDatasetsAggregator class >> allClauseTypes [
	^ #('ALL' 'DISTINCT' 'EXCEPT' 'FETCH' 'FOR' 'FROM' 'GROUPBY' 'HAVING' 'INTERSECT' 'INTO' 'LIMIT' 'OFFSET' 'ONCONFLICT' 'ORDERBY' 'RETURNING' 'SELECT' 'SET' 'UNION' 'USING' 'VALUES' 'WHERE' 'WITH')
]

{ #category : #writing }
MLDatasetsAggregator class >> csvHeader [
	^ {'Base64-encoded UTF8 Query' . 'Query type' . 'Project name'}
		, self allClauseTypes
]

{ #category : #accessing }
MLDatasetsAggregator >> allClauseTypes [
	^ self class allClauseTypes
]

{ #category : #analyzing }
MLDatasetsAggregator >> analyze [
	^ self loaders flatCollect: [ :loader |
		self analyzeDataset: loader load ]
]

{ #category : #analyzing }
MLDatasetsAggregator >> analyzeDataset: aMLDataset [
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
			ast queryType. aMLDataset projectName }
				,
					((clauseTypeToLiteralsCount associations sorted: #key asSortFunction)
						collect: #value) ]
]

{ #category : #accessing }
MLDatasetsAggregator >> csvHeader [
	^ self class csvHeader
]

{ #category : #accessing }
MLDatasetsAggregator >> loaders [
	^ loaders
]

{ #category : #accessing }
MLDatasetsAggregator >> loaders: anObject [
	loaders := anObject
]

{ #category : #writing }
MLDatasetsAggregator >> writeToCSVFile: aFileReference [
	aFileReference
		writeStreamDo: [ :stream | 
			(NeoCSVWriter on: stream)
				nextPut: self csvHeader;
				nextPutAll: self analyze ]
]
