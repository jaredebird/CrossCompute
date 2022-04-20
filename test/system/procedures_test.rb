require "application_system_test_case"

class ProceduresTest < ApplicationSystemTestCase
  setup do
    @procedure = procedures(:one)
  end

  test "visiting the index" do
    visit procedures_url
    assert_selector "h1", text: "Procedures"
  end

  test "creating a Procedure" do
    visit procedures_url
    click_on "New Procedure"

    fill_in "Description", with: @procedure.description
    fill_in "Img", with: @procedure.img
    fill_in "Name", with: @procedure.name
    fill_in "Price", with: @procedure.price
    click_on "Create Procedure"

    assert_text "Procedure was successfully created"
    click_on "Back"
  end

  test "updating a Procedure" do
    visit procedures_url
    click_on "Edit", match: :first

    fill_in "Description", with: @procedure.description
    fill_in "Img", with: @procedure.img
    fill_in "Name", with: @procedure.name
    fill_in "Price", with: @procedure.price
    click_on "Update Procedure"

    assert_text "Procedure was successfully updated"
    click_on "Back"
  end

  test "destroying a Procedure" do
    visit procedures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Procedure was successfully destroyed"
  end
end
