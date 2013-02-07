var string = require('string');

module.exports = {
	readComment: function(line) {
	  var comment = {};
	  line = string(line.toString()).trim();

	  if (line.indexOf('//-') == 0 && line.indexOf(':') > 0) {
	    var pair = line.split(':');

	    if (pair.length == 2) {
	      comment.key = string(pair[0].replace('//-','')).trim();
	      comment.value = string(pair[1]).trim();
	    }
	  } else {
	    return false; // Signals end of comment block.
	  }

	  return comment;
	},

	readComments: function(lines) {
	  var data = {};
	  lines = lines.toString().split("\n");

	  for (i in lines) {
	    var comment = this.readComment(lines[i]);

	    if (comment === false) {
	      return data; // We have reached the end of the comment block.
	    }

	    if (typeof comment.key !== 'undefined' && typeof comment.value !== 'undefined') {
	      data[comment.key] = comment.value;
	    }
	  }

	  return data;
	}
};