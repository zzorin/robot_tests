*** Settings ***
Documentation     A resource file with reusable keywords and variables.
Library           Selenium2Library

*** Variables ***
${INDEX}           1
${SERVER}         sd.tom.ru
${BROWSER}        Chrome
${DELAY MAX}          1
${DELAY MIN}          0.1
${USER}     login
${PASSWORD}    password
${LOGIN URL}      http://${SERVER}/
${WELCOME URL}    https://${SERVER}/pages/journal
${MARK URL}    https://${SERVER}/pages/mark
${DAYBOOK URL}    https://${SERVER}/pages/daybook
${HOMEWORK URL}    https://${SERVER}/pages/homework
${ERROR URL}      https://${SERVER}/sessions

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY MAX}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Томская электронная школа

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    session_login    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    session_password    ${password}

Submit Credentials
    Click Button    Войти

Open Subject List
    Click Button    dropdownSubjects

Select Subject
    [Arguments]    ${id}
    Click Element   id:${id}

Select Year Filter
    Click Button    js-btn-filter-year

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Page Should Contain    Журнал успеваемости    tag:h2

Open Mark Page
    Click Element    pages_mark

Mark Page Should Be Open
    Location Should Be    ${MARK URL}
    Page Should Contain    Оценки    tag:h2

Valid Login
    Open Browser To Login Page
    Input Username    ${USER}
    Input Password    ${PASSWORD}
    Submit Credentials
    Open Mark Page

Get Mark Count
    ${MARK COUNT}=    Get Element Count    xpath://table[@class="table mark-table"]//tbody//tr//td//div[@class="marks-container"]//span[contains(concat(' ', @class, ' '), 'modal_button circle color-')]
    Return From Keyword    ${MARK COUNT}

Get Mark Sum
    [Arguments]    ${MARK COUNT}
    ${SUM}=     Evaluate     0
    : FOR    ${INDEX}    IN RANGE    1    ${MARK COUNT}+1
    \   ${TEXT VALUE}=    Get Text    xpath://span[contains(concat(' ', @class, ' '), 'modal_button circle color-')][${INDEX}]
    \   ${VALUE}=    Convert To Number    ${TEXT VALUE}
    \   ${SUM}=      Evaluate    ${SUM}+${VALUE}
    ${AVERAGE MARK}=    Evaluate    ${SUM}/${MARK COUNT}
    Return From Keyword    ${AVERAGE MARK}


Get Average Mark
    ${MARK COUNT}=    Get Mark Count
    # Run Keyword If    ${MARK COUNT} > 0    Return From Keyword    Get Mark Sum     ELSE    Return From Keyword    0
    ${AVERAGE MARK}=    Run Keyword If    ${MARK COUNT} > 0    Get Mark Sum    ${MARK COUNT}     ELSE    Return Zero
    Return From Keyword    ${AVERAGE MARK}

Read Average Mark
    ${AVERAGE MARK}=    Get Text   xpath://table[@class="table mark-table"]//tbody//tr//td[contains(concat(' ', @class, ' '), 'middle-point color-')]
    Return From Keyword    ${AVERAGE MARK}

Return Zero
    Return From Keyword    0

Read Average Color
    ${AVERAGE COLOR}=    Get Element Attribute   xpath://table[@class="table mark-table"]//tbody//tr//td[contains(concat(' ', @class, ' '), 'middle-point color-')]    class
    Return From Keyword    ${AVERAGE COLOR}

Select Color For Mark
    [Arguments]    ${average}
    Run Keyword If    '${average}' >= '4.5'    Return From Keyword    middle-point color-5
    Run Keyword If    '${average}' >= '3.5' and '${average}' < '4.5'    Return From Keyword    middle-point color-4
    Run Keyword If    '${average}' >= '2.5' and '${average}' < '3.5'    Return From Keyword    middle-point color-3
    Run Keyword If    '${average}' >= '1.5' and '${average}' < '2.5'    Return From Keyword    middle-point color-2
    Run Keyword If    '${average}' < '1.5'    Return From Keyword    middle-point color-


