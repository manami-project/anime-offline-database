---
name: Falsely merged entry
about: Entries have been merged together although they should be separate entries?
title: ''
labels: ''
assignees: manami-project

---

Please read the [FAQ](https://github.com/manami-project/anime-offline-database/blob/master/.github/CONTRIBUTING.md#faq) first.
Especially the sections on [duplicates](https://github.com/manami-project/anime-offline-database/blob/master/.github/CONTRIBUTING.md#there-are-duplicates-in-the-data-set) and [splits](https://github.com/manami-project/anime-offline-database/blob/master/.github/CONTRIBUTING.md#how-do-you-split-entries). Please refrain from creating issues stating that entries should be merged together. This is only for _splitting_ entries which have already been merged together, but should be separated.
**Only one entry per issue**

## Which entry should be split? (original from data set)

**Example:**
```
"https://anidb.net/anime/9466",
"https://anilist.co/anime/15809",
"https://anime-planet.com/anime/the-devil-is-a-part-timer",
"https://kitsu.io/anime/7314",
"https://myanimelist.net/anime/15809",
"https://notify.moe/anime/CGnFpKimR"
"https://anidb.net/anime/16104",
"https://anilist.co/anime/130592",
"https://anime-planet.com/anime/the-devil-is-a-part-timer-2",
"https://kitsu.io/anime/44113",
"https://myanimelist.net/anime/48413",
"https://notify.moe/anime/Zy3-TV8MR"
```

## How should it be split?

**Example:**
```
"https://anidb.net/anime/9466",
"https://anilist.co/anime/15809",
"https://anime-planet.com/anime/the-devil-is-a-part-timer",
"https://kitsu.io/anime/7314",
"https://myanimelist.net/anime/15809",
"https://notify.moe/anime/CGnFpKimR"
```

```
"https://anidb.net/anime/16104",
"https://anilist.co/anime/130592",
"https://anime-planet.com/anime/the-devil-is-a-part-timer-2",
"https://kitsu.io/anime/44113",
"https://myanimelist.net/anime/48413",
"https://notify.moe/anime/Zy3-TV8MR"
```