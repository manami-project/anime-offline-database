# manami-offline-database
The purpose of this *.json file is to create an offline database containing anime meta data aggregated by different anime source pages. This file is supposed to used by manami.

The target structure of the resulting file is as follows:

```
{
    "data": [
        {
            "id": "UUID",
            "title": "Death Note",
            "synonyms": [
                "Death Note: Relight",
                "DN",
                "デスノート"
            ],
            "type": "TV",
            "episodes": 37,
            "picture": "https://myanimelist.cdn-dena.com/images/anime/13/8518.jpg",
            "thumbnail": "https://myanimelist.cdn-dena.com/images/anime/13/8518t.jpg",
            "relations": [
                {
                    "relation": "Summary",
                    "id": "???"
                }
            ],
            "sources": {
                "https://myanimelist.net/anime/2994",
                "https://anidb.net/perl-bin/animedb.pl?show=anime&aid=4563",
                "https://www.animenewsnetwork.com/encyclopedia/anime.php?id=6592"
            }
        }
    ],
    "excludes": {
        "mal": [
            "36069"
        ]
    },
    "404": {
        "mal": [
            "2"
        ]
    }
}
```
**Data types**

| Field | Type |
| --- | --- |
| data | List|
| id | String|
| title | String|
| synonyms | Set|
| type | Enum of [TV, Movie, OVA, ONA, Special, Music]|
| episodes | Integer |
| picture | Url |
| thumbnail | Url |
| relations | Set |
| sources | Set |
| excludes | Object |
| mal in excludes | Set |
| 404 | Object |
| mal in 404 | Set |

This database should only contain real japanese anime. The following types are to be excluded:
+ commercials/promotions
+ stop motion videos
+ music videos
+ pure CG records without real anime relations
+ any non-japanese productions (korean, chinese, american...)
+ anime before 1970