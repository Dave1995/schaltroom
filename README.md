## Schaltroom
[![Build Status](https://travis-ci.org/Dave1995/schaltroom.svg?branch=master)](https://travis-ci.org/Dave1995/schaltroom)  
Schaltroom is a Feature Toggle Management Tool, which is designed to support complex rails dual doot projects.

## TODOs
* return false(default) if a feature is unknow or raise an exception. This should be configurable
* file configuration
* schaltroom-rubocop
* schaltroom-server

## Usage
add the gem to your Gemfile
```ruby
gem 'schaltroom'
```
require schaltroom and load the configuration after Bundle.require
```ruby
# Bundle.require
# config/application.rb
require File.expand_path('schaltroom', __dir__)
```

```ruby
#config/schaltroom.rb

require 'schaltroom'

Schaltroom.config do |config|
end

Schaltroom.repository do |repository|
  repository.add_feature(:feature_name, :boolean, true)
  repostiroy.add_gem(Rails)
  # ...
end
```
```ruby
## Support Schaltroom without the gem. This might be usable in a dualboot project.
```ruby
  class Schaltroom
    def self.active?(name)
      false
    end

    def self.inactive?(name)
      false
    end

    def self.active_since?(name, version)
      false
    end

    def self.inactive_since?(name, version)
      !active_since?(name, version)
    end

    def self.active_before?(name, version)
      false
    end

    def self.inactive_before?(name, version)
      true
    end

    def self.active_between?(name, first_version, last_version)
      false
    end
  end
```
