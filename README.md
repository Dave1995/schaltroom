## Schaltroom
[![Build Status](https://travis-ci.org/Dave1995/schaltroom.svg?branch=master)](https://travis-ci.org/Dave1995/schaltroom)  
Schaltroom is a Feature Toggle Management Tool and designed for complex rails dual doot projects.

## Installation for Rails applications

Add this line to your application's Gemfile
```ruby
gem 'schaltroom'
```

Add the following file to your Rails application
```ruby
# config/schaltroom.rb

require 'schaltroom'

Schaltroom.config do |config|
end

Schaltroom.repository do |repository|
  repository.add_feature(:feature_name, :boolean, true)
  repostiroy.add_gem(Rails)
  # ...
end
```

And add the following line to your config/application.rb after Bundler.require
```ruby
# config/application.rb

# Bundle.require
require File.expand_path('schaltroom', __dir__)
```

And then execute:
```bash
bundle
```

## Installation for other Ruby applications

Add this line to your application's Gemfile
```ruby
gem 'schaltroom'
```
Add the following lines to your application after running Bundler.setup and before using Schaltroom.
```ruby
require 'schaltroom'

Schaltroom.config do |config|
end

Schaltroom.repository do |repository|
  repository.add_feature(:feature_name, :boolean, true)
  repostiroy.add_gem(Rails)
  # ...
end
```

And then execute:
```bash
bundle
```

## Usage:
Consider the following configuration
```ruby
Schaltroom.repository do |repository|
  repository.add_feature(:boolean_feature, :boolean, true)
  repostiroy.add_gem(Rails) # this might not work with all gems
  repository.add_feature(Rails.to_s.to_sym, :version, '4.2.11.1') # You can use this aproach instead to add a gem
end
```

```ruby
Schaltroom.active?('boolean_feature')
# => true
Schaltroom.active?(:boolean_feature)
# => true
Schaltroom.inactive?(:boolean_feature)
# => false
Schaltroom.active_since?(:rails, '5.1')
# => false
Schaltroom.active_before?(:rails, '5.1')
# => true
Schaltroom.active_between?(:rails, '4.1', '5.0')
# => true
```

Testing with different configurations
```ruby
Schaltroom.add_feature(:active1, :boolean, true)
repository = Schaltroom::Repository.new
repository.add_feature(:active2, :boolean, true)
Schaltroom.with_config_and_repository(Schaltroom.config, repository) do
  assert(Schaltroom.active?(:active1))
  assert(Schaltroom.active?(:active2))
end
```


## TODOs
* return false(default) if a feature is unknow or raise an exception. This should be configurable
* file configuration
* schaltroom-rubocop
* schaltroom-server


## Support Schaltroom without adding the gem. This might be usable during the first stage of implementing a dual boot development aproach.
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
