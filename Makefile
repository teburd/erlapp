ERL ?= erl
APP := erlapp

.PHONY: all compile deps eunit rel clean

all: compile

deps:
	@./rebar get-deps

update:
	@./rebar update-deps
	@./rebar compile

compile:
	@./rebar compile

fast:
	@./rebar compile skip_deps=true

clean_fast:
	@./rebar clean skip_deps=true

clean:
	@./rebar clean

distclean: clean
	@./rebar delete-deps

refresh: clean distclean deps compile

doc:
	@./rebar skip_deps=true doc

APPS = kernel stdlib sasl erts ssl tools os_mon runtime_tools crypto inets \
	   	xmerl webtool snmp public_key mnesia eunit syntax_tools compiler
COMBO_PLT = $(HOME)/.erlapp_dialyzer_plt

build_plt:
	dialyzer --build_plt --output_plt $(COMBO_PLT) --apps $(APPS) deps/*/ebin ebin

dialyzer:
	@echo
	@echo Use "'make build_plt'" to build PLT prior to using this target.
	@echo
	@sleep 1
	dialyzer -Wno_return --plt $(COMBO_PLT) apps/*/ebin deps/*/ebin ebin

clean_plt:
	@echo
	@echo "Ary you sure? It takes about 1/2 hour to re-build."
	@echo Deleting $(COMBO_PLT) in 5 seconds.
	@echo
	sleep 5
	rm $(COMBO_PLT)

ct:
	@./rebar skip_deps=true ct

ct_all:
	@./rebar ct

typer:
	typer --plt $(COMBO_PLT) -r apps -I deps -I apps

eunit:
	rm -f .eunit/*.dat
	@./rebar skip_deps=true eunit

eunit_all:
	rm -f .eunit/*.dat
	@./rebar eunit

test: all eunit ct

test_all: eunit_all ct_all

rel: rel/reltool.config rel_clean all
	@./rebar generate

rel_clean:
	rm -rf rel/erlapp
