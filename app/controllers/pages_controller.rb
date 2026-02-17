class PagesController < ApplicationController
  def home
    @basic_plan = Plan.find_by(name: 'Basic')
    @pro_plan = Plan.find_by(name: 'Pro')
  end

    def about
    # About page action
  end   
end