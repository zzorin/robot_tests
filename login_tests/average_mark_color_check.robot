*** Settings ***
Documentation     A test suite containing tests related to checking average marks colors.
Suite Setup       Valid Login
Suite Teardown    Close Browser
Test Template     Average Mark Color Checking
Resource          resource.robot


*** Test Cases ***               ID        FULL NAME
English Checking    3d1ce6d90ca7e44fb972aeb1ed8eff72    английский язык
Izo Checking        4c31c3eb535e5a4a84b872241a895e29    изобразительное искусство
Reading Checking    568b3c7b108552428ce14c94b64933fe    Литературное чтение
Math Checking       a93dfb3d11b2c8449a53d82681d0af50    математика
Music Checking      70ff8e320c237647a787c70c91613fe1    музыка
Outward Checking    7c8adba27c71ce4d9eff7b480fd135fd    окружающий мир
Russian Checking    67a0d1a555dca148af8b1d519d114ada    русский язык
Tech Checking       0ee5ed6e19e22248b98369d396c20d3e    технология
Physical Checking    c71411c8073a754e82f6b72bc70c7f9f    физкультура

*** Keywords ***
Average Mark Color Checking
    [Arguments]    ${id}    ${fullname}
    Set Selenium Speed    ${DELAY MAX}
    Open Subject List
    Select Subject    ${id}
    Select Year Filter
    Set Selenium Speed    ${DELAY MIN}
    ${AVERAGE MARK}=     Read Average Mark
    ${AVERAGE COLOR}=    Read Average Color
    ${RESULTING COLOR}=    Select Color For Mark    ${AVERAGE MARK}
    Should be equal    ${RESULTING COLOR}    ${AVERAGE COLOR}
    Page Should Contain    ${fullname}    class:subject