TAG_NAME := $(shell cat week.release)
YEAR     := $(shell echo $(TAG_NAME) | cut -d'-' -f1)
WEEK     := $(shell echo $(TAG_NAME) | cut -d'-' -f2)
SHELL    := /bin/bash

ifndef GITHUB_USERNAME
	GITHUB_USERNAME := $(shell test -f ~/.github_username && cat ~/.github_username || (read -p "GitHub Username: " username && echo $$username > ~/.github_username && echo $$username))
endif

ifndef GITHUB_TOKEN
	GITHUB_TOKEN := $(shell test -f ~/.github_token && cat ~/.github_token || (read -sp "GitHub Personal Access Token: " token && echo $$token > ~/.github_token && echo $$token))
endif

export GH_TOKEN := $(GITHUB_TOKEN)

weekly: check-schema git-auth create-weekly-update clean

delta: git-auth create-delta-update clean

check-schema:
	@set -e; \
	check-jsonschema --schemafile ./schemas/anime-offline-database-minified.schema.json anime-offline-database-minified.json & \
	check-jsonschema --schemafile ./schemas/anime-offline-database.schema.json anime-offline-database.json & \
	wait
	
	@set -e; \
	check-jsonschema --schemafile ./schemas/dead-entries.schema.json anidb.json & \
	check-jsonschema --schemafile ./schemas/dead-entries.schema.json anilist.json & \
	check-jsonschema --schemafile ./schemas/dead-entries.schema.json animenewsnetwork.json & \
	check-jsonschema --schemafile ./schemas/dead-entries.schema.json kitsu.json & \
	check-jsonschema --schemafile ./schemas/dead-entries.schema.json myanimelist.json & \
	wait

	@set -e; \
	check-jsonschema --schemafile ./schemas/dead-entries.schema.json anidb-minified.json & \
	check-jsonschema --schemafile ./schemas/dead-entries.schema.json anilist-minified.json & \
	check-jsonschema --schemafile ./schemas/dead-entries.schema.json animenewsnetwork-minified.json & \
	check-jsonschema --schemafile ./schemas/dead-entries.schema.json kitsu-minified.json & \
	check-jsonschema --schemafile ./schemas/dead-entries.schema.json myanimelist-minified.json & \
	wait

git-auth:
	@echo "Caching credentials..." && \
	echo "https://$(GITHUB_USERNAME):$(GITHUB_TOKEN)@github.com/${GITHUB_USERNAME}/test.git" > ~/.git-credentials && \
	git config --local credential.helper store && \
	echo "Credentials cached for the session." || $(MAKE) clean

