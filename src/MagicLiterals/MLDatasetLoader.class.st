Class {
	#name : #MLDatasetLoader,
	#superclass : #Object,
	#instVars : [
		'csvFileToLoad',
		'extractor'
	],
	#category : #MagicLiterals
}

{ #category : #accessing }
MLDatasetLoader >> csvFileToLoad [
	^ csvFileToLoad
]

{ #category : #accessing }
MLDatasetLoader >> csvFileToLoad: anObject [
	csvFileToLoad := anObject
]

{ #category : #accessing }
MLDatasetLoader >> extractorClass [
	^ extractor
]

{ #category : #accessing }
MLDatasetLoader >> extractorClass: anObject [
	extractor := anObject
]

{ #category : #actions }
MLDatasetLoader >> load [
	^ self csvFileToLoad readStreamDo: [ :s |
		((self extractorClass csvReaderOn: s)
			skipHeader;
			upToEnd) in: [ :items |
				MLDataset new
					items: items;
					yourself ] ]
]

{ #category : #actions }
MLDatasetLoader >> load: aFileReference [
	self csvFileToLoad: aFileReference.
	^ self load
]
