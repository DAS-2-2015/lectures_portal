Feature: Edit Lecture
	In order to edit lecture
	As an logged user
	You must edit your lecture

	Before do
		Lecture.create(title: "Tecnologia", description: "Descrição da palestra 1", price: 0.0, duration: 1, date: Time.now, speaker_id: 2)
    end

    @omniauth_test_success
    Scenario: Editing lecture
    	Given I am an user
        And I am on the root page
        And I own a lecture
        When I follow "Comece Agora"
        And I should be on home page

        When I follow "Ver Palestras"
        And I should be on lectures page

        When I follow "Editar"
        Then I should be on edit lecture page
    	When I fill in the following:
		| Título | Palestra editada |
		| Duração | 2 |
		And I press "Atualizar Palestra"
		Then I should see "Palestra foi atualizada com sucesso."
