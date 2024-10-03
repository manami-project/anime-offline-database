# Contribution guidelines
Please read the FAQ down below.

## Possible errors / problems in the database
If you find something that, in your opinion, could be the result of incorrectly extacted data, please submit an issue rather than creating a pull request, because the database is created by an automated process.

# FAQ

## Can I somehow contribute?
Check the [predefined issue templates](https://github.com/manami-project/anime-offline-database/issues/new/choose) in case you want to report to one of the available cases.

## What do you mean by 'meta data providers'?
Websites which provide information about anime such as `myanimelist.net`, `notify.moe`, ...

## Can you please add additional data/properties?
No. The dataset has been created for my own tool. It contains all data/properties that I need and I won't add more data/properties. This is merely an index. The idea is to visit the meta data provider of your choice to get additional information about the anime.

Out of curiosity I created an extension project "[modb-extension ](https://github.com/manami-project/modb-extension)" which can be seen as an experimental demonstration on how to extend the current dataset. It currently contains **synopsis** and **scores**.

## Can you please add an additional meta data provider?
No. I don't plan to add any additional meta data provider.

## Can you please change the structure of the file?
No. The file has the structure that it needs to have for the purpose it has been built for.

## Why are there duplicates in the dataset?
If the entry of one meta data provider is not merged with an entry of a different meta data provider, although they are practically the same entry, then this is **not a duplicate**.
They are simply not merged together. This can happen and it is intentional. Since this dataset is created automatically two entries should rather not be merged than falsely merged together.
If you query this dataset based on titles/synonyms it might seem that there are duplicates. However the intended usage is to query by the url of the meta data provider. This way you will always retrieve the entry that you want. Entries being merged together is just a nice to have.

A duplicate by defintion of this dataset is an entry which contains multiple links of the same meta data provider in `sources`.

## Why are there no IDs?
There are. The entries under `sources` are the IDs. Each of the arrays URLs is a key for that specific entry.

## Is this dataset created automatically or manually?
It is created automatically and reviewed in a half-automated process.

## Do you plan to open source the code which creates this dataset?
The code is [available](https://github.com/manami-project?tab=repositories&q=modb&type=source).

## How do you split entries?
Entries are split if one meta data provider lists multiple entries as one and others don't.
**Example:**
* The entry of a meta data provider which lists 3 Movies as one entry is split from three separate entries of another meta data provider
* A series is listed as one entry having 26 episodes on one meta data provider and as two entries having 13 episodes each on the other meta data provider

However if one entry is listed with 13 episodes whereas the other is listed with 12, because it doesn't count the recap episode then these entries are still merged together.

## Does this dataset contain all anime from the supported meta data providers?
No. MAL and anisearch are the only providers which list adult titles publicly. So this type of anime is missing for the other meta data providers.
It's possible to retrieve adult titles from anilist, but because they cannot be accessed without an account in the browser those are not fit for the review process. That's why entries from anilist marked as adult are missing as well.
If there are new entries which have been created after an update then those obviously won't appear until the next update.
Apart from that it should contain all titles from the supported meta data providers.

## Will you create a similar dataset for manga?
No. I don't have a project which needs it and therefore no necessity for it. This repo is actually just a side project originating from [manami](https://github.com/manami-project/manami). So without manami I wouldn't have created it.
The other reason is that despite the automation already in place I still invest a huge amount of time in order to keep this dataset continuously updated. Which means that another project like this would be too time consuming. Especially if I don't need it for a project of my own.

## Can you merge tags like "scifi", "sci fi" and "sci-fi" together?
No. Different meta data providers list tags and genres differently. Tags don't aspire to be a curated list. Besides, it would be too tedious to keep track and I would have to make a decision about which value wins. But I don't want to decide on the wording. See also the [original release notes](https://github.com/manami-project/anime-offline-database/releases/tag/2020-25).

## Can you fix a typo in the title/synonym/tags?
No. The values are taken as-is from the meta data providers. Please check from which meta data provider the faulty value originates and ask for change there.

## Can you add a synonym/tag/related anime?
No. I don't add data myself. The data is taken from the meta data proividers as-is. If you want to add/change values then request a change at the meta data provider of your choice.