import { createElement } from "@lwc/engine-dom";
import DeveloperPanelLWC from "c/developerPanelLWC";

describe("c-developer-panel-lwc", () => {
  afterEach(() => {
    // The jsdom instance is shared across test cases in a single file so reset the DOM
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
  });

  it("renderiza lightning-card do painel", () => {
    const element = createElement("c-developer-panel-lwc", {
      is: DeveloperPanelLWC
    });

    document.body.appendChild(element);

    const card = element.shadowRoot.querySelector("lightning-card");
    expect(card).not.toBeNull();
  });
});
