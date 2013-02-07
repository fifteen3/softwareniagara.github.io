var fs   = require('fs')
  , path = require('path')
	, th   = require('./template_helper');

/**
 * Works synchronously because we need this data at a guaranteed time
 * in executation.
 */
module.exports = {
  
  /**
   * Menu generation is synchronous because we need to ensure the menu 
   * is generated before the page is rendered.
   */
  generate: function(dir) {
    var items = []
      , files = fs.readdirSync(dir);

    for (i in files) {
      var file  = files[i]
        , lines = fs.readFileSync(path.join(dir, file))
        , data  = th.readComments(lines)
        , item  = {};

      if (typeof data.menu !== 'undefined') {
        item.title = data.menu;
      } else if (typeof data.title !== 'undefined') {
        item.title = data.title;
      } else {
        item.title = 'Undefined';
      }

      if (typeof data.order !== 'undefined') {
        item.order = parseInt(data.order);
      } else {
        item.order = 0;
      }

      item.link = '/' + file.replace('.jade', '');
      items.push(item);
    }

    return items.sort(onTitle).sort(onOrder);
  }
};

function onOrder(a,b) {
  if (a.order < b.order)
    return -1;
  if (a.order > b.order)
    return 1;
  return 0;
}

function onTitle(a,b) {
  if (a.title < b.title)
    return -1;
  if (a.title > b.title) 
    return 1;
  return 0;
}