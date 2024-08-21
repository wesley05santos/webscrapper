require 'open-uri'

class FetchProfileExtraDataService
  def initialize(id)
    @profile_id = id
  end

  def self.call(id)
    new(id).call
  end

  def call
    run
  end
  
  private

  def run
    profile = Profile.find(@profile_id)
    doc = Nokogiri::HTML(URI.open(profile.url))
    profile.followers    = fetch_followers(doc).to_i
    profile.followings   = fetch_followings(doc).to_i
    profile.repositories = fetch_repositories(doc).to_i
    profile.stars        = fetch_stars(doc).to_i
    profile.image_url    = fetch_image(doc)
    profile.company      = fetch_company(doc)
    profile.location     = fetch_location(doc)
    profile.save
  end

  def fetch_followers(doc)
    css_selector = 'body > div.logged-out.env-production.page-responsive.page-profile > div.application-main > main > div.container-xl.px-3.px-md-4.px-lg-5 > div > div.Layout-sidebar > div > div.js-profile-editable-replace > div.d-flex.flex-column > div.js-profile-editable-area.d-flex.flex-column.d-md-block > div.flex-order-1.flex-md-order-none.mt-2.mt-md-0 > div > a:nth-child(1)'
    doc.css(css_selector).first.content.strip.split("\n").first
  end

  def fetch_followings(doc)
    css_selector = 'body > div.logged-out.env-production.page-responsive.page-profile > div.application-main > main > div.container-xl.px-3.px-md-4.px-lg-5 > div > div.Layout-sidebar > div > div.js-profile-editable-replace > div.d-flex.flex-column > div.js-profile-editable-area.d-flex.flex-column.d-md-block > div.flex-order-1.flex-md-order-none.mt-2.mt-md-0 > div > a:nth-child(2) > span'
    doc.css(css_selector).first.content.strip.split("\n").first
  end

  def fetch_repositories(doc)
    css_selector = 'body > div.logged-out.env-production.page-responsive.page-profile > div.application-main > main > div.mt-4.position-sticky.top-0.d-none.d-md-block.color-bg-default.width-full.border-bottom.color-border-muted > div > div > div.Layout-main > div > nav > a:nth-child(2) > span:nth-child(2)'
    doc.css(css_selector).first.content.strip.split("\n").first
  end

  def fetch_stars(doc)
    css_selector = 'body > div.logged-out.env-production.page-responsive.page-profile > div.application-main > main > div.mt-4.position-sticky.top-0.d-none.d-md-block.color-bg-default.width-full.border-bottom.color-border-muted > div > div > div.Layout-main > div > nav > a:nth-child(5) > span'
    doc.css(css_selector).first.content.strip.split("\n").first
  end

  def fetch_image(doc)
    css_selector = 'body > div.logged-out.env-production.page-responsive.page-profile > div.application-main > main > div.container-xl.px-3.px-md-4.px-lg-5 > div > div.Layout-sidebar > div > div.js-profile-editable-replace > div.clearfix.d-flex.d-md-block.flex-items-center.mb-4.mb-md-0 > div.position-relative.d-inline-block.col-2.col-md-12.mr-3.mr-md-0.flex-shrink-0 > a > img'
    doc.css(css_selector).first.attr('src')
  end

  def fetch_company(doc)
    css_selector = 'body > div.logged-out.env-production.page-responsive.page-profile > div.application-main > main > div.container-xl.px-3.px-md-4.px-lg-5 > div > div.Layout-sidebar > div > div.js-profile-editable-replace > div.d-flex.flex-column > div.js-profile-editable-area.d-flex.flex-column.d-md-block > ul > li:nth-child(1) > span > div'
    return if doc.css(css_selector).empty?

    doc.css(css_selector).first.content
  end

  def fetch_location(doc)
    css_selector = 'body > div.logged-out.env-production.page-responsive.page-profile > div.application-main > main > div.container-xl.px-3.px-md-4.px-lg-5 > div > div.Layout-sidebar > div > div.js-profile-editable-replace > div.d-flex.flex-column > div.js-profile-editable-area.d-flex.flex-column.d-md-block > ul > li:nth-child(2) > span'
    return if doc.css(css_selector).empty?

    doc.css(css_selector).first.content
  end
end
