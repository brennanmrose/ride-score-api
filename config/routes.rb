# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :rides, only: [:index], defaults: { format: 'json' }
  end
end
