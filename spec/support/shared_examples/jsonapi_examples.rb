RSpec.shared_context 'a JSON API response' do
  it 'has the JSON API content-type' do
    expect(response).to be_content_type :jsonapi
  end
end

RSpec.shared_context 'a conforming JSON API single object schema' do |schema|
  it "conforms to JSON API schema for a single '#{schema.singularize}'" do
    expect(response).to match_response_schema jsonapi_object_schema(schema)
  end
end

RSpec.shared_context 'a conforming JSON API objects list schema' do |schema|
  it "conforms to JSON API schema for a list of '#{schema}'" do
    expect(response).to match_response_schema jsonapi_objects_schema(schema)
  end
end

RSpec.shared_context 'a JSON API errors response' do
  it 'conforms to JSON API errors schema' do
    expect(response).to match_response_schema('errors')
  end
end
