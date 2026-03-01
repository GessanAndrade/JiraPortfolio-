import { LightningElement, api } from 'lwc';
import searchAllDevelopers from '@salesforce/apex/DeveloperController.getAllDevelopers';

export default class DeveloperLWC extends LightningElement {
    //A notação @api faz com que o atributo seja acessivel pelo lightning web component
    @api recordId;
    //Declaração dos atributos da class
    contas;
    error;

    connectedCallback() {
        searchAllDevelopers()
            .then((listaRetornada) => {
                this.contas = listaRetornada;
                this.error = undefined;
            })
            .catch((error) => {
                this.error = error.body.message;
                this.contas = undefined;
            });
    }
}