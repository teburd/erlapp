%% @author Tom Burdick <thomas.burdick@gmail.com>
%% @copyright 2011 Tom Burdick
%% @doc Erlapp development startup.

-module(erlapp).

-export([start/0, stop/0]).

%% @doc Ensure an erlang application is started.
-spec ensure_started(App::atom()) -> term().
ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.

%% @doc Start.
start() ->
    dbg:start(),   % start dbg
    dbg:tracer(),  % start a simple tracer process
    dbg:p(all, c),   % trace calls (c) of that MFA for all processes.
    ensure_started(erlapp),
    ok.

%% @doc Stop.
stop() ->
    application:stop(erlapp),
    ok.
