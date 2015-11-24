Feature:
    In order to search for a specific theme
    As an logged user
    I want to fill the search form and get a specific lecture

    @omniauth_test_success
    Scenario: Access the Home page as a visitor
        Given I am on the root page
        When I follow "Comece Agora"
        Then I should be on home page
        When I follow "Ver Palestrantes"
        Then I should be on speakers page
        And  I own a lecture
        And  I am an user
        When I fill in the following:
        | Digite o nome do palestrante... | Barack Putin |
