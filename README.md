![Check JSON files](https://github.com/manami-project/anime-offline-database/actions/workflows/json_lint.yml/badge.svg)

# anime-offline-database
The purpose of this repository is to create a dataset containing anime meta data aggregated by different anime meta data providers (such as myanimelist.net, anidb.net, kitsu.app and more) and allow cross references between those meta data providers. This dataset is supposed to be used by and created for [manami](https://github.com/manami-project/manami).

**The goal is to deliver at least weekly updates.**

## Statistics
Update **week 38 [2024]**

The dataset consists of **34621** entries _(98% reviewed)_ composed of:

| Number of entries | Meta data provider |
|-------------------|--------------------|
| 27729 | [myanimelist.net](https://myanimelist.net) |
| 24124 | [anime-planet.com](https://anime-planet.com) |
| 20681 | [kitsu.app](https://kitsu.app) |
| 18945 | [anisearch.com](https://anisearch.com) |
| 18870 | [anilist.co](https://anilist.co) |
| 16511 | [notify.moe](https://notify.moe) |
| 13511 | [anidb.net](https://anidb.net) |
| 11433 | [livechart.me](https://livechart.me) |

Missed updates:
+ **2024:** 0 _(so far)_
+ **2023:** 0
+ **2022:** 0
+ **2021:** 0
+ **2020:** 0
+ **2019:** 2
+ **2018:** 1

## Files

This repository contains various JSON and zip files. The dataset file itself as well as files containing IDs of dead entries for some meta data providers to support the automated process.

| File                                          | Type reference                         | Description                                                                                                                                                                                                            |
|-----------------------------------------------|----------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `anime-offline-database.json`                 | [Database root](#database-root)        | Contains anime data already merged from different meta data providers. Content is pretty print. Check [modb-extension](https://github.com/manami-project/modb-extension) if you are looking for additional properties. |
| `anime-offline-database.schema.json`          | [JSON schema](https://json-schema.org) | JSON schema file for validating `anime-offline-database.json`.                                                                                                                                                         |
| `anime-offline-database-minified.json`        | [Database root](#database-root)        | Minified version of `anime-offline-database.json` which contains the same data, but is smaller in size.                                                                                                                |
| `anime-offline-database-minified.schema.json` | [JSON schema](https://json-schema.org) | JSON schema file for validating `anime-offline-database-minified.json`.                                                                                                                                                |
| `anime-offline-database.zip`                  | [Database root](#database-root)        | Zipped file of `anime-offline-database-minified.json` which contains the same data, but is even smaller in size.                                                                                                       |
| `dead-entries/*.json`                         | [DeadEntries root](#deadentries-root)  | A file where `*` is the name of the respective meta data provider. Contains anime IDs which have been removed from the meta data provider. Pretty print.                                                               |
| `dead-entries/*-minified.json`                | [DeadEntries root](#deadentries-root)  | A file where `*` is the name of the respective meta data provider. Contains the same data as `dead-entries/*.json`, but is smaller in size.                                                                            |
| `dead-entries/dead-entries.schema.json`       | [JSON schema](https://json-schema.org) | JSON schema file for validating all the `dead-entries/*-minified.json` and `dead-entries/*.json` files.                                                                                                                |
| `dead-entries/*.zip`                          | [DeadEntries root](#deadentries-root)  | A file where `*` is the name of the respective meta data provider. Contains the same data as `dead-entries/*-minified.json`, but is even smaller in size.                                                              |

## Type reference

Here is description of the types in the JSON files.

### Database root

| Field        | Type                        | Nullable | Description                                                       |
|--------------|-----------------------------|----------|-------------------------------------------------------------------|
| `license`    | [License](#license)         | no       | Information about the license of the dataset.                     |
| `repository` | `URL`                       | no       | URL of this github repository which is the source of the dataset. |
| `lastUpdate` | `Date` (format: YYYY-MM-DD) | no       | The date on which the file was updated.                           |
| `data`       | [Anime[]](#anime)           | no       | List of all anime.                                                |

### License

| Field | Type     | Nullable | Description                    |
|-------|----------|----------|--------------------------------|
| name  | `String` | no       | Name of the license.           |
| url   | `URL`    | no       | URL to the whole license file. |

### Anime

| Field        | Type                                              | Nullable | Description                                                                       |
|--------------|---------------------------------------------------|----------|-----------------------------------------------------------------------------------|
| sources      | `URL[]`                                           | no       | URLs to the pages of the meta data providers for this anime.                      |
| title        | `String`                                          | no       | Main title.                                                                       |
| type         | `Enum of [TV, MOVIE, OVA, ONA, SPECIAL, UNKNOWN]` | no       | Distribution type.                                                                |
| episodes     | `Integer`                                         | no       | Number of episodes, movies or parts.                                              |
| status       | `Enum of [FINISHED, ONGOING, UPCOMING, UNKNOWN]`  | no       | Status of distribution.                                                           |
| animeSeason  | [AnimeSeason](#animeseason)                       | no       | Data on when the anime was first distributed.                                     |
| picture      | `URL`                                             | no       | URL of a picture which represents the anime.                                      |
| thumbnail    | `URL`                                             | no       | URL of a smaller version of the picture.                                          |
| duration     | [Duration](#duration)                             | yes      | Duration. Normally this is per episode.                                           |
| synonyms     | `String[]`                                        | no       | Alternative titles and spellings under which the anime is also known.             |
| relatedAnime | `URL[]`                                           | no       | URLs to the meta data providers for anime that are somehow related to this anime. |
| tags         | `String[]`                                        | no       | A non-curated list of tags and genres which describe the anime.                   |

### AnimeSeason

| Field  | Type                                                | Nullable | Description |
|--------|-----------------------------------------------------|----------|-------------|
| season | `Enum of [SPRING, SUMMER, FALL, WINTER, UNDEFINED]` | no       | Season.     |
| year   | `Integer`                                           | yes      | Year.       |

### Duration

| Field  | Type      | Nullable | Description                                           |
|--------|-----------|----------|-------------------------------------------------------|
| value  | `Integer` | no       | Duration in seconds.                                  |
| unit   | `String`  | no       | For (de)serialization this value is always `SECONDS`. |

### DeadEntries root

| Field       | Type                        | Nullable | Description                                                                  |
|-------------|-----------------------------|----------|------------------------------------------------------------------------------|
| license     | [License](#license)         | no       | Information about the license of the dataset.                                |
| repository  | `URL`                       | no       | URL of this github repository which is the source of the dataset.            |
| lastUpdate  | `Date` (format: YYYY-MM-DD) | no       | The date on which the file was updated.                                      |
| deadEntries | `String[]`                  | no       | IDs of anime which have been removed from the respective meta data provider. |

## Examples

Here are some examples showing what the files look like.

### anime-offline-database.json:

```json
{
    "license": {
      "name": "GNU Affero General Public License v3.0",
      "url": "https://github.com/manami-project/anime-offline-database/blob/master/LICENSE"
    },
    "repository": "https://github.com/manami-project/anime-offline-database",
    "lastUpdate": "2024-01-06",
    "data": [
        {
            "sources": [
                "https://anidb.net/anime/4563",
                "https://anilist.co/anime/1535",
                "https://anime-planet.com/anime/death-note",
                "https://anisearch.com/anime/3633",
                "https://kitsu.app/anime/1376",
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
            "duration": {
                "value": 1380,
                "unit": "SECONDS"
            },
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
            "relatedAnime": [
                "https://anidb.net/anime/8146",
                "https://anidb.net/anime/8147",
                "https://anilist.co/anime/2994",
                "https://anime-planet.com/anime/death-note-rewrite-1-visions-of-a-god",
                "https://anime-planet.com/anime/death-note-rewrite-2-ls-successors",
                "https://anisearch.com/anime/4441",
                "https://anisearch.com/anime/5194",
                "https://kitsu.app/anime/2707",
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

### dead-entries/*.json

```json
{
    "license": {
      "name": "GNU Affero General Public License v3.0",
      "url": "https://github.com/manami-project/anime-offline-database/blob/master/LICENSE"
    },
    "repository": "https://github.com/manami-project/anime-offline-database",
    "lastUpdate": "2024-01-06",
    "deadEntries": [
        "38492",
        "38518",
        "38522",
        "38531"
    ]
}
```