#!/bin/bash

#This .sh will run everything related to the piix-app-frontend app

MODULE="accesible_insurance_project"
echo "********************************************************************************"
echo "Running tests and checking code coverage for $MODULE"
echo "********************************************************************************"
fvm flutter test --coverage
echo ""

echo ""
echo "********************************************************************************"
echo "Creating coverage report for $MODULE"
echo "********************************************************************************"
genhtml coverage/lcov.info -o cover
echo ""

echo ""
echo "********************************************************************************"
echo "Opening coverage report for $MODULE"
echo "********************************************************************************"
open coverage/html/index.html
echo ""