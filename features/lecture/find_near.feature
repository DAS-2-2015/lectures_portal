Feature: Find near lectures
	In order to be informed about lectures near a place
	As an user
	I should be able to search lectures near an address

    @omniauth_test_success
	Scenario: Create a lecture in Gama-DF and search lecture near and other not near
		Given I am on the root page
	    When I follow "Comece Agora"
	    And I should be on home page

		When I follow "Ver Palestras"
		And I should be on lectures page
		When I follow "Criar uma palestra"
		Then I should be on create lecture page
		And I fill in the following:
		| Título | Hello |
		| Tema | Hello_theme |
		| Descrição | hello_world |
		| Endereço | Gama DF Brasil |
		| Preço | 10 |
		| Duração | 40 |
		| Data | 2015-12-12 16:00:00 |
		When I press "Criar Palestra"
		Then I should be on show lecture page
		And I should see "Palestra foi criada com sucesso."
		When I follow "Voltar"
		Then I should be on lectures page

		And I fill in the following:
		| Digite a localidade desejada... | Santa Maria DF Brasil |
		When I press "Encontrar"
		Then I should be on lectures page
		And I should see "Hello"
		And I should see "Hello_theme"

		And I fill in the following:
		| Digite a localidade desejada... | Anapolis GO Brasil |
		When I press "Encontrar"
		Then I should be on lectures page
		And I should not see "Hello"
		And I should not see "Hello_theme"
