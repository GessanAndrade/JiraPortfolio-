import { createElement } from '@lwc/engine-dom';
import DeveloperSelectorLWC from 'c/developerSelectorLWC';

describe('c-developer-selector-lwc', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('renderiza combobox e botao de update', () => {
        const element = createElement('c-developer-selector-lwc', {
            is: DeveloperSelectorLWC
        });

        document.body.appendChild(element);

        const combobox = element.shadowRoot.querySelector('lightning-combobox');
        const button = element.shadowRoot.querySelector('lightning-button');

        expect(combobox).not.toBeNull();
        expect(button).not.toBeNull();
    });
});