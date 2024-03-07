## <a name="introduction"></a> Introduction
The goal of this repository is

## Table of Contents
- [Introduction](#introduction)
- [Apex Spesification](#apex-spesification)
- [Data Type, Conditions and Loops]()
- [Classes, Objects and Interfaces]
- [Annotations]
- [Data Manipulation Language]
- [SOQL and SOSL Queries]
- [Apex Security and Sharing]

## <a name="apex-spesification"></a> Apex Spesification
The @IsTest annotation on methods is equivalent to the testMethod keyword. As best practice, Salesforce recommends that you use @IsTest rather than testMethod. The testMethod keyword may be versioned out in a future release.
In addition, before you deploy Apex or package it for the AppExchange, the following must be true. 
Unit tests must cover at least 75% of your Apex code, and all of those tests must complete successfully. Note the following.
* When deploying Apex to a production organization, each unit test in your organization namespace is executed by default.
* Calls to System.debug aren’t counted as part of Apex code coverage.
* Test methods and test classes aren’t counted as part of Apex code coverage.
* While only 75% of your Apex code must be covered by tests, don’t focus on the percentage of code that is covered. Instead, make sure that every use case of your application is covered, including positive and negative cases, as well as bulk and single records. This approach ensures that 75% or more of your code is covered by unit tests.
* Every trigger must have some test coverage.
* All classes and triggers must compile successfully.
* ObjectName__c = custom object, include custom field

When should I use Apex?
- Web services
- Email services
- Complex validation over multiple object
- Complex business processes not supported by declarative artefacts
- Custom transactional logic
- Attach custom logic to another

When should I NOT use Apex?
- Render elements in the user interface other than error messages
- Change standard functionality
- Temporary file creation
- Spawn threads
