// Execute Anonymous Apex
// Cria 50 Address, 50 Developer (com Address), 50 Task (com Developer),
// 50 Sprint e 50 Sprint_Task (associando Sprint e Task).

Integer N = 50;

// "Random" simples sem crypto: usa millisecond do instante + índice.
Long seed = DateTime.now().getTime();

String pickRandom(List<String> opts, Integer i) {
    Integer idx = Math.mod(Integer.valueOf(Math.abs(seed + i)), opts.size());
    return opts[idx];
}

// Picklists (ajuste para os valores reais da sua org)
List<String> taskStatus = new List<String>{ 'To Do', 'In Progress', 'Done', 'Rejected' };
List<String> sprintStatus = new List<String>{ 'Inactive', 'Active', 'Done' };
List<String> devLevel = new List<String>{ 'Junior', 'Pleno', 'Senior' };
List<String> devRole  = new List<String>{ 'Developer', 'QA', 'Scrum Master', 'P.O' };

// 1) Addresses
List<Address__c> addresses = new List<Address__c>();
for (Integer i = 0; i < N; i++) {
    addresses.add(new Address__c(
        City__c = 'City ' + i,
        CEP__c  = String.valueOf(10000 + i) + '-' + String.valueOf(100 + Math.mod(i, 900))
    ));
}
insert addresses;

// 2) Developers (cada um com um Address aleatório)
List<Developer__c> developers = new List<Developer__c>();
for (Integer i = 0; i < N; i++) {
    // escolhe um address aleatório
    Integer aIdx = Math.mod(i * 7 + 13, addresses.size());

    developers.add(new Developer__c(
        Name__c      = 'Developer ' + i,
        Age__c       = 18 + Math.mod(i * 3 + 11, 30), // 18..47
        Bio__c       = 'Bio rand ' + i + ' (seed ' + seed + ')',
        Address__c   = addresses[aIdx].Id,
        Birth__c     = Date.today().addDays(-(365 * (18 + Math.mod(i, 25))) - Math.mod(i * 17, 365)),
        Level__c     = pickRandom(devLevel, i),
        Role__c      = pickRandom(devRole, i * 3),
        Start_Job__c = Date.today().addDays(-Math.mod(i * 29, 1500)), // até ~4 anos
        Task_On__c   = Math.mod(i * 5, 20)
    ));
}
insert developers;

// 3) Tasks (cada uma com um Developer aleatório)
List<Task__c> tasks = new List<Task__c>();
for (Integer i = 0; i < N; i++) {
    Integer dIdx = Math.mod(i * 11 + 5, developers.size());

    tasks.add(new Task__c(
        Status__c    = pickRandom(taskStatus, i * 4),
        Title__c     = 'Task Title ' + i,
        Developer__c = developers[dIdx].Id
    ));
}
insert tasks;

// 4) Sprints
List<Sprint__c> sprints = new List<Sprint__c>();
for (Integer i = 0; i < N; i++) {
    Date beginDate = Date.today().addDays(Math.mod(i * 7, 365));
    sprints.add(new Sprint__c(
        Status__c     = pickRandom(sprintStatus, i * 9),
        Date_Begin__c = beginDate,
        Date_End__c   = beginDate.addDays(7 + Math.mod(i, 14)) // 1 a 3 semanas
    ));
}
insert sprints;

// 5) Sprint_Task (associa 50 tarefas a 50 sprints, misturando)
List<Sprint_Task__c> sprintTasks = new List<Sprint_Task__c>();
for (Integer i = 0; i < N; i++) {
    Integer sIdx = Math.mod(i * 13 + 2, sprints.size());
    Integer tIdx = Math.mod(i * 17 + 7, tasks.size());

    sprintTasks.add(new Sprint_Task__c(
        Sprint_FKN__c = sprints[sIdx].Id,
        Task__c       = tasks[tIdx].Id
    ));
}
insert sprintTasks;

System.debug('--- CRIADO COM SUCESSO ---');
System.debug('Addresses: ' + addresses.size());
System.debug('Developers: ' + developers.size());
System.debug('Tasks: ' + tasks.size());
System.debug('Sprints: ' + sprints.size());
System.debug('SprintTasks: ' + sprintTasks.size());
