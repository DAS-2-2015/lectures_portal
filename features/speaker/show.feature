Feature: Show Speaker
	In order to interact with speakers
	As an user
	I should see the speakers

	    @omniauth_test_success
	    Scenario: Showing speaker
	        And I am on the root page
	        And I own a lecture
	        When I follow "Comece Agora"
	        And I should be on home page
	        When I follow "Ver Palestrantes"
	        Then I should be on speakers page
	        When I follow "Ver"
	        Then I should be on show speaker page
