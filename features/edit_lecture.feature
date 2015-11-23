Feature: Edit Lecture
	In order to edit user
	As an logged Usuario
	You must edit your information

	Before do
		Lecture.create(title: "Tecnologia", description: "Descrição da palestra 1", price: 0.0, duration: 1, date: Time.now, speaker_id: 1)
    end

    @omniauth_test_success
    Scenario: Editing lecture
        Given I am on the root page
        When I follow "Comece Agora"
        And I should be on home page

        When I follow "Ver Palestras"
        And I should be on lectures page
        # When I press "Editar"
