import { createElement } from "@lwc/engine-dom";
import DeveloperLWC from "c/developerLWC";

describe("c-developer-lwc", () => {
  afterEach(() => {
    // The jsdom instance is shared across test cases in a single file so reset the DOM
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
  });

  it("renderiza lightning-card do componente", () => {
    const element = createElement("c-developer-lwc", {
      is: DeveloperLWC
    });

    document.body.appendChild(element);

    const card = element.shadowRoot.querySelector("lightning-card");
    expect(card).not.toBeNull();
  });
});
