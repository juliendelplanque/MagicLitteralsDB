Class {
	#name : #MLDataset,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#category : #MagicLiterals
}

{ #category : #'instance creation' }
MLDataset class >> loadFrom: aFileReference extractor: anExtractorClass [
	^ aFileReference readStreamDo: [ :s |
		((anExtractorClass csvReaderOn: s)
			skipHeader;
			upToEnd) in: [ :items |
				self new
					items: items;
					yourself ] ].
]

{ #category : #accessing }
MLDataset >> items [
	^ items
]

{ #category : #accessing }
MLDataset >> items: anObject [
	items := anObject
]
