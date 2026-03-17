enum ChickenRarity {
    case veryCommon
    case common
    case uncommon
    case rare
    case veryRare
    
    var title: String {
        switch self {
            case .veryCommon:
                "Very Common"
            case .common:
                "Common"
            case .uncommon:
                "Uncommon"
            case .rare:
                "Rare"
            case .veryRare:
                "Very Rare"
        }
    }
}
