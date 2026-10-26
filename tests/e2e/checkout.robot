*** Settings ***
Documentation     Checkout flow tests for SauceDemo
Resource          ../../resources/keywords/common.robot
Resource          ../../resources/pages/inventory_page.robot
Resource          ../../resources/pages/cart_page.robot
Resource          ../../resources/pages/checkout_page.robot
Resource          ../../resources/data/users.robot
# Each test gets a fresh logged-in browser so no test depends on the page the previous one ended on.
Test Setup        Open Browser And Login
Test Teardown     Close Test Browser
Test Tags         checkout    regression

*** Test Cases ***
Complete Checkout With Single Item
    [Documentation]    Verify full checkout flow with one product
    Add Product To Cart By Name    Sauce Labs Backpack
    Open Cart
    Cart Should Contain Product    Sauce Labs Backpack
    Click Checkout
    Fill Checkout Information    ${CHECKOUT_FIRST}    ${CHECKOUT_LAST}    ${CHECKOUT_ZIP}
    Click Continue
    ${total}=    Get Order Total
    Should Contain    ${total}    $
    Click Finish
    Order Should Be Complete

Checkout Fails Without First Name
    [Documentation]    Verify checkout validation for first name
    Add Product To Cart By Name    Sauce Labs Bolt T-Shirt
    Open Cart
    Click Checkout
    Fill Checkout Information    ${EMPTY}    ${CHECKOUT_LAST}    ${CHECKOUT_ZIP}
    Click Continue
    Checkout Error Should Be Visible    First Name is required

Checkout Fails Without Postal Code
    [Documentation]    Verify checkout validation for postal code
    Add Product To Cart By Name    Sauce Labs Onesie
    Open Cart
    Click Checkout
    Fill Checkout Information    ${CHECKOUT_FIRST}    ${CHECKOUT_LAST}    ${EMPTY}
    Click Continue
    Checkout Error Should Be Visible    Postal Code is required
