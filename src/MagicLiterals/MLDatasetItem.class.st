Class {
	#name : #MLDatasetItem,
	#superclass : #Object,
	#instVars : [
		'queryString',
		'startIndexInSource',
		'endIndexInSource',
		'pattern'
	],
	#category : #MagicLiterals
}

{ #category : #accessing }
MLDatasetItem >> endIndexInSource [
	^ endIndexInSource
]

{ #category : #accessing }
MLDatasetItem >> endIndexInSource: anObject [
	endIndexInSource := anObject
]

{ #category : #accessing }
MLDatasetItem >> pattern [
	^ pattern
]

{ #category : #accessing }
MLDatasetItem >> pattern: anObject [
	pattern := anObject
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
