@isTest
public class DeveloperControllerTest {
  @testSetup
  public static void setup() {
    Helper helper = new Helper();
    List<Address__c> addresses = helper.createFakeAddresses(2);
    insert addresses;

    List<Address__c> address = [SELECT Id FROM Address__c LIMIT 1];

    System.debug('endereço: ' + address[0].id);

    List<Developer__c> developers = helper.createFakeDevelopers(
      2,
      address[0].Id
    );
    insert developers;

    List<Developer__c> developer = [SELECT Id FROM Developer__c LIMIT 1];

    System.debug('dev: ' + developer[0].id);
  }

  @isTest
  public static void testGetAllDevelopers() {
    List<Developer__c> developers = DeveloperController.getAllDevelopers();
    System.Assert.areEqual(2, developers.size(), 'Expected 2 developers');
  }

  @isTest
  public static void testGetDeveloperById() {
    Developer__c developer = [
      SELECT Id
      FROM Developer__c
      WHERE Name__c = 'Developer 0'
      LIMIT 1
    ];
    Developer__c result = DeveloperController.getDeveloperById(developer.Id);
    System.Assert.isNotNull(result, 'Expected to find a developer');
  }

  @isTest
  public static void testCreateDeveloper() {
    Address__c address = new Address__c(City__c = 'City C');
    insert address;
    DeveloperController.createDeveloper('Developer 2', address.Id);
    Developer__c result = [
      SELECT Id, Name__c
      FROM Developer__c
      WHERE Name__c = 'Developer 2'
      LIMIT 1
    ];
    System.Assert.isNotNull(
      result,
      'Expected to find the newly created developer'
    );
    System.Assert.areEqual(
      'Developer 2',
      result.Name__c,
      'Developer name does not match'
    );
  }
}
