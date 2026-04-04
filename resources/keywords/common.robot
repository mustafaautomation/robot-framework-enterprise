*** Settings ***
Library    SeleniumLibrary
Resource   ../variables.robot
Resource   ../pages/login_page.robot

*** Keywords ***
Open Browser And Login
    [Arguments]    ${username}=${STANDARD_USER}    ${password}=${PASSWORD}
    Open Browser    ${BASE_URL}    ${BROWSER}    options=add_argument("--headless");add_argument("--no-sandbox")
    Set Selenium Timeout    ${TIMEOUT}
    Open Login Page
    Login With Credentials    ${username}    ${password}
    Login Should Succeed

Close Test Browser
    Close All Browsers

Open Browser To Login Page
    Open Browser    ${BASE_URL}    ${BROWSER}    options=add_argument("--headless");add_argument("--no-sandbox")
    Set Selenium Timeout    ${TIMEOUT}
    Open Login Page
