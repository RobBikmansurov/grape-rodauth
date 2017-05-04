require 'grape'
require 'roda'
require './api'
require './auth'

use Rack::Session::Cookie, secret: '1'	#ENV['SECRET']
use Auth
run API
