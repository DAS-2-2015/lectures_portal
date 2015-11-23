Feature: Create Review
	To register a review on a speaker
	As a user
	I should be able to create review

	    @omniauth_test_success
	    Scenario: Create a review
	    	Given I am an user
	        And I am on the root page
		    When I follow "Comece Agora"
		    And I should be on home page

			When I follow "Ver Palestrantes"
			And I should be on speakers page
			When I follow_specific "Ver"
			Then I should be on show speaker page
			When I follow "Avaliar este Palestrante"
			And I fill in the following:
			| Pontos | 10 |
			When I press "Avaliar"
			Then I should be on show review page
			And I should see "Avaliação realizada com sucesso."