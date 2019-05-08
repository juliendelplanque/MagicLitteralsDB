Class {
	#name : #MLDataset,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#category : #MagicLiterals
}

{ #category : #'instance creation' }
MLDataset class >> loadFrom: aFileReference [
	^ aFileReference readStreamDo: [ :s |
		((NeoCSVReader on: s)
			recordClass: MLDatasetItem;
			addIntegerField: #startIndexInSource:;
			addIntegerField: #endIndexInSource:;
			addField: #queryString: converter: [ :base64String | base64String base64Decoded asString ];
			addField: #pattern:;
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
