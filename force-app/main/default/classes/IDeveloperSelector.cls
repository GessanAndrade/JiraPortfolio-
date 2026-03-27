public interface IDeveloperSelector {
  List<Developer__c> getAllDevelopers();
  Developer__c getDeveloperById(Id developerId);
}
