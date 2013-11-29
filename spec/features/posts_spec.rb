require 'spec_helper'

feature 'viewing posts' do
  let(:bucket_one) { FactoryGirl.create(:bucket, name: 'This Bucket') }
  let(:bucket_two) { FactoryGirl.create(:bucket, name: 'That Bucket') }
  let(:valid_attributes) { FactoryGirl.attributes_for(:post, bucket_id: bucket_one) }


  scenario 'viewing posts for all buckets' do
    #bucket_one.posts << FactoryGirl.create(:post, name: 'First Bucket Post')
    #bucket_two.posts << FactoryGirl.create(:post, name: 'Second Bucket Post')
    FactoryGirl.create(:post, name: 'First Bucket Post', bucket: bucket_one)
    FactoryGirl.create(:post, name: 'Second Bucket Post', bucket: bucket_two)
    visit posts_path
    page.should have_content('First Bucket Post')
    page.should have_content('Second Bucket Post')
  end
  scenario 'viewing posts for a single bucket' do
    #bucket_one.posts << FactoryGirl.create(:post, name: 'First Bucket Post')
    #bucket_two.posts << FactoryGirl.create(:post, name: 'Second Bucket Post')
    FactoryGirl.create(:post, name: 'First Bucket Post', bucket: bucket_one)
    FactoryGirl.create(:post, name: 'Second Bucket Post', bucket: bucket_two)
    visit bucket_path(bucket_one)
    page.should have_content('First Bucket Post')
    page.should_not have_content('Second Bucket Post')
  end
  scenario 'single post attributes with no url on the posts index page' do
    #post = FactoryGirl.create(:post, name: 'First Bucket Post')
    #bucket_one.posts << post
    post = FactoryGirl.create(:post, name: 'First Bucket Post', bucket: bucket_one)
    visit posts_path
    within("#post-#{post.id}.post") do
      page.should have_content("First Bucket Post")
      page.should have_content("Submitted at: #{post.created_at}")
      #page.should have_link(post_path(post))
      page.should have_link("First Bucket Post",  href: post_path(post))
    end
  end
  scenario "single post attributes with url on the posts index page" do
    #post = FactoryGirl.create(:post, name: 'First Bucket Post', url: 'http://www.google.com')
    #bucket_one.posts << post
    post = FactoryGirl.create(:post, name: 'First Bucket Post', bucket: bucket_one, url: 'http://www.google.com')
    visit posts_path
    within("#post-#{post.id}.post") do
      page.should have_content("First Bucket Post")
      page.should have_content("Submitted at: #{post.created_at}")
      page.should have_link("First Bucket Post",  href: "http://www.google.com")
    end
  end
end
