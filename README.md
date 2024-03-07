## <a name="introduction"></a> Introduction
The goal of this repository is

## Table of Contents
- [Introduction](#introduction)
- [Apex Spesification](#apex-spesification)
- [Data Type, Conditions and Loops](#data-type-conditions-and-loops)
- [Classes, Objects and Interfaces](#classes-objects-and-interfaces)
- [Annotations](#annotations)
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

## <a name="data-type-conditions-and-loops"></a> Data Type, Conditions and Loops
* ID: Any valid 18-character Lightning Platform record identifier. For example: ID id='00300000003T2PGAA0’; If you set ID to a 15-character value, Apex converts the value to its 18-character representation. All invalid ID values are rejected with a runtime exception.
* Object: Any data type that is supported in Apex. Apex supports primitive data types (such as Integer), user-defined custom classes, the sObject generic type, or an sObject specific type (such as Account). All Apex data types inherit from Object.
* Unlike Java, the enum type itself has no constructor syntax. public enum Season {X, Y}
* Apex, SOQL and SOSL is case-insensitive
* Safe navigation operator (?.): Short-circuits expressions that attempt to operate on a null value and returns null instead of throwing a NullPointerException. Use it to replace explicit, sequential checks for null references.
* Salesforce recommends against using multiple SOQL queries in a single statement that also uses the null coalescing operator
```
Account defaultAccount = new Account(name='TEST');
Account a = [SELECT Id FROM Account WHERE Id = '001000000FAKEID'] ?? defaultAccount;
Assert.areEqual(defaultAccount, a);
```

* when in switch-case can use multiple value
* These types of procedural loops are supported: 
  • do {statement} while (Boolean_condition); 
  • while (Boolean_condition) statement; 
  • for (initialization; Boolean_exit_condition; increment) statement; 
  • for (variable : array_or_set) statement; 
  • for (variable : [inline_soql_query]) statement;

* All loops allow for loop control structures: 
• break; exits the entire loop 
• continue; skips to the next iteration of the loop

## <a name="classes-objects-and-interfaces"></a> Classes, Objects and Interfaces
* The global access modifier declares that this class is known by all Apex code everywhere. All classes containing methods defined with the webservice keyword must be declared as global. If a method or inner class is declared as global, the outer, top-level class must also be defined as global.

* The virtual definition modifier declares that this class allows extension and overrides. You can’t override a method with the override keyword unless the class has been defined as virtual.

* In API version 50.0 and later, scope and accessibility rules are enforced on Apex variables, methods, inner classes, and interfaces that are annotated with @namespaceAccessible

* Similar in Java, constructor can be overloaded
```
public class TestObject2 {

  private static final Integer DEFAULT_SIZE = 10; 
  Integer size; 

  //Constructor with no arguments 
  public TestObject2() { 
    this(DEFAULT_SIZE); // Using this(...) calls the one argument constructor 
  }	 

  // Constructor with one argument 
  public TestObject2(Integer ObjectSize) { 
    size = ObjectSize; 
  } 
}
```

* Using automatic properties to declare setter and getter: 
`public double MyReadWriteProp { get; set;}`

* Interface, abstract and inner class specification is similar within Java.

* Use the `transient` keyword to declare instance variables that can't be saved, and shouldn't be transmitted as part of the view state for a Visualforce page. You can also use the transient keyword in Apex classes that are serializable, namely in controllers, controller extensions, or classes that implement the Batchable or Schedulable interface. In addition, you can use transient in classes that define the types of fields declared in the serializable classes.

* Use the `with sharing` keywords when declaring a class to enforce the sharing rules that apply to the current user.
* Use the `without sharing` keyword when declaring a class to ensure that the sharing rules for the current user are not enforced.
* Use the `inherited sharing` keyword when declaring a class to enforce the sharing rules of the class that calls it. Using inherited sharing is an advanced technique to determine the sharing mode at runtime and design Apex classes that can run in either with sharing or without sharing mode.

## <a name="annotations"></a> Annotations
- The `@AuraEnabled` annotation enables client-side and server-side access to an Apex controller method.

- Use the `@Deprecated` annotation to identify methods, classes, exceptions, enums, interfaces, or variables that can no longer be referenced in subsequent releases of the managed package in which they reside.

- Use the `@Future` annotation to identify methods that are executed asynchronously. When you specify Future, the method executes when Salesforce has available resources.

- Use the `@InvocableMethod` annotation to identify methods that can be run as invocable actions. Invocable methods are called natively from Rest, Apex, Flow, or Einstein bot that interacts with the external API source. Invocable methods have dynamic input and output values and support describe calls, include @InvocableVariable.

- Use the `@IsTest(SeeAllData=true)` annotation to grant test classes and individual test methods access to all data in the organization.

- Use the `@IsTest(OnInstall=true)` annotation to specify which Apex tests are executed during package installation

- Use the `@IsTest(IsParallel=true)` annotation to indicate test classes that can run in parallel.

- The `@JsonAccess` annotation defined at Apex class level controls whether instances of the class can be serialized or deserialized. If the annotation restricts the JSON or XML serialization and deserialization, a runtime JSONException exception is thrown. The serializable and deserializable parameters of the @JsonAccess annotation enforce the contexts in which Apex allows serialization and deserialization. You can specify one or both parameters, but you can’t specify the annotation with no parameters. 
The valid values for the parameters to indicate whether serialization and deserialization are allowed: 
• never: never allowed 
• sameNamespace: allowed only for Apex code in the same namespace 
• samePackage: allowed only for Apex code in the same package (impacts only second-generation packages) 
• always: always allowed for any Apex code

- The `@RemoteAction` annotation provides support for Apex methods used in Visualforce to be called via JavaScript. This process is often referred to as JavaScript remoting. Method with this annotation must be static either global or public.

- Use the `@TestVisible` annotation to allow test methods to access private or protected members of another class outside the test class

- The `@RestResource` annotation is used at the class level and enables you to expose an Apex class as a REST resource. Class must be defined as global, case-sensitive and can contain a wildcard (*) in url.

- For the Apex REST annotation uses `@HttpPost`, `@HttpDelete`, `@HttpGet`, `@HttpPut`, `@HttpPatch` and `@ReadOnly`

- An sObject variable represents a row of data and can only be declared in Apex using SOAP API name of the object.
