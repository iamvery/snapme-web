step 'an invitation has been requested' do
  InvitationRequest.create!(email: 'test@example.com')
end

step 'I view invitation requests' do
  visit invitation_requests_path
end

step 'I request an invitation be sent to :email' do |email|
  visit root_path
  find('[rel~=request-invitation]').click
  fill_in 'invitation_request_email', with: email
  find('[rel~=send-request]').click
end

step 'I send an invitation for the request' do
  send 'I view invitation requests'
  find('[rel~=send-invitation]').click
end

step 'there is an invitation request for :email' do |email|
  send 'I view invitation requests'
  expect(page).to have_content(email)
end

step 'there are no invitation requests' do
  expect(page).to_not have_css('.invitation-request')
end
