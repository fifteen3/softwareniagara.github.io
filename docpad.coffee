# The DocPad Configuration File
# It is simply a CoffeeScript Object (Sorry about that!) which is parsed by CSON

docpadConfig = {

  # =================================
  # appData
  # These are variables that will be accessible via our application, such as our custom routes.
  # =================================

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
  # =================================

  templateData:
    site:
      organization: "Software Niagara"

      blurb: "Software Niagara is a grassroots initiative to build a software community in the Niagara Region. We believe that sharing and collaboration will lead to the creation of great software and technology in Niagara."
      
      networks: [
        {
          name: "facebook",
          url: "https://www.facebook.com/softwareniagara",
          slogan: "Like us on Facebook",
          icon: "facebook"
        },{
          name: "twitter",
          url: "https://twitter.com/softwareniagara",
          slogan: "Follow us on Twitter",
          icon: "twitter"
        },{
          name: "googleplus",
          url: "https://plus.google.com/100835796280756308699",
          slogan: "Follow us on Goolge+",
          icon: "google-plus"
        },{
          name: "github",
          url: "https://github.com/softwareniagara",
          slogan: "Fork us on Github",
          icon: "github"
        }
      ]

      url: "http://softwareniagara.com"

      oldUrls: [
        'www.softwareniagara.com',
        'softwareniagara.herokuapp.com'
      ]

      title: "Software Niagara"

      description: """
        When your website appears in search results in say Google, the text here will be shown underneath your website's title.
        """

      keywords: """
       place, your, website, keywoards, here, keep, them, related, to, the, content, of, your, website
       """

    # -----------------------------
    # Helper Functions

    getPreparedTitle: ->
      if @document.title
        "#{@document.title} | #{@site.title}"
      else
        @site.title

    getPreparedDescription: ->
      @document.description or @site.description

    getPreparedKeywords: ->
      @document.keywords or @site.keywords.concat(@document.keywords or []).join(', ')

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
  # =================================

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

module.exports = docpadConfig