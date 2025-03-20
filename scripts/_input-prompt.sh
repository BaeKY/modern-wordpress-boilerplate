#!/bin/bash

# 기본값 설정
VAR_NAME=""
DESCRIPTION=""
IS_SECRET=false
DEFAULT_VALUE=""
QUOTES=0

# 사용법 함수
usage() {
  echo "Usage: $0 --description=\"Description\" [--var=VAR_NAME] [--is-secret] [--default=DEFAULT_VALUE] [--limit=LIMIT]"
  exit 1
}

function build_paragraph() {
  local paragraph=""
  if [[ "$IS_SECRET" == "true" ]]; then
    paragraph="🔑 $DESCRIPTION"
  else
    paragraph="📝 $DESCRIPTION"
  fi

  if [[ -n "$DEFAULT_VALUE" && "$IS_SECRET" != "true" ]]; then
    paragraph="$paragraph [Default: $DEFAULT_VALUE]: "
  else 
    paragraph="$paragraph: "
  fi

  echo -n $paragraph
}

opt=();

# 인자 파싱
for arg in "$@"; do
  case $arg in
    --var=*)
      VAR_NAME="${arg#*=}"
      ;;
    --description=*)
      DESCRIPTION="${arg#*=}"
      ;;
    --is-secret)
      opt+=("-s")
      IS_SECRET=true
      ;;
    --default=*)
      DEFAULT_VALUE="${arg#*=}"
      ;;
    --quotes)
      QUOTES=1
      ;;
    --limit=*)
      # TODO: Backspace 처리, newline 처리
      if ! [[ "${arg#*=}" =~ ^[0-9]+$ ]]; then
        echo "Error: Limit must be a number."
        usage
      fi
      opt+=("-n ${arg#*=}")
      ;;
    *)
      echo "Unknown argument: $arg"
      usage
      ;;
  esac
done

# 필수 인자 검증
if [[ -z "$DESCRIPTION" ]]; then
  echo "Error: Missing required arguments."
  usage
fi

opt+=("-p$(build_paragraph) ")

read "${opt[@]}" value

# 기본값 처리
if [[ -z "$value" && -n "$DEFAULT_VALUE" && "$IS_SECRET" != "true" ]]; then
  value="${DEFAULT_VALUE}"
fi

if [ "${QUOTES}" == 1 ]; then
  value="\"${value}\""
fi

if [[ -z "$VAR_NAME" ]]; then 
  echo -n "${value}"
else 
  echo -n "$VAR_NAME=${value}"
fi