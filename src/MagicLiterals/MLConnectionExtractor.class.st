Class {
	#name : #MLConnectionExtractor,
	#superclass : #MLBasicQueryExtractor,
	#instVars : [
		'sourceConnection'
	],
	#category : #MagicLiterals
}

{ #category : #csv }
MLConnectionExtractor class >> csvReaderOn: aStream [
	^ (NeoCSVReader on: aStream)
			recordClass: MLDatasetItem;
			addField: #queryString: converter: [ :base64String | base64String base64Decoded asString ];
			addIgnoredField;
			addIgnoredField;
			yourself
]

{ #category : #extraction }
MLConnectionExtractor >> extractToTargetFile [
	| metadata pgDB views storedProcedures |
	metadata := PgMetadata database: '' connection: self sourceConnection.
	pgDB := metadata extractMetadata.
	views := pgDB getViews.
	storedProcedures := pgDB getFunctions reject: [ :sp | sp isStub or: [ sp language name ~= 'plpgsql' ] ].
	self targetFile writeStreamDo: [ :s |
		|csvWriter|
		csvWriter := NeoCSVWriter on: s.
		csvWriter nextPut: #('Base64-encoded UTF8 Query' 'Source entity name').
		views do: [ :v | 
			csvWriter nextPut: { (PostgreSQLParser parseSelectQuery: v code) sourceCode asByteArray base64Encoded . v name } ].
		storedProcedures
			do: [ :sp | 
				[ (TreeQuery depthFirst
					collectMatches;
					predicate: #isCRUDQuery asTQPredicate;
					runOn: (PostgreSQLParser parseStoredProcedureBody: sp code) childrenBlock: #children)
						do: [ :queryAST |
							csvWriter nextPut: { queryAST sourceCode asByteArray base64Encoded . sp name } ]
				] on: PSQLParseError do: [ 
				csvWriter nextPut: { nil . sp name } ] ] ]
]

{ #category : #accessing }
MLConnectionExtractor >> sourceConnection [
	^ sourceConnection
]

{ #category : #accessing }
MLConnectionExtractor >> sourceConnection: anObject [
	sourceConnection := anObject
]
