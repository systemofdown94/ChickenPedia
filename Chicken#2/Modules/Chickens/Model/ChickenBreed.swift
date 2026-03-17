import SwiftUI

enum ChickenBreed: Int, Identifiable, CaseIterable, Codable {
    case leghorn = 0
    case rhodeIslandRed
    case plymouthRock
    case sussex
    case australorp
    case orpington
    case brahma
    case cochin
    case jerseyGiant
    case cornish
    case wyandotte
    case marans
    case araucana
    case ameraucana
    case easterEgger
    case hamburg
    case polish
    case sebright
    case silkie
    case faverolles
    case andalusian
    case minorca
    case campine
    case phoenix
    case yokohama
    case lakenvelder
    case dominique
    case barnevelder
    case welsummer
    case fayoumi
    
    var id: Self {
        self 
    }
    
    var name: String {
        switch self {
            case .leghorn: return "Leghorn"
            case .rhodeIslandRed: return "Rhode Island Red"
            case .plymouthRock: return "Plymouth Rock"
            case .sussex: return "Sussex"
            case .australorp: return "Australorp"
            case .orpington: return "Orpington"
            case .brahma: return "Brahma"
            case .cochin: return "Cochin"
            case .jerseyGiant: return "Jersey Giant"
            case .cornish: return "Cornish"
            case .wyandotte: return "Wyandotte"
            case .marans: return "Marans"
            case .araucana: return "Araucana"
            case .ameraucana: return "Ameraucana"
            case .easterEgger: return "Easter Egger"
            case .hamburg: return "Hamburg"
            case .polish: return "Polish"
            case .sebright: return "Sebright"
            case .silkie: return "Silkie"
            case .faverolles: return "Faverolles"
            case .andalusian: return "Andalusian"
            case .minorca: return "Minorca"
            case .campine: return "Campine"
            case .phoenix: return "Phoenix"
            case .yokohama: return "Yokohama"
            case .lakenvelder: return "Lakenvelder"
            case .dominique: return "Dominique"
            case .barnevelder: return "Barnevelder"
            case .welsummer: return "Welsummer"
            case .fayoumi: return "Fayoumi"
        }
    }
    
    var rarity: ChickenRarity {
        switch self {
            case .leghorn, .rhodeIslandRed, .plymouthRock, .sussex:
                return .veryCommon
                
            case .australorp, .orpington, .wyandotte, .cornish:
                return .common
                
            case .marans, .ameraucana, .welsummer, .barnevelder:
                return .uncommon
                
            case .brahma, .cochin, .faverolles, .minorca, .andalusian:
                return .rare
                
            case .silkie, .sebright, .phoenix, .yokohama, .lakenvelder, .campine, .hamburg, .dominique, .jerseyGiant, .fayoumi, .polish, .araucana, .easterEgger:
                return .veryRare
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .leghorn:
                    .Images.Chickens.leghorn
            case .rhodeIslandRed:
                    .Images.Chickens.rhodeIslandRed
            case .plymouthRock:
                    .Images.Chickens.plymouthRock
            case .sussex:
                    .Images.Chickens.sussex
            case .australorp:
                    .Images.Chickens.australorp
            case .orpington:
                    .Images.Chickens.orpington
            case .brahma:
                    .Images.Chickens.brahma
            case .cochin:
                    .Images.Chickens.cochin
            case .jerseyGiant:
                    .Images.Chickens.jerseyGiant
            case .cornish:
                    .Images.Chickens.cornish
            case .wyandotte:
                    .Images.Chickens.wyandotte
            case .marans:
                    .Images.Chickens.marans
            case .araucana:
                    .Images.Chickens.araucana
            case .ameraucana:
                    .Images.Chickens.ameraucana
            case .easterEgger:
                    .Images.Chickens.easterEgger
            case .hamburg:
                    .Images.Chickens.hamburg
            case .polish:
                    .Images.Chickens.polish
            case .sebright:
                    .Images.Chickens.sebright
            case .silkie:
                    .Images.Chickens.silkie
            case .faverolles:
                    .Images.Chickens.faverolles
            case .andalusian:
                    .Images.Chickens.andalusian
            case .minorca:
                    .Images.Chickens.minorca
            case .campine:
                    .Images.Chickens.campine
            case .phoenix:
                    .Images.Chickens.phoenix
            case .yokohama:
                    .Images.Chickens.yokohama
            case .lakenvelder:
                    .Images.Chickens.lakenvelder
            case .dominique:
                    .Images.Chickens.dominique
            case .barnevelder:
                    .Images.Chickens.barnevelder
            case .welsummer:
                    .Images.Chickens.welsummer
            case .fayoumi:
                    .Images.Chickens.fayoumi
        }
    }
    
