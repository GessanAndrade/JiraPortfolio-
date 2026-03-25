@isTest
public with sharing class TaskControllerTest {
  @testSetup
  static void setup() {
    Address__c address = new Address__c(City__c = 'Anytown');
    insert address;

    Developer__c developer = new Developer__c(
      Name__c = 'Gessan Andrade',
      Address__c = address.Id
    );
    insert developer;

    List<Task__c> tasks = new List<Task__c>();
    for (Integer i = 0; i < 5; i++) {
      tasks.add(
        new Task__c(
          Status__c = 'To Do',
          Title__c = 'Task Title ' + i,
          Developer__c = developer.Id
        )
      );
    }
    insert tasks;
  }

  @isTest
  static void testGetTasksForDeveloper() {
    Developer__c developer = [
      SELECT Id, Name__c
      FROM Developer__c
      WHERE Name__c = 'Gessan Andrade'
      LIMIT 1
    ];

    Test.startTest();
    List<Task__c> tasks = TaskController.getTasksByDeveloper(developer.Id);
    Test.stopTest();

    System.assertEquals(5, tasks.size(), 'Expected 5 tasks for the developer');

    for (Integer i = 0; i < tasks.size(); i++) {
      System.assertEquals('To Do', tasks[i].Status__c);
      System.assertEquals('Task Title ' + i, tasks[i].Title__c);
    }
  }
}
