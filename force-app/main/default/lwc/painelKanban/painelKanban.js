import { LightningElement, track } from "lwc";
import getTasksFromActiveSprint from "@salesforce/apex/SprintController.getTasksFromActiveSprint";
import updateTaskStatus from "@salesforce/apex/TaskController.updateTaskStatus";

export default class PainelKanban extends LightningElement {
  @track todo = [];

  @track doing = [];

  @track test = [];

  @track done = [];

  @track rejected = [];

  draggedCardId;
  draggedCardTitle;
  draggedCardDeveloper;
  origemColuna;

  handleDragStart(event) {
    this.draggedCardId = event.currentTarget.dataset.id;
    this.draggedCardTitle = event.currentTarget.dataset.title;
    this.draggedCardDeveloper = event.currentTarget.dataset.developer;

    const col = event.currentTarget.closest(".col");
    this.origemColuna = col ? col.dataset.col : null;

    event.currentTarget.classList.add("dragging");

    event.dataTransfer.setData("text/plain", this.draggedCardId);
    event.dataTransfer.effectAllowed = "move";
  }

  handleDragEnd(event) {
    event.currentTarget.classList.remove("dragging");
  }

  handleDragOver(event) {
    event.preventDefault();
    event.currentTarget.classList.add("drag-over");
    event.dataTransfer.dropEffect = "move";
  }

  handleDragLeave(event) {
    event.currentTarget.classList.remove("drag-over");
  }

  handleDrop(event) {
    event.preventDefault();
    const destinoColuna = event.currentTarget.dataset.col;
    event.currentTarget.classList.remove("drag-over");

    if (!this.draggedCardId) return;

    if (this.origemColuna === destinoColuna) {
      console.log(
        `"${this.draggedCardTitle}" ficou em "${destinoColuna}" (não mudou de coluna)`
      );
      return;
    }

    const removed = this.removeCardFromLists(this.draggedCardId);
    if (!removed) return;

    this.addCardToColumn(destinoColuna, removed);

    console.log(
      `"${this.draggedCardId}" foi movida de "${this.origemColuna}" para "${destinoColuna}"`
    );

    updateTaskStatus({ taskId: this.draggedCardId, newStatus: destinoColuna })
      .then(() => {
        console.log(
          "Status da tarefa",
          this.draggedCardId,
          "atualizado para",
          destinoColuna
        );
      })
      .catch((error) => {
        console.error("Erro ao atualizar status da tarefa:", error);
      });

    this.draggedCardId = null;
    this.draggedCardTitle = null;
    this.draggedCardDeveloper = null;
    this.origemColuna = null;
  }

  removeCardFromLists(cardId) {
    // TODO
    let idx = this.todo.findIndex((c) => c.id === cardId);
    if (idx !== -1) {
      const [item] = this.todo.splice(idx, 1);
      this.todo = [...this.todo];
      return item;
    }

    // DOING
    idx = this.doing.findIndex((c) => c.id === cardId);
    if (idx !== -1) {
      const [item] = this.doing.splice(idx, 1);
      this.doing = [...this.doing];
      return item;
    }

    // TEST
    idx = this.test.findIndex((c) => c.id === cardId);
    if (idx !== -1) {
      const [item] = this.test.splice(idx, 1);
      this.test = [...this.test];
      return item;
    }

    // DONE
    idx = this.done.findIndex((c) => c.id === cardId);
    if (idx !== -1) {
      const [item] = this.done.splice(idx, 1);
      this.done = [...this.done];
      return item;
    }

    // REJECTED
    idx = this.rejected.findIndex((c) => c.id === cardId);
    if (idx !== -1) {
      const [item] = this.rejected.splice(idx, 1);
      this.rejected = [...this.rejected];
      return item;
    }

    return null;
  }

  addCardToColumn(colName, item) {
    if (colName === "To Do") this.todo = [...this.todo, item];
    else if (colName === "Doing") this.doing = [...this.doing, item];
    else if (colName === "Test") this.test = [...this.test, item];
    else if (colName === "Done") this.done = [...this.done, item];
    else if (colName === "Rejected") this.rejected = [...this.rejected, item];
    else this.todo = [...this.todo, item];
  }

  loadTasks() {
    getTasksFromActiveSprint()
      .then((tasks) => {
        const normalizedTasks = Array.isArray(tasks) ? tasks : [];

        const todo = [];
        const doing = [];
        const test = [];
        const done = [];
        const rejected = [];

        for (const task of normalizedTasks) {
          const item = {
            id: task.Id,
            title: task.Title__c,
            developer: task.Developer__r.Name__c
          };

          if (task.Status__c === "To Do") todo.push(item);
          else if (task.Status__c === "Doing") doing.push(item);
          else if (task.Status__c === "Test") test.push(item);
          else if (task.Status__c === "Done") done.push(item);
          else if (task.Status__c === "Rejected") rejected.push(item);
          else todo.push(item);
        }

        // se você quer substituir os mocks, use só isso:
        this.todo = todo;
        this.doing = doing;
        this.test = test;
        this.done = done;
        this.rejected = rejected;
      })
      .catch((error) => {
        console.error(error);
      });
  }

  connectedCallback() {
    this.loadTasks();
  }
}
