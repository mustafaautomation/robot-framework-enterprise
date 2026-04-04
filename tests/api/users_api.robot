*** Settings ***
Documentation     API tests for reqres.in Users endpoint
Resource          ../../resources/keywords/api.robot
Resource          ../../resources/data/users.robot
Suite Setup       Create API Session
Test Tags         api

*** Test Cases ***
List Users Returns Paginated Response
    [Documentation]    GET /api/users returns paginated user list
    ${response}=    GET Request Should Succeed    /api/users?page=1
    Response Should Have Key    ${response}    data
    Response Array Should Have Length    ${response}    data    6
    Should Be Equal As Numbers    ${response.json()}[page]    1

Get Single User By ID
    [Documentation]    GET /api/users/2 returns user details
    ${response}=    GET Request Should Succeed    /api/users/2
    Response Should Have Key    ${response}    data
    Should Be Equal As Numbers    ${response.json()}[data][id]    2
    Should Not Be Empty    ${response.json()}[data][email]

Get Non-Existent User Returns 404
    [Documentation]    GET /api/users/999 returns 404
    ${response}=    GET Request Should Succeed    /api/users/999    expected_status=404

Create New User
    [Documentation]    POST /api/users creates a new user
    ${response}=    POST Request Should Succeed    /api/users    ${NEW_USER}
    Should Be Equal    ${response.json()}[name]    Test User
    Should Be Equal    ${response.json()}[job]    QA Engineer
    Response Should Have Key    ${response}    id

Login Returns Token
    [Documentation]    POST /api/login returns auth token
    &{login_data}=    Create Dictionary    email=eve.holt@reqres.in    password=cityslicka
    ${response}=    POST Request Should Succeed    /api/login    ${login_data}    expected_status=200
    Response Should Have Key    ${response}    token

Login Fails Without Password
    [Documentation]    POST /api/login fails with missing password
    &{login_data}=    Create Dictionary    email=eve.holt@reqres.in
    ${response}=    POST Request Should Succeed    /api/login    ${login_data}    expected_status=400
    Response Should Have Key    ${response}    error
