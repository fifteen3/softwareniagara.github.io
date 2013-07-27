This site is based on [Jekyll](http://jekyllrb.com/). If you're new to Jekyll, take a look at
[Jekyll's directory structure](http://jekyllrb.com/docs/structure/) so you know what goes where.

## Markup formats

Jekyll supports two popular content markup formats: [Markdown](http://daringfireball.net/projects/markdown/)
and [Textile](http://hobix.github.io/hobix/textile/). ONLY USE MARKDOWN WHEN CONTRIBUTING TO THIS WEBSITE.

## Creating posts

### Creating slides

Place slides for the home page in `_posts/slides/`. They should be named in the format `YEAR-MONTH-DAY-title.MARKUP`.
For example `2011-12-31-slap-chop.md` or `2012-09-12-sham-wow.textile` or `2013-09-09-schticky.html`. Note that the
slides are ordered in descending order by date.

The slides should include the following front matter:

```
layout: page
ident: contact
class: inverse
index: 8
title: Contact Software Niagara
icon: comments
categories:
  - slides
```

* __layout__: use the `page` layout
* __ident__: id attribute for the slide
* __class__: class attribute for the slide
* __index__: data-index attribute for the slide - used for navigation
* __title__: title appears in the slide header
* __icon__: icon appears in the slide header - see FontAwesome for reference
* __categories__: use the `slides` category

### Creating blog posts

Coming soon...

### More information on creating posts

For more info on creating posts, check out [Jekyll's official docs](http://jekyllrb.com/docs/posts/).

### Using Prose.io

This website is configured to be edited with [prose.io](http://prose.io). You may login to prose with your GitHub account.
From there you can use a GUI to create, edit, and delete slides and blog posts.

## Setting up your development environment

If you want to contribute to the development of this website, you will need to setup your development environment. In
addition to Jekyll you will need to use Sass/Compass for authoring CSS and Grunt for building your JavaScript scripts.
We have setup a Rake task to handle running the Jekyll server and Compass.

1. Run `bundle install` to install Jekyll and its dependencies.
2. Run `rake server` to run the Jekyll server and to make Compass listen for changes to your Sass files.
3. Run `npm install` to install Grunt and its dependencies.
4. Run `grunt` to concatenate and minify your JavaScript files.
