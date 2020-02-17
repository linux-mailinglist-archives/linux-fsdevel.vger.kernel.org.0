Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9911C160F95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 11:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgBQKII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 05:08:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35177 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgBQKIH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:08:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so6523329plt.2;
        Mon, 17 Feb 2020 02:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iKKgCiAZlR1taRlkitZ7rxNp+Ck/w8sUZXo1iF6SB2U=;
        b=l4GwjAEgyLa1IfyrC1EX3top7xBdvOxuyT485lRii+2r5eBnPu1Nyv8LZOiBMIjt6r
         4jlf/RfnUesX38OCosHT9wufaIPTJgTxnmTJ1cJZKz3fSTAjzTAgQFrPV8dB3vYdotLe
         3Rr5LzM6vrx4d7eQ7mspS2GBRtwAmyIMwAlAo8ZwB886Uh2iGFZnKkQTbOTL5MpyV6uA
         MtRTGXPiWSZk1Qz6NtGLUOvRRQKh/Dnc4PhZfGc8NFqL93feXlJVtkPML5IUig23XlnV
         7LpS/FKcITq7yfeCz/0xxrTi7iFrr1MWTT9mzjvC5SS+hCOwJRsghg0eiNa0aonCGnpC
         RATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iKKgCiAZlR1taRlkitZ7rxNp+Ck/w8sUZXo1iF6SB2U=;
        b=A1p+fFsDKZG+vdE2M01qbNFHuSCFZFH6C2v/Kd0Zzpu0RVUUoMIoCFlGMPFw9wMa95
         8CMFxu/+gkHbH0kDMN7gk7JELpOGL6MUo3+EOov42hw3rQUVt2ew255LySUFbSuqo4AY
         ty+FHXhyg2BqfG+WHBr2+QLl6YZ1kHhydNglpuyT5JCuT07HQMrOSV6XO1Vzcar28BF0
         qSdlKvMUiUF7qK/dTrLdsiv+zfrm4+xlUDrFFGmwp2535402h1MBjjA08kWUNMzXfHsL
         EwBGhSzZy2M4NWUlnp5O40XoRAkBTWbqXYlDUwPB3r5EmZzaeTz1q9N3DIO8XbZqqCyS
         Kzxw==
X-Gm-Message-State: APjAAAUe/7eTUpH6Tqz6KS3nnYi9FTuA7KK2OxbGozL+wGwjUr9ez6P/
        TPUo/KM/8J0t002T4EHHk28=
X-Google-Smtp-Source: APXvYqxqw5HdWcN+K6hXrAPr/tXKfemgsC0JTymT3aHo00NLx6k1Sa0S8ypRKht4ImTFvmqtJ1ZX9A==
X-Received: by 2002:a17:902:a984:: with SMTP id bh4mr15723986plb.281.1581934086617;
        Mon, 17 Feb 2020 02:08:06 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id y1sm51118pgi.56.2020.02.17.02.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 02:08:05 -0800 (PST)
Date:   Mon, 17 Feb 2020 18:08:00 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfstests: add fuse support
Message-ID: <20200217100800.GH2697@desktop>
References: <20200108192504.GA893@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108192504.GA893@miu.piliscsaba.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 08, 2020 at 08:25:25PM +0100, Miklos Szeredi wrote:
> This allows using any fuse filesystem that can be mounted with
> 
>   mount -t fuse.$SUBTYPE ...
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

So sorry for being so late to review..

This patch looks fine to me overall, just some minor comments inline.

