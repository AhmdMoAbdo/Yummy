//
//  Flags.swift
//  Yummy
//
//  Created by Ahmed on 21/08/2023.
//

import Foundation

class Flags {
    public static func getFlag (mealSource: String) -> String{
        switch mealSource {
        case "American":
            return "https://flagcdn.com/w320/us.png"
        case "British" :
            return "https://flagcdn.com/w320/gb.png"
        case "Canadian" :
            return "https://flagcdn.com/w320/ca.png"
        case "Chinese" :
            return "https://flagcdn.com/w320/cn.png"
        case "Croatian" :
            return "https://flagcdn.com/w320/hr.png"
        case "Dutch" :
            return "https://flagcdn.com/w320/nl.png"
        case "Egyptian" :
            return "https://flagcdn.com/w320/eg.png"
        case "French" :
            return "https://flagcdn.com/w320/fr.png"
        case "Greek" :
            return "https://flagcdn.com/w320/gr.png"
        case "Indian" :
            return "https://flagcdn.com/w320/in.png"
        case "Irish" :
            return "https://flagcdn.com/w320/ie.png"
        case "Italian" :
            return "https://flagcdn.com/w320/it.png"
        case "Jamaican" :
            return "https://flagcdn.com/w320/jm.png"
        case "Japanese" :
            return "https://flagcdn.com/w320/jp.png"
        case "Kenyan" :
            return "https://flagcdn.com/w320/ke.png"
        case "Malaysian" :
            return "https://flagcdn.com/w320/my.png"
        case "Mexican" :
            return "https://flagcdn.com/w320/mx.png"
        case "Moroccan" :
            return "https://flagcdn.com/w320/ma.png"
        case "Polish" :
            return "https://flagcdn.com/w320/pl.png"
        case "Portuguese" :
            return "https://flagcdn.com/w320/pt.png"
        case "Russian" :
            return "https://flagcdn.com/w320/ru.png"
        case "Spanish" :
            return "https://flagcdn.com/w320/es.png"
        case "Thai" :
            return "https://flagcdn.com/w320/th.png"
        case "Tunisian" :
            return "https://flagcdn.com/w320/tn.png"
        case "Turkish" :
            return "https://flagcdn.com/w320/tr.png"
        case "Vietnamese" :
            return "https://flagcdn.com/w320/vn.png"
        default:
            return "https://flagcdn.com/w320/ph.png"
        }
    }
}
