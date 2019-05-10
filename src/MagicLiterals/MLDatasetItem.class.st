Class {
	#name : #MLDatasetItem,
	#superclass : #Object,
	#instVars : [
		'queryString',
		'startIndexInSource',
		'endIndexInSource'
	],
	#category : #MagicLiterals
}

{ #category : #accessing }
MLDatasetItem >> ast [
	^ [ 
		PostgreSQLParser parseCRUDQuery: (self queryString ifNil: [ MLNullQuery new ])
	]
		on: Error
		do: [ MLNullQuery new ]
]

{ #category : #accessing }
MLDatasetItem >> endIndexInSource [
	^ endIndexInSource
]

{ #category : #accessing }
MLDatasetItem >> endIndexInSource: anObject [
	endIndexInSource := anObject
]

{ #category : #'as yet unclassified' }
MLDatasetItem >> gtSourceCodeIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite text
		title: 'Query';
		display: [ self  ];
		format: [ :item | item queryString ];
		withLineNumbers: true;
		yourself
]

{ #category : #accessing }
MLDatasetItem >> queryString [
	^ queryString
]

{ #category : #accessing }
MLDatasetItem >> queryString: anObject [
	queryString := anObject
]

{ #category : #accessing }
MLDatasetItem >> startIndexInSource [
	^ startIndexInSource
]

{ #category : #accessing }
MLDatasetItem >> startIndexInSource: anObject [
	startIndexInSource := anObject
]
