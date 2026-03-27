public interface ISprintTaskSelector {
  List<Sprint_Task__c> getListTasksBySprint();

  Sprint_Task__c getSprintTaskById(Id taskId);
}
