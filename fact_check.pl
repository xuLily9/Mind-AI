% Define the knowledge base with verified facts.
% Each fact is represented as a predicate.
fact(historical_event, "Apollo 11 moon landing", 1969).
fact(historical_event, "Einstein's theory of relativity publication", 1915).
fact(historical_event, "Declaration of Independence signing", 1776).

% Define a predicate to check if a fact exists in the knowledge base.
fact_exists(Fact, Year) :- fact(historical_event, Fact, Year).

% Define a predicate to check if the response contains a specific fact.
response_contains_fact(Response, Fact) :-
    fact_exists(Fact, _),  % Check if the fact exists in the knowledge base
    sub_string(Response, _, _, _, Fact).  % Check if the fact is mentioned in the response

% Example usage:
% Sample response from the MRC system
response("The Apollo 11 moon landing occurred in 1969.").

% Check if the response contains a specific fact
%?- response_contains_fact("The Apollo 11 moon landing occurred in 1969.", "Apollo 11 moon landing").
