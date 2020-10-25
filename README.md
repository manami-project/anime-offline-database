# anime-offline-database ![CI build status](https://github.com/manami-project/anime-offline-database/workflows/Check%20JSON%20files/badge.svg "CI build status: Check JSON files")
The purpose of this repository is to create an offline database containing anime meta data aggregated by different anime meta data providers (such as myanimelist.net, anidb.net, kitsu.io and more) and allow cross references between those meta data providers. This file is supposed to be used by and created for [manami](https://github.com/manami-project/manami).

**The goal is to deliver at least weekly updates.**

## Statistics
Update **week 43 [2020]**

The database consists of **30086** entries composed of:
+ 18033 entries from myanimelist.net
+ 15602 entries from kitsu.io
+ 15319 entries from anime-planet.com
+ 14522 entries from notify.moe
+ 13561 entries from anilist.co
+ 11378 entries from anidb.net

Missed updates:
+ **2020:** 0 _(so far)_
+ **2019:** 2
+ **2018:** 1

## Participation
If you want to contribute, please read the [contribution guidelines](./.github/CONTRIBUTING.md) first.

## Structure
This repository contains various JSON files. The database file itself as well as one file containing IDs of dead entries for each meta data provider to support the automated process.

### anime-offline-database.json

#### Data types

**Root**
| Field | Type | Nullable |
| --- | --- | --- |
| data | ```Array<Anime>``` | no |

**Anime**
| Field | Type | Nullable |
| --- | --- | --- |
| sources | ```Array<URL>``` | no |
| title | ```String``` | no |
| type | ```Enum of [TV, Movie, OVA, ONA, Special]``` | no |
| episodes | ```Integer``` | no |
| status | ```Enum of [FINISHED, CURRENTLY, UPCOMING, UNKNOWN]``` | no |
| animeSeason | ```AnimeSeason``` | no |
| picture | ```URL``` | no |
| thumbnail | ```URL``` | no |
| synonyms | ```Array<String>``` | no |
| relations | ```Array<URL>``` | no |
| tags | ```Array<String>``` | no |

**AnimeSeason**
| Field | Type | Nullable |
| --- | --- | --- |
| season | ```Enum of [SPRING, SUMMER, FALL, WINTER, UNDEFINED]``` | no |
| year | ```Integer``` | yes |

#### Example:

```json
{
    "data": [
        {
            "sources": [
                "https://anidb.net/anime/4563",
                "https://anilist.co/anime/1535",
                "https://anime-planet.com/anime/death-note",
                "https://kitsu.io/anime/1376",
                "https://myanimelist.net/anime/1535",
                "https://notify.moe/anime/0-A-5Fimg"
            ],
            "title": "Death Note",
            "type": "TV",
            "episodes": 37,
            "status": "FINISHED",
            "animeSeason": {
                "season": "FALL",
                "year": 2006
            },
            "picture": "https://cdn.myanimelist.net/images/anime/9/9453.jpg",
            "thumbnail": "https://cdn.myanimelist.net/images/anime/9/9453t.jpg",
            "synonyms": [
                "Caderno da Morte",
                "DEATH NOTE",
                "DN",
                "Death Note - A halállista",
                "Death Note - Carnetul morţii",
                "Death Note - Zápisník smrti",
                "Mirties Užrašai",
                "Notatnik śmierci",
                "Notes Śmierci",
                "Quaderno della Morte",
                "Sveska Smrti",
                "Ölüm Defteri",
                "Τετράδιο Θανάτου",
                "Бележник на Смъртта",
                "Записник Смерті",
                "Свеска Смрти",
                "Тетрадка на Смъртта",
                "Тетрадь cмерти",
                "Үхлийн Тэмдэглэл",
                "מחברת המוות",
                "دفترچه مرگ",
                "دفترچه یادداشت مرگ",
                "كـتـاب الـموت",
                "مدونة الموت",
                "مذكرة الموت",
                "موت نوٹ",
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
                "https://anime-planet.com/anime/death-note-rewrite-1-visions-of-a-god",
                "https://anime-planet.com/anime/death-note-rewrite-2-ls-successors",
                "https://kitsu.io/anime/2707",
                "https://myanimelist.net/anime/2994",
                "https://notify.moe/anime/DBBU5Kimg"
            ],
            "tags": [
                "alternative present",
                "amnesia",
                "anti-hero",
                "asia",
                "based on a manga",
                "contemporary fantasy",
                "cops",
                "crime",
                "criminals",
                "demons",
                "detective",
                "detectives",
                "drama",
                "earth",
                "espionage",
                "gods",
                "japan",
                "male protagonist",
                "manga",
                "mind games",
                "mystery",
                "overpowered main characters",
                "philosophy",
                "plot continuity",
                "police",
                "present",
                "primarily adult cast",
                "primarily male cast",
                "psychological",
                "psychopaths",
                "revenge",
                "rivalries",
                "secret identity",
                "serial killers",
                "shinigami",
                "shounen",
                "supernatural",
                "thriller",
                "time skip",
                "tragedy",
                "urban",
                "urban fantasy",
                "vigilantes",
                "work"
            ]
        }
    ]
}
```

### dead-entries
Contains IDs which have been removed from the database of the corresponding meta data provider.

#### Data types

| Field | Type | Nullable |
| --- | --- | --- |
| deadEntries | ```Array<String>``` | no |

#### Example

```json
{
    "deadEntries": [
        "38492",
        "38518",
        "38522",
        "38531"
    ]
}
```

## Other projects using this database
If you have a project that uses this database and you want to add it to this list, please read the [contribution guidelines](./.github/CONTRIBUTING.md) first.

|Project|Author/Maintainer|Short description|
|----|----|----|
|[adb-aws-lambda](https://github.com/manami-project/adb-aws-lambda)|[manami-project](https://github.com/manami-project)|REST service for querying this database up and running in minutes using AWS Lambda.|
|[adb-zeppelin-statistics](https://github.com/manami-project/adb-zeppelin-statistics)|[manami-project](https://github.com/manami-project)|A set of statistics and insights about anime on MAL.|
|[animanga-wordlist](https://github.com/ryuuganime/animanga-wordlist)|[ryuuganime](https://github.com/ryuuganime)|Japanese Anime, Manga, Characters, and Studio Word List/Dictionary|
|[arm-server](https://github.com/BeeeQueue/arm-server)|[BeeeQueue](https://github.com/BeeeQueue)|A REST API for querying this database.|
|[manami](https://github.com/manami-project/manami)|[manami-project](https://github.com/manami-project)|A tool to catalog anime on your hard drive and discover new anime to watch.|