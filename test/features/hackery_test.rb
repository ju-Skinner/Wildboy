require 'test_helper'

describe 'hackery' do

  it 'will upload file' do
    visit '/'
    fill_in 'Email', with: 'bob.pack@arpc.com'
    fill_in 'Password', with: 'yagni123'
    click_link_or_button 'Sign in'

    find(:css, '[rel="bulk-upload-button"]').click

    script = %{$('#batch_document').after('<input type="file" id="random_file" />');}

    page.execute_script(script)
    sleep(200)
  end
end
