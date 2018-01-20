# anime-offline-database
The purpose of this *.json file is to create an offline database containing anime meta data aggregated by different anime source pages. This file is supposed to be used by manami.

**The goal is to deliver at least weekly updates.**

## Content
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
If you find anything that you think should be changed, please file an issue rather than creating a pull request.

## Structure
This repository contains three files. The database file itself and two files for regulation. One file with IDs which have been excluded from the database as well as a file with IDs from the distributor sites result in 404 not found.

### anime-offline-database.json
```
{
    "data": [
        {
            "id": "2d88de4c-9dbd-4837-b3ab-66c597c379ce",
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
                "https://myanimelist.net/anime/1535",
                "https://anidb.net/a8146",
                "https://anidb.net/a8147"
            ],
            "sources": {
                "https://myanimelist.net/anime/2994",
                "https://anidb.net/a4563"
            }
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

    ]
}
```