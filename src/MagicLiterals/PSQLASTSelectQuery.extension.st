Extension { #name : #PSQLASTSelectQuery }

{ #category : #'*MagicLiterals' }
PSQLASTSelectQuery >> clauseType [
	"This is a hack because the SELECT clause is not reified in the AST."
	^ 'SELECT'
]

{ #category : #'*MagicLiterals' }
PSQLASTSelectQuery >> queryType [
	^ 'SELECT'
]
