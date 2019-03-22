#!/bin/bash
#Author Goodwish Matyila
set -eu
set -o pipefail
clear
echo ""
router_path="build/http/class.routes.js"
controller_path="build/controllers/class.controller.js"
models_path="build/models/class.model.js"
views_path="build/views/class.views.js"

html(){
    rootdir=${project_name}/index.html
    echo "<!DOCTYPE html>" >$rootdir
    echo "<html>" >>$rootdir
    echo "<head>" >>$rootdir
    echo "  <title>${project_name}</title>" >> $rootdir
    echo "  <link href='css/bootstrap.min.css' rel='stylesheet'/>" >>$rootdir
    echo "  <link href='styles/kendo.common.min.css' rel='stylesheet'/>" >>$rootdir
    echo "  <link href='styles/kendo.default.min.css' rel='stylesheet'/>" >>$rootdir
    echo "  <link href='styles/kendo.default.mobile.min.css' rel='stylesheet'/>" >>$rootdir
    echo "  <script src='js/jquery.min.js'></script>" >>$rootdir
    echo "  <script src='js/kendo.all.min.js'></script>" >>$rootdir
    echo "<script src='${router_path}'></script>" >>$rootdir
    echo "<script src='${models_path}'></script>" >>$rootdir
    echo "<script src='${controller_path}'></script>" >>$rootdir
    echo "<script src='${views_path}'></script>" >>$rootdir
    echo "</head>" >>$rootdir
    echo "<body>" >>$rootdir
    echo "</body>" >>$rootdir
    echo "</html>" >>$rootdir

    tsc --target "es3" --init --rootDir "./build" --typeRoots "./types"
    mv tsconfig.json ${project_name}/

}

proj() {
    clear
    read -p "Project name <project name>: " project_name
#make root
    mkdir -m 777 ${project_name}
        #subs
        html $project_name
#make sub dir
    mkdir -m 777 ${project_name}/css
    mkdir -m 777 ${project_name}/styles
    mkdir -m 777 ${project_name}/tests
    mkdir -m 777 ${project_name}/documentation
    mkdir -m 777 ${project_name}/images
    mkdir -m 777 ${project_name}/temp
    mkdir -m 777 ${project_name}/build
    mkdir -m 777 ${project_name}/build/controllers
    mkdir -m 777 ${project_name}/build/http
    mkdir -m 777 ${project_name}/build/views
    mkdir -m 777 ${project_name}/build/models

#source files
    echo "" > class.routes.js
    echo "" > class.routes.ts
    mv class.routes.js ${project_name}/build/http/
    mv class.routes.ts ${project_name}/build/http/


    echo "" > class.controller.js
    echo "" > class.controller.ts
    mv class.controller.js ${project_name}/build/controllers/
    mv class.controller.ts ${project_name}/build/controllers/


    echo "" > class.views.js
    echo "" > class.views.ts
    mv class.views.js ${project_name}/build/views/
    mv class.views.ts ${project_name}/build/views/

    echo "" > class.model.js
    echo "" > class.model.ts
    mv class.model.js ${project_name}/build/models/
    mv class.model.ts ${project_name}/build/models/

}

kendo(){
    cp $HOME/vendor/kendo-ui/styles/ ${project_name}/ -r 
    cp $HOME/vendor/kendo-ui/js/ ${project_name}/  -r 
    cp $HOME/vendor/kendo-ui/css/ ${project_name}/  -r 
    cp $HOME/vendor/kendo-ui/fonts/ ${project_name}/  -r 
    cp $HOME/vendor/kendo-ui/types/ ${project_name}/  -r 
}

start(){
if [ "${1}" == "create" ] ; then
    proj
elif [ "${1}" == "kendo-ui-mvc" ]  ; then 
    proj
    kendo
    echo "Completed"
elif [ "${1}" == "build" ] ; then
    read -p "Project to build: <project name> " project_name
    build $project_name
else
    clear
    echo "Enter valid command"
fi
}

if [ ! $# -eq 1 ] ; then
clear
echo "#####################################################################"
echo "# Project SPA App Quick Bootstrap v1.0.0     Automation             #"
echo "#                                @za_goodwish                       #"
echo "#                            Author: Goodwish Matyila               #"
echo "#####################################################################"
echo
echo  -e "\033[31mAvailable commands <create> | <kendo-ui-mvc> | <build> \033[0m"
echo 
echo "    Usage: $0 <command>"
echo
echo "Documentation: "
echo "============="
echo 
echo  "Create blank project without Kendo-UI"
echo  "====================================="
echo -e "\033[34mTypeScript Project > Project <create> \033[0m"
echo 
echo  "Create with stack Jquery,KendoUI,Angular with MVVM"
echo  "=================================================="
echo -e "\033[31mTypeScript Project > Project <kendo-ui-mvc> \033[0m"
echo
    exit 2
else
    start ${1}
   
fi



 



 