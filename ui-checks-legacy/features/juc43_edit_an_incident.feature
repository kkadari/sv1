@JUC43
Feature: JUC43 - Edit an Incident

  @JUC43.1
  Scenario: Participant edits an amber anonymous incident report
  	Given I have logged in as "participant A"
  	When I have raised a red incident report anonymously in a private group
  	Then I can edit the anonymous incident report

  @JUC43.2 @wip
  Scenario: Participant updates the IHM for an incident report
  	Given I have logged in as "participant A"
  	When I have raised a red incident report anonymously in a private group
  	Then I can change incident report marking
