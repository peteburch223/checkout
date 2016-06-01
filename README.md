
#### Pete BURCH
### Brief

## Ruby Test

Our client is an online marketplace, here is a sample of some of the products available on our site:

```
Product code  | Name                   | Price
----------------------------------------------------------
001           | Lavender heart         | £9.25
002           | Personalised cufflinks | £45.00
003           | Kids T-shirt           | £19.95
```

Our marketing team want to offer promotions as an incentive for our customers to purchase these items.

If you spend over £60, then you get 10% off of your purchase.
If you buy 2 or more lavender hearts then the price drops to £8.50.

Our check-out can scan items in any order, and because our promotions will change, it needs to be flexible regarding our promotional rules.

The interface to our checkout looks like this (shown in Ruby):

```ruby
co = Checkout.new(promotional_rules)
co.scan(item)
co.scan(item)
price = co.total
```

Implement a checkout system that fullfills these requirements.

```
Test data
---------
Basket: 001,002,003
Total price expected: £66.78

Basket: 001,003,001
Total price expected: £36.95

Basket: 001,002,001,003
Total price expected: £73.76
```

### Usage

To run the tests, navigate to the root directory and run `rspec`.

The tests consist of unit tests for each class and an acceptance test that demonstrates that the functionality  fulfils the above specification.

The code does not perform any output formatting, and returns amounts as floats, rounded to two decimal places, without a currency symbol.

### Promotion rules

Promotion rules are created as Ruby lambdas and are passed to the `new` method of the Checkout object as a hash. A promotion rule calculates the discount that the checkout will apply.
This hash should contain two key-value pairs, the values of which are arrays containing 1..n rules that respect the following interface: <br>

- item rule: `lambda { |obj| block } -> float`

- global rule: `lambda { |float| block } -> float`

Item rules are processed before any global rules.

`spec/acceptance/acceptance_spec.rb` provides an example of each type of rule

Note that as rounding is performed by the `total` method of the `Checkout` class, it is unnecessary to include rounding logic in the promotion rules.
