%% @author Tom Burdick <thomas.burdick@gmail.com>
%% @copyright 2011 Tom Burdick
%% @doc Erlapp Application.

-module(erlapp_app).

-behaviour(application).

%% application callbacks
-export([start/2, stop/1]).


%% ----------------------------------------------------------------------------
%% application callbacks
%% ----------------------------------------------------------------------------

%% @doc Start application.
-spec start(StartType::any(), StartArgs::any()) -> {ok, pid()}.
start(_StartType, _StartArgs) ->
    erlapp_sup:start_link().

%% @doc Stop application.
-spec stop(State::any()) -> {ok, pid()}.
stop(_State) ->
    ok.
