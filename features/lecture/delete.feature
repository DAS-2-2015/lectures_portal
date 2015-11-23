Feature: Delete Lecture
	In order to be able to remove lecture
	As an user
	The system should have an interface to it

	    @omniauth_test_success
	    Scenario: Deleting lecture
	        And I am on the root page
	        And I own a lecture
	        When I follow "Comece Agora"
	        And I should be on home page
	        When I follow "Ver Palestras"
	        Then I should be on lectures page
	        When I follow "Apagar"
	        Then I should be on lectures page
	        And I should see "Palestra foi apagada com sucesso."
