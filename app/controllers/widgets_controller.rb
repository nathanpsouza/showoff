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

  def edit
    @widget = Widget.new(widget_params)
    @widget.id = params[:id]
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

  def update
    @widget = Widget.new(widget_params)
    if @widget.valid?
      widget_client.update(params[:id], @widget)
      redirect_to widgets_path
    else
      @widget.id = params[:id]
      render :edit
    end
  end

  def destroy
    widget_client.delete(params[:id])
    redirect_to widgets_path
  end

  private
    def widget_client
      @client ||= ShowoffApi::Client.widget(access_token)
    end

    def widget_params
      params.require(:widget).permit(
        :id, :name, :description, :kind
      )
    end
end
