*** Settings ***
Documentation     Login functionality tests for SauceDemo
Resource          ../../resources/keywords/common.robot
Resource          ../../resources/pages/login_page.robot
Resource          ../../resources/pages/inventory_page.robot
Resource          ../../resources/data/users.robot
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Test Browser
Test Setup        Open Login Page
Test Tags         login    smoke

*** Test Cases ***
Valid Login With Standard User
    [Documentation]    Verify standard user can log in successfully
    Login With Credentials    ${STANDARD_USER}    ${PASSWORD}
    Login Should Succeed
    Inventory Page Should Be Loaded

Login Fails With Locked Out User
    [Documentation]    Verify locked out user sees error message
    Login With Credentials    ${LOCKED_USER}    ${PASSWORD}
    Login Should Fail With Error    this user has been locked out

Login Fails With Empty Username
    [Documentation]    Verify error when username is empty
    Enter Password    ${PASSWORD}
    Click Login Button
    Login Should Fail With Error    Username is required

Login Fails With Empty Password
    [Documentation]    Verify error when password is empty
    Enter Username    ${STANDARD_USER}
    Click Login Button
    Login Should Fail With Error    Password is required

Login Fails With Invalid Credentials
    [Documentation]    Verify error with wrong username/password
    Login With Credentials    invalid_user    wrong_pass
    Login Should Fail With Error    do not match any user
