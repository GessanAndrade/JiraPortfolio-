import { createElement } from "@lwc/engine-dom";
import PainelKanban from "c/painelKanban";

describe("c-painel-kanban", () => {
  afterEach(() => {
    // The jsdom instance is shared across test cases in a single file so reset the DOM
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
  });

  it("renderiza o card e as colunas do kanban", () => {
    const element = createElement("c-painel-kanban", {
      is: PainelKanban
    });

    document.body.appendChild(element);

    const board = element.shadowRoot.querySelector(".board");
    const columns = element.shadowRoot.querySelectorAll("section.col");

    expect(board).not.toBeNull();
    expect(columns.length).toBe(5);
  });
});
