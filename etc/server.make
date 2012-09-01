DOC_DIR    = ${SOCIAL_ROOT}/build/server/
SCRIPT_DIR = $(addsuffix /,$(subst src/server,build/server,$(realpath .)))

SOURCE_DOCS = $(wildcard *.html *.css)
DOCS        = $(addprefix $(DOC_DIR),$(SOURCE_DOCS))

SCRIPTS =  $(addprefix $(SCRIPT_DIR),$(wildcard *.js *.json))
SCRIPTS += $(addprefix $(SCRIPT_DIR),$(patsubst %.coffee,%.js,$(wildcard *.coffee)))
SCRIPTS += $(addprefix $(SCRIPT_DIR),$(patsubst %.cson,%.json,$(wildcard *.cson)))

$(SCRIPT_DIR)%.js: %.coffee
	coffee --compile --output $(SCRIPT_DIR) $< 

$(SCRIPT_DIR)%.json: %.cson
	coffee --compile --output $(SCRIPT_DIR)/$*.json $< 

$(SCRIPT_DIR)%.js: %.js
	cp $< $(SCRIPT_DIR)

$(SCRIPT_DIR)%.json: %.json
	cp $< $(SCRIPT_DIR)

$(DOC_DIR)%.css: %.css
	cp $< $(DOC_DIR)

$(DOC_DIR)%.html: %.html
	cp $< $(DOC_DIR)

.PHONY: all
all: $(SCRIPTS) $(DOCS)

# Local Variables:
# mode: makefile
# End: