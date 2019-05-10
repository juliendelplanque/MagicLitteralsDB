Extension { #name : #PSQLASTCRUDQuery }

{ #category : #'*MagicLiterals' }
PSQLASTCRUDQuery >> queryType [
	"Returns the kind of query it is for building the analysis results."
	^ self subclassResponsibility
]