> ---
>  README.fuse   |   28 ++++++++++++++++++++++++++++
>  check         |    2 ++
>  common/attr   |    4 ++--
>  common/config |    8 +++++++-
>  common/rc     |   34 ++++++++++++++++++++++++++++------
>  5 files changed, 67 insertions(+), 9 deletions(-)
> 
> --- a/common/config
> +++ b/common/config
> @@ -295,6 +295,9 @@ _mount_opts()
>  	9p)
>  		export MOUNT_OPTIONS=$PLAN9_MOUNT_OPTIONS
>  		;;
> +	fuse)
> +		export MOUNT_OPTIONS=$FUSE_MOUNT_OPTIONS
> +		;;
>  	xfs)
>  		export MOUNT_OPTIONS=$XFS_MOUNT_OPTIONS
>  		;;
> @@ -353,6 +356,9 @@ _test_mount_opts()
>  	9p)
>  		export TEST_FS_MOUNT_OPTS=$PLAN9_MOUNT_OPTIONS
>  		;;
> +	fuse)
> +		export TEST_FS_MOUNT_OPTS=$FUSE_MOUNT_OPTIONS
> +		;;
>  	cifs)
>  		export TEST_FS_MOUNT_OPTS=$CIFS_MOUNT_OPTIONS
>  		;;
> @@ -485,7 +491,7 @@ _check_device()
>  	fi
>  
>  	case "$FSTYP" in
> -	9p|tmpfs|virtiofs)
> +	9p|fuse|tmpfs|virtiofs)
>  		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
>  		# tmpfs doesn't use mount source, ignore

Update comment above and mention fuse too?

>  		;;
> --- a/common/rc
> +++ b/common/rc
> @@ -143,6 +143,8 @@ case "$FSTYP" in
>  	 ;;
>      9p)
>  	 ;;
> +    fuse)
> +	 ;;
>      ceph)
>  	 ;;
>      glusterfs)
> @@ -339,7 +341,7 @@ _try_scratch_mount()
>  		_overlay_scratch_mount $*
>  		return $?
>  	fi
> -	_mount -t $FSTYP `_scratch_mount_options $*`
> +	_mount -t $FSTYP$SUBTYP `_scratch_mount_options $*`

Or make it more explicit and call it $FUSE_SUBTYP ? So we know it's only
useful in fuse testing.

>  }
>  
>  # mount scratch device with given options and _fail if mount fails
> @@ -422,7 +424,7 @@ _test_mount()
>          return $?
>      fi
>      _test_options mount
> -    _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> +    _mount -t $FSTYP$SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
>  }
>  
>  _test_unmount()
> @@ -614,6 +616,9 @@ _test_mkfs()
>      9p)
>  	# do nothing for 9p
>  	;;
> +    fuse)
> +	# do nothing for fuse
> +	;;
>      virtiofs)
>  	# do nothing for virtiofs
>  	;;
> @@ -654,6 +659,9 @@ _mkfs_dev()
>      9p)
>  	# do nothing for 9p
>  	;;
> +    fuse)
> +	# do nothing for fuse
> +	;;
>      virtiofs)
>  	# do nothing for virtiofs
>  	;;
> @@ -705,6 +713,14 @@ _scratch_cleanup_files()
>  		_overlay_mkdirs $OVL_BASE_SCRATCH_MNT
>  		# leave base fs mouted so tests can setup lower/upper dir files
>  		;;
> +	fuse)
> +		[ -n "$SCRATCH_MNT" ] || return 1
> +		_scratch_mount
> +		if [ ! -e $SCRATCH_MNT/bin/sh ]; then

What's the purpose of this check? Avoid deleting / ? I think that has
been done by the $SCRATCH_MNT check.

