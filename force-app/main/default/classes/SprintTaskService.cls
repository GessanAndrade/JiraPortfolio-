public with sharing class SprintTaskService {

    public static Decimal getPointsByDeveloperActiveSprint(Id developerId) {
        if (developerId == null) {
            throw new AuraHandledException('DeveloperId cannot be null.');
        }

        try {
            Sprint__c sprint = SprintService.getActiveSprint();
            if (sprint == null) {
                return 0;
            }

            List<Sprint_Task__c> tasks = SprintTaskSelector.getListTasksBySprint(sprint.Id);
            if (tasks == null || tasks.isEmpty()) {
                return 0;
            }

            Set<Id> taskIdsSet = new Set<Id>();
            for (Sprint_Task__c st : tasks) {
                if (st.Task__c != null) taskIdsSet.add(st.Task__c);
            }

            if (taskIdsSet.isEmpty()) {
                return 0;
            }

            List<Task__c> taskDetails = TaskService.getTasksFromSprintTasksAndIdDeveloper(new List<Id>(taskIdsSet), developerId);

            Decimal totalPoints = 0;
            for (Task__c t : taskDetails) {
                totalPoints += (t.Points__c == null ? 0 : t.Points__c);
            }

            return totalPoints;
        } catch (AuraHandledException e) {
            throw e;
        } catch (Exception e) {
            throw new AuraHandledException('Unable to calculate points for active sprint.');
        }
    }

    public static List<Task__c> getTasksBySprintTasks(List<Id> taskIds) {
        if (taskIds == null || taskIds.isEmpty()) {
            throw new AuraHandledException('TaskIds cannot be empty.');
        }

        try {
            return TaskSelector.getTasksByTasksIds(taskIds);
        } catch (Exception e) {
            throw new AuraHandledException('Unable to load tasks.');
        }
    }

    public static void createTaskBySprint(Id sprintId, Id taskId) {
        if (sprintId == null || taskId == null) {
            throw new AuraHandledException('SprintId and TaskId are required.');
        }

        try {
            insert new Sprint_Task__c(Sprint_FKN__c = sprintId, Task__c = taskId);
        } catch (DmlException e) {
            throw new AuraHandledException('Unable to add task to sprint.');
        }
    }

    public static void updateTaskStatus(Id sprintTaskId, String newStatus) {
        throw new AuraHandledException('Invalid operation. Update the status on Task__c, not on Sprint_Task__c.');
    }
}