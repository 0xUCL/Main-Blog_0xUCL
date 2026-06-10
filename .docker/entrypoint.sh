#! /bin/bash

# print folder contents for debugging
printf "\n\nContents:\n\n"
ls

# DIHAPUS: cite process tidak dipakai di project ini
# python3 _cite/cite.py

# run jekyll serve in hot-reload mode
# rerun whenever _config.yaml changes (jekyll hot-reload doesn't work with this file)
watchmedo auto-restart \
    --debug-force-polling \
    --patterns="_config.yaml" \
    --signal SIGTERM \
    -- bundle exec jekyll serve --open-url --force_polling --livereload --trace --host=0.0.0.0 \
    | sed "s/LiveReload address.*//g;s/0.0.0.0/localhost/g" &

# DIHAPUS: cite re-watcher tidak dipakai di project ini
# watchmedo shell-command \
#     --patterns="_data/sources*;_data/orcid*;_data/pubmed*;_data/google-scholar*" \
#     --command="python3 _cite/cite.py"

# keep container running
wait
