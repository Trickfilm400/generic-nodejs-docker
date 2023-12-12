#/bin/sh

#regex for a valid http(s) / ftp url
regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

# check if a package.json file exists and caching from a url is enablesd
if [[ -f /app/package.json ]] && [[ ${CACHE} = "true" ]]; then
    # cd into workdir
    cd /app
    # check for typescript compile
    if [[ ${BUILD_TYPESCRIPT} = "true" ]]; then
          # install ALL dependencies and run build job
          sh -c "npm install"
          sh -c "npm run build"
    else
          # install only dependencies for production, withput devDependencies
          echo "Installing Dependencies.... [npm ci --omit=dev]"
          sh -c "npm ci --omit=dev --audit=false --fund=false"
    fi
    # run script from package.json start script
    echo "Running [npm start] to start your nodejs program..."
    sh -c "npm start"
else
    if [[ ${URL} =~ $regex ]]; then # check for valid URL
        # download new data because CACHE is disabled [==false]
        if [[ ${CACHE} = "false" ]]; then
         echo "Downloading new data due to non caching policy"
            # delete old files
            rm -rf /app /app.zip
            # download new files into app.zip
            wget ${URL} -O /app.zip
            # unzip zip file
            sh -c "unzip -d /app/ /app.zip"
            # move data to workdir
            mv /app/*/* /app
            # go into workdir
            cd .. && cd /app
        fi
        # download init project if no package.json file exist
        if [[ ! -f /app/package.json ]]; then
            echo "Downloading initial project data"
            # download zip
            wget ${URL} -O /app.zip
            # unzip zip file
            sh -c "unzip -d /app/ /app.zip"
            # move files in place
            mv /app/*/* /app
         fi
         ## if package.json exits, install dependencies
         if [[ -f /app/package.json ]]; then
             cd /app
             # check for typescript compile
             if [[ ${BUILD_TYPESCRIPT} = "true" ]]; then
                 # install ALL dependencies and run build job
                 sh -c "npm install"
                 sh -c "npm run build"
             else
                 # install only dependencies for production (without devDependencies)
                 echo "Installing Dependencies.... [npm ci]"
                 sh -c "npm ci --audit=false --fund=false"
             fi
             # start nodejs project via package.json start script
             echo "Running [npm start] to start your nodejs program..."
             sh -c " cd /app && npm start"
         fi

    else
        # exit with exit code 1 if given URL does not match regex
        echo "NO VALID ZIP HTTPS LINK GIVEN"
        echo "EXITING..."
        exit 1
    fi

    # exit with exit code 2 if no package.json file was found
    echo "NO PACKAGE.JSON FILE FOUND."
    echo "EXITING..."
    exit 2
fi