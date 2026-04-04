*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   ../variables.robot

*** Keywords ***
Create API Session
    Create Session    api    ${API_BASE_URL}    verify=${True}

GET Request Should Succeed
    [Arguments]    ${endpoint}    ${expected_status}=200
    ${response}=    GET On Session    api    ${endpoint}    expected_status=${expected_status}
    RETURN    ${response}

POST Request Should Succeed
    [Arguments]    ${endpoint}    ${body}    ${expected_status}=201
    ${response}=    POST On Session    api    ${endpoint}    json=${body}    expected_status=${expected_status}
    RETURN    ${response}

Response Should Have Key
    [Arguments]    ${response}    ${key}
    Dictionary Should Contain Key    ${response.json()}    ${key}

Response Array Should Have Length
    [Arguments]    ${response}    ${key}    ${expected_length}
    ${data}=    Set Variable    ${response.json()}[${key}]
    ${length}=    Get Length    ${data}
    Should Be Equal As Numbers    ${length}    ${expected_length}
