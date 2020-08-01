Class {
	#name : #BookTest,
	#superclass : #TestCase,
	#instVars : [
		'book'
	],
	#category : #'TGBookLibrary-Tests'
}

{ #category : #'tests - object' }
BookTest class >> bookJson [

^ '{
	"author" : "name",
	"bookId" : "55",
	"title" : "The Book Title",
	"originalPublicationYear" : 2020,
	"imageUrl" : "http://localhost/image.jpg",
	"smallImageUrl" : "http://localhost/sm_image.jpg"
}'
]

{ #category : #running }
BookTest >> setUp [ 

	book := Book new author: 'name';
				bookId: '55';
				title: 'The Book Title';
				originalPublicationYear: 2020;
				smallImageUrl: 'http://localhost/sm_image.jpg';
				imageUrl: 'http://localhost/image.jpg'.
]

{ #category : #tests }
BookTest >> testCreateJson [
	| jsonStr | 
	
	jsonStr := book toJson.
	self assert: jsonStr notNil.
	self assert: jsonStr equals: (self class bookJson)
]
