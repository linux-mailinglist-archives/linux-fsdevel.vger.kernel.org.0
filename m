Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A700169824
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 15:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgBWOqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 09:46:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40238 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWOq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 09:46:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id b185so3909692pfb.7;
        Sun, 23 Feb 2020 06:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BFmvR6FXjIiaKj0uGYjYuAkA3IYTXfDuXDN6BEVXAi8=;
        b=d1PGMP0q2gyHWtYiojcyQFQQZ6zFdugDBtV9XTiC7PeXcYa3lpugKc2EWuGcrbBdMj
         FRVMxBa3UI/Yg7ujTT2A2B6cpp+UWAC79CRHZCzI3m1EAlRvO3eXY+1uV/rOkZBOIfau
         rO1iyYqUeOIw+zOFQ410oXXIAWcuT1hyShMB7T2LSE6OcoUF7NjQb8q+Eg8CildoDeNC
         AbH1t/8RvOvGlZQpxHYDQ75hT43vOjaBpJ/1OWhUsY3afHC6g1wEyyGkN3sPdoGPKJMv
         cThKTufNVhqPUI+rJWBBYaGRRSw7JYDilTLt8ufEw++RIH7xhLTnMkTmI/WqYXCYuOZ/
         ri4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BFmvR6FXjIiaKj0uGYjYuAkA3IYTXfDuXDN6BEVXAi8=;
        b=GjKRuAYXWuzJ/wLjE2hSv1XjQ+hYFwXpbSmVRd8MU9lAlBZLZ177Ubs5tqSDVS6kbR
         gqrUGGUajepYhQrsQWHCzJAiqVDsPUoG0ZH51N3+mvqUhMGFZbWZ+kzQMffr9vIFUWf8
         eaDCBUwPKeuPOUt41fvMcOvo1zCrOdkvx9mQKonE9nV/sOgmo9InXWQTsp915kElanlc
         vBTrbvutqUSAmLFb6+xhGtERbO9WJxhLp4u+oNYmbHqMXlvMBfKh5wVjUXn5Djv9WeAw
         +Ujk7u9CSZjyKdUfFyvSY5UymlC2RT1l1PVGPf/TKGMfM/S6c+6eFgtevTDbMwGMPQxD
         ZJyw==
X-Gm-Message-State: APjAAAX+0ggQoukFSxHTRgDPhjRu0veR9LsslauUwNbRHmRQq+Tq4uNn
        6H7G/VDn0b0S7Lig3zOyyNnWXbaD+04=
X-Google-Smtp-Source: APXvYqzYO/p7EgGYRqDVODSuOoJ9hxTp7laqD+BWxt1FdHzRKGazplZoI0v9QZ4jXlwsgiyDiHo5Gg==
X-Received: by 2002:a63:515d:: with SMTP id r29mr47131410pgl.265.1582469188855;
        Sun, 23 Feb 2020 06:46:28 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id 144sm9738371pfc.45.2020.02.23.06.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 06:46:27 -0800 (PST)
Date:   Sun, 23 Feb 2020 22:46:17 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        kernel-team@fb.com, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Xi Wang <xi@cs.washington.edu>, fstests@vger.kernel.org
Subject: Re: [RFC PATCH xfstests] generic: add smoke test for AT_LINK_REPLACE
Message-ID: <20200223144345.GE3840@desktop>
References: <cover.1580251857.git.osandov@fb.com>
 <f23621bea2e8d5f919389131b84fa0226b90f502.1580253372.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f23621bea2e8d5f919389131b84fa0226b90f502.1580253372.git.osandov@fb.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 12:58:27AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Cc: fstests@vger.kernel.org
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Looks fine overall, would you please provide more info about this
AT_LINK_REPLACE flag? e.g. what's the expected behavior, what's current
status (merged in kernel or still pending?), reference the related
commits if already merged.

