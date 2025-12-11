SHELL    := /bin/bash
TAG_NAME := $(shell cat week.release)
YEAR     := $(shell echo $(TAG_NAME) | cut -d'-' -f1)
WEEK     := $(shell echo $(TAG_NAME) | cut -d'-' -f2)

ifndef GITHUB_USERNAME
	GITHUB_USERNAME := $(shell test -f ~/.github_username && cat ~/.github_username || (read -p "GitHub Username: " username && echo $$username > ~/.github_username && echo $$username))
endif

ifndef GITHUB_TOKEN
	GITHUB_TOKEN := $(shell test -f ~/.github_token && cat ~/.github_token || (read -sp "GitHub Personal Access Token: " token && echo $$token > ~/.github_token && echo $$token))
endif

export GH_TOKEN := $(GITHUB_TOKEN)

weekly: check-requirements check-schema git-auth create-weekly-update clean

delta: check-requirements git-auth create-delta-update clean

init-or-reset: git-auth
	@echo "Initializing or resetting anime-offline-database repo..."

	@set -euo pipefail; \
	gh release download latest --pattern 'anime-offline-database.json' --clobber 1>/dev/null & \
	gh release download latest --pattern 'anime-offline-database.jsonl' --clobber 1>/dev/null & \
	gh release download latest --pattern 'anime-offline-database.jsonl.zst' --clobber 1>/dev/null & \
	gh release download latest --pattern 'anime-offline-database-minified.json' --clobber 1>/dev/null & \
	gh release download latest --pattern 'anime-offline-database-minified.json.zst' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'anidb.json' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'anidb-minified.json' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'anidb-minified.json.zst' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'anilist.json' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'anilist-minified.json' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'anilist-minified.json.zst' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'animenewsnetwork.json' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'animenewsnetwork-minified.json' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'animenewsnetwork-minified.json.zst' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'kitsu.json' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'kitsu-minified.json' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'kitsu-minified.json.zst' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'myanimelist.json' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'myanimelist-minified.json' --clobber 1>/dev/null & \
	gh release download latest --dir ./dead-entries --pattern 'myanimelist-minified.json.zst' --clobber 1>/dev/null & \
	wait || $(MAKE) clean

	$(MAKE) clean

	@echo "Done."

check-requirements:
	@set -euo pipefail; \
	echo "" && \
	echo "Checking requirements." && \
	for tool in make bash set echo rm jsonschema gh git; do \
		command -v $$tool >/dev/null 2>&1 || \
		{ echo "✘ not found: $$tool"; exit 1; }; \
		echo "✔ found: $$tool"; \
	done

check-schema:
	@echo "Validating JSON files against their schemas..."

	@set -euo pipefail; \
	jsonschema metaschema ./schemas

	@set -euo pipefail; \
	jsonschema validate ./schemas/anime-offline-database-minified.schema.json anime-offline-database-minified.json & \
	jsonschema validate ./schemas/anime-offline-database.schema.json anime-offline-database.json & \
	wait
	
	@set -euo pipefail; \
	jsonschema validate ./schemas/dead-entries.schema.json ./dead-entries/anidb.json & \
	jsonschema validate ./schemas/dead-entries.schema.json ./dead-entries/anilist.json & \
	jsonschema validate ./schemas/dead-entries.schema.json ./dead-entries/animenewsnetwork.json & \
	jsonschema validate ./schemas/dead-entries.schema.json ./dead-entries/kitsu.json & \
	jsonschema validate ./schemas/dead-entries.schema.json ./dead-entries/myanimelist.json & \
	wait

	@set -euo pipefail; \
	jsonschema validate ./schemas/dead-entries.schema.json ./dead-entries/anidb-minified.json & \
	jsonschema validate ./schemas/dead-entries.schema.json ./dead-entries/anilist-minified.json & \
	jsonschema validate ./schemas/dead-entries.schema.json ./dead-entries/animenewsnetwork-minified.json & \
	jsonschema validate ./schemas/dead-entries.schema.json ./dead-entries/kitsu-minified.json & \
	jsonschema validate ./schemas/dead-entries.schema.json ./dead-entries/myanimelist-minified.json & \
	wait

	@echo "Done"

git-auth:
	@set -euo pipefail; \
	echo "Caching credentials..." && \
	echo "https://$(GITHUB_USERNAME):$(GITHUB_TOKEN)@github.com/${GITHUB_USERNAME}/anime-offline-database.git" > ~/.git-credentials && \
	git config --local credential.helper store && \
	echo "Credentials cached for the session." || $(MAKE) clean

