Feature: Banking Features

  @Smoke 
  Scenario Outline: Create User (Both valid and Invalid)
    Given the endpoint create_user
      And   User name is <UserName>
      And   User ID is <UserID>
      When  method post with params

  Examples:
    UserName                | UserID | response_status  
    # create User --> 
    Suraj Bhattad           | 123    | 201              |
    New user                | 456    | 201              | 
    # CreateInvalid user -->
    Invalid User            | 789    | 400              |
    # Create Repeat user -->
    Suraj Bhattad           | 123    | 400              |
  

  @Smoke 
  Scenario Outline: Create Accounts (Both valid and Invalid)
    Given the endpoint create_account
      And   Balance is <Balance>
      And   Account name is <AccountName>
      And   Address is <Address>
      When  method post with params
      Then  the response status is <response_status>
      And   the response equals <response_json> json
      And   the response matches <response_schema> schema

  Examples:
    | Balance        | AccountName             | Address          | response_status  | response_json             | response_schema               |
    # A user can create accounts --> 
    | 1000.00        | Suraj Bhattad           | 123 , Nagpur     | 201              | valid_account_creation    | Valid_account_creation.json   |
    | 1500.00        | New user                | 456 , Nagpur     | 201              | valid_account_creation    | Valid_account_creation.json   |
    # Invalid user -->
    | 2000.00        | Invalid User            | 789 , Nagpur     | 409              | account_already_exist     | Invalid_account_creation.json |
    # An account cannot have less than $100 at any time in an account --> 
    | 10.00          | New User 12             | 789 , Nagpur     | 400              | account_errors            | Invalid_account_creation.json | 
  
  
  @Smoke 
  Scenario Outline: Account Transactions (Both valid and Invalid)
    Given the endpoint account_transaction/<AccountNumber>
      And   Balance is <Balance>
      And   New Balance is <New_Balance>
      And   Account number is <AccountNumber>
      And   Transaction type is <Transaction_type>
      And   Transaction value is <Transaction_value>
      When  method put with params
      Then  the response status is <response_status>
      And   method get with params


  Examples:
    | Balance        | New_Balance        | AccountNumber| Transaction_type          | Transaction_value  | response_status |
    # Debit transaction more than 90% -->
    | 1000.00        | 1000               | 123          | Dr                        | 901                | 400             | 
    # A user can deposit and withdraw from accounts --> 
    | 1000.00        | 546                | 456          | Dr                        | 100                | 200             |
    | 1000.00        | 1789               | 789          | Cr                        | 5000               | 200             |
    # deposit more than $10,000 in a single transaction -->
    | 1000.00        | 1000               | 111          | Cr                        | 10001              | 400             |
    # An account cannot have less than $100 at any time in an account -->
    | 100.00         | 100                | 111          | Dr                        | 10                 | 400             |


  @Smoke 
  Scenario Outline: Delete Account
    Given the endpoint account_delete/<AccountNumber>
      And   Account number is <AccountNumber>
      When  method delete with params
      Then  the response status is <response_status>


  Examples:
    | AccountNumber| response_status |
    # A user can delete accounts --> 
    | 123          | 204             | 
    | 456          | 204             |
    # Invalid accounts -->
    | 000          | 400             |
    | 001          | 400             |