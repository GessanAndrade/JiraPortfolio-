import { LightningElement, wire, api } from 'lwc';
import getAllDevelopers from '@salesforce/apex/DeveloperController.getAllDevelopers';
import getDeveloperByTaskId from '@salesforce/apex/TaskController.getDeveloperByTaskId';
import { publish, MessageContext } from 'lightning/messageService';
import SIMPLE_CHANNEL from '@salesforce/messageChannel/SimpleMessageChannel__c';

export default class DeveloperSelectorLWC extends LightningElement {

    @api recordId;

    options = [];
    value; // DeveloperId selecionado (Id)

    @wire(MessageContext)
    messageContext;

    handleChange(event) {
        this.value = event.detail.value;

        const message = {
            Id: this.value,
            Integer: 0
        };

        publish(this.messageContext, SIMPLE_CHANNEL, message);
    }

    handleButtonClickDeveloper() {

        const message = {
            Id: this.value,
            Integer: 1
        };
        publish(this.messageContext, SIMPLE_CHANNEL, message);
    }

    @wire(getAllDevelopers)
    wiredDevelopers({ error, data }) {
        if (data) {
            this.options = data.map(dev => ({
                label: dev.Name__c,
                value: dev.Id
            }));
        } else if (error) {
            console.error('Erro getAllDevelopers:', error);
        }
    }

    @wire(getDeveloperByTaskId, { taskId: '$recordId' })
    wiredDeveloperId({ error, data }) {
        if (data) {
            this.value = data.Id; // data deve ser o DeveloperId
        } else if (error) {
            console.error('Erro getDeveloperByTaskId:', error);
        }
    }

}