*** Settings ***
Documentation     A test suite with a test for the matching of subjects in dropdown menu and table.
Suite Setup       Valid Login
Suite Teardown    Close Browser
Test Template     Current Subject Check
Resource          resource.robot

*** Test Cases ***        FULL NAME
English Checking    английский язык
Izo Checking        изобразительное искусство
Reading Checking    литературное чтение
Math Checking       математика
Music Checking      музыка
Outward Checking    окружающий мир
Russian Checking     русский язык
Tech Checking       технология
Physical Checking    физкультура

*** Keywords ***
Current Subject Check
    [Arguments]    ${fullname}
    Set Selenium Speed    ${DELAY MIN}
    Page Should Contain    ${fullname}    tag:td