> +			rm -rf $SCRATCH_MNT/*
> +		fi
> +		_scratch_unmount
> +		;;
>  	*)
>  		[ -n "$SCRATCH_MNT" ] || return 1
>  		_scratch_mount
> @@ -721,7 +737,7 @@ _scratch_mkfs()
>  	local mkfs_status
>  
>  	case $FSTYP in
> -	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
> +	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs)
>  		# unable to re-create this fstyp, just remove all files in
>  		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
>  		# created in previous runs
> @@ -1495,7 +1511,7 @@ _require_scratch_nocheck()
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
>  		fi
>  		;;
> -	9p|virtiofs)
> +	9p|fuse|virtiofs)
>  		if [ -z "$SCRATCH_DEV" ]; then
>  			_notrun "this test requires a valid \$SCRATCH_DEV"
>  		fi

Check for $SCRATCH_MNT as well?

> @@ -1619,7 +1635,7 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> -	9p|virtiofs)
> +	9p|fuse|virtiofs)
>  		if [ -z "$TEST_DEV" ]; then
>  			_notrun "this test requires a valid \$TEST_DEV"
>  		fi

Same here, should check $TEST_DIR too.

> @@ -2599,7 +2615,7 @@ _mount_or_remount_rw()
>  
>  	if [ $USE_REMOUNT -eq 0 ]; then
>  		if [ "$FSTYP" != "overlay" ]; then
> -			_mount -t $FSTYP $mount_opts $device $mountpoint
> +			_mount -t $FSTYP$SUBTYP $mount_opts $device $mountpoint
>  		else
>  			_overlay_mount $device $mountpoint
>  		fi
> @@ -2727,6 +2743,9 @@ _check_test_fs()
>      9p)
>  	# no way to check consistency for 9p
>  	;;
> +    fuse)
> +	# no way to check consistency for fuse
> +	;;
>      virtiofs)
>  	# no way to check consistency for virtiofs
>  	;;
> @@ -2788,6 +2807,9 @@ _check_scratch_fs()
>      9p)
>  	# no way to check consistency for 9p
>  	;;
> +    fuse)
> +	# no way to check consistency for fuse
> +	;;
>      virtiofs)
>  	# no way to check consistency for virtiofs
>  	;;
> --- a/check
> +++ b/check
> @@ -56,6 +56,7 @@ check options
>      -glusterfs		test GlusterFS
>      -cifs		test CIFS
>      -9p			test 9p
> +    -fuse		test fuse
>      -virtiofs		test virtiofs
>      -overlay		test overlay
>      -pvfs2		test PVFS2
> @@ -269,6 +270,7 @@ while [ $# -gt 0 ]; do
>  	-glusterfs)	FSTYP=glusterfs ;;
>  	-cifs)		FSTYP=cifs ;;
>  	-9p)		FSTYP=9p ;;
> +	-fuse)		FSTYP=fuse ;;
>  	-virtiofs)	FSTYP=virtiofs ;;
>  	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
>  	-pvfs2)		FSTYP=pvfs2 ;;
> --- a/common/attr
> +++ b/common/attr
> @@ -238,7 +238,7 @@ _getfattr()
>  
>  # set maximum total attr space based on fs type
>  case "$FSTYP" in
> -xfs|udf|pvfs2|9p|ceph)
> +xfs|udf|pvfs2|9p|ceph|fuse)
>  	MAX_ATTRS=1000
>  	;;
>  *)
> @@ -258,7 +258,7 @@ xfs|udf|btrfs)
>  pvfs2)
>  	MAX_ATTRVAL_SIZE=8192
>  	;;
> -9p|ceph)
> +9p|ceph|fuse)
>  	MAX_ATTRVAL_SIZE=65536
>  	;;

As you're fuse maintainer, I assume above max attr setting is correct :)


Thanks,
Eryu

>  *)
> --- /dev/null
> +++ b/README.fuse
> @@ -0,0 +1,28 @@
> +Here are instructions for testing fuse using the passthrough_ll example
> +filesystem provided in the libfuse source tree:
> +
> +git clone git://github.com/libfuse/libfuse.git
> +cd libfuse
> +meson build
> +cd build
> +ninja
> +cp example/passthrough_ll /usr/bin
> +cd
> +cat << 'EOF' > /sbin/mount.fuse.passthrough_ll
> +#!/bin/bash
> +ulimit -n 1048576
> +exec /usr/bin/passthrough_ll -ofsname="$@"
> +EOF
> +chmod +x /sbin/mount.fuse.passthrough_ll
> +mkdir -p /mnt/test /mnt/scratch /home/test/test /home/test/scratch
> +
> +Use the following config file:
> +
> +export TEST_DEV=non1
> +export TEST_DIR=/mnt/test
> +export SCRATCH_DEV=non2
> +export SCRATCH_MNT=/mnt/scratch
> +export FSTYP=fuse
> +export SUBTYP=.passthrough_ll
> +export FUSE_MOUNT_OPTIONS="-osource=/home/test/scratch,allow_other,default_permissions"
> +export TEST_FS_MOUNT_OPTS="-osource=/home/test/test,allow_other,default_permissions"
> 
> 
> 
