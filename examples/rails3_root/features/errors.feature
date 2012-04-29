Feature: Email-spec errors example
  In order to help alleviate email testing in apps
  As a email-spec contributor I a newcomer
  Should be able to easily determine where I have gone wrong
  These scenarios should fail with helpful messages

  Background:
    Given I am on the homepage
    And no emails have been sent
    When I fill in "Email" with "example@example.com"
    And I press "Sign up"

  Scenario: I fail to open an email with incorrect subject
    Then I should receive an email
    When I run the step:
    """
    When "example@example.com" opens the email with subject "no email"
    """
    Then I should get a helpful error message containing:
    """
    Could not find email with subject "no email" in the mailbox for example@example.com. 
     Found the following emails:
    """

  Scenario: I fail to open an email with incorrect subject
    Then I should receive an email
    When I run the step:
    """
    When "example@example.com" opens the email with subject /no email/
    """
    Then I should get a helpful error message containing:
    """
    Could not find email with subject "(?-mix:no email)" in the mailbox for example@example.com. 
     Found the following emails:
    """

  Scenario: I fail to open an email with incorrect text
    Then I should receive an email
    When I run the step:
    """
    When "example@example.com" opens the email with text "no email"
    """
    Then I should get a helpful error message containing:
    """
    Could not find email with text "no email" in the mailbox for example@example.com. 
     Found the following emails:
    """

  Scenario: I fail to open an email with incorrect text
    Then I should receive an email
    When I run the step:
    """
    When "example@example.com" opens the email with text /no email/
    """
    Then I should get a helpful error message containing:
    """
    Could not find email with text "(?-mix:no email)" in the mailbox for example@example.com. 
     Found the following emails:
    """

  Scenario: I fail to receive an email with the expected link
    Then I should receive an email
    When I open the email
    When I run the step:
    """
    When I follow "link that doesn't exist" in the email
    """
    Then I should get a helpful error message containing:
    """
    expected the body to contain "link that doesn't exist" but was "Hello ! <a href=\"http://example.com/confirm\">Click here to confirm your account!</a> This is the HTML part
    """

  Scenario: I attempt to operate on an email that is not opened
    Then I should receive an email
    When I run the step:
    """
    When I follow "confirm" in the email
    """
    Then I should get a helpful error message containing:
    """
    Expected an open email but none was found. Did you forget to call open_email?
    """

  Scenario: I attempt to check out an unopened email
    When I run the step:
    """
    Then I should see "confirm" in the email body
    """
    Then I should get a helpful error message containing:
    """
    Expected an open email but none was found. Did you forget to call open_email?
    """
    And I run the step:
    """
    And I should see "Account confirmation" in the email subject
    """
    Then I should get a helpful error message containing:
    """
    Expected an open email but none was found. Did you forget to call open_email?
    """
