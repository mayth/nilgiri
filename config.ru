#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require File.expand_path("../config/boot.rb", __FILE__)

unless Padrino.env == :production
  map '/assets' do
    run Nilgiri::Assets::Environment.get root
  end
end

run Padrino.application
