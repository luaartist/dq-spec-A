.PHONY: paper scan clean distclean

PAPER_DIR := paper
MAIN      := main

paper: scan
	cd $(PAPER_DIR) && latexmk -pdf -interaction=nonstopmode -halt-on-error $(MAIN).tex

scan:
	@bash scripts/scan.sh

clean:
	cd $(PAPER_DIR) && latexmk -c $(MAIN).tex || true

distclean:
	cd $(PAPER_DIR) && latexmk -C $(MAIN).tex || true
	rm -f $(PAPER_DIR)/$(MAIN).pdf
