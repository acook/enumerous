# Enumerous

Handy functionality for your Arrays and Enumerables!

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     enumerous:
       github: acook/enumerous
   ```

2. Run `shards install`

## Usage

```crystal
require "enumerous/all"
```

```crystal
has_different_elements = [1,2].similar [2,3]       #=> false
contains_same_elements = [1,2].similar [2,1]       #=> true

extra, missing = [1,2].diff [2,3]                  #=> {[3],[1]}

index_of_first_difference = [1,2].diff_index [1,3] #=> 1

[1,2].find_and_map {|element| element > 1 && element.to_s }             #=> "2"
{a: 1, b: 2}.find_and_map {|key, value| value > 1 && "#{key}:#{value} } #=> "b:2"
```

## Contributing

1. Fork it (<https://github.com/acook/enumerous/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Anthony Cook](https://github.com/acook) - creator and maintainer
