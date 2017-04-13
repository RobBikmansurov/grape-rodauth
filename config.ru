require 'grape'
require 'roda'
require './app'
require './auth'

use Rack::Session::Cookie, secret: '1'	#ENV['SECRET']
use Auth
run API
