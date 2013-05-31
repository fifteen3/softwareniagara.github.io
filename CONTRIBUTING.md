This site is based on [Jekyll](http://jekyllrb.com/).

Here's an example of a Jekyll directory layout.
```
.
|-- _config.yml
|-- _includes
|-- _layouts
|   |-- default.html
|   `-- post.html
|-- _posts
|   |-- 2007-10-29-why-every-programmer-should-play-nethack.textile
|   `-- 2009-04-26-barcamp-boston-4-roundup.textile
|-- _site
`-- index.html
```

`_config.yml`: YAML formatted configuration file that can hold information like
how many posts to display per page or what base URL to serve your site from. You
can start with an empty file, and Jekyll will just use default settings.

`_includes/`: Put any partials (reusable bits of code) here so you can use them in
your layouts and posts. You can start with nothing in this directory, and as you
create more and more posts or if you decide to have multiple layouts, you'll
find that you can extract common code into partials.

`_layouts/`: Put your templates here. These are useful for wrapping common
elements around your posts and any other content you want to publish. You can
specify what layout to use for individual posts/files. In your layouts, you use
the tag {{ content }} to indicate where post or file contents will be inserted.

`_posts/`: Put your blog posts into this directory. Again, these are just HTML,
Markdown or Textile files, and they are just the content part of the post. The
file names should be of the format year-month-day-title.markupextension. So if
you created a blog post in HTML called "Hello World" published on January 1,
2012, you would name the file 2012-01-01-hello-world.html.

`_site/`: Jekyll puts its output in this directory. The content in this
directory is your site in HTML format.
