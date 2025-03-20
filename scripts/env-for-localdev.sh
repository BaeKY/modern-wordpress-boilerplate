#!/bin/bash

set -e

exec_from=$(pwd)
script_path="$(cd $(dirname $0) && pwd)"
project_path="$(dirname ${script_path})"
env_scheme_file="${project_path}/envscheme.local.json"
env_local="${project_path}/.env"
input_prompt="${script_path}/_input-prompt.sh"

if [ -f $env_local ]; then
    echo "${env_local} 파일이 이미 존재합니다."
    exit 1
fi

function should_omit() {
    local target_variable=$1
    local omit_list=(
        "AUTH_KEY"
        "SECURE_AUTH_KEY"
        "LOGGED_IN_KEY"
        "NONCE_KEY"
        "AUTH_SALT"
        "SECURE_AUTH_SALT"
        "LOGGED_IN_SALT"
        "NONCE_SALT"
        "WP_ENV"
        "WP_HOME"
        "WP_SITEURL"
        "DB_HOST"
    )

    if [[ " ${omit_list[*]} " =~ " ${target_variable} " ]]; then
        return 0
    fi
    return 1
}

INPUT=()

sections=`jq -r '.sections[] | @base64' ${env_scheme_file}`;
for section in $sections; do
    section_name=`echo $section | base64 --decode | jq -r '.name'`;
    section_required=`echo $section | base64 --decode | jq -r '.required'`;
    if [ "$section_required" = "false" ]; then 
        read -p "Do you want to configure $section_name? (y/N): " configure_optional;
        if [ "$configure_optional" != "y" ]; then
            continue;
        fi
    fi
    echo "$section_name:"
    INPUT+=("# $section_name")
    schemes=`echo $section | base64 --decode | jq -r '.scheme[] | @base64'`;
		for scheme in $schemes; do
			scheme_name=`echo $scheme | base64 --decode | jq -r '.name'`;
			scheme_description=`echo $scheme | base64 --decode | jq -r '.description'`;
			scheme_default=`echo $scheme | base64 --decode | jq -r '.default'`;
			scheme_is_secret=`echo $scheme | base64 --decode | jq -r '.is_secret // empty'`;
			if [ "$scheme_is_secret" = "true" ]; then
				while true; do
					kv=$($input_prompt --var="$scheme_name" --description="$scheme_description" --is-secret --quotes);
					if [ -n "${kv#${scheme_name}=}" ]; then
						INPUT+=("$kv");
						break;
					fi
					echo;
				done;
				echo;
			else
				while true; do
					kv=$($input_prompt --var="$scheme_name" --description="$scheme_description" --default="$scheme_default" --quotes);
					if [ -n "${kv#${scheme_name}=}" ]; then
						INPUT+=("$kv");
						break;
					fi
				done;
			fi
		done;
		echo;
		INPUT+=("");
	done;
    INPUT+=('# Constants')
    INPUT+=('DB_NAME="db"')
    INPUT+=('DB_USER="db"')
    INPUT+=('DB_PASSWORD="db"')
    INPUT+=('WP_ENV="development"')
    INPUT+=('WP_HOME="${DDEV_PRIMARY_URL}"')
    INPUT+=('WP_SITEURL="${DDEV_PRIMARY_URL}/wp"')
    INPUT+=('DB_HOST="db"')
    INPUT+=("")
	echo -n "" > ${env_local};
	for input in "${INPUT[@]}"; do
		echo ${input} >> ${env_local};
	done;
	echo "환경변수 설정이 완료되었습니다.";



echo "Generate secret keys and salts for WordPress"
curl -s https://api.wordpress.org/secret-key/1.1/salt/ | awk -F"'" '{print $2"='\''"$4"'\''"}' >> $env_local

echo "Environment variables loaded successfully."