create-weekly-update:
	@echo "Creating a weekly update."

	@set -euo pipefail; \
	git add README.md && \
	git commit -m "Updated entries ${YEAR} week ${WEEK}" && \
	git push && \
	git tag ${TAG_NAME} && \
	git push origin ${TAG_NAME} && \
	gh release create ${TAG_NAME} --verify-tag --latest --title "${TAG_NAME}" --notes-file release-notes.md || $(MAKE) clean

	@set -euo pipefail; \
	gh release upload ${TAG_NAME} anime-offline-database.json 1>/dev/null & \
	gh release upload ${TAG_NAME} anime-offline-database.jsonl 1>/dev/null & \
	gh release upload ${TAG_NAME} anime-offline-database.jsonl.zst 1>/dev/null & \
	gh release upload ${TAG_NAME} anime-offline-database-minified.json 1>/dev/null & \
	gh release upload ${TAG_NAME} anime-offline-database-minified.json.zst 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/anidb.json 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/anidb-minified.json 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/anidb-minified.json.zst 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/anilist.json 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/anilist-minified.json 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/anilist-minified.json.zst 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/animenewsnetwork.json 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/animenewsnetwork-minified.json 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/animenewsnetwork-minified.json.zst 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/kitsu.json 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/kitsu-minified.json 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/kitsu-minified.json.zst 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/myanimelist.json 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/myanimelist-minified.json 1>/dev/null & \
	gh release upload ${TAG_NAME} ./dead-entries/myanimelist-minified.json.zst 1>/dev/null & \
	wait || $(MAKE) clean

	@set -euo pipefail; \
	git tag -f latest && \
	git push -f origin latest && \
	gh release edit latest --notes-file release-notes.md || $(MAKE) clean

	@set -euo pipefail; \
	gh release upload latest anime-offline-database.json --clobber 1>/dev/null & \
	gh release upload latest anime-offline-database.jsonl --clobber 1>/dev/null & \
	gh release upload latest anime-offline-database.jsonl.zst --clobber 1>/dev/null & \
	gh release upload latest anime-offline-database-minified.json --clobber 1>/dev/null & \
	gh release upload latest anime-offline-database-minified.json.zst --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/anidb.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/anidb-minified.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/anidb-minified.json.zst --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/anilist.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/anilist-minified.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/anilist-minified.json.zst --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/animenewsnetwork.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/animenewsnetwork-minified.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/animenewsnetwork-minified.json.zst --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/kitsu.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/kitsu-minified.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/kitsu-minified.json.zst --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/myanimelist.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/myanimelist-minified.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/myanimelist-minified.json.zst --clobber 1>/dev/null & \
	wait || $(MAKE) clean

	@echo "Done."

create-delta-update:
	@echo "Creating delta update."

	@set -euo pipefail; \
	git add README.md && \
	git commit -m "Delta Update" && \
	git push && \
	git tag -f latest && \
	git push -f origin latest && \
	gh release edit latest --notes "" || $(MAKE) clean

	@set -euo pipefail; \
	gh release upload latest anime-offline-database.json --clobber 1>/dev/null & \
	gh release upload latest anime-offline-database.jsonl --clobber 1>/dev/null & \
	gh release upload latest anime-offline-database.jsonl.zst --clobber 1>/dev/null & \
	gh release upload latest anime-offline-database-minified.json --clobber 1>/dev/null & \
	gh release upload latest anime-offline-database-minified.json.zst --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/anidb.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/anidb-minified.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/anidb-minified.json.zst --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/anilist.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/anilist-minified.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/anilist-minified.json.zst --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/animenewsnetwork.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/animenewsnetwork-minified.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/animenewsnetwork-minified.json.zst --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/kitsu.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/kitsu-minified.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/kitsu-minified.json.zst --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/myanimelist.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/myanimelist-minified.json --clobber 1>/dev/null & \
	gh release upload latest ./dead-entries/myanimelist-minified.json.zst --clobber 1>/dev/null & \
	wait || $(MAKE) clean

	@echo "Done."

clean:
	@echo "Cleaning up credentials..."
	@git config --unset credential.helper || true
	@rm ~/.github_username || true
	@rm ~/.github_token || true
	@rm ~/.git-credentials || true
	@rm release-notes.md && touch release-notes.md || true
	@echo "Cleanup successful!"
