module.exports = {
	development: 'mongodb://localhost/softwareniagara-www-dev',
	test: 'mongodb://localhost/softwareniagara-www.test',
	production: process.env.MONGOLAB_URI
};