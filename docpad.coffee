# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON
docpadConfig = {

	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	# To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

	templateData:

		# Specify some site properties
		site:
			# The production url of our website
			url: "http://softwareniagara.com"

			# Here are some old site urls that you would like to redirect from
			oldUrls: [
				'www.softwareniagara.com',
			]

			# The default title of our website
			title: "Software Niagara"

			# The website description (for SEO)
			description: """
				Software Niagara is a group of designers, developers, and entrepreneurs with a belief that Niagara is a great
		    place to create. And we have the will to make it even better.
      	"""

			# The website keywords (for SEO) separated by commas
			keywords: """
				software, apps, application, development, design, programming, niagara, st catharines, welland, fort erie,
		    port colborne, thorold, beamsville, lincoln
      	"""

			# The website author's name
			author: "Software Niagara"

			# The website author's email
			email: "info@softwareniagara.com"



		# -----------------------------
		# Helper Functions

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page's title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site's title onto it
			if @document.title
				"#{@document.title} | #{@site.title}"
			# if our document does not have it's own title, then we should just use the site's title
			else
				@site.title

		# Get the prepared site/document description
		getPreparedDescription: ->
			# if we have a document description, then we should use that, otherwise use the site's description
			@document.description or @site.description

		# Get the prepared site/document keywords
		getPreparedKeywords: ->
			# Merge the document keywords with the site keywords
			@site.keywords.concat(@document.keywords or []).join(', ')


	# =================================
	# Collections
	# These are special collections that our website makes available to us

	collections:
		# For instance, this one will fetch in all documents that have pageOrder set within their meta data
		pages: (database) ->
			database.findAllLive({pageOrder: $exists: true}, [pageOrder:1,title:1])

		# This one, will fetch in all documents that have the tag "post" specified in their meta data
		posts: (database) ->
			database.findAllLive({relativeOutDirPath:'posts'},[date:-1])

		# This one, will fetch in all documents that have the tag "event" specified in their meta data
		events: (database) ->
			database.findAllLive({relativeOutDirPath:'events/internal'},[date:-1])

		# Fetch all events by Software Niagara
		internal_events: (database) ->
			database.findAllLive({relativeOutDirPath:'events/internal'},[name:-1])

		# Fetch all events by other groups or communities
		external_events: (database) ->
			database.findAllLive({relativeOutDirPath:'events/external'},[name:-1])

		# This one, will fetch in all documents that have the tag "bio" specified in their meta data
		bios: (database) ->
			database.findAllLive({relativeOutDirPath:'bios'},[name:-1])


	# =================================
	# DocPad Events

	# Here we can define handlers for events that DocPad fires
	# You can find a full listing of events on the DocPad Wiki
	events:

		# Server Extend
		# Used to add our own custom routes to the server before the docpad routes are added
		serverExtend: (opts) ->
			# Extract the server from the options
			{server} = opts
			docpad = @docpad

			# As we are now running in an event,
			# ensure we are using the latest copy of the docpad configuraiton
			# and fetch our urls from it
			latestConfig = docpad.getConfig()
			oldUrls = latestConfig.templateData.site.oldUrls or []
			newUrl = latestConfig.templateData.site.url

			# Redirect any requests accessing one of our sites oldUrls to the new site url
			server.use (req,res,next) ->
				if req.headers.host in oldUrls
					res.redirect(newUrl+req.url, 301)
				else
					next()
}


# Export our DocPad Configuration
module.exports = docpadConfig