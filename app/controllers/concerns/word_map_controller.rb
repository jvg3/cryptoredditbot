class WordMapController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json do
        words = Mention.mentions_from_date(Time.now.utc - 1.hour, :reddit_cryptocurrency)

        render json: { words: words }
      end
    end
  end
end
