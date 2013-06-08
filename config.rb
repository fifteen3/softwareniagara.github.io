# Require any additional compass plugins here.
require 'zurb-foundation'

http_path       = '/'
css_dir         = 'assets/css'
sass_dir        = '_sass'
images_dir      = 'assets/images'
javascripts_dir = 'assets/js'

# compressed output in production environment
environment  = :production
output_style = (environment == :production) ? :compressed : :expanded

# To enable relative paths to assets via compass helper functions. Uncomment:
relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false

# Leave this alone!
preferred_syntax = :scss


# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed

environment = :production
output_style = :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
relative_assets = true