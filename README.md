# JavaProperties

[![Build Status](http://img.shields.io/travis/jnbt/java-properties.png)](https://travis-ci.org/jnbt/jnbt/java-properties)
[![Code Climate](http://img.shields.io/codeclimate/github/jnbt/java-properties.png)](https://codeclimate.com/github/jnbt/java-properties)
[![Coveralls](http://img.shields.io/coveralls/jnbt/java-properties.png)](https://coveralls.io/r/jnbt/java-properties)
[![RubyGems](http://img.shields.io/gem/v/java-properties.png)](http://rubygems.org/gems/java-properties)

A ruby library to read and write [Java properties files](http://en.wikipedia.org/wiki/.properties).

## Installation

Install via Rubygems

```bash
$ gem install java-properties
```

... or add to your Gemfile

```ruby
gem "java-properties"
```

## Loading files

You can load a valid Java properties file from the file system using a path:

```ruby
properties = JavaProperties.load("path/to/my.properties")
properties[:foo] # => "bar"
```

If have already the content of the properties file at hand than parse the content as:

```ruby
properties = JavaProperties.load("foo=bar")
properties[:foo] # => "bar"
```

## Writing files

You can write any Hash-like structure as a properties file:

```ruby
hash = {:foo => "bar"}
JavaProperties.write(hash, "path/to/my.properties")
```

Or if you want to omit the file you can receive the content directly:

```ruby
hash = {:foo => "bar"}
JavaProperties.generate(hash)  # => "foo=bar"
```

## Encodings and special chars

As Java properties files normally hold UTF-8 chars in their escaped representation this tool tries to convert them:

```
"ה" <=> "\u05d4"
```

The tool also escaped every '=', ' ' and ':' in the name part of a property line:

```ruby
JavaProperties.generate({"i : like=strange" => "bar"}) 
# => "i\ \:\ like\=strange=bar"
```

## Multi line and line breaks

In Java properties files a string can be multi line but line breaks have to be escaped. 

Assume the following input:

```ini
my=This is a multi \
   line content with only \n one line break
```

The parses would read:

```ruby
{:my => "This is a multi line content which only \n one line break"}
```

In the opposite direction line breaks will be correctly escaped but the generator will never use multi line values.

## Contributing

1. [Fork it!](https://github.com/jnbt/java-properties/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author

Jonas Thiel (@jonasthiel)

## References

For more information about the properties file format have a look at the [Java Plattform documenation](http://docs.oracle.com/javase/6/docs/api/java/util/Properties.html).

## License

This gem is released under the MIT License. See the LICENSE file for further details.
