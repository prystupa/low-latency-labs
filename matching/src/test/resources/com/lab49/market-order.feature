Feature: Market Price Matching Rules
  Scenario: the market order is totally filled
    Given that reference price is 10
    And the following orders submitted to the book:
      | Broker | OrderId | Quantity | Price | Price | Quantity | OrderId | Broker |
      | A      | 1       | 50       | MTL   | MTL   | 40       | 4       | D      | 
      | G      | 7       | 20       | MO    | 10,08 | 100      | 5       | E      | 
      | B      | 2       | 90       | 10,1  | 10,15 | 60       | 6       | F      |
      | C      | 3       | 10       | 9,9   |       |          |         |        |
    When class auction completes
    Then the following trades are generated:
      | Buying broker | Selling broker | Quantity | Price |
      | A             | D              | 40       | 10,1  | 
      | A             | E              | 10       | 10,1  |
      | G             | E              | 20       | 10,1  |
      | B             | E              | 70       | 10,1  |
    And the book looks like:
      | Broker | OrderId | Quantity | Price | Price | Quantity | OrderId | Broker |
      | B      | 2       | 20       | 10,1  | 10,15 | 60       | 6       | F      |
      | C      | 3       | 10       | 9,9   |       |          |         |        |

  Scenario: the market order is partially filled
    Given that reference price is 10
    And the following orders submitted to the book:
      | Broker | OrderId | Quantity | Price | Price | Quantity | OrderId | Broker |
      | A      | 1       | 40       | MTL   | MO    | 45       | 2       | D      | 
      | G      | 3       | 20       | MO    |       |          |         |        |
    When class auction completes
    Then the following trades are generated:
      | Buying broker | Selling broker | Quantity | Price |
      | A             | D              | 40       | 10    | 
      | G             | D              | 5        | 10    |
    And the book looks like:
      | Broker | OrderId | Quantity | Price | Price | Quantity | OrderId | Broker |
      | G      | 3       | 15       |  MO   |       |          |         |        |