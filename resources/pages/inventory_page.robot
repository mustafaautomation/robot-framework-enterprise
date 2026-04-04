*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${INVENTORY_LIST}         css:.inventory_list
${INVENTORY_ITEMS}        css:.inventory_item
${CART_BADGE}             css:.shopping_cart_badge
${CART_LINK}              css:.shopping_cart_link
${SORT_DROPDOWN}          css:[data-test="product-sort-container"]
${ITEM_NAME}              css:.inventory_item_name
${ITEM_PRICE}             css:.inventory_item_price

*** Keywords ***
Inventory Page Should Be Loaded
    Wait Until Element Is Visible    ${INVENTORY_LIST}    ${TIMEOUT}

Get Inventory Item Count
    ${count}=    Get Element Count    ${INVENTORY_ITEMS}
    RETURN    ${count}

Add Product To Cart By Name
    [Arguments]    ${product_name}
    ${button_id}=    Set Variable    add-to-cart-${product_name.lower().replace(' ', '-')}
    Click Button    css:[data-test="${button_id}"]

Remove Product From Cart By Name
    [Arguments]    ${product_name}
    ${button_id}=    Set Variable    remove-${product_name.lower().replace(' ', '-')}
    Click Button    css:[data-test="${button_id}"]

Get Cart Badge Count
    ${visible}=    Run Keyword And Return Status    Element Should Be Visible    ${CART_BADGE}
    IF    ${visible}
        ${count}=    Get Text    ${CART_BADGE}
        RETURN    ${count}
    ELSE
        RETURN    0
    END

Open Cart
    Click Element    ${CART_LINK}
    Wait Until Location Contains    cart    ${TIMEOUT}

Sort Products By
    [Arguments]    ${option}
    Select From List By Value    ${SORT_DROPDOWN}    ${option}

Get First Product Name
    ${name}=    Get Text    ${ITEM_NAME}
    RETURN    ${name}

Get First Product Price
    ${price}=    Get Text    ${ITEM_PRICE}
    RETURN    ${price}
