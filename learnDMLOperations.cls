// Created on 10-Oct-2014.
public class learnDMLOperations{

public void DMLOperations(){

// ----------------------------------------- PART 1 ----------------------------------------- 
// Usage of Upsert in DML - Option 1
Contact josh = new Contact(LastName = 'Josh', FirstName='Kaplan');
insert josh;
josh.Email='josh@gmail.com';

Contact cathy = new Contact(LastName = 'Cathy');
List<Contact> lstContacts = new List<Contact>{Josh,Cathy};
upsert(lstContacts);
/* Output: Your org will have only one Josh Kaplan record, not two, because the upsert operation found the existing record and updated it instead of creating a new contact record. 
One Kathy Brown contact record will be there too.*/

// Usage of Upsert in DML - Option 2: 
// Alternatively, you can specify a field to be used for matching records. 
// This example uses the Email field on Contact because it has idLookup property set. 
// The example inserts the Jane Smith contact, and creates a second Contact sObject, populates it with the same email, 
// then calls upsert to update the contact by using the email field for matching.
Contact jane = new Contact(LastName='Jane', 
                           FirstName='Smith',
                           Email='jane.smith@example.com',
                           Description='Contact of the day');
insert jane;                           

Contact jane2 = new Contact(LastName='Jane', 
                           FirstName='Smith',
                           Email='jane.smith@example.com',
                           Description='Prefers to be contacted by email');
// Upsert the contact by using the idLookup field for matching.
upsert jane2 contact.fields.email;
// Verify that the contact has been updated
System.assertEquals('Prefers to be contacted by email.',
                   [SELECT Description FROM Contact WHERE Id=:jane.Id].Description);
}

// ----------------------------------------- Part 2 - Database Methods--------------------------------------
/* Unlike DML statements, Database methods have an optional allOrNone parameter that allows you to specify whether the operation should partially succeed. 
When this parameter is set to false, if errors occur on a partial set of records, 
the successful records will be committed and errors will be returned for the failed records. 
Also, no exceptions are thrown with the partial success option*/

Account acct1 = new Account(Name = 'Acc 1');
Account acct2 = new Account(Name = 'Acc 2');

List<Account> lstAcc = new List<Account>();
/*for(integer i;i<3:i++)
    lstAcc [i] = new Account(Name='Acc ');
Database.insert(lstAcc, false);*/

}