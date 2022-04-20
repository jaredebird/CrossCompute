require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  setup do
    @page = pages(:one)
  end

  test "visiting the index" do
    visit pages_url
    assert_selector "h1", text: "Pages"
  end

  test "creating a Page" do
    visit pages_url
    click_on "New Page"

    check "Dental" if @page.dental
    fill_in "Layout", with: @page.layout
    check "Medical" if @page.medical
    fill_in "Order", with: @page.order
    fill_in "Title", with: @page.title
    check "Vision" if @page.vision
    click_on "Create Page"

    assert_text "Page was successfully created"
    click_on "Back"
  end

  test "updating a Page" do
    visit pages_url
    click_on "Edit", match: :first

    check "Dental" if @page.dental
    fill_in "Layout", with: @page.layout
    check "Medical" if @page.medical
    fill_in "Order", with: @page.order
    fill_in "Title", with: @page.title
    check "Vision" if @page.vision
    click_on "Update Page"

    assert_text "Page was successfully updated"
    click_on "Back"
  end

  test "destroying a Page" do
    visit pages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Page was successfully destroyed"
  end
end
