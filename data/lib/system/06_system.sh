namespace oo

System.LoadFile(){
    @var libPath

    if [ -f "$libPath" ]
    then
        ## if already imported let's return
        if Array.Contains "$file" "${__oo__importedFiles[@]}"
        then
            subject=level3 Log "File previously imported: ${libPath}"
            return 0
        fi

        subject=level2 Log "Importing: $libPath"

        __oo__importedFiles+=( "$libPath" )

        source "$libPath" || throw "Unable to load $libPath"

        # TODO: maybe only Type.Load when the filename starts with a capital?
        # In that case all the types would have to start with a capital letter

        if Function.Exists Type.Load
        then
            Type.Load
            subject=level3 Log "Loading Types..."
        fi
    else
        subject=level2 Log "File doesn't exist when importing: $libPath"
    fi
}

System.Import.github() {
    @var libPath
    # example: import steffenhoenig/crash/modules/example
    # curl https://api.github.com/repos/steffenhoenig/crash/contents/modules/example
    ! $(which curl &>/dev/null) && throw "Cannot find curl" && return 1 
    ! $(which jq &>/dev/null) && throw "Cannot find jq" && return 1 
    local gitModules=${libPath#*/*/}
    local gitUserRepo=${libPath/\/${gitModules}}
    #subject=level3 Log "Trying to load from (github): ${gitUserRepo}"
    #check, if file exists on github.com
    downloadLinks=($(\
        curl https://api.github.com/repos/${gitUserRepo}/contents/${gitModules} | \
        jq -r '., .[] | .["download_url"]? | select (. != null)'\
        ))
    [ "${downloadLinks}"x = x ] && return 0
    # If the base name of $gitModules equals the one of
    # $downloadLinks[0] it's safe assuming a single file
    if [ ${gitModules##*/}.sh = ${downloadLinks[0]##*/} ]; then  
        downloadDir=${gitModules%/*}
    else
        downloadDir=${gitModules}
    fi
    echo "\$downloadDir: $downloadDir"
    # getting the files
    mkdir -p ${__oo__path}/${gitUserRepo}/${downloadDir}
    (cd ${__oo__path}/${gitUserRepo}/${downloadDir}
        for l in ${downloadLinks[@]}; do
            curl -O $l
        done)
    return 0
}

System.Import() {
    local libPath
    for libPath in "$@"; do
        local requestedPath="$libPath"
       
        ## correct path if relative
        [ ! -e "$libPath" ] && libPath="${__oo__path}/${libPath}"
        [ ! -e "$libPath" ] && libPath="${libPath}.sh"
        subject=level4 Log "Trying to load from: ${__oo__path} / ${requestedPath}"


        if [ ! -e "$libPath" ]
        then
            # try a relative reference
#            local localPath="${BASH_SOURCE[1]%/*}"
            local localPath="$( cd "${BASH_SOURCE[1]%/*}" && pwd )"
#            [ -f "$localPath" ] && localPath="$(dirname "$localPath")"
            libPath="${localPath}/${requestedPath}"
            subject=level4 Log "Trying to load from: ${localPath} / ${requestedPath}"

            [ ! -e "$libPath" ] && libPath="${libPath}.sh"
        fi
        subject=level3 Log "Trying to load from: ${libPath}"
        [ ! -e "$libPath" ] && return 1 
        
        libPath="$(File.GetAbsolutePath "$libPath")"

        if [ -d "$libPath" ]; then
            local file
            for file in "$libPath"/*.sh
            do
                System.LoadFile "$file"
            done
        else
            System.LoadFile "$libPath"
        fi
    done
    return 0
}

System.Import.wrapper() {
    @var libPath
    try {
        System.Import $libPath
    } catch {
        System.Import.github $libPath
        System.Import $libPath || throw "Cannot import $libPath" && return 1 
        return 0
    }
        return 0
}

alias import="System.Import"
