Rails.application.routes.draw do
  post '/signup' => 'signup#signup'
  get '/signin' => 'signin#signin'
  delete 'signout' => 'signout#signout'

  get '/mainpg' => 'mainpg#mainpg'

  get '/read' => 'read#read'
  post '/write' => 'write#write'

  get '/refresh' => 'refresh#refresh'
end