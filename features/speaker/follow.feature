Feature: Follow Speaker
	In order to interact with speakers
	As an user
	I should follow the speaker

    @omniauth_test_success
    Scenario: Following speaker
    	Given I am an user
        And I am on the root page
        When I follow "Comece Agora"
        And I should be on home page
        When I follow "Ver Palestrantes"
        Then I should be on speakers page
        When I follow_specific "Ver"
        Then I should be on show speaker page
        When I follow "Seguir"
        Then I should be on show speaker page
        And I should see "Você está seguindo este usuário."
