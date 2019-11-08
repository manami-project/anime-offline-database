# anime-offline-database ![CI build status](https://github.com/manami-project/anime-offline-database/workflows/Check%20JSON%20files/badge.svg "CI build status: Check JSON files")
The purpose of this repository is to create an offline database containing anime meta data aggregated by different anime meta data providers (such as myanimelist.net, anidb.net, anilist.co and kitsu.io) and allow cross references between those meta data providers. This file is supposed to be used by and created for [manami](https://github.com/manami-project/manami).

**The goal is to deliver at least weekly updates.**

## Statistics
Update **week 45 [2019]**

The database consists of **30853** entries composed of:
+ 16366 entries from myanimelist.net
+ 14695 entries from kitsu.io
+ 12704 entries from notify.moe
+ 12020 entries from anilist.co
+ 10952 entries from anidb.net

Missed updates:
+ **2019** _(so far)_: 2
+ **2018:** 1

**You want more statistics and insights? Check out [adb-zeppelin-statistics](https://github.com/manami-project/adb-zeppelin-statistics)**

## Participation
If you want to contribute, please read the [contribution guidelines](./.github/CONTRIBUTING.md) first.

## Structure
This repository contains four files. The database file itself and a file to support the automated process containing IDs from the meta data providers which don't exist anymore. Additionally there are two files which support the merging of the automated process.

### anime-offline-database.json
Example of the structure:
```json
{
    "data": [
        {
            "sources": [
                "http://anilist.co/anime/1535",
                "https://anidb.net/anime/4563",
                "https://kitsu.io/anime/1376",
                "https://myanimelist.net/anime/1535"
            ],
            "type": "TV",
            "title": "Death Note",
            "picture": "https://cdn.myanimelist.net/images/anime/9/9453.jpg",
            "relations": [
                "http://anilist.co/anime/2994",
                "https://anidb.net/anime/8146",
                "https://anidb.net/anime/8147",
                "https://myanimelist.net/anime/2994"
            ],
            "thumbnail": "https://cdn.myanimelist.net/images/anime/9/9453t.jpg",
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
| title | ```String``` |
| synonyms | ```Set<String>``` |
| type | ```Enum of [TV, Movie, OVA, ONA, Special]``` |
| episodes | ```Integer``` |
| picture | ```URL``` |
| thumbnail | ```URL``` |
| relations | ```Set<URL>``` |
| sources | ```Set<URL>``` |

### merge-preventions.md
Contains anime whose merging was prevented, as well as the reason why. Entries in this file are the base for creating `merge locks`.

Example:
```
Year [1993] does not match [1992]. Not merging [https://anidb.net/anime/3172] into [https://kitsu.io/anime/12337, https://myanimelist.net/anime/32628].
Duration [1800]seconds does not match [1500]seconds. Not merging [https://anilist.co/anime/6868] into [https://anidb.net/anime/2880, https://kitsu.io/anime/4761, https://myanimelist.net/anime/6868].
```

### merge-locks.json
Contains `merge locks`. A `merge lock` indicates that all entries within this lock will be merged together. This is necessary to merge entries that appear in the `merge-preventions.md`. You can help in two ways to fill this list and therefore increase the quality of this database. Check the [contribution guidelines](./.github/CONTRIBUTING.md)

Example:
```json
[
    [
        "https://anidb.net/anime/3172",
        "https://kitsu.io/anime/12337",
        "https://myanimelist.net/anime/32628"
    ],
    [
        "https://anilist.co/anime/6868",
        "https://anidb.net/anime/2880",
        "https://kitsu.io/anime/4761",
        "https://myanimelist.net/anime/6868"
    ]
]
```

### dead-entries.json
Contains IDs which have been removed from the meta data provider's database.
```json
{
    "mal": [
        38492,
        38518,
        38522,
        38531,
        ...
    ],
    "anidb": [
        4612,
        14190,
        ...
    ],
    "anilist": [
        104857,
        104735,
        104888,
        104870,
        104747,
        ...
    ],
    "kitsu": [
        14230,
        41667,
        41698,
        41755,
        ...
    ]
}
```

## Other projects using this database
If you have a project that uses this database and you want to add it to this list, please read the [contribution guidelines](./.github/CONTRIBUTING.md) first.

|Project|Author/Maintainer|Short description|
|----|----|----|
|[adb-aws-lambda](https://github.com/manami-project/adb-aws-lambda)|[manami-project](https://github.com/manami-project)|REST service for querying this database up and running in minutes using AWS Lambda.|
|[adb-zeppelin-statistics](https://github.com/manami-project/adb-zeppelin-statistics)|[manami-project](https://github.com/manami-project)|A set of statistics and insights about anime on MAL.|
|[arm-server](https://github.com/BeeeQueue/arm-server)|[BeeeQueue](https://github.com/BeeeQueue)|A REST API for querying this database.|
|[manami](https://github.com/manami-project/manami)|[manami-project](https://github.com/manami-project)|A tool to catalog anime on your hard drive and discover new anime to watch.|