> ---
>  common/rc             |  2 +-
>  tests/generic/593     | 97 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/593.out |  6 +++
>  tests/generic/group   |  1 +
>  4 files changed, 105 insertions(+), 1 deletion(-)
>  create mode 100755 tests/generic/593
>  create mode 100644 tests/generic/593.out
> 
> diff --git a/common/rc b/common/rc
> index eeac1355..257f65a1 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2172,7 +2172,7 @@ _require_xfs_io_command()
>  		;;
>  	"flink")
>  		local testlink=$TEST_DIR/$$.link.xfs_io
> -		testio=`$XFS_IO_PROG -F -f -c "flink $testlink" $testfile 2>&1`
> +		testio=`$XFS_IO_PROG -F -f -c "flink $param $testlink" $testfile 2>&1`
>  		rm -f $testlink > /dev/null 2>&1
>  		;;
>  	"-T")
> diff --git a/tests/generic/593 b/tests/generic/593
> new file mode 100755
> index 00000000..8a9fee02
> --- /dev/null
> +++ b/tests/generic/593
> @@ -0,0 +1,97 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 593
> +#
> +# Smoke test linkat() with AT_LINK_REPLACE.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_xfs_io_command "-T"
> +_require_xfs_io_command "flink" "-f"
> +
> +same_file() {
> +	[[ "$(stat -c '%d %i' "$1")" = "$(stat -c '%d %i' "$2")" ]]
> +}
> +
> +touch "$TEST_DIR/$seq.src"
> +touch "$TEST_DIR/$seq.tgt"
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.tgt" "$TEST_DIR/$seq.src"
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.tgt" ||
> +	echo "Target was not replaced"
> +
> +# Linking to the same file should be a noop.
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.src" "$TEST_DIR/$seq.src"
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.tgt" "$TEST_DIR/$seq.src"
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.tgt" || echo "Target changed?"
> +
> +# Should work with O_TMPFILE.
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.tgt" -T "$TEST_DIR"
> +stat -c '%h' "$TEST_DIR/$seq.tgt"
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.tgt" &&
> +	echo "Target was not replaced"
> +
> +# It's okay if the target doesn't exist.
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.tgt2" "$TEST_DIR/$seq.src"
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.tgt2" ||
> +	echo "Target was not created"
> +
> +# Can't replace directories.
> +mkdir "$TEST_DIR/$seq.dir"
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.dir" "$TEST_DIR/$seq.src"
> +cd "$TEST_DIR/$seq.dir"
> +$XFS_IO_PROG -c "flink -f ." "$TEST_DIR/$seq.src"
> +$XFS_IO_PROG -c "flink -f .." "$TEST_DIR/$seq.src"
> +cd - &> /dev/null
> +
> +# Can't replace local mount points.
> +touch "$TEST_DIR/$seq.mnt"
> +$MOUNT_PROG --bind "$TEST_DIR/$seq.mnt" "$TEST_DIR/$seq.mnt"
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.mnt" "$TEST_DIR/$seq.src"
> +
> +# Can replace mount points in other namespaces, though.
> +unshare -m \

Better to define an UNSHARE_PROG in common/config and require it in this
test, then use $UNSHARE_PROG here.

Thanks,
Eryu

> +	bash -c "$UMOUNT_PROG $TEST_DIR/$seq.mnt; $XFS_IO_PROG -c \"flink -f $TEST_DIR/$seq.mnt\" $TEST_DIR/$seq.src"
> +if $UMOUNT_PROG "$TEST_DIR/$seq.mnt" &> /dev/null; then
> +	echo "Mount point was not detached"
> +fi
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.mnt" ||
> +	echo "Mount point was not replaced"
> +
> +# Should replace symlinks, not follow them.
> +touch "$TEST_DIR/$seq.symtgt"
> +ln -s "$TEST_DIR/$seq.symtgt" "$TEST_DIR/$seq.sym"
> +$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.sym" "$TEST_DIR/$seq.src"
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.sym" ||
> +	echo "Symlink was not replaced"
> +same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.symtgt" &&
> +	echo "Symlink target was replaced"
> +
> +rm -rf "$TEST_DIR/$seq."*
> +
> +status=0
> +exit
> diff --git a/tests/generic/593.out b/tests/generic/593.out
> new file mode 100644
> index 00000000..834c34bf
> --- /dev/null
> +++ b/tests/generic/593.out
> @@ -0,0 +1,6 @@
> +QA output created by 593
> +1
> +flink: Is a directory
> +flink: Is a directory
> +flink: Is a directory
> +flink: Device or resource busy
> diff --git a/tests/generic/group b/tests/generic/group
> index 6fe62505..0a87efca 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -595,3 +595,4 @@
>  590 auto prealloc preallocrw
>  591 auto quick rw pipe splice
>  592 auto quick encrypt
> +593 auto quick hardlink
> -- 
> 2.25.0
> 
