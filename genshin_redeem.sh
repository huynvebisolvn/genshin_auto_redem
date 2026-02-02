#!/bin/bash
GENSHIN_UID="856197706"
REGION="os_asia"
COOKIE="cookie_token_v2=v2_CAQSDGNlMXRidXdiMDB6axokZTU5YzBiNmMtYTA0OS00YjViLTk5OGYtNmRmYzlmNDIwNzM4IOLVgcwGKO__u1Uwx7uIZEILaGs0ZV9nbG9iYWxqAlNH.4mqAaQAAAAAB.MEUCIQD0LnE78AeUSTxYDGtRrnNrs6D2JL7lXKhIl3yF6vtIxgIgLvGLrh3kyOd3nqIhqJUsrHYagGuXgcZwb3yKv4yRNKo; account_mid_v2=191pvgox28_hy; account_id_v2=209853895"
CODES_JSON=$(curl -s "https://db.hashblen.com/codes")
GENSHIN_CODES=$(echo "$CODES_JSON" | osascript -l JavaScript -e 'function run(argv) { const data = JSON.parse(argv[0]); return (data.genshin || []).map(item => item.code).join("\n"); }' "$CODES_JSON" 2>/dev/null)
if [ -z "$GENSHIN_CODES" ]; then
    echo "Khong tim thay codes Genshin hoac loi khi lay du lieu"
    exit 1
fi
SUCCESS=0
FAILED=0
ALREADY_USED=0
SUCCESS_CODES=()
for CODE in $GENSHIN_CODES; do
    RESPONSE=$(curl -s --location "https://sg-hk4e-api.hoyoverse.com/common/apicdkey/api/webExchangeCdkey?lang=en&game_biz=hk4e_global&uid=$GENSHIN_UID&region=$REGION&cdkey=$CODE" \
        --header "Cookie: $COOKIE" \
        --header 'Accept: application/json, text/plain, */*' \
        --header 'Accept-Encoding: gzip, deflate, br, zstd' \
        --header 'Connection: keep-alive' \
        --header 'x-rpc-app_version: 2.34.1' \
        --header 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
        --header 'x-rpc-client_type: 4')
    RETCODE=$(osascript -l JavaScript -e "function run(argv) { const data = JSON.parse(argv[0]); return data.retcode || 'null'; }" "$RESPONSE" 2>/dev/null)
    MESSAGE=$(osascript -l JavaScript -e "function run(argv) { const data = JSON.parse(argv[0]); return data.message || 'Unknown error'; }" "$RESPONSE" 2>/dev/null)
    case $RETCODE in
        0)
            SUCCESS_CODES+=("$CODE")
            ((SUCCESS++))
            ;;
        -2017|-2018)
            ((ALREADY_USED++))
            ;;
        -2001)
            ((FAILED++))
            ;;
        -2003)
            ((FAILED++))
            ;;
        *)
            ((FAILED++))
            ;;
    esac
    sleep 5.5
done

# Ghi log
LOG_DATE=$(date '+%Y-%m-%d %H:%M:%S')
if [ ${#SUCCESS_CODES[@]} -gt 0 ]; then
    echo "$LOG_DATE: ${SUCCESS_CODES[*]}"
else
    echo "$LOG_DATE: null"
fi
