#!/bin/bash
# -----------------------------------------------------------------------------
#
# Package	    : connect-redis
# Version	    : v7.1.1
# Source repo	    : https://github.com/tj/connect-redis
# Tested on	    : UBI 9.3
# Language          : Node
# Travis-Check      : True
# Script License    : Apache License, Version 2 or later
# Maintainer	    : Prachi Kurade <prachi.kurade1@ibm.com>
#
# Disclaimer: This script has been tested in root mode on given
# ==========  platform using the mentioned version of the package.
#             It may not work as expected with newer versions of the
#             package and/or distribution. In such case, please
#             contact "Maintainer" of this script.
#
# ----------------------------------------------------------------------------

PACKAGE_NAME=connect-redis
PACKAGE_VERSION=${1:-v7.1.1}
PACKAGE_URL=https://github.com/tj/connect-redis

export NODE_VERSION=${NODE_VERSION:-16}

yum install -y python3 python3-devel.ppc64le git gcc gcc-c++ libffi make

#Installing nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source "$HOME"/.bashrc
echo "installing nodejs $NODE_VERSION"
nvm install "$NODE_VERSION" >/dev/null
nvm use $NODE_VERSION



git clone $PACKAGE_URL $PACKAGE_NAME
cd  $PACKAGE_NAME
git checkout $PACKAGE_VERSION

if ! npm install && npm audit fix --force; then
    echo "------------------$PACKAGE_NAME:install_fails-------------------------------------"
    echo "$PACKAGE_URL $PACKAGE_NAME"
    echo "$PACKAGE_NAME  |  $PACKAGE_URL | $PACKAGE_VERSION | GitHub | Fail |  Install_Fails"
    exit 1
fi

exit 0
## Unit tests can be executed as mentioned in the README.md. Disabled here as they require a redis server

