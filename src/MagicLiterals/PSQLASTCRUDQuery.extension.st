Extension { #name : #PSQLASTCRUDQuery }

{ #category : #'*MagicLiterals' }
PSQLASTCRUDQuery >> literalNodes [
	^ TreeQuery depthFirst
		collectMatches;
		predicate: #isConstant asTQPredicate;
		runOn: self childrenBlock: #children
]

{ #category : #'*MagicLiterals' }
PSQLASTCRUDQuery >> queryType [
	"Returns the kind of query it is for building the analysis results."
	^ self subclassResponsibility
]
