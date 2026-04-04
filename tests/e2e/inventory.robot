*** Settings ***
Documentation     Inventory page tests for SauceDemo
Resource          ../../resources/keywords/common.robot
Resource          ../../resources/pages/inventory_page.robot
Resource          ../../resources/pages/cart_page.robot
Suite Setup       Open Browser And Login
Suite Teardown    Close Test Browser
Test Tags         inventory    regression

*** Test Cases ***
Inventory Page Displays Six Products
    [Documentation]    Verify all 6 products are displayed
    Inventory Page Should Be Loaded
    ${count}=    Get Inventory Item Count
    Should Be Equal As Numbers    ${count}    6

Add Product To Cart
    [Documentation]    Verify adding a product updates cart badge
    Add Product To Cart By Name    Sauce Labs Backpack
    ${badge}=    Get Cart Badge Count
    Should Not Be Equal    ${badge}    0

Remove Product From Cart
    [Documentation]    Verify removing a product from cart
    Add Product To Cart By Name    Sauce Labs Bike Light
    Remove Product From Cart By Name    Sauce Labs Bike Light

Sort Products By Price Low To High
    [Documentation]    Verify price sorting works
    Sort Products By    lohi
    ${price}=    Get First Product Price
    Should Contain    ${price}    $

Sort Products By Name Z To A
    [Documentation]    Verify name sorting works
    Sort Products By    za
    ${name}=    Get First Product Name
    Should Not Be Empty    ${name}

Navigate To Cart
    [Documentation]    Verify cart page loads
    Open Cart
    Cart Page Should Be Loaded
