Feature: Edit Lecture
    In order to edit lecture
    As an user
    You must edit your lecture

    @omniauth_test_success
    Scenario: Editing lecture
        Given I am on the root page
        And I own a lecture
        When I follow "Comece Agora"
        Then I should be on home page

        When I follow "Ver Palestras"
        Then I should be on lectures page

        When I follow "Editar"
        Then I should be on edit lecture page
        When I fill in the following:
        | Título | Palestra editada |
        | Duração | 2 |
        And I press "Atualizar Palestra"
        Then I should be on show lecture page
        And I should see "Palestra foi atualizada com sucesso."
