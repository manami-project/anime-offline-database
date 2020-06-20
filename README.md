# anime-offline-database ![CI build status](https://github.com/manami-project/anime-offline-database/workflows/Check%20JSON%20files/badge.svg "CI build status: Check JSON files")
The purpose of this repository is to create an offline database containing anime meta data aggregated by different anime meta data providers (such as myanimelist.net, anidb.net, anilist.co and kitsu.io) and allow cross references between those meta data providers. This file is supposed to be used by and created for [manami](https://github.com/manami-project/manami).

**The goal is to deliver at least weekly updates.**

## Statistics
Update **week 25 [2020]**

The database consists of **24321** entries composed of:
+ 17244 entries from myanimelist.net
+ 15191 entries from kitsu.io
+ 14329 entries from notify.moe
+ 13012 entries from anilist.co
+ 11224 entries from anidb.net

Missed updates:
+ **2020:** 0 _(so far)_
+ **2019:** 2
+ **2018:** 1

## Participation
If you want to contribute, please read the [contribution guidelines](./.github/CONTRIBUTING.md) first.

## Structure
This repository contains two files. The database file itself and a file to support the automated process containing IDs which don't exist anymore on the meta data provider's site.

### anime-offline-database.json

#### Data types

**Root**
| Field | Type |
| --- | --- |
| data | ```Array<Anime>``` |

**Anime**
| Field | Type |
| --- | --- |
| sources | ```Array<URL>``` |
| title | ```String``` |
| type | ```Enum of [TV, Movie, OVA, ONA, Special]``` |
| episodes | ```Integer``` |
| status | ```Enum of [FINISHED, CURRENTLY, UPCOMING, UNKNOWN]``` |
| picture | ```URL``` |
| thumbnail | ```URL``` |
| synonyms | ```Array<String>``` |
| relations | ```Array<URL>``` |
| tags | ```Array<String>``` |

#### Example:

```json
{
    "data": [
        {
            "sources": [
                "https://anidb.net/anime/4563",
                "https://anilist.co/anime/1535",
                "https://kitsu.io/anime/1376",
                "https://myanimelist.net/anime/1535",
                "https://notify.moe/anime/0-A-5Fimg"
            ],
            "title": "Death Note",
            "type": "TV",
            "episodes": 37,
            "status": "FINISHED",
            "picture": "https://cdn.myanimelist.net/images/anime/9/9453.jpg",
            "thumbnail": "https://cdn.myanimelist.net/images/anime/9/9453t.jpg",
            "synonyms": [
                "DEATH NOTE",
                "DN",
                "Death Note - A halállista",
                "Death Note - Carnetul morţii",
                "Death Note - Zápisník smrti",
                "Notatnik śmierci",
                "Τετράδιο Θανάτου",
                "Бележник на Смъртта",
                "Тетрадь cмерти",
                "Үхлийн Тэмдэглэл",
                "دفترچه یادداشت مرگ",
                "كـتـاب الـموت",
                "डेथ नोट",
                "ですのーと",
                "デスノート",
                "死亡笔记",
                "데스노트"
            ],
            "relations": [
                "https://anidb.net/anime/8146",
                "https://anidb.net/anime/8147",
                "https://anilist.co/anime/2994",
                "https://kitsu.io/anime/2707",
                "https://myanimelist.net/anime/2994",
                "https://notify.moe/anime/DBBU5Kimg"
            ],
            "tags": [
                "alternative present",
                "anti-hero",
                "asia",
                "assassins",
                "contemporary fantasy",
                "cops",
                "crime",
                "demons",
                "detective",
                "earth",
                "espionage",
                "gods",
                "japan",
                "male protagonist",
                "manga",
                "mystery",
                "philosophy",
                "plot continuity",
                "police",
                "present",
                "primarily male cast",
                "psychological",
                "shounen",
                "supernatural",
                "survival",
                "thriller",
                "tragedy",
                "urban",
                "urban fantasy",
                "work"
            ]
        }
    ]
}
```

### dead-entries.json
Contains IDs which have been removed from the meta data provider's database.

#### Data types

| Field | Type |
| --- | --- |
| mal | ```Array<Integer>``` |
| anidb | ```Array<Integer>``` |
| anilist | ```Array<Integer>``` |
| kitsu | ```Array<Integer>``` |

#### Example

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