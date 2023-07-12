# Contribution guidelines
Please read the FAQ down below.

## Possible errors / problems in the database
If you find something that, in your opinion, could be the result of incorrectly extacted data, please submit an issue rather than creating a pull request, because the database is created by an automated process.

# FAQ

## Can I somehow contribute?
Check the [predefined issue templates](https://github.com/manami-project/anime-offline-database/issues/new/choose) in case you want to report to one of the available cases.

## What do you mean by 'meta data provider'?
Websites which provide information about anime such as `myanimelist.net`, `notify.moe`, ...

## Can you please add additional data/properties?
No. The data set has been created for my own tool. It contains all data/properties that I need and I won't add more data/properties. This is merely an index. The idea is to visit the meta data provider of your choice to get additional information about the anime.

## Can you please add an additional meta data provider?
No. I don't plan to add any additional meta data provider.

## Can you please change the structure of the file?
No. The file has the structure that it needs to have for the purpose it has been built for.

## There are duplicates in the data set.
If the entry of one meta data provider is not merged with an entry of a different meta data provider, although they are practically the same entry, then this is **not a duplicate**.
They are simply not merged together. This can happen and it is intentional. Since this data set is created automatically two entries should rather not be merged than falsely merged together.
If you query this data set based on titles/synonyms it might seem that there are duplicates. However the intended usage is to query by the url of the meta data provider. This way you will always retrieve the entry that you want. Entries being merged together is just a nice to have.

A duplicate by defintion of this data set is an entry which contains multiple links of the same meta data provider in `sources`.

## Why are there no IDs?
There are. The entries under `sources` are the IDs. Each one of the array's URLs is a key for that specific entry.

## Is this data set created automatically or manually?
It is created automatically and reviewed in a half-automated process.

## Do you plan to open source the code which creates this data set?
Yes. Parts of the code are already [available](https://github.com/manami-project?tab=repositories&q=modb&type=source). However there is still work to do before I can/want to open source the rest and that doesn't have any priority right now.

## How do you split entries?
Entries are split if one meta data provider lists multiple entries as one and others don't.
**Example:**
* The entry of a meta data provider which lists 3 Movies as one entry is split from three separate entries of another meta data provider
* A series is listed as one entry having 26 episodes on one meta data provider and as two entries having 13 episodes each on the other meta data provider

However if one entry is listed with 13 episodes whereas the other is listed with 12, because it doesn't count the recap episode then these entries are still merged together.

## Does this data set contain all anime from the supported meta data provider?
No. MAL and anisearch are the only provider which list adult titles publicly. So this type of anime is missing for the other meta data providers.
If there are new entries which have been created after an update then those obviously won't appear until the next update.
Apart from that it should contain all titles from the supported meta data provider.

## Will you create a similar data set for manga?
No. I don't have a project which needs it and therefore no necessity for it. This repo is actually just a side project originating from [manami](https://github.com/manami-project/manami). So without manami I wouldn't have created it.
The other reason is that despite the automation already in place I still invest a huge amount of time in order to keep this data set continuously updated. Which means that another project like this would be too time consuming. Especially if I don't need it for a project of my own.