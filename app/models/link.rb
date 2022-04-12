class Link < ApplicationRecord
  after_find do |link|
    link.url_generated = ("%{BASE_URL}/"  + link.url_generated) % ENV.to_h.symbolize_keys
  end
  validates :url, presence: true
  validates :url_generated, presence: true, uniqueness: true
end
