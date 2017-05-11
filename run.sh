#!/bin/sh

[ -f /run-pre.sh ] && /run-pre.sh

if [ ! -d $CONFDIR ] ; then
  mkdir -p $CONFDIR
fi

if [ ! -d $CONFDIR/conf.d ] ; then
  mkdir -p $CONFDIR/conf.d
fi

function moveConf()
{
  if [ -f $CONFDIR/$1 ] ; then
  
    if [ -f /etc/nginx/$1 ] ; then
      rm -rf /etc/nginx/$1
    fi

    cp -rf $CONFDIR/$1 /etc/nginx/$1
    chown root:root /etc/nginx/$1
  else
    cp -rf /etc/nginx/$1 $CONFDIR/$1
  fi
}

$(moveConf fastcgi.conf);
$(moveConf fastcgi_params);
$(moveConf mime.types);
$(moveConf nginx.conf);
$(moveConf scgi_params);
$(moveConf uwsgi_params);

cp $CONFDIR/conf.d/* /etc/nginx/conf.d/

# start nginx
nginx -g "daemon off;"
