Class {
	#name : #BookLib,
	#superclass : #Object,
	#instVars : [
		'client',
		'books',
		'page',
		'pageSize'
	],
	#category : #'TGBookLibrary-Domain'
}

{ #category : #'api-configuration' }
BookLib class >> openAPIString [
	^'{
   "openapi": "3.0.1",
   "info": {
      "title": "Book Library",
      "description": "This is a sample booklibrary server.",
      "version": "1.0.0"
   },
   "servers": [
      {
         "url": "/"
      }
   ],
   "tags": [
      {
         "name": "Book Library Resources",
         "description": "manage books"
      },
      {
         "name": "Book Management"
      }
   ],
   "paths": {
      "/library/book": {
         "post": {
            "tags": [
               "Book Management"
            ],
            "operationId": "putBook",
            "requestBody": {
               "content": {
                  "application/json": {
                     "schema": {
                        "$ref": "#/components/schemas/Book"
                     }
                  }
               },
               "required": false
            },
            "responses": {
               "200": {
                  "description": "Post a book instance",
                  "content": {
                     "application/json": {
                        "schema": {
                           "$ref": "#/components/schemas/Book"
                        }
                     }
                  }
               },
               "400": {
                  "description": "Invalid book supplied",
                  "content": {
                     "application/json": {
                        "schema": {
                           "$ref": "#/components/schemas/BookError"
                        }
                     }
                  }
               },
               "406": {
                  "description": "Do not set bookid on creation",
                  "content": {
                     "application/json": {
                        "schema": {
                           "$ref": "#/components/schemas/BookError"
                        }
                     }
                  }
               }
            },
            "x-codegen-request-body-name": "body"
         }
      },
      "/library/book/{id}": {
         "get": {
            "tags": [
               "Book Management"
            ],
            "operationId": "getBook",
            "parameters": [
               {
                  "name": "id",
                  "in": "path",
                  "required": true,
                  "schema": {
                     "type": "string"
                  }
               }
            ],
            "responses": {
               "200": {
                  "description": "Get a book instance",
                  "content": {
                     "application/json": {
                        "schema": {
                           "$ref": "#/components/schemas/Book"
                        }
                     }
                  }
               },
               "400": {
                  "description": "Invalid book id supplied",
                  "content": {
                     "application/json": {
                        "schema": {
                           "$ref": "#/components/schemas/BookError"
                        }
                     }
                  }
               },
               "404": {
                  "description": "Book not found",
                  "content": {
                     "application/json": {
                        "schema": {
                           "$ref": "#/components/schemas/BookError"
                        }
                     }
                  }
               }
            }
         }
      },
      "/library/books": {
         "get": {
            "tags": [
               "Book Management"
            ],
            "operationId": "getBooks",
            "responses": {
               "200": {
                  "description": "Get a book instance",
                  "content": {
                     "application/json": {
                        "schema": {
                           "$ref": "#/components/schemas/BookList"
                        }
                     }
                  }
               },
               "400": {
                  "description": "Invalid book id supplied",
                  "content": {
                     "application/json": {
                        "schema": {
                           "type": "string"
                        }
                     }
                  }
               }
            }
         }
      }
   },
   "components": {
      "schemas": {
         "BookList": {
            "type": "object",
            "properties": {
               "count": {
                  "type": "integer",
                  "format": "int32"
               },
               "books": {
                  "type": "array",
                  "items": {
                     "$ref": "#/components/schemas/Book"
                  }
               }
            }
         },
         "Book": {
            "type": "object",
            "properties": {
               "title": {
                  "type": "string"
               },
               "publisher": {
                  "type": "string"
               },
               "author": {
                  "type": "string"
               },
               "published": {
                  "type": "integer",
                  "format": "int32"
               },
               "bookId": {
                  "type": "string"
               }
            }
         },
         "BookError": {
            "type": "object",
            "properties": {
               "code": {
                  "type": "integer",
                  "format": "int32"
               },
               "message": {
                  "type": "string"
               }
            }
         }
      }
   }
}'
]

{ #category : #adding }
BookLib >> addBook: aBook [
	aBook bookId ifNil: [ 
			aBook bookId: (self books size). 
			self books add: aBook].
	client operationWithId: 'putBook' arguments: nil body: aBook toJson .
]

{ #category : #accessing }
BookLib >> books [
	^ books
]

{ #category : #accessing }
BookLib >> books: aList [
	books := aList
]

{ #category : #accessing }
BookLib >> cache: aBook [

	self books detect: [ :each | aBook bookId = each bookId ]  
		ifNone: [ self addBook: aBook ]
]

{ #category : #accessing }
BookLib >> client [
	^ client
]

{ #category : #accessing }
BookLib >> client: anObject [
	client := anObject
]

{ #category : #'accessing - data' }
BookLib >> fetchBookWithId: anId [
	| booksWithId |
 
	books ifNil: [ books := self fetchList].
	booksWithId := books select: [ :each | (anId asString) = each bookId ].
	booksWithId isNotEmpty 
		ifTrue: [   ^booksWithId at: 1 ]
		ifFalse: [  ^client fetchRawBookWithId: anId ]
]

{ #category : #'accessing - data' }
BookLib >> fetchList [
	| jsonData | 
	jsonData := client fetchRawBookList.
	books := ((jsonData at: 'books') collect: [ :each | Book fromJson: each ]).
	^books
]

{ #category : #initialization }
BookLib >> initialize [ 
	pageSize := 10.
	page :=1.
]

{ #category : #initialization }
BookLib >> initializeWithClient: aClient [
	self initialize.
	client := aClient  .
	
	 
	
]

{ #category : #initialization }
BookLib >> initializeWithUrl: url [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
	self initialize.
	client := BookLibraryClient new initializeWithUrl: url .
	
	 
	
]

{ #category : #testing }
BookLib >> isInCache: aBook [

	^self books contains: [ :each | aBook bookId = each bookId ]
]

{ #category : #testing }
BookLib >> isValidForSave: aBook [

	^(aBook notNil) and: (aBook author notNil); and:(aBook title  notNil)
]

{ #category : #accessing }
BookLib >> page [
	^ page
]

{ #category : #accessing }
BookLib >> page: anInt [
	page := anInt
]

{ #category : #accessing }
BookLib >> pageSize [
	^ pageSize
]

{ #category : #accessing }
BookLib >> pageSize: anInt [
	pageSize := anInt
]

{ #category : #removing }
BookLib >> removeBook: aBook [
	self books remove: aBook. 
	self client removeBook: aBook. 
]

{ #category : #'accessing - data' }
BookLib >> saveBook: aBook [
	
	self cache: aBook. 
	
]
