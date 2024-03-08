## <a name="introduction"></a> Introduction
The goal of this repository is summary notes from Apex Developer Guide to create CRM(Customer Relationship Management) sites using Salesforce. 

## Table of Contents
- [Introduction](#introduction)
- [Apex Spesification](#apex-spesification)
- [Data Type, Conditions and Loops](#data-type-conditions-and-loops)
- [Classes, Objects and Interfaces](#classes-objects-and-interfaces)
- [Annotations](#annotations)
- [Data Manipulation Language](#data-manipulation-language)
- [SOQL and SOSL Queries](#soql-and-sosl-queries)
- [Apex Security and Sharing](#apex-security-and-sharing)
- [Additional References](#additional-references)

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

## <a name="data-manipulation-language"></a> Data Manipulation Language
- Adding and retrieveing data with DML:
```
Account a = new Account(Name='Account Example'); 
insert a;
```
- You can insert records related to existing records if a relationship has already been defined between the two objects, such as a lookup or master-detail relationship
- Fields on related records can't be updated with the same call to the DML operation and require a separate DML call. Updated it with several value
- Using the upsert operation, you can either insert or update an existing record in one call. To determine whether a record already exists, the upsert statement or Database method uses the record’s ID as the key to match records, a custom external ID field, or a standard field with the idLookup attribute set to true
- Use merge operation when you have duplicate lead, contact, case, or account records in the database, cleaning up your data and consolidating the records might be a good idea.
- delete records aren’t deleted permanently from Salesforce, but they are placed in the Recycle Bin for 15 days from where they can be restored. Restoring deleted records is covered using undelete
- DML statements return run-time exceptions if something went wrong in the database during the execution of the DML operations. You can handle the exceptions in your code by wrapping your DML statements within try-catch blocks.
- The `allowFieldTruncation` (Boolean) property specifies the truncation behavior of strings. In Apex saved against API versions previous to 15.0, if you specify a value for a string and that value is too large, the value is truncated.
- The `assignmentRuleHeader.assignmentRuleID/useDefaultRule` property specifies the assignment rule to be used when creating a case or lead. `assignmentRuleID`: The ID of an assignment rule for the case or lead. `useDefaultRule`: Indicates whether the default (active) assignment rule will be used for a case or lead.
- The `DuplicateRuleHeader.AllowSave` property determines whether a record that’s identified as a duplicate can be saved.
- Use `Database.rollback(databaseSavepoint)` and `Database.setSavepoint()` to use transaction. For Apex tests with API version 60.0 or later, all savepoints are released when `Test.startTest()` and `Test.stopTest()` are called. If any savepoints are reset, a `SAVEPOINT_RESET` event is logged.
- In Apex, you can use `FOR UPDATE` to lock sObject records while they’re being updated in order to prevent race conditions and other thread safety problems. While an sObject record is locked, no other client or user is allowed to make updates either through code or the Salesforce user interface. `Account[] accts = [SELECT Id FROM Account LIMIT 2 FOR UPDATE];`

## <a name="soql-and-sosl-queries"></a> SOQL and SOSL Queries
- In the API, the value of the FIND clause is demarcated with braces. For example: `FIND {Account*} IN ALL FIELDS RETURNING Account (Id, Name), Opportunity`
- Example foreign key and parent-child relationship: `System.debug([SELECT Account.Name FROM Contact WHERE FirstName = 'Caroline'].Account.Name);`
- `ORDER BY` cannot use in SOQL, but `GROUP BY` is can.
  
- Bind expressions can be used as: 
• The search string in FIND clauses. 
• The filter literals in WHERE clauses. 
• The value of the IN or NOT IN operator in WHERE clauses, allowing filtering on a dynamic set of values. Note that this is of particular use with a list of IDs or Strings, though it works with lists of any type. 
• The division names in WITH DIVISION clauses. 
• The numeric value in LIMIT clauses. 
• The numeric value in OFFSET clauses.

- The break and continue keywords can be used in both types of inline query for loop formats. When using the sObject list format, continue skips to the next list of sObjects.
- You can assign a List variable directly to the results of a SOQL query: `List<Account> accts = [SELECT Id, Name FROM Account LIMIT 1000];`
- Apex automatically generates IDs for each object in an sObject list that was inserted or upserted using DML. Therefore, a list that contains more than one instance of an sObject cannot be inserted or upserted even if it has a null ID. This situation would imply that two IDs would need to be written to the same structure in memory, which is illegal.
- sObject and list expressions can be expanded with method references and list expressions, respectively, to form new expressions: `String accNameLowercase = [SELECT Name FROM Account][0].Name.toLowerCase();`
- To create a dynamic SOQL query at run time, use the `Database.query(string)` or `Database.queryWithBinds(string, bindVariablesMap, accessLevel)` methods, in one of the following ways. Return can be sObject or List<sObject>.
- `Database.countQuery` and `Database.countQueryWithBinds`: Return the number of records that a dynamic SOQL query would return when executed.
- To create a dynamic SOSL query at run time, use the search query method: `List<> myQuery = search.query(SOSL_search_string);`

## <a name="apex-security-and-sharing"></a> Apex Security and Sharing
- Enforcing sharing rules by using the with sharing keyword doesn’t enforce the user's permissions and field-level security. Apex always has access to all fields and objects in an organization, ensuring that code won’t fail to run because of fields or objects that are hidden from a user.
- You can run database operations in user mode rather than in the default system mode by using SOQL or SOSL queries with special keywords or by using DML method overloads: `List<Account> acc = [SELECT Id FROM Account WITH USER_MODE]`
- Use the stripInaccessible method to enforce field-level and object-level data protection. This method can be used to strip the fields and relationship fields from query and subquery results that the user can’t access.
- Use the WITH SECURITY_ENFORCED clause to enable field- and object-level security permissions checking for SOQL SELECT queries in Apex code, including subqueries and cross-object relationships: `List<Account> act1 = [SELECT Id, (SELECT LastName FROM Contacts) FROM Account WHERE Name like 'Acme' WITH SECURITY_ENFORCED]`
- To access sharing programmatically, you must use the share object associated with the standard or custom object for which you want to share: `MyCustomObject__Share`. If the owner of the record changes, the sharing is automatically deleted.
- Open redirects through static resources can expose users to the risk of unintended, and possibly malicious, redirects.
- Cross-site scripting (XSS) attacks are where malicious HTML or client-side scripting is provided to a web application. The web application includes malicious scripting in a response to a user who unknowingly becomes the victim of the attack.
- When using components that have set the escape attribute to false, or when including formulas outside of a Visualforce component, output is unfiltered and must be validated for security. This is especially important when using formula expressions.
- To prevent a SOQL injection attack, avoid using dynamic SOQL queries. Instead, use static queries and binding variables. The preceding vulnerable example can be rewritten using static SOQL: 
```
String queryName = '%' + name + '%'; 
List<Contact> queryResult = [SELECT Id FROM Contact WHERE (IsDeleted = false and Name LIKE :queryName)];
```

## <a name="additional-references"></a> Additional References
[salesforce_apex_developer_guide.pdf](https://github.com/ichwansh03/apex-sfdc-discovery/files/14533185/salesforce_apex_developer_guide.pdf)
[Salesforce course](https://trailhead.salesforce.com/today)
