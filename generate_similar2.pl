% Define synonyms for words
%synonyms("I", ["I", "myself", "me"]).
synonyms("want", ["want", "desire", "wish"]).
synonyms("to", ["to", "towards", "for", "in the direction of"]).
synonyms("book", ["book", "reserve", "purchase", "get", "secure"]).
synonyms("a", ["a", "an"]).
synonyms("flight", ["flight", "airfare", "journey", "trip", "voyage"]).
synonyms("to", ["to", "towards", "for", "in the direction of"]).
synonyms("Paris", ["Paris", "the City of Light", "the French capital"]).

% Replace a word with a randomly selected synonym
replace_word(Word, Synonyms, Synonym) :-
    member(Synonym, Synonyms),
    Synonym \= Word.

% Generate a sentence with replaced words
generate_similar_sentence(OriginalSentence, SimilarSentence) :-
    split_string(OriginalSentence, " ", " ", OriginalWords),
    maplist(replace_word_in_wordlist, OriginalWords, Synonyms, SimilarWords),
    atomic_list_concat(SimilarWords, ' ', SimilarSentence).

% Replace a word in a list with a synonym
replace_word_in_wordlist(Word, Synonyms, Synonym) :-
    (synonyms(Word, Synonyms) ->
        random_member(Synonym, Synonyms)
    ; % If no synonyms are available, keep the original word
        Synonym = Word
    ).

% Generate 5 similar sentences based on a seed sentence
generate_5_similar_sentences(SeedSentence, SimilarSentences) :-
    findall(SimilarSentence, (
        between(1, 5, _),  % Generate 5 similar sentences
        generate_similar_sentence(SeedSentence, SimilarSentence)
    ), SimilarSentences).

% Example usage:

