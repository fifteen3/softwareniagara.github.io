module.exports = {
	cookies: {
		key: process.env.SNWWW_COOKIES_KEY
	},
	mandrill: {
		key: process.env.SNWWW_MANDRILL_KEY
	},
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
	},
	providers: {
		github: {
			id: process.env.SNWWW_GITHUB_ID,
			secret: process.env.SNWWW_GITHUB_SECRET
		}
	},
	contributors: process.env.SNWWW_CONTRIBUTORS.split(',')
};