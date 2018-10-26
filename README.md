# anime-offline-database
The purpose of this repository is to create an offline database containing anime meta data aggregated by different anime meta data provider (such as myanimelist.net, anidb.net, animenewsnetwork.com, anilist.co, kitsu.io) and allow cross reference between those meta data provider. This file is supposed to be used by [manami](https://github.com/manami-project/manami).

**The goal is to deliver at least weekly updates.**

## Statistics
Update **week 43 [2018]**

The database consists of **15129** entries composed of:
+ 15129 entries from myanimelist.net
+ 10350 entries from anidb.net
+ 11042 entries from anilist.co
+ 14083 entries from kitsu.io

## Participation
If you find something that, in you opinion, should be changed, please submit an issue rather than creating a pull request, because the database is created by an automated process.

## Structure
This repository contains two files. The database file itself and a file to support the automated process containing ID from the meta data provider which don't exist anymore.

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