Feature:
  Como usuario registrado
  quiero ver un botón "Modificar voto" en una propuesta que ya voté.

  Background:
    Given user is logged in

  Scenario: Doesnt show button Modificar voto in a proposal he didnt vote
    Given a proposal he did not vote yet
    And   user visits proposal detail page
    Then  he should not see "Modificar voto" button

  @wip
  Scenario: Shows button Modificar voto in a proposal he voted
    Given a proposal he already voted
    And   user visits proposal detail page
    Then he should see "Modificar voto" button

  @wip
  Scenario: Modificar voto lets user modify its vote on a proposal
    Given a user creates a proposal
    And user votes a proposal positively
    When clicks on "Modificar voto"
    Then "Positive thumb" should be bigger than "Negative thumb"