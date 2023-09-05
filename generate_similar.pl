synonym('The cat is on the mat', 'The feline is on the rug').
synonym('The cat is on the mat', 'A cat sits on the carpet').
synonym('The cat is on the mat', 'A kitty is on the pad').
synonym('The cat is on the mat', 'The feline is resting on the rug').
synonym('The cat is on the mat', 'A kitten is on the rug').

generate_synonyms(Sentence, Synonyms) :-
    findall(Synonym, synonym(Sentence, Synonym), Synonyms).
