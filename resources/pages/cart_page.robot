*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CART_LIST}              css:.cart_list
${CART_ITEMS}             css:.cart_item
${CHECKOUT_BUTTON}        id:checkout
${CONTINUE_SHOPPING}      id:continue-shopping
${CART_ITEM_NAME}         css:.inventory_item_name
${CART_ITEM_PRICE}        css:.inventory_item_price

*** Keywords ***
Cart Page Should Be Loaded
    Wait Until Element Is Visible    ${CART_LIST}    ${TIMEOUT}

Get Cart Item Count
    ${count}=    Get Element Count    ${CART_ITEMS}
    RETURN    ${count}

Cart Should Contain Product
    [Arguments]    ${product_name}
    Element Should Contain    ${CART_LIST}    ${product_name}

Cart Should Not Contain Product
    [Arguments]    ${product_name}
    Element Should Not Contain    ${CART_LIST}    ${product_name}

Click Checkout
    Wait Until Element Is Visible    ${CHECKOUT_BUTTON}    ${TIMEOUT}
    Click Button    ${CHECKOUT_BUTTON}
    Wait Until Location Contains    checkout-step-one    ${TIMEOUT}

Click Continue Shopping
    Click Element    ${CONTINUE_SHOPPING}
    Wait Until Location Contains    inventory    ${TIMEOUT}
