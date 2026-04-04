*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${USERNAME_INPUT}     id:user-name
${PASSWORD_INPUT}     id:password
${LOGIN_BUTTON}       id:login-button
${ERROR_MESSAGE}      css:[data-test="error"]

*** Keywords ***
Open Login Page
    [Arguments]    ${url}=${BASE_URL}
    Go To    ${url}
    Wait Until Element Is Visible    ${LOGIN_BUTTON}    ${TIMEOUT}

Enter Username
    [Arguments]    ${username}
    Input Text    ${USERNAME_INPUT}    ${username}

Enter Password
    [Arguments]    ${password}
    Input Text    ${PASSWORD_INPUT}    ${password}

Click Login Button
    Click Button    ${LOGIN_BUTTON}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Enter Username    ${username}
    Enter Password    ${password}
    Click Login Button

Login Should Fail With Error
    [Arguments]    ${expected_error}
    Wait Until Element Is Visible    ${ERROR_MESSAGE}    ${TIMEOUT}
    Element Should Contain    ${ERROR_MESSAGE}    ${expected_error}

Login Should Succeed
    Wait Until Location Contains    inventory    ${TIMEOUT}
