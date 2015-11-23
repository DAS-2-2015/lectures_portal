Feature: Show Lecture
	In order to interact with lectures
	As an user
	I should see the lectures

	    @omniauth_test_success
	    Scenario: Editing lecture
	        And I am on the root page
	        And I own a lecture
	        When I follow "Comece Agora"
	        And I should be on home page
	        When I follow "Ver Palestras"
	        Then I should be on lectures page
	        When I follow "Ver"
	        Then I should be on show lecture page
