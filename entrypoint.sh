#!/bin/bash

pritunl set-mongodb ${MONGODB_URI:-"mongodb://mongo:27017/pritunl"}
pritunl set app.reverse_proxy true
pritunl set app.redirect_server false
pritunl set app.server_ssl false
pritunl set app.server_port 80
