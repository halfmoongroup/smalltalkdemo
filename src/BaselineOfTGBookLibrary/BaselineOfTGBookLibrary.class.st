Class {
	#name : #BaselineOfTGBookLibrary,
	#superclass : #BaselineOf,
	#category : #BaselineOfTGBookLibrary
}

{ #category : #baselines }
BaselineOfTGBookLibrary >> baseline: spec [ 
	<baseline>
	self openAPI: spec. 
	spec 
		for: #common 
		do: [  
			self openAPI: spec. 
			spec 
					package: 'TG-BookLibrary'
		]

	
]

{ #category : #'as yet unclassified' }
BaselineOfTGBookLibrary >> openAPI: spec [ 
	spec
		baseline: 'OpenAPI'
		with: [ spec repository: 'https://github.com/zweidenker/OpenAPI/src' ]
]

{ #category : #accessing }
BaselineOfTGBookLibrary >> projectClass [ 

	^MetacelloCypressBaselineProject 
]
