Feature: rating

  Background:
    Given user is logged in
    And proposal detail page

  Scenario: Rate a proposal positively
    When clicks on "Positive_rating_button"
    Then should see "Gracias por su voto"

  Scenario: Rate a proposal negatively
    When clicks on "Negative_rating_button"
    Then should see "Gracias por su voto"