create-weekly-update:
	@git add README.md && \
	git commit -m "Updated entries ${YEAR} week ${WEEK}" && \
	git push && \
	git tag ${TAG_NAME} && \
	git push origin ${TAG_NAME} && \
	gh release create ${TAG_NAME} --verify-tag --latest --title "${TAG_NAME}" --notes-file release-notes.md && \
	gh release upload ${TAG_NAME} anime-offline-database.json && \
	gh release upload ${TAG_NAME} anime-offline-database.json.zst && \
	gh release upload ${TAG_NAME} anime-offline-database.jsonl && \
	gh release upload ${TAG_NAME} anime-offline-database.jsonl.zst && \
	gh release upload ${TAG_NAME} anime-offline-database-minified.json && \
	gh release upload ${TAG_NAME} anime-offline-database-minified.json.zst && \
	gh release upload ${TAG_NAME} anidb.json && \
	gh release upload ${TAG_NAME} anidb-minified.json && \
	gh release upload ${TAG_NAME} anidb-minified.json.zst && \
	gh release upload ${TAG_NAME} anilist.json && \
	gh release upload ${TAG_NAME} anilist-minified.json && \
	gh release upload ${TAG_NAME} anilist-minified.json.zst && \
	gh release upload ${TAG_NAME} animenewsnetwork.json && \
	gh release upload ${TAG_NAME} animenewsnetwork-minified.json && \
	gh release upload ${TAG_NAME} animenewsnetwork-minified.json.zst && \
	gh release upload ${TAG_NAME} kitsu.json && \
	gh release upload ${TAG_NAME} kitsu-minified.json && \
	gh release upload ${TAG_NAME} kitsu-minified.json.zst && \
	gh release upload ${TAG_NAME} myanimelist.json && \
	gh release upload ${TAG_NAME} myanimelist-minified.json && \
	gh release upload ${TAG_NAME} myanimelist-minified.json.zst && \
	git tag -f latest && \
	git push -f origin latest && \
	gh release edit latest --notes-file release-notes.md
	gh release upload latest anime-offline-database.json --clobber && \
	gh release upload latest anime-offline-database.json.zst --clobber && \
	gh release upload latest anime-offline-database.jsonl --clobber && \
	gh release upload latest anime-offline-database.jsonl.zst --clobber && \
	gh release upload latest anime-offline-database-minified.json --clobber && \
	gh release upload latest anime-offline-database-minified.json.zst --clobber && \
	gh release upload latest anidb.json --clobber && \
	gh release upload latest anidb-minified.json --clobber && \
	gh release upload latest anidb-minified.json.zst --clobber && \
	gh release upload latest anilist.json --clobber && \
	gh release upload latest anilist-minified.json --clobber && \
	gh release upload latest anilist-minified.json.zst --clobber && \
	gh release upload latest animenewsnetwork.json --clobber && \
	gh release upload latest animenewsnetwork-minified.json --clobber && \
	gh release upload latest animenewsnetwork-minified.json.zst --clobber && \
	gh release upload latest kitsu.json --clobber && \
	gh release upload latest kitsu-minified.json --clobber && \
	gh release upload latest kitsu-minified.json.zst --clobber && \
	gh release upload latest myanimelist.json --clobber && \
	gh release upload latest myanimelist-minified.json --clobber && \
	gh release upload latest myanimelist-minified.json.zst --clobber || $(MAKE) clean

create-delta-update:
	@git add README.md && \
	git commit -m "Delta Update" && \
	git push && \
	git tag -f latest && \
	git push -f origin latest && \
	gh release edit latest --notes ""
	gh release upload latest anime-offline-database.json --clobber && \
	gh release upload latest anime-offline-database.json.zst --clobber && \
	gh release upload latest anime-offline-database.jsonl --clobber && \
	gh release upload latest anime-offline-database.jsonl.zst --clobber && \
	gh release upload latest anime-offline-database-minified.json --clobber && \
	gh release upload latest anime-offline-database-minified.json.zst --clobber && \
	gh release upload latest anidb.json --clobber && \
	gh release upload latest anidb-minified.json --clobber && \
	gh release upload latest anidb-minified.json.zst --clobber && \
	gh release upload latest anilist.json --clobber && \
	gh release upload latest anilist-minified.json --clobber && \
	gh release upload latest anilist-minified.json.zst --clobber && \
	gh release upload latest animenewsnetwork.json --clobber && \
	gh release upload latest animenewsnetwork-minified.json --clobber && \
	gh release upload latest animenewsnetwork-minified.json.zst --clobber && \
	gh release upload latest kitsu.json --clobber && \
	gh release upload latest kitsu-minified.json --clobber && \
	gh release upload latest kitsu-minified.json.zst --clobber && \
	gh release upload latest myanimelist.json --clobber && \
	gh release upload latest myanimelist-minified.json --clobber && \
	gh release upload latest myanimelist-minified.json.zst --clobber || $(MAKE) clean

clean:
	@echo "Cleaning up credentials..."
	@git config --unset credential.helper || true
	@rm ~/.github_username || true
	@rm ~/.github_token || true
	@rm ~/.git-credentials || true
	@rm release-notes.md && touch release-notes.md || true
	@echo "Cleanup successful!"
