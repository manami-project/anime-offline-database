![CI build status](https://github.com/manami-project/anime-offline-database/workflows/Check%20JSON%20files/badge.svg "CI build status: Check JSON files")

# anime-offline-database
The purpose of this repository is to create an offline database containing anime meta data aggregated by different anime meta data providers (such as myanimelist.net, anidb.net, kitsu.io and more) and allow cross references between those meta data providers. This file is supposed to be used by and created for [manami](https://github.com/manami-project/manami).

**The goal is to deliver at least weekly updates.**

## Statistics
Update **week 24 [2023]**

The database consists of **31421** entries _(98% reviewed)_ composed of:
+ 24834 entries from myanimelist.net
+ 22848 entries from anime-planet.com
+ 19164 entries from kitsu.io
+ 17804 entries from anisearch.com
+ 17221 entries from anilist.co
+ 15807 entries from notify.moe
+ 12836 entries from anidb.net
+ 10713 entries from livechart.me

Missed updates:
+ **2023:** 0 _(so far)_
+ **2022:** 0
+ **2021:** 0
+ **2020:** 0
+ **2019:** 2
+ **2018:** 1

## Structure
This repository contains various JSON files. The database file itself as well as one file containing IDs of dead entries for some meta data providers to support the automated process.

### anime-offline-database-minified.json

Minified version of `anime-offline-database.json` which contains the same data, but is smaller in size.

### anime-offline-database.json

#### Data types

**Root**
| Field | Type | Nullable |
| --- | --- | --- |
| license | `License` | no |
| repository | `URL` | no |
| lastUpdate | `Date` (format: YYYY-MM-DD) | no |
| data | `Anime[]` | no |

**Anime**
| Field | Type | Nullable |
| --- | --- | --- |
| sources | `URL[]` | no |
| title | `String` | no |
| type | `Enum of [TV, MOVIE, OVA, ONA, SPECIAL, UNKNOWN]` | no |
| episodes | `Integer` | no |
| status | `Enum of [FINISHED, ONGOING, UPCOMING, UNKNOWN]` | no |
| animeSeason | `AnimeSeason` | no |
| picture | `URL` | no |
| thumbnail | `URL` | no |
| synonyms | `String[]` | no |
| relations | `URL[]` | no |
| tags | `String[]` | no |

**AnimeSeason**
| Field | Type | Nullable |
| --- | --- | --- |
| season | `Enum of [SPRING, SUMMER, FALL, WINTER, UNDEFINED]` | no |
| year | `Integer` | yes |

**License**
| Field | Type | Nullable |
| --- | --- | --- |
| name | `String` | no |
| url | `URL` | no |

#### Example:

```json
{
    "data": [
        {
            "sources": [
                "https://anidb.net/anime/4563",
                "https://anilist.co/anime/1535",
                "https://anime-planet.com/anime/death-note",
                "https://anisearch.com/anime/3633",
                "https://kitsu.io/anime/1376",
                "https://livechart.me/anime/3437",
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
                "Bilježnica smrti",
                "Caderno da Morte",
                "Carnet de la Mort",
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
                "https://anisearch.com/anime/4441",
                "https://anisearch.com/anime/5194",
                "https://kitsu.io/anime/2707",
                "https://livechart.me/anime/3808",
                "https://myanimelist.net/anime/2994",
                "https://notify.moe/anime/DBBU5Kimg"
            ],
            "tags": [
                "alternative present",
                "amnesia",
                "anti-hero",
                "asexual",
                "asia",
                "based on a manga",
                "contemporary fantasy",
                "cops",
                "crime",
                "crime fiction",
                "criminals",
                "detective",
                "detectives",
                "drama",
                "earth",
                "espionage",
                "fantasy",
                "genius",
                "gods",
                "hero of strong character",
                "horror",
                "japan",
                "kamis",
                "kuudere",
                "male protagonist",
                "manga",
                "mind games",
                "mystery",
                "overpowered main characters",
                "philosophy",
                "plot continuity",
                "police",
                "policeman",
                "present",
                "primarily adult cast",
                "primarily male cast",
                "psychological",
                "psychological drama",
                "psychopaths",
                "revenge",
                "rivalries",
                "secret identity",
                "serial killers",
                "shinigami",
                "shounen",
                "supernatural",
                "supernatural drama",
                "thriller",
                "time skip",
                "tragedy",
                "twisted story",
                "university",
                "urban",
                "urban fantasy",
                "vigilantes"
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
| deadEntries | `String[]` | no |

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