#!/bin/sh

if [ -z "${IS_GITHUB_ACTIONS}" ]; then
	echo "This script is run in GitHub Actions."
	pip install netaddr
fi

ansible-galaxy collection install -r requirements.yml