    var description: String {
        switch self {
            case .leghorn:
                return """
                    The Leghorn is one of the most famous egg-laying chicken breeds in the world and is widely used in commercial poultry farming. Originating from Italy, this breed became globally popular after being refined in the United States and Northern Europe. Leghorns are known for their lightweight bodies, large upright combs, and active, alert behavior. They are extremely efficient layers of white eggs and are capable of producing large numbers of eggs while consuming relatively little feed. The breed comes in several color varieties, although the white Leghorn is by far the most common. Leghorns are hardy birds that adapt well to different climates but tend to be more independent and flighty compared to many backyard chicken breeds. Because of their productivity and efficiency, they are considered the foundation of modern industrial egg production.
                    """
                
            case .rhodeIslandRed:
                return """
                    The Rhode Island Red is a classic American chicken breed developed in the late nineteenth century in the state of Rhode Island. It is considered one of the most successful dual-purpose breeds, valued both for egg production and for meat. The birds are known for their deep reddish-brown plumage, strong bodies, and exceptional hardiness. Rhode Island Reds are adaptable to many environments and climates, making them very popular with backyard farmers and small poultry operations. They are good layers of brown eggs and can remain productive even in colder weather. The breed is also known for its resilience and ability to forage effectively when allowed to roam. Due to its reliability, durability, and consistent egg production, the Rhode Island Red has become one of the most widely recognized chicken breeds in the world.
                    """
                
            case .plymouthRock:
                return """
                    Plymouth Rock is a historic American chicken breed that has been widely raised since the nineteenth century. It is especially recognized for its distinctive barred black-and-white feather pattern, which gives the bird a striking appearance. Plymouth Rocks are medium to large birds that were originally developed as a dual-purpose breed, providing both eggs and meat for farm households. They are calm, friendly, and easy to manage, which makes them one of the best breeds for backyard flocks and beginner poultry keepers. The hens produce a steady supply of brown eggs and are known for their reliable laying performance. Plymouth Rocks are also hardy birds that tolerate a wide range of climates. Because of their balanced productivity and gentle temperament, they remain one of the most popular traditional farm chicken breeds.
                    """
                
            case .sussex:
                return """
                    The Sussex is an old and respected English chicken breed with a history that goes back hundreds of years. Originally developed in the county of Sussex in southern England, these birds were bred for both meat and egg production. Sussex chickens are medium to large birds with a calm temperament and excellent adaptability to different environments. One of the most recognizable varieties is the Light Sussex, which has a white body with black neck and tail feathers. Sussex hens are dependable layers of light brown eggs and are known for their ability to continue laying during colder months. They are also good foragers and do well in free-range systems. Due to their docile nature and steady productivity, Sussex chickens are commonly kept in backyard flocks around the world.
                    """
                
            case .australorp:
                return """
                    The Australorp is an Australian chicken breed famous for its remarkable egg-laying ability. It was developed in Australia from imported British Orpington chickens and selectively bred for improved egg production. Australorps are medium-to-large birds with glossy black feathers that often display a greenish sheen in sunlight. They have a calm and friendly temperament, making them easy to handle and suitable for small farms and backyard poultry keepers. This breed gained international recognition after setting world records for egg production in the early twentieth century. Australorp hens lay large brown eggs consistently and are considered one of the most productive traditional breeds. They are also hardy birds that can adapt to a variety of climates and management systems.
                    """
                
            case .orpington:
                return """
                    Orpington chickens were developed in England by poultry breeder William Cook in the late nineteenth century. The breed was designed to be a large dual-purpose bird suitable for both meat and egg production. Orpingtons are known for their soft, fluffy plumage and rounded body shape, which gives them a very full appearance. They are calm, friendly, and often very tolerant of human interaction, making them a popular choice for backyard poultry enthusiasts. Several color varieties exist, including buff, black, blue, and white, with the buff variety being the most famous. Orpington hens produce a good number of brown eggs and may also display broody behavior. Their gentle temperament and attractive appearance have made them one of the most beloved heritage chicken breeds.
                    """
                
            case .brahma:
                return """
                    The Brahma is one of the largest chicken breeds in the world and is often referred to as the "King of Chickens." This impressive breed was developed in the United States during the nineteenth century from large Asian chicken stock. Brahmas are easily recognized by their massive size, feathered legs, and distinctive head shape with a small pea comb. Despite their large size, they are known for having a calm and gentle temperament. Brahma hens lay medium to large brown eggs and often continue laying during the winter months when many other breeds slow down. Because of their thick plumage, they tolerate cold climates particularly well. The combination of impressive size, striking appearance, and docile personality makes the Brahma a favorite among poultry enthusiasts.
                    """
                
            case .cochin:
                return """
                    Cochins are large ornamental chickens originally imported from China during the nineteenth century. They became extremely popular in Europe and North America during a period sometimes referred to as "hen fever," when interest in exotic poultry breeds was at its peak. Cochins are known for their very abundant, fluffy plumage that covers not only their bodies but also their legs and feet. This gives them a round, almost ball-like appearance. Although they are not the most productive egg layers, Cochins are valued for their calm and friendly temperament. They are often used in ornamental flocks and poultry exhibitions. Cochins also tend to become broody easily, which means they are sometimes used to hatch eggs from other breeds.
                    """
                
            case .jerseyGiant:
                return """
                    The Jersey Giant is one of the largest chicken breeds ever developed and was created in the United States in the late nineteenth century. It was originally bred to provide an alternative to turkey as a large meat bird. Jersey Giants are massive birds with broad bodies, strong legs, and a calm disposition. Despite their size, they are generally gentle and easy to manage. The breed grows more slowly than commercial broiler chickens but produces high-quality meat. Jersey Giant hens also lay a moderate number of brown eggs each year. Because of their impressive size and steady temperament, they are often admired by poultry enthusiasts and kept both for practical farming and for exhibition.
                    """
                
            case .cornish:
                return """
                    The Cornish chicken originated in England and was initially developed for cockfighting due to its muscular build and strong frame. Over time, the breed became extremely important in commercial poultry production because of its ability to produce large amounts of meat. Cornish chickens have a broad chest, compact body, and powerful legs. Modern commercial broiler chickens are typically produced by crossing Cornish birds with other breeds to achieve rapid growth and efficient feed conversion. While pure Cornish chickens are not particularly strong egg layers, they are highly valued for their role in the poultry meat industry. Their unique body structure makes them visually distinct from most traditional chicken breeds.
                    """
            case .marans:
                return """
                    Marans is a famous French chicken breed that originated in the town of Marans in western France. It is especially valued for producing some of the darkest brown eggs of any chicken breed, often described as chocolate-colored. These birds are medium to large in size and typically have a calm temperament, making them suitable for backyard flocks and small farms. Marans chickens are hardy and adapt well to different climates, although they particularly thrive in temperate environments. Several plumage varieties exist, including the popular Black Copper Marans with its striking black body and copper-colored neck feathers. In addition to their beautiful eggs, Marans are also considered a decent dual-purpose breed that can provide both eggs and meat.
                    """
                
            case .araucana:
                return """
                    The Araucana is a distinctive chicken breed originally developed in Chile and is famous for laying naturally blue eggs. These birds are unusual in appearance because many of them lack tail feathers, a trait known as rumplessness. Araucanas may also have small feather tufts near their ears, which adds to their unique look. The breed is energetic and alert, often displaying active foraging behavior when allowed to roam freely. Araucana chickens played an important role in the development of several modern egg-color breeds. Although they are not the most prolific layers, their blue eggs make them very popular among poultry enthusiasts who enjoy collecting eggs of different colors.
                    """
                
            case .ameraucana:
                return """
                    The Ameraucana is an American chicken breed that was developed from Araucana stock in order to preserve the blue egg-laying trait while improving overall health and stability. Unlike Araucanas, Ameraucanas have full tails and beards of feathers around their faces, which give them a distinctive appearance. These chickens come in several officially recognized color varieties and are known for their calm temperament. Ameraucana hens consistently lay blue eggs, which makes them very popular among backyard poultry keepers interested in colorful egg baskets. They are considered moderately productive layers and generally adapt well to different climates and management systems.
                    """
                
            case .easterEgger:
                return """
                    Easter Egger is not a true standardized breed but rather a hybrid type of chicken that carries the blue egg gene originally derived from Araucana or Ameraucana chickens. These birds are extremely popular among backyard poultry keepers because they can lay eggs in a wide range of colors, including blue, green, turquoise, and sometimes pinkish shades. Easter Eggers vary widely in appearance and may have different feather colors, comb shapes, and body sizes. Because they are hybrids, they often benefit from hybrid vigor, making them hardy and adaptable birds. Their colorful eggs and friendly personalities make them one of the most popular chickens in small backyard flocks.
                    """
                
            case .hamburg:
                return """
                    Hamburg chickens are an old European breed that likely originated in northern Germany and the Netherlands before becoming popular in England. These birds are known for their elegant appearance and beautiful feather patterns, particularly the silver-spangled and golden-spangled varieties. Hamburgs are relatively small and lightweight chickens with active personalities and strong flying ability. They are excellent foragers and tend to prefer free-range environments where they can search for insects and seeds. Although they are not large birds, Hamburg hens are surprisingly productive layers of small white eggs. Their graceful appearance and lively behavior make them a favorite among poultry enthusiasts.
                    """
                
            case .polish:
                return """
                    Polish chickens are an ornamental breed that is instantly recognizable because of the large crest of feathers on top of their heads. Despite the name, the exact origin of the breed is uncertain, although it has been present in Europe for several centuries. The crest can sometimes limit the bird's vision, which gives them a somewhat quirky personality and behavior. Polish chickens are usually kept more for their unusual appearance than for egg production. They are relatively calm birds and often become favorites in backyard flocks due to their distinctive look. Many color varieties exist, including white-crested black and golden laced.
                    """
                
            case .sebright:
                return """
                    The Sebright is a small ornamental bantam chicken breed developed in England during the early nineteenth century by Sir John Sebright. It is famous for its beautiful laced feather pattern in which each feather is edged with a contrasting color. Sebrights are unique because both males and females have similar feather patterns and coloration. These birds are quite small and delicate compared to standard chicken breeds, and they are typically kept for exhibition and ornamental purposes. Although they do lay eggs, their egg production is relatively low. Their striking appearance, however, makes them one of the most admired bantam breeds in the poultry world.
                    """
                
            case .silkie:
                return """
                    Silkie chickens are one of the most unusual and recognizable chicken breeds in the world. They are named for their distinctive feathers, which lack the normal structure that keeps feathers smooth and flat. Instead, their plumage is soft and fluffy, resembling fur rather than typical feathers. Silkies also have several unusual traits, including dark skin, blue earlobes, and five toes on each foot instead of the usual four. The breed originated in Asia and has been known in Europe for several centuries. Silkies are extremely gentle and friendly birds, often used as broody hens to hatch eggs from other breeds. Their unique appearance makes them especially popular in ornamental flocks.
                    """
                
            case .faverolles:
                return """
                    Faverolles is a French chicken breed originally developed in the village of Faverolles during the nineteenth century. These birds were bred as a dual-purpose farm chicken capable of providing both meat and eggs. Faverolles chickens are easily recognized by their beard, muffs, feathered legs, and the unusual trait of having five toes. They typically have a gentle and friendly temperament, which makes them very suitable for backyard flocks. The most common variety is the Salmon Faverolles, which has a distinctive salmon-colored plumage pattern. In addition to their attractive appearance, they are valued for their calm nature and reliable egg production.
                    """
                
            case .andalusian:
                return """
                    Andalusian chickens originate from the Andalusia region of southern Spain and are best known for their striking blue-gray plumage. This unique color is the result of a special genetic combination that produces the characteristic slate-blue feathers with darker edges. Andalusians are active and energetic birds that prefer environments where they have space to move and forage. They are relatively good layers of white eggs and are well adapted to warm climates. Their elegant appearance and unusual feather coloration have made them a popular breed among poultry enthusiasts and exhibition breeders.
                    """
                
            case .minorca:
                return """
                    Minorca chickens come from the Mediterranean island of Minorca, which belongs to Spain. They are one of the largest Mediterranean chicken breeds and are particularly known for laying very large white eggs. Minorcas have sleek black plumage with a greenish sheen and a large red comb that stands upright in males and may flop over in females. These birds are active and alert and prefer warm climates similar to those of their Mediterranean homeland. While they are not typically raised for meat, they are valued for their excellent egg-laying ability and distinctive appearance.
                    """
                
            case .campine:
                return """
                    Campine chickens originate from Belgium and are closely related to the Dutch Braekel breed. They are small, active birds known for their beautiful barred plumage patterns in either silver or golden coloration. Campines are energetic and alert, often preferring free-range environments where they can forage for food. They are relatively good layers of white eggs considering their small size. Campines are also known for their graceful appearance and upright posture. Because of their lively temperament and elegant feather pattern, they are appreciated by poultry enthusiasts interested in traditional European breeds.
                    """
                
            case .phoenix:
                return """
                    Phoenix chickens are an ornamental breed developed in Germany using long-tailed Japanese chickens as foundation stock. The breed is famous for its extremely long tail feathers, which can grow several feet in length under proper care. Phoenix birds have a graceful and elegant appearance and are often kept primarily for exhibition and ornamental purposes. They are relatively lightweight birds and are not typically raised for meat production. Although they do lay eggs, their egg production is moderate at best. Their striking appearance and flowing tails make them one of the most visually impressive chicken breeds.
                    """
                
            case .yokohama:
                return """
                    Yokohama chickens are a rare ornamental breed that originated from Japanese long-tailed chickens and was further developed in Europe. These birds are known for their exceptionally long tail feathers and elegant posture. Yokohamas often have white plumage with red markings on the shoulders and saddle feathers. They are typically kept for decorative purposes rather than for egg or meat production. The breed is relatively rare and is mainly maintained by dedicated poultry breeders and hobbyists who appreciate its unusual beauty. Their graceful appearance makes them a striking addition to ornamental poultry collections.
                    """
                
            case .lakenvelder:
                return """
                    Lakenvelder chickens are a distinctive European breed that originated in the border region between Germany and the Netherlands. They are known for their striking black-and-white color pattern in which the body is white while the neck and tail are solid black. This unique pattern makes them easy to recognize among other chicken breeds. Lakenvelders are active birds that enjoy free-ranging and foraging for food. They are moderately good egg layers and produce white eggs. Although not as common as some commercial breeds, they remain popular among poultry enthusiasts who appreciate heritage chickens.
                    """
                
            case .dominique:
                return """
                    Dominique chickens are considered one of the oldest American chicken breeds and played an important role in early American agriculture. They were commonly raised by settlers because of their hardiness and ability to adapt to harsh conditions. Dominiques have a distinctive barred feather pattern similar to that of the Plymouth Rock but with a rose comb instead of a single comb. They are calm and friendly birds that are well suited for backyard flocks. Dominique hens produce a steady supply of brown eggs and are also known to be good mothers when raising chicks.
                    """
                
            case .barnevelder:
                return """
                    Barnevelder chickens originate from the Netherlands and were developed during the early twentieth century. They became popular for their ability to lay rich dark brown eggs. One of the most admired features of the breed is its beautiful double-laced feather pattern, where each feather displays two contrasting color edges. Barnevelders are calm, friendly birds that adapt well to both confinement and free-range environments. They are reliable layers and continue producing eggs even during colder months. Their combination of beauty and productivity makes them a popular heritage breed among poultry keepers.
                    """
                
            case .welsummer:
                return """
                    Welsummer chickens come from the Netherlands and are well known for producing terracotta-colored eggs with dark speckles. The breed was developed in the early twentieth century and quickly gained popularity among farmers and poultry enthusiasts. Welsummers have attractive reddish-brown plumage with black and gold highlights. They are active birds that enjoy free-ranging and are excellent foragers. In addition to their beautiful eggs, they are valued for their hardy nature and adaptability. Their distinctive egg color and attractive feather pattern have made them a favorite among backyard chicken keepers.
                    """
                
            case .fayoumi:
                return """
                    Fayoumi chickens are an ancient breed originating from Egypt, particularly from the region around the Fayoum oasis. These birds are known for their exceptional hardiness, disease resistance, and ability to thrive in hot climates. Fayoumis are small but very active chickens that are excellent foragers and capable of surviving in challenging environments. They mature quickly and begin laying eggs at a relatively young age compared to many other breeds. Although their eggs are somewhat smaller than those of larger breeds, they are very consistent layers. Because of their resilience and adaptability, Fayoumis are sometimes used in breeding programs aimed at improving disease resistance in poultry.
                    """
            case .wyandotte:
                return """
                The Wyandotte is a well-known American chicken breed that was developed in the United States during the late nineteenth century. It was created as a hardy and productive dual-purpose bird that could provide both eggs and meat for farm households. Wyandottes are medium to large chickens with rounded bodies, a rose comb, and dense plumage that helps them tolerate colder climates. One of the most admired features of the breed is its wide variety of beautiful feather patterns, including silver-laced, golden-laced, blue, black, and several other color varieties. The laced varieties are especially striking because each feather is outlined with a contrasting color.
                
                Wyandotte chickens are generally calm, friendly, and easy to manage, which makes them a popular choice for backyard poultry keepers. They adapt well to different living conditions and can thrive in both free-range environments and enclosed coops. Hens are reliable layers of medium to large brown eggs and tend to produce consistently throughout the year, including during colder seasons when some breeds slow down.
                
                Because of their combination of attractive appearance, steady egg production, and hardy temperament, Wyandottes have remained one of the most popular heritage chicken breeds in North America and many other parts of the world. They are commonly kept by both small-scale farmers and poultry enthusiasts who appreciate traditional and visually distinctive chicken breeds.
                """
        }
    }
    
    var averageLifespanYears: Double {
        switch self {
            case .jerseyGiant, .brahma:
                return 8
            case .silkie, .polish:
                return 7
            default:
                return 6
        }
    }
    
    var averagePriceUSD: Double {
        switch rarity {
            case .veryCommon: return 15
            case .common: return 20
            case .uncommon: return 30
            case .rare: return 45
            case .veryRare: return 60
        }
    }
    
    var eggsPerWeek: Double {
        switch self {
            case .leghorn: return 6
            case .rhodeIslandRed, .australorp: return 5.5
            case .plymouthRock, .sussex, .orpington: return 5
            case .marans, .ameraucana, .welsummer: return 4
            case .silkie, .sebright, .phoenix, .yokohama: return 2
            default: return 3.5
        }
    }
    
    var color: Color {
        switch rarity {
            case .veryCommon:
                Color(hex: "#9AA0A6")
            case .common:
                Color(hex: "#4CAF50")
            case .uncommon:
                Color(hex: "#3FA7FF")
            case .rare:
                Color(hex: "#9C6BFF")
            case .veryRare:
                Color(hex: "#FFB74D")
        }
    }
}
