def params_invalid?(required, sent)
  invalid = false
  required.each do |required_param|
    invalid = {"error" => "missing params"} unless sent[required_param]
  end
  invalid
end

get '/' do
  haml :index
end

post '/post' do
  content_type :json
  invalid = params_invalid? ['service', 'secret', 'user', 'message'], params
  if invalid
    return invalid.to_json
  else
    notifo = Notifo.new(params[:service], params[:secret])
    return notifo.post(params[:user], params[:message]).to_json
  end
end

post '/subscribe' do
  content_type :json
  invalid = params_invalid? ['service', 'secret', 'user'], params
  if invalid
    return invalid.to_json
  else
    notifo = Notifo.new(params[:service], params[:secret])
    return notifo.subscribe_user(params[:user]).to_json
  end
end