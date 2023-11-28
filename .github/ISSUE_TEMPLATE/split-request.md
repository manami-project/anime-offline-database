---
name: Split entries request
about: Entries have been merged together although they should be separate entries?
title: ''
labels: split-request
assignees: manami-project

---

<!---
Please read the FAQ first:
https://github.com/manami-project/anime-offline-database/blob/master/.github/CONTRIBUTING.md#faq

Especially the sections on duplicates: https://github.com/manami-project/anime-offline-database/blob/master/.github/CONTRIBUTING.md#there-are-duplicates-in-the-data-set
and splits: https://github.com/manami-project/anime-offline-database/blob/master/.github/CONTRIBUTING.md#how-do-you-split-entries

ONLY ONE ENTRY PER ISSUE.
--->

## Which entry should be split? (original from dataset)

<!--- EXAMPLE --->
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

<!--- EXAMPLE --->
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