Class {
	#name : #BookLibTest,
	#superclass : #TestCase,
	#instVars : [
		'bookLibrary',
		'client'
	],
	#category : #'TGBookLibrary-Tests'
}

{ #category : #accessing }
BookLibTest >> bookLibrary [
	^ bookLibrary
]

{ #category : #accessing }
BookLibTest >> bookLibrary: anObject [
	bookLibrary := anObject
]

{ #category : #running }
BookLibTest >> setUp [
	super setUp.
	client := BookTestClient new. 
	client initialize.
	bookLibrary := BookLib new initializeWithClient: client. 
	
	

]

{ #category : #tests }
BookLibTest >> testFetchAList [
	self bookLibrary fetchList.
	self assert: (self bookLibrary books) isNotEmpty.
]

{ #category : #tests }
BookLibTest >> testIsInCache [

	| book|
	
	self bookLibrary fetchList. 
	book :=  self bookLibrary books at: 1. 
	self assert: (bookLibrary isInCache: book).
	book := BookTestClient randomBook.
	self assert: (bookLibrary isInCache: book) equals: false
]

{ #category : #tests }
BookLibTest >> testIsValidForSave [
		|book |
		book := Book new. 
		self assert: (bookLibrary isValidForSave: book) equals: false. 
		book author: 'Bob'.
		self assert: (bookLibrary isValidForSave: book) equals: false. 
		book title: 'a title'.
		self assert: (bookLibrary isValidForSave: book). 
]

{ #category : #tests }
BookLibTest >> testListContainsBook [

	|bookId book|
	
	self bookLibrary fetchList. 
	bookId :=  client getFirstBookId.
	book := self bookLibrary fetchBookWithId: bookId.
	self assert: bookId  equals:  book bookId.
	
]
