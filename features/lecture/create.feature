Feature: Create Lecture

    @omniauth_test_success
	Scenario: Create a lecture
		Given I am on the root page
	    When I follow "Comece Agora"
	    And I should be on home page

		When I follow "Ver Palestras"
		And I should be on lectures page
		When I follow "Criar uma palestra"
		And I should be on create lecture page
		When I fill in the following:
		| Título | abc |
		| Tema | abc_tema |
		| Descrição | abc_descricao |
		| Endereço | logo ali |
		| Preço | 12 |
		| Duração | 12 |
		| Data | 2015-11-23 15:16:25 |
		When I press "Criar Palestra"
		And I should be on show lecture page
