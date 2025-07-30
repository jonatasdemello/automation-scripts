
https://xelloworld.atlassian.net/wiki/spaces/ENG/pages/214040729/Cypress+end-to-end+testing
https://xelloworld.atlassian.net/wiki/spaces/ENG/pages/221479350/Automated+Regression+Testing+Strategy

https://docs.cypress.io/app/end-to-end-testing/testing-your-app
https://docs.cypress.io/app/get-started/open-the-app
https://docs.cypress.io/app/references/command-line


npm run cy-run-dev
npm run cy-run-test
npm run cy-run-uat

npx cypress open --env configFile=dev
npx cypress open --env configFile=test
npx cypress open --env configFile=uat

# OR to run the test suite for a specific project:
npx cypress run --env configFile=dev --spec cypress\integration\student-side\**
npx cypress run --env configFile=dev --spec cypress\integration\educator-side\**

npx cypress run --env configFile=dev --spec cypress\integration\student-side\matchmaker_spec.js

npx cypress run --env configFile=test --spec cypress\e2e\educator-side\**

# D:\workspace\E2E\Xello.E2E.Web\cypress\e2e\student-side\about-me\matchmaker.cy.json

#- this is for local
npx cypress run --env configFile=localhost --e2e --browser chrome --spec cypress/e2e/educator-side/**/**

# - this is for Test
npx cypress run --env configFile=test.us --e2e --browser chrome --spec cypress/e2e/educator-side/**/**


# Open the Cypress Test Runner, which utilizes full Chrome browser:
# You can open Cypress from your project root using one of the following commands,
# depending on the package manager (npm, Yarn or pnpm) you are using:
# After a moment, the Cypress Launchpad will open.

npx cypress open


# not working
npm run start

#Once loaded, the app will open a new browser tab pointing to http://localhost:8080

