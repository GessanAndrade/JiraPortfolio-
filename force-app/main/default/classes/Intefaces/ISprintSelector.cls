public interface ISprintSelector {
  List<Sprint__c> getAllSprints();

  List<Sprint__c> getActiveSprints();

  Sprint__c getSprintById(Id sprintId);
}
