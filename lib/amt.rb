#
# amt.rb
#
# A command line client to access Intel AMT
#
# Copyright (c) 2015, SUSE Linux LLC
# Written by Klaus Kaempf <kkaempf@suse.de>
#
# Licensed under the MIT license
#
require 'rubygems'
require 'wbem'

module Amt
  require "amt/version"
  require "amt/kvm"
  require "amt/sol"
  @@debug = nil
  def Amt.debug
    @@debug
  end
  def Amt.debug= level
    @@debug = (level == 0) ? nil : level
  end       
end # Module
