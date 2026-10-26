*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${FIRST_NAME_INPUT}       id:first-name
${LAST_NAME_INPUT}        id:last-name
${POSTAL_CODE_INPUT}      id:postal-code
${CONTINUE_BUTTON}        id:continue
${FINISH_BUTTON}          id:finish
${CANCEL_BUTTON}          id:cancel
${SUMMARY_TOTAL}          css:[data-test="total-label"]
${COMPLETE_HEADER}        css:.complete-header
${CHECKOUT_ERROR}         css:[data-test="error"]

*** Keywords ***
Fill Checkout Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Wait Until Element Is Visible    ${FIRST_NAME_INPUT}    ${TIMEOUT}
    Input Text    ${FIRST_NAME_INPUT}    ${first_name}
    Input Text    ${LAST_NAME_INPUT}    ${last_name}
    Input Text    ${POSTAL_CODE_INPUT}    ${postal_code}

Click Continue
    Click Button    ${CONTINUE_BUTTON}

Click Finish
    Click Button    ${FINISH_BUTTON}

Order Should Be Complete
    Wait Until Element Is Visible    ${COMPLETE_HEADER}    ${TIMEOUT}
    Element Should Contain    ${COMPLETE_HEADER}    Thank you for your order

Get Order Total
    Wait Until Element Is Visible    ${SUMMARY_TOTAL}    ${TIMEOUT}
    ${total_text}=    Get Text    ${SUMMARY_TOTAL}
    RETURN    ${total_text}

Checkout Error Should Be Visible
    [Arguments]    ${expected_error}
    Wait Until Element Is Visible    ${CHECKOUT_ERROR}    ${TIMEOUT}
    Element Should Contain    ${CHECKOUT_ERROR}    ${expected_error}
