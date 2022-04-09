class RefController < ApplicationController
  before_action :set_link, only: %i[ show ]
  # GET /links/1
  def show
    browser = Browser.new("Some User Agent", accept_language: "en-us")
    link_history = LinkHistory.new do |lh|
      lh.link = @link
      lh.ip = request.remote_ip
      lh.browser = browser.name
      lh.platform = browser.platform
    end
    link_history.save
    redirect_to @link.url, allow_other_host: true
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find_by(url_generated: params[:id])
  end
end
