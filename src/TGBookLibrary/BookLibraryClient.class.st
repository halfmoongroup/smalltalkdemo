Class {
	#name : #BookLibraryClient,
	#superclass : #Object,
	#instVars : [
		'api',
		'client'
	],
	#category : #'TGBookLibrary-Domain'
}

{ #category : #'api-configuration' }
BookLibraryClient class >> openAPIString [ 

	^'{
  "openapi": "3.0.1",
  "info": {
    "title": "Book Library",
    "description": "This is a sample booklibrary search service.",
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
    },
    {
      "name": "Book Search"
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
      },
      "put": {
        "tags": [
          "Book Management"
        ],
        "operationId": "resetBsook",
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
      },
      "delete": {
        "tags": [
          "Book Management"
        ],
        "operationId": "deleteBook",
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
    },
    "/search/books": {
      "post": {
        "tags": [
          "Book Search"
        ],
        "operationId": "searchBooks",
        "requestBody": {
          "content": {
            "*/*": {
              "schema": {
                "$ref": "#/components/schemas/BookSearch"
              }
            }
          },
          "required": false
        },
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
        },
        "x-codegen-request-body-name": "body"
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
          "author": {
            "type": "string"
          },
          "imageUrl": {
            "type": "string"
          },
          "smallImageUrl": {
            "type": "string"
          },
          "originalPublicationYear": {
            "type": "integer",
            "format": "int32"
          },
          "bookId": {
            "type": "string"
          },
          "languageCode": {
            "type": "string"
          }
        }
      },
      "BookSearch": {
        "type": "object",
        "properties": {
          "title": {
            "type": "string"
          },
          "author": {
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

{ #category : #accessing }
BookLibraryClient >> api [
	^ api
]

{ #category : #accessing }
BookLibraryClient >> api: anObject [
	api := anObject
]

{ #category : #accessing }
BookLibraryClient >> client [
	^ client
]

{ #category : #accessing }
BookLibraryClient >> client: anObject [
	client := anObject
]

{ #category : #api }
BookLibraryClient >> fetchRawBookList [

	^client operationWithId: 'getBooks' arguments: nil body: nil.
]

{ #category : #api }
BookLibraryClient >> fetchRawBookWithId: anId [
	^client operationWithId: 'getBook' arguments: {#id -> anId} body: nil.
]

{ #category : #initialization }
BookLibraryClient >> initializeWithClient: aClient [
	client := aClient
]

{ #category : #initialization }
BookLibraryClient >> initializeWithUrl: aURL [

	api := OpenAPI readFrom: (self class openAPIString)  readStream.
	client := OpenApiClient new baseUri: aURL; openApi: api
]

{ #category : #api }
BookLibraryClient >> putBook: aBook [ 

	 ^client operationWithId: 'putBook' arguments: nil body: (aBook toJson).
]

{ #category : #api }
BookLibraryClient >> removeBook: aBookId [

	^client operationWithId: 'deleteBook' arguments: {#id -> aBookId}  body: nil.
]

{ #category : #api }
BookLibraryClient >> resetBook: aBook [

	^client operationWithId: 'resetBook' arguments: {#id -> (aBook bookId)} body: nil.
]
