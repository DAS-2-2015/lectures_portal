Feature:
	In order to user the Website
	As an unlogged User
	You must access the home page

	@omniauth_test_success
  Scenario: Access the Home page as a visitor
		Given I am on the root page
		When I follow "Comece Agora"
		Then I should be on home page
