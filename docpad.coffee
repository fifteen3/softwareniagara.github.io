# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON
docpadConfig = {

  # =================================
  # appData
  appData:
    # The api key for Mandrill
    mandrillKey: process.env.SNWWW_MANDRILL_KEY

    emails: {
      to: [
        {
          name: process.env.SNWWW_EMAIL_NAME,
          email: process.env.SNWWW_EMAIL_ADDRESS
        }
      ],
      from: {
        name: process.env.SNWWW_EMAIL_NAME,
        email: process.env.SNWWW_EMAIL_ADDRESS
      }
    }

    database: {
      development: 'mongodb://localhost/softwareniagara-www-dev',
      test: 'mongodb://localhost/softwareniagara-www-test',
      production: process.env.MONGOLAB_URI
    }

  # =================================
  # Template Data
  # These are variables that will be accessible via our templates
  # To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

  templateData:

    # Specify some site properties
    site:
      # The organization name
      organization: "Software Niagara"

      # A blurb describing the organization
      blurb: "Software Niagara is a grassroots initiative to build a software community in the Niagara Region. We believe that sharing and collaboration will lead to the creation of great software and technology in Niagara."
      
      # Social networks
      networks: [
        {
          name: "facebook",
          url: "htts://www.facebook.com/softwareniagara",
          slogan: "Like us on Facebook"
        },{
          name: "twitter",
          url: "http://twitter.com/softwareniagara",
          slogan: "Follow us on Twitter"
        },{
          name: "googleplus",
          url: "https://plus.google.com/100835796280756308699",
          slogan: "Follow us on Goolge+"
        },{
          name: "github",
          url: "https://github.com/softwareniagara",
          slogan: "Fork us on Github"
        }
      ]

      # The production url of our website
      url: "http://softwareniagara.com"

      # Here are some old site urls that you would like to redirect from
      oldUrls: [
        'www.softwareniagara.com',
        'softwareniagara.herokuapp.com'
      ]

      # The default title of our website
      title: "Your Website"

      # The website description (for SEO)
      description: """
        When your website appears in search results in say Google, the text here will be shown underneath your website's title.
        """

      # The website keywords (for SEO) separated by commas
      keywords: """
       place, your, website, keywoards, here, keep, them, related, to, the, content, of, your, website
       """

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

    getGruntedStyles: ->
      _ = require 'underscore'
      styles = []
      gruntConfig = require('./grunt-config.json')
      _.each gruntConfig, (value, key) ->
        styles = styles.concat _.flatten _.pluck value, 'dest'
      styles = _.filter styles, (value) ->
        return value.indexOf('.min.css') > -1
      _.map styles, (value) ->
        return value.replace 'out', ''

    getGruntedScripts: ->
      _ = require 'underscore'
      scripts = []
      gruntConfig = require('./grunt-config.json')
      _.each gruntConfig, (value, key) ->
        scripts = scripts.concat _.flatten _.pluck value, 'dest'
      scripts = _.filter scripts, (value) ->
        return value.indexOf('.min.js') > -1
      _.map scripts, (value) ->
        return value.replace 'out', ''


  # =================================
  # DocPad Collections
  collections:
    pages: ->
      @getCollection('html').findAllLive({isPage:true})
    
    organizers: (database)->
      database.findAllLive({relativeOutDirPath:'organizers'}, [title: 1])

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
      routes = require(__dirname+'/routes.js')(server,docpad)

    # Write After
    # Used to minify our assets with grunt
    writeAfter: (opts,next) ->
      # Prepare
      docpad = @docpad
      rootPath = docpad.config.rootPath
      balUtil = require 'bal-util'
      _ = require 'underscore'

      # Make sure to register a grunt `default` task
      command = ["#{rootPath}/node_modules/.bin/grunt", 'default']
      
      # Execute
      balUtil.spawn command, {cwd:rootPath,output:true}, ->
        src = []
        gruntConfig = require './grunt-config.json'
        _.each gruntConfig, (value, key) ->
          src = src.concat _.flatten _.pluck value, 'src'
        _.each src, (value) ->
          balUtil.spawn ['rm', value], {cwd:rootPath, output:false}, ->
        balUtil.spawn ['find', '.', '-type', 'd', '-empty', '-exec', 'rmdir', '{}', '\;'], {cwd:rootPath+'/out', output:false}, ->
        next()

      # Chain
      @
}

# Export our DocPad Configuration
module.exports = docpadConfig