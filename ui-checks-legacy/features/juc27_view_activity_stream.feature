@JUC27
Feature: JUC27 - View an Activity Stream
#JUC27.3: Participant is following a Group in an Activity Stream which has content posted anonymously

  @JUC27.1
  Scenario: Activity stream doesn't leak an anonymously posted incident report
    Given I have logged in as "participant A"
    And I have raised a white incident report anonymously in a private group
    Then another user is not able to view it in my activity stream

  @JUC27.1
  Scenario: Activity stream doesn't leak an anonymously edited incident report
	  Given I have logged in as "participant A"
  	And I have raised a green incident report anonymously in a private group
  	And I can edit the anonymous incident report
  	When I have logged in as "participant B"
  	And another user is not able to view it in my activity stream

  @JUC27.2
  Scenario: Activity stream doesn't leak an anonymously posted comment on incident report
  	Given I have logged in as "participant B"
    And I have raised an amber incident report in a private group
    And I have commented on the incident report anonymously
    When I have logged in as "participant A"
  	Then I am not able to view their identity on the comment in their activity stream

  @JUC27.3
  Scenario: Activity stream does not leak anonymous content posted in a shared group
    Given a participant has raised an anonymous incident report in a group I follow in my connections stream
    Then I can verify the incident report is marked anonymous in my connection stream

  Scenario: Participant is following a Group in an Activity Stream which has content posted anonymously
    Given "participant A" and "participant B" are members of the same group
    When "participant B" creates a new piece of content for the group
    Then I will see the recently created content in my connections stream as "participant A"
