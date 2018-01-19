*** Settings ***
Documentation     A test suite containing tests for checking the accuracy of the average score.
Suite Setup       Valid Login
Suite Teardown    Close Browser
Test Template     Current Subject Checking
Resource          resource.robot

*** Test Cases ***               ID
English Checking    3d1ce6d90ca7e44fb972aeb1ed8eff72
Izo Checking        4c31c3eb535e5a4a84b872241a895e29
Reading Checking    568b3c7b108552428ce14c94b64933fe
Math Checking       a93dfb3d11b2c8449a53d82681d0af50
Music Checking      70ff8e320c237647a787c70c91613fe1
Outward Checking    7c8adba27c71ce4d9eff7b480fd135fd
Russian Checking    67a0d1a555dca148af8b1d519d114ada
Tech Checking       0ee5ed6e19e22248b98369d396c20d3e
Physical Checking    c71411c8073a754e82f6b72bc70c7f9f

*** Keywords ***
Current Subject Checking
    [Arguments]    ${id}
    Set Selenium Speed    ${DELAY MAX}
    Open Subject List
    Select Subject    ${id}
    Select Year Filter
    ${AVERAGE MARK}=    Read Average Mark
    Set Selenium Speed    ${DELAY MIN}
    ${RESULTING AVERAGE}=    Get Average Mark
    Should Be Equal As Numbers    ${AVERAGE MARK}    ${RESULTING AVERAGE}   precision=2
