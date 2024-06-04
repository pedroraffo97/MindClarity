//
//  StoicPhrasesClass.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 29.02.24.
//

import Foundation

struct StoicPhrase: Hashable, Encodable, Decodable, Identifiable {
    var code: Int
    var phrase: String
    var autor: String
    var id = UUID()
}

class PhrasesLibrary: ObservableObject {
    @Published var phrasesArray = [
    
        StoicPhrase(code: 0, phrase: "Think of the life you have lived until now as over and, as a dead man, see what’s left as a bonus and live it according to Nature. Love the hand that fate deals you and play it as your own, for what could be more fitting?", autor: "Marcus Aurelius"),
        StoicPhrase(code: 1, phrase: "It never ceases to amaze me: we all love ourselves more than other people, but care more about their opinion than our own.", autor: "Marcus Aurelius"),
        StoicPhrase(code: 2, phrase: "He who fears death will never do anything worth of a man who is alive.", autor: "Seneca"),
        StoicPhrase(code: 3, phrase: "It's not that we have a short time to live, but that we waste much of it.", autor: "Seneca"),
        StoicPhrase(code: 4, phrase: "The best revenge is to be unlike him who performed the injustice.", autor: "Marcus Aurelius"),
        StoicPhrase(code: 5, phrase: "He who has a why to live can bear almost any how.", autor: "Friedrich Nietzsche"),
        StoicPhrase(code: 6, phrase: "He who is brave is free.", autor: "Seneca"),
        StoicPhrase(code: 7, phrase: "We suffer more often in imagination than in reality.", autor: "Seneca"),
        StoicPhrase(code: 8, phrase: "No person has the power to have everything they want, but it is in their power not to want what they don't have, and to cheerfully put to good use what they do have.", autor: "Seneca"),
        StoicPhrase(code: 9, phrase: "The best revenge is to be unlike him who performed the injustice.", autor: "Marcus Aurelius"),
        StoicPhrase(code: 10, phrase: "It is not that we have a short time to live, but that we waste much of it.", autor: "Seneca"),
        StoicPhrase(code: 11, phrase: "Very little is needed to make a happy life; it is all within yourself, in your way of thinking.", autor: "Marcus Aurelius"),
        StoicPhrase(code: 12, phrase: "Waste no more time arguing about what a good man should be. Be one.", autor: "Marcus Aurelius"),
        StoicPhrase(code: 13, phrase: "It's not that we have a short time to live, but that we waste much of it.", autor: "Seneca"),
        StoicPhrase(code: 14, phrase: "It is not the man who has too little, but the man who craves more, that is poor.", autor: "Seneca"),
        StoicPhrase(code: 15, phrase: "It is not that we have a short time to live, but that we waste much of it.", autor: "Seneca"),
        StoicPhrase(code: 16, phrase: "The best revenge is to be unlike him who performed the injustice.", autor: "Marcus Aurelius"),
        StoicPhrase(code: 17, phrase: "No person has the power to have everything they want, but it is in their power not to want what they don't have, and to cheerfully put to good use what they do have.", autor: "Seneca"),
        StoicPhrase(code: 18, phrase: "He who is brave is free.", autor: "Seneca"),
        StoicPhrase(code: 19, phrase: "Very little is needed to make a happy life; it is all within yourself, in your way of thinking.", autor: "Marcus Aurelius"),
        StoicPhrase(code: 20, phrase: "Waste no more time arguing about what a good man should be. Be one.", autor: "Marcus Aurelius"),
        StoicPhrase(code: 21, phrase: "It's not that we have a short time to live, but that we waste much of it.", autor: "Seneca")
    ]
}
