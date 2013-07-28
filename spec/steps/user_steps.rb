step 'there is an existing user' do
  User.create!(
    provider: 'a_provider',
    uid:      1337,
    username: 'kramer' )
end

step 'I view the users page' do
  visit users_path
end

step %q{I see :count user(')s(') snapshot(s)} do |count|
  expect(page).to have_css('.user', count: count)
end
