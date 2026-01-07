[![License: ODbL-1.0](https://img.shields.io/badge/license-ODbL--1.0-orange)](https://github.com/manami-project/anime-offline-database/blob/2026-02/LICENSE)

# anime-offline-database
The purpose of this repository is to create a dataset containing anime meta data aggregated by different anime meta data providers (such as myanimelist.net, anidb.net, kitsu.app and more) and allow cross references between those meta data providers. This dataset is supposed to be used by and created for [manami](https://github.com/manami-project/manami).

> [!IMPORTANT]  
> After the _2025-25_ update the dataset files will be removed from the repo and moved to releases instead.
> The reason is that this project is close to hitting the limits of github free plan and my assumption is
> that even git LFS won't last long under the free plan. There is a **latest** release available, always
> containing the most recent version of the files. Additionally named releases like **2025-25** are created
> which contain the files for that specific week.

## Statistics
Update **week 02 [2026]**

The dataset consists of **40337** entries _(67% reviewed)_ composed of:

| Number of entries | Meta data provider |
|-------------------|--------------------|
| 29859 | [myanimelist.net](https://myanimelist.net) |
| 26571 | [anime-planet.com](https://anime-planet.com) |
| 21788 | [kitsu.app](https://kitsu.app) |
| 20498 | [anisearch.com](https://anisearch.com) |
| 20198 | [anilist.co](https://anilist.co) |
| 14234 | [simkl.com](https://simkl.com) |
| 14234 | [animecountdown.com](https://animecountdown.com) |
| 14228 | [anidb.net](https://anidb.net) |
| 12386 | [animenewsnetwork.com](https://animenewsnetwork.com) |
| 12056 | [livechart.me](https://livechart.me) |


## Files

This repository contains various JSON and zip files. The dataset file itself as well as files containing IDs of dead entries for some meta data providers to support the automated process.

| File                                          | Type reference                         | Description                                                                                                                                              |
|-----------------------------------------------|----------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| `anime-offline-database-minified.json`        | [Database root](#database-root)        | Minified version of `anime-offline-database.json`. Values containing `null` are omitted.                                                                 |
| `anime-offline-database-minified.schema.json` | [JSON schema](https://json-schema.org) | JSON schema file for validating `anime-offline-database-minified.json`.                                                                                  |
| `anime-offline-database-minified.json.zst`    | [Database root](#database-root)        | Zstandard compressed file of `anime-offline-database-minified.json`.                                                                                     |
| `anime-offline-database.jsonl`                | [Anime](#anime)                        | [JSON lines](https://jsonlines.org) file containing anime. Each line is an anime object except for the first line which contains meta data.              |
| `anime-offline-database.jsonl.schema.json`    | [JSON schema](https://json-schema.org) | JSON schema file for validating each line within `anime-offline-database.jsonl`                                                                          |
| `anime-offline-database.jsonl.zst`            | [Anime](#anime)                        | Zstandard compressed file of `anime-offline-database.jsonl`                                                                                              |
| `dead-entries/dead-entries.schema.json`       | [JSON schema](https://json-schema.org) | JSON schema file for validating all the `dead-entries/*-minified.json` and `dead-entries/*.json` files.                                                  |
| `dead-entries/*-minified.json`                | [DeadEntries root](#deadentries-root)  | A file where `*` is the name of the respective meta data provider. Contains anime IDs which have been removed from the meta data provider. Minified.     |
| `dead-entries/*-minified.json.zst`            | [DeadEntries root](#deadentries-root)  | Zstandard compressed file of the corresponding `dead-entries/*.json` file.                                                                               |

## Type reference

Here is a description of the types in the JSON files.

### Database root

| Field        | Type                        | Nullable | Description                                                       |
|--------------|-----------------------------|----------|-------------------------------------------------------------------|
| `$schema`    | `URI`                       | no       | Link to the JSON schema which allows to validate the content.     |
| `license`    | [License](#license)         | no       | Information about the license of the dataset.                     |
| `repository` | `URL`                       | no       | URL of this github repository which is the source of the dataset. |
| `scoreRange` | [ScoreRange](#scorerange)   | no       | Describes the upper and lower boundaries of a score.              |
| `lastUpdate` | `Date` (format: YYYY-MM-DD) | no       | The date on which the file was updated.                           |
| `data`       | [Anime[]](#anime)           | no       | List of all anime.                                                |

### License

| Field  | Type     | Nullable | Description              |
|--------|----------|----------|--------------------------|
| `name` | `String` | no       | Name of the license.     |
| `url`  | `URL`    | no       | URL to the license file. |

### ScoreRange

| Field          | Type     | Nullable | Description                                              |
|----------------|----------|----------|----------------------------------------------------------|
| `minInclusive` | `Double` | no       | Minimum value that a score can take. **Default:** `1.0`  |
| `maxInclusive` | `Double` | no       | Maximum value that a score can take. **Default:** `10.0` |

### Anime

| Field          | Type                                              | Nullable | Description                                                                                                                        |
|----------------|---------------------------------------------------|----------|------------------------------------------------------------------------------------------------------------------------------------|
| `sources`      | `URL[]`                                           | no       | URLs to the pages of the meta data providers for this anime.                                                                       |
| `title`        | `String`                                          | no       | Main title.                                                                                                                        |
| `type`         | `Enum of [TV, MOVIE, OVA, ONA, SPECIAL, UNKNOWN]` | no       | Distribution type.                                                                                                                 |
| `episodes`     | `Integer`                                         | no       | Number of episodes, movies or parts.                                                                                               |
| `status`       | `Enum of [FINISHED, ONGOING, UPCOMING, UNKNOWN]`  | no       | Status of distribution.                                                                                                            |
| `animeSeason`  | [AnimeSeason](#animeseason)                       | no       | Data on when the anime was first distributed.                                                                                      |
| `picture`      | `URL`                                             | no       | URL of a picture which represents the anime.                                                                                       |
| `thumbnail`    | `URL`                                             | no       | URL of a smaller version of the picture.                                                                                           |
| `duration`     | [Duration](#duration)                             | yes      | Duration. Normally this is per episode.                                                                                            |
| `score`        | [Score](#score)                                   | yes      | Score calculated using all available scores from meta data providers. Original scores are rescaled if necessary.                   |
| `synonyms`     | `String[]`                                        | no       | Alternative titles and spellings under which the anime is also known. Duplicate free (case sensitive). Doesn't contain the `title` |
| `studios`      | `String[]`                                        | no       | Lower case studio names. In general a duplicate free list, but might contain duplicates for different writings.                    |
| `producers`    | `String[]`                                        | no       | Lower case producers names. Companys only. In general a duplicate free list, but might contain duplicates for different writings.  |
| `relatedAnime` | `URL[]`                                           | no       | URLs to the meta data providers for anime that are somehow related to this anime.                                                  |
| `tags`         | `String[]`                                        | no       | A non-curated list of tags and genres which describe the anime. All entries are lower case.                                        |

### AnimeSeason

| Field    | Type                                                | Nullable | Description                                 |
|----------|-----------------------------------------------------|----------|---------------------------------------------|
| `season` | `Enum of [SPRING, SUMMER, FALL, WINTER, UNDEFINED]` | no       | Season in which the first release occurred. |
| `year`   | `Integer`                                           | yes      | Year of first release.                      |

### Duration

| Field    | Type      | Nullable | Description                                           |
|----------|-----------|----------|-------------------------------------------------------|
| `value`  | `Integer` | no       | Duration in seconds.                                  |
| `unit`   | `String`  | no       | For (de)serialization this value is always `SECONDS`. |

### Score

| Field                     | Type     | Nullable | Description                                                                           |
|---------------------------|----------|----------|---------------------------------------------------------------------------------------|
| `arithmeticGeometricMean` | `Double` | no       | Arithmetic–geometric mean based on all available scores from all meta data providers. |
| `arithmeticMean`          | `Double` | no       | Arithmetic mean based on all available scores from all meta data providers.           |
| `median`                  | `Double` | no       | Median based on all available scores from all meta data providers.                    |

### DeadEntries root

| Field         | Type                        | Nullable | Description                                                                  |
|---------------|-----------------------------|----------|------------------------------------------------------------------------------|
| `$schema`     | `URI`                       | no       | Link to the JSON schema which allows to validate the content.                |
| `license`     | [License](#license)         | no       | Information about the license of the dataset.                                |
| `repository`  | `URL`                       | no       | URL of this github repository which is the source of the dataset.            |
| `lastUpdate`  | `Date` (format: YYYY-MM-DD) | no       | The date on which the file was updated.                                      |
| `deadEntries` | `String[]`                  | no       | IDs of anime which have been removed from the respective meta data provider. |

## Examples

Here are some examples showing what the files look like.

### anime-offline-database.json:

<details open>
<summary>Example</summary>

```json
{
  "$schema": "https://raw.githubusercontent.com/manami-project/anime-offline-database/refs/tags/2025-18/anime-offline-database.schema.json",
  "license": {
    "name": "Open Data Commons Open Database License (ODbL) v1.0 + Database Contents License (DbCL) v1.0",
    "url": "https://github.com/manami-project/anime-offline-database/blob/2025-18/LICENSE"
  },
  "repository": "https://github.com/manami-project/anime-offline-database",
  "scoreRange": {
    "minInclusive": 1.0,
    "maxInclusive": 10.0
  },
  "lastUpdate": "2025-05-02",
  "data": [
    {
      "sources": [
        "https://anidb.net/anime/4563",
        "https://anilist.co/anime/1535",
        "https://anime-planet.com/anime/death-note",
        "https://animecountdown.com/40190",
        "https://animenewsnetwork.com/encyclopedia/anime.php?id=6592",
        "https://anisearch.com/anime/3633",
        "https://kitsu.app/anime/1376",
        "https://livechart.me/anime/3437",
        "https://myanimelist.net/anime/1535",
        "https://simkl.com/anime/40190"
      ],
      "title": "Death Note",
      "type": "TV",
      "episodes": 37,
      "status": "FINISHED",
      "animeSeason": {
        "season": "FALL",
        "year": 2006
      },
      "picture": "https://cdn.myanimelist.net/images/anime/1079/138100.jpg",
      "thumbnail": "https://cdn.myanimelist.net/images/anime/1079/138100t.jpg",
      "duration": {
        "value": 1380,
        "unit": "SECONDS"
      },
      "score": {
        "arithmeticGeometricMean": 8.631697859409492,
        "arithmeticMean": 8.631818181818183,
        "median": 8.65
      },
      "synonyms": [
        "Bilježnica smrti",
        "Caderno da Morte",
        "Carnet de la Mort",
        "Cuốn sổ tử thần",
        "DEATH NOTE",
        "DN",
        "Death Note - A halállista",
        "Death Note - Carnetul morţii",
        "Death Note - Zápisník smrti",
        "Death Note(デスノート)",
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
        "डेथ नोट",
        "สมุดโน้ตกระชากวิญญาณ",
        "ですのーと",
        "デスノート",
        "死亡笔记",
        "死亡筆記本",
        "데스노트"
      ],
      "studios": [
        "madhouse"
      ],
      "producers": [
        "d.n. dream partners",
        "nippon television network",
        "shueisha",
        "vap"
      ],
      "relatedAnime": [
        "https://anidb.net/anime/8146",
        "https://anidb.net/anime/8147",
        "https://anilist.co/anime/20931",
        "https://anilist.co/anime/2994",
        "https://anime-planet.com/anime/death-note-rewrite-1-visions-of-a-god",
        "https://anime-planet.com/anime/death-note-rewrite-2-ls-successors",
        "https://animecountdown.com/36687",
        "https://animecountdown.com/40690",
        "https://anisearch.com/anime/4441",
        "https://anisearch.com/anime/5194",
        "https://kitsu.app/anime/2707",
        "https://livechart.me/anime/3808",
        "https://myanimelist.net/anime/2994",
        "https://simkl.com/anime/36687",
        "https://simkl.com/anime/40690"
      ],
      "tags": [
        "achronological order",
        "acting",
        "adapted into japanese movie",
        "adapted into jdrama",
        "adapted into other media",
        "adults are useless",
        "alternative present",
        "americas",
        "amnesia",
        "anti-hero",
        "antihero",
        "asexual",
        "asia",
        "assassins",
        "based on a manga",
        "battle of wits",
        "bishounen",
        "canon filler",
        "contemporary fantasy",
        "contractor",
        "cops",
        "crime",
        "crime fiction",
        "criminals",
        "death",
        "detective",
        "detectives",
        "drama",
        "earth",
        "espionage",
        "everybody dies",
        "fantasy",
        "feet",
        "following one`s dream",
        "genius",
        "gods",
        "grail in the garbage",
        "hero of strong character",
        "horror",
        "insane",
        "japan",
        "japanese production",
        "journalism",
        "just as planned",
        "kamis",
        "kuudere",
        "law and order",
        "male protagonist",
        "manga",
        "memory manipulation",
        "mind games",
        "mundane made awesome",
        "murder",
        "mystery",
        "overpowered main characters",
        "philosophy",
        "place",
        "plot continuity",
        "police",
        "police are useless",
        "policeman",
        "predominantly adult cast",
        "present",
        "primarily adult cast",
        "primarily male cast",
        "psychological",
        "psychological drama",
        "psychopaths",
        "real-world location",
        "rivalries",
        "rivalry",
        "romance",
        "school life",
        "secret identity",
        "serial killers",
        "shinigami",
        "shounen",
        "speculative fiction",
        "suicide",
        "supernatural",
        "supernatural drama",
        "supernatural thriller",
        "suspense",
        "tennis",
        "thriller",
        "time",
        "time skip",
        "tragedy",
        "tropes",
        "twisted story",
        "united states",
        "university",
        "unrequited love",
        "unusual weapons -- to be split and deleted",
        "urban",
        "urban fantasy",
        "vigilantes",
        "weekly shounen jump",
        "world domination",
        "yandere"
      ]
    }
  ]
}
```
</details>

### dead-entries/*.json

<details>
<summary>Example</summary>

```json
{
  "$schema": "https://raw.githubusercontent.com/manami-project/anime-offline-database/refs/tags/2025-18/dead-entries/dead-entries.schema.json",
  "license": {
    "name": "Open Data Commons Open Database License (ODbL) v1.0 + Database Contents License (DbCL) v1.0",
    "url": "https://github.com/manami-project/anime-offline-database/blob/2025-18/LICENSE"
  },
  "repository": "https://github.com/manami-project/anime-offline-database",
  "lastUpdate": "2025-05-02",
  "deadEntries": [
    "38492",
    "38518",
    "38522",
    "38531"
  ]
}
```
</details>