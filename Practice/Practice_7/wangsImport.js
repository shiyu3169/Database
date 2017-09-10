db.user.drop()
db.createCollection("user")
db.user.createIndex( { username: 1 }, { unique: true, sparse: true} )
db.user.insert(
	[
		{
			"username":"ashley",
			"password":"ashley",
			"active": true,
			"addresses" : [
				{
					"street":"170 Commonwealth Avenue",
					"city":"Boston",
					"zip": "02140",
					"state":"Massachusetts",
					"country":"US"
				},
				{
					"street":"10 Park Avenue",
					"city":"Boston",
					"zip": "02140",
					"state":"Massachusetts",
					"country":"US"
				}
			],
			"dateOfCreation": new Date("2014-04-20")
		},
		{
			"username":"jason",
			"password":"jason",
			"active":true,
			"addresses" : [
				{
					"street":"70 Peterbourough Street",
					"city":"Boston",
					"zip": "02145",
					"state":"Massachusetts",
					"country":"US"
				},
				{
					"street":"2 Downtown",
					"city":"Boston",
					"zip": "02143",
					"state":"Massachusetts",
					"country":"US"
				}
			],
			"dateOfCreation": new Date("2015-09-20")
		},
		{
			"username":"admin",
			"password":"admin",
			"active":true,
			"addresses" : [
				{
					"street":"10 Geng Road",
					"city":"Palo Alto",
					"zip": "94303",
					"state":"California",
					"country":"US"
				}
			],
			"dateOfCreation": new Date("2014-01-04")
		},
		{
			"username":"jen",
			"password":"jen",
			"active":false,
			"addresses" : [
				{
					"street":"Geng Road",
					"city":"Palo Alto",
					"zip": "94303",
					"state":"California",
					"country":"US"
				}
			],
			"dateOfCreation": new Date("2013-11-25")
		}
	]
)

db.author.drop()
db.createCollection("author")
db.author.insert(
	[
		  {
		    "first_name":"Danielle",
		    "last_name":"Steel",
		    "dob": new Date("1967-03-02")
		  },
		  {
		    "first_name":"Donald",
		    "last_name":"Knuth",
		    "dob": new Date("1938-10-01")
		  },
		  {
		    "first_name":"Brian",
		    "last_name":"Kernigan",
		    "dob": new Date("1951-02-28")
		  },
		  {
		    "first_name":"Herbert",
		    "last_name":"Schild",
		    "dob": new Date("1951-02-28")
		  },
		  {
		    "first_name":"Larry",
		    "last_name":"Wall",
		    "dob": new Date("1952-09-27")
		  }
	]
)

db.publisher.drop()
db.createCollection("publisher")
db.publisher.createIndex( { name: 1, addresses: 1}, { unique: true, sparse: true} )
db.publisher.insert(
	[
		  {
		    "name":"Random House",
		    "date": new Date("2002-04-23"),
		    addresses: [
		    			{
		    				"street":"1475 Broadway",
						    "city":"New York",
						    "zip": "10019",
						    "state":"New York",
						    "country":"US"
		    			},
		    			{
		    				"street":"375 Hudson Street",
						    "city":"New York",
						    "zip":"10014",
						    "state":"New York",
						    "country":"US"
		    			}
		    ]	    
		  },
		  {
		    "name":"Penguin Publishers",
		    "date": new Date("1998-01-19"),
		    addresses: [
		    			{
				    		"street":"140 Broadway",
						    "city":"New York",
						    "zip":"10013",
						    "state":"New York",
						    "country":"US"
		    			}
		    ]
		  },
		  {
		    "name":"Addison-Wesley",
		    "date": new Date("1994-03-01"),
		    addresses: [
		    			{
		    				"street":"75 Arlington Street",
						    "city":"Boston",
						    "zip":"2116",
						    "state":"Massachusetts",
						    "country":"US"
		    			}
		    ]
		  }
	]
)

db.book.drop()
db.createCollection("book")
db.book.createIndex( { isbn: 1}, { unique: true, sparse: true} )
db.book.insert(
	[
		  {
		    "title":"Southern Lights",
		    "author": {
		    			$ref : "author",
		    			$id : db.author.findOne({
							    				"first_name" : "Danielle",
							    				"last_name" : "Steel"
							    				})._id
		    		  },
		    "isbn":"303041974",
		    "publisher": [
		    				{
		    					$ref : "publisher",
		    					$id : db.publisher.findOne({
		    											name : "Random House"
		    											})._id
		    				},
		    				{
		    					$ref : "publisher",
		    					$id : db.publisher.findOne({
		    											name : "Penguin Publishers"
		    											})._id
		    				},
		    			],
		    "available":true,
		    "pages":2042,
		    "summary":"Danielle Steel sweeps us from a Manhattan courtroom to the Deep South in her powerful new novelâ€”at once a behind-closed-doors look into the heart of a family and a tale of crime and punishment.",
		    "subjects": ["Fiction", "Romance"],
		    "note": [
		    			{
		    				"notesuser":"jason",
		   					 "notebody":"Nice book. Must Read"
		    			},
		    			{
		    				"notesuser":"jen",
		    				"notebody":"Nice book. I have been traveling a lot, so I listened to the audio of this book. I really enjoyed it."
		    			}
		    		],
		    "language":"English"
		  },
		  {
		    "title":"Concrete Mathematics",
		    "author": {
		    			$ref : "author",
		    			$id : db.author.findOne({
							    				"first_name" : "Donald",
							    				"last_name" : "Knuth"
							    				})._id
		    		  },
		    "isbn":"0-203-03803-1",
		    "publisher":"Addison-Wesley",
		    "publisher": [
		    				{
		    					$ref : "publisher",
		    					$id : db.publisher.findOne({
		    											name : "Addison-Wesley"
		    											})._id
		    				}
		    			],
		    "available":"Y",
		    "pages":3524,
		    "summary":"Concrete Mathematics: A Foundation for Computer Science, by Ronald Graham, Donald Knuth, and Oren Patashnik, is a textbook that is widely used in computer-science departments",
		    "subjects": ["Mathematics", "Algebra"],
		    "note": [],
		    "language":"English"
		  }
]
)