# anime-offline-database
The purpose of this repository is to create an offline database containing anime meta data aggregated by different anime source pages (such as myanimelist.net, anidb.net, animenewsnetwork.com, anilist.co) and allow cross reference between those source pages. This file is supposed to be used by manami.

**The goal is to deliver at least weekly updates.**

## Statistics
Update  **week 36 [2018]**

The database consists of **12 121** entries composed of:
+ 12 253 entries from myanimelist.net
+ 8 836 entries from anidb.net
+ 10 728 entries from anilist.co
+ 14 045 entries from kitsu.io

## Content

### [Please give me Feedback on this topic in this issue.](https://github.com/manami-project/anime-offline-database/issues/1)

This database is limited to a certain type of anime. Anime which match the following criteria are to be **excluded**:
+ commercials/promotions
+ stop motion productions
+ music videos
+ pure CG productions
+ abstract animations
+ unrelated shorts
+ any non-japanese productions (korean, chinese, american...)
+ anime before 1970

## Participation
If you find something you think should be changed, please submit an issue rather than creating a pull request.

## Structure
This repository contains four files. The database file itself and three files for regulation. One file with IDs which have been excluded from the database, a file with IDs from the source pages which result in 404 not found as well as a whitelist.

### anime-offline-database.json
Example of the structure:
```
{
    "data": [
        {
            "sources": [
                "http://anilist.co/anime/1535",
                "https://anidb.net/a4563",
                "https://animenewsnetwork.com/encyclopedia/anime.php?id=6592",
                "https://kitsu.io/anime/1376",
                "https://myanimelist.net/anime/1535"
            ],
            "type": "TV",
            "title": "Death Note",
            "picture": "https://myanimelist.cdn-dena.com/images/anime/9/9453.jpg",
            "relations": [
                "http://anilist.co/anime/2994",
                "https://anidb.net/a8146",
                "https://anidb.net/a8147",
                "https://myanimelist.net/anime/2994"
            ],
            "id": "2d88de4c-9dbd-4837-b3ab-66c597c379ce",
            "thumbnail": "https://myanimelist.cdn-dena.com/images/anime/9/9453t.jpg",
            "episodes": 37,
            "synonyms": [
                "Caderno da Morte",
                "DEATH NOTE",
                "DN",
                "Death Note",
                "Death Note - A hal\u00e1llista",
                "Death Note - Carnetul mor\u0163ii",
                "Death Note - Z\u00e1pisn\u00edk smrti",
                "Mirties U\u017era\u0161ai",
                "Notatnik \u015bmierci",
                "Notes \u015amierci",
                "Quaderno della Morte",
                "Sveska Smrti",
                "\u00d6l\u00fcm Defteri",
                "\u03a4\u03b5\u03c4\u03c1\u03ac\u03b4\u03b9\u03bf \u0398\u03b1\u03bd\u03ac\u03c4\u03bf\u03c5"
            ]
        }
    ]
}
```
**Data types**

| Field | Type |
| --- | --- |
| data | ```List``` |
| id | ```UUID``` |
| title | ```String``` |
| synonyms | ```Set<String>``` |
| type | ```Enum of [TV, Movie, OVA, ONA, Special, Music]``` |
| episodes | ```Integer``` |
| picture | ```URL``` |
| thumbnail | ```URL``` |
| relations | ```Set<URL>``` |
| sources | ```Set<URL>``` |

### excludes.json
File for controlling the automatic update process. Contains ID's which don't meet the database's criteria and therefore have been excluded from it.
```
{
    "mal": [
        36069
    ],
    "anidb": [

    ],
    "anilist": [

    ]
}
```

### not-found.json
File for controlling the automatic update process. Contains ID's which have been removed.
```
{
    "mal": [
        2
    ],
    "anidb": [

    ],
    "anilist": [

    ]
}
```

### whitelist.json
File for controlling the automatic update process. Contains ID's trigger the filter, but are fine to be included in the databse.
```
{
    "mal": [
        3626
    ],
    "anidb": [

    ],
    "anilist": [

    ]
}
```