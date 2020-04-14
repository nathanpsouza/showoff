# frozen_string_literal: true

class WidgetsController < ApplicationController
  def index
    @term = params[:term]
    response = widget_client.widgets @term
    @widgets = response[:data][:widgets]
  end

  def new
    @widget = Widget.new
  end

  def create
    @widget = Widget.new(widget_params)
    if @widget.valid?
      widget_client.save(@widget)
      redirect_to widgets_path
    else
      render :new
    end
  end

  private
    def widget_client
      @client ||= ShowoffApi::Client.widget(access_token)
    end

    def widget_params
      params.require(:widget).permit(
        :name, :description
      ).merge(kind: 'hidden')
    end
end
