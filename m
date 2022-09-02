Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E543A5AA50F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 03:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiIBB2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 21:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiIBB2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:28:48 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80D479605;
        Thu,  1 Sep 2022 18:28:47 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z187so458743pfb.12;
        Thu, 01 Sep 2022 18:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wdOFKuho9Zld1TwLEDrskI2ZoOHyDGzDHs92/BbP8A8=;
        b=n709tqp0rcIBiBaB2JgoGy4MIm/Thxqtai0bj/WPQVW0420rjxiicg0QV2xA6Me+OU
         Ao3cAv8IcVUZevpMoHW5ljUlCyG1q5DY+O0iEnjja8D8fOR6f3A0Z08QDkkaKC7tR5jV
         DfVIc01MTZT/9PYLPpFk5mWg0EE0DgTguzE91q7pvQl3vdo6U+bD9P37iWFVNMSv9VfB
         8ZJlQ90ySUVV7cvynl7oky3UI7H5ayZ62GmZVkfaHRuUUqo0zYEfyZjZW8/GD6Zf3XUE
         NBvRq654Qxq+iMDztSQaJlVcEpBZCzpLNyoRY9jYEXH5Y0d6CM51OZLQXqOg6s439Mu/
         udtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wdOFKuho9Zld1TwLEDrskI2ZoOHyDGzDHs92/BbP8A8=;
        b=x5+aD51rXf0PrQxTJcfPVCf4MYUgc5hjVIShYpCSz1butJ3UzN7HyaJGPMCR8KGUzV
         VmcsYz2vj/b4UbElWas7HsvIDCk35K+q5G0yrmlq0NYW/rnB6tKGGi6EBYhz/YE2gCcb
         Qq/HxrwRq/DeX6G2e09QU9dmqlpglp3Ewg01iF20Ro25zLgIEsnXRABeHVVz1rIKWDg5
         XjosTOta7HWaArEmzO5j+rBFazjhy/CtcxUncRCwtTuDhf6iI8paUdAGdZbCbwxPMMYX
         QE6SiO2t4jONL8GtzX39EhtiDMUKD2/NZDk58iSBgqv3bt9JJo+0LFtWIo9Y0VNBGqha
         lJIA==
X-Gm-Message-State: ACgBeo2kOf8K/GKsR+B2IVsSSFKTLEJdaHS7s7s3aVIuO2xNxiGs7DuP
        aRySTeTq4kr7tQsH6MKAeVzpwi65hpyUAsf9ZDSrqrfz
X-Google-Smtp-Source: AA6agR6aQQYuOi09DM41oLxHzOgtFW/Fz887ks1AT8uwv3ZDP2JUZiMkHx98nZpy7zoCn1ABJ2iLiKwtPjmu26WKVP8=
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:6302 with SMTP id
 b12-20020a056a00114c00b005282c7a6302mr33959772pfm.37.1662082127293; Thu, 01
 Sep 2022 18:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220816133413.44298-1-jlayton@kernel.org>
In-Reply-To: <20220816133413.44298-1-jlayton@kernel.org>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Fri, 2 Sep 2022 09:28:35 +0800
Message-ID: <CADJHv_ufx=k+HGbL8wChLVXLsv-HOgzdMMfU4eUfnV3dZFMnaQ@mail.gmail.com>
Subject: Re: [xfstests PATCH] generic/693: add basic change attr test
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff,

Thanks for the patch!

On Tue, Aug 16, 2022 at 9:43 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> Now that we have the ability to query the change attribute in userland,
> test that the filesystems implement it correctly. Fetch the change
> attribute before and after various operations and validate that it
> changes (or doesn't change) as expected.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/rc             |  17 ++++++
>  tests/generic/693     | 138 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/693.out |   1 +
>  3 files changed, 156 insertions(+)
>  create mode 100755 tests/generic/693
>  create mode 100644 tests/generic/693.out
>
> Please look and make sure I'm not missing other operations that we
> should be testing here!
>
> diff --git a/common/rc b/common/rc
> index 197c94157025..b9cb47f99016 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5052,6 +5052,23 @@ hexdump()
>         _fail "Use _hexdump(), please!"
>  }
>
> +_require_change_attr ()
> +{
> +
> +       _mask=$($XFS_IO_PROG -f -c "statx -m 0x2000 -r" $TEST_DIR/change_attr_test.$$ \
> +               | grep "^stat.mask" | cut -d' ' -f 3)
> +       rm -f $TEST_DIR/change_attr_test.$$
> +       if [ $(( ${_mask}&0x2000 )) -eq 0 ]; then
> +               _notrun "$FSTYP does not support inode change attribute"
> +       fi
> +}
> +
> +_get_change_attr ()
> +{
> +       $XFS_IO_PROG -r -c "statx -m 0x2000 -r" $1 | grep '^stat.change_attr' | \
> +               cut -d' ' -f3
> +}
> +
>  init_rc
>
>  ################################################################################
> diff --git a/tests/generic/693 b/tests/generic/693
> new file mode 100755
> index 000000000000..fa92931d2ac8
> --- /dev/null
> +++ b/tests/generic/693
> @@ -0,0 +1,138 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021, Jeff Layton <jlayton@redhat.com>
> +#
> +# FS QA Test No. 693
> +#
> +# Test the behavior of the inode change attribute
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_change_attr
> +
> +# from the stat.h header file
> +UTIME_OMIT=1073741822
> +
> +testdir="$TEST_DIR/test_iversion_dir.$$"
> +testfile="$testdir/test_iversion_file.$$"
> +
> +mkdir $testdir
> +
> +# DIRECTORY TESTS
> +#################
> +# Does dir change attr change on a create?
> +old=$(_get_change_attr $testdir)
> +touch $testfile
> +new=$(_get_change_attr $testdir)
> +if [ $old = $new ]; then
> +       _fail "Change attr of dir did not change after create!"
> +fi
> +
> +# on a hardlink?
> +old=$new
> +ln $testfile $testdir/linky

We may need to clean up these temporary testing files.

Other parts look good to me.

Regards~

> +new=$(_get_change_attr $testdir)
> +if [ $old = $new ]; then
> +       _fail "Change attr of dir did not change after hardlink!"
> +fi
> +
> +# on an unlink?
> +old=$new
> +rm -f $testfile
> +new=$(_get_change_attr $testdir)
> +if [ $old = $new ]; then
> +       _fail "Change attr of dir did not change after unlink!"
> +fi
> +
> +# on a rename (within same dir)
> +old=$new
> +mv $testdir/linky $testfile
> +new=$(_get_change_attr $testdir)
> +if [ $old = $new ]; then
> +       _fail "Change attr of dir did not change after rename!"
> +fi
> +
> +# on a mknod
> +old=$new
> +mknod $testdir/pipe p
> +new=$(_get_change_attr $testdir)
> +if [ $old = $new ]; then
> +       _fail "Change attr of dir did not change after mknod!"
> +fi
> +
> +
> +# REGULAR FILE TESTS
> +####################
> +# ensure change_attr changes after a write
> +old=$(_get_change_attr $testfile)
> +$XFS_IO_PROG -c "pwrite -W -q 0 32" $testfile
> +new=$(_get_change_attr $testfile)
> +if [ $old = $new ]; then
> +       _fail "Change attr did not change after write!"
> +fi
> +
> +# ensure it doesn't change after a sync
> +old=$new
> +sync
> +new=$(_get_change_attr $testfile)
> +if [ $old != $new ]; then
> +       _fail "Change attr changed after sync!"
> +fi
> +
> +# ensure change_attr does not change after read
> +old=$new
> +cat $testfile > /dev/null
> +new=$(_get_change_attr $testfile)
> +if [ $old != $new ]; then
> +       _fail "Change attr changed after read!"
> +fi
> +
> +# ensure it changes after truncate
> +old=$new
> +truncate --size 0 $testfile
> +new=$(_get_change_attr $testfile)
> +if [ $old = $new ]; then
> +       _fail "Change attr did not change after truncate!"
> +fi
> +
> +# ensure it changes after only atime update
> +old=$new
> +$XFS_IO_PROG -c "utimes 1 1 $UTIME_OMIT $UTIME_OMIT" $testfile
> +new=$(_get_change_attr $testfile)
> +if [ $old = $new ]; then
> +       _fail "Change attr did not change after atime update!"
> +fi
> +
> +# ensure it changes after utimes atime/mtime update
> +old=$new
> +$XFS_IO_PROG -c "utimes 1 1 1 1" $testfile
> +new=$(_get_change_attr $testfile)
> +if [ $old = $new ]; then
> +       _fail "Change attr did not change after mtime update!"
> +fi
> +
> +# after setting xattr
> +old=$new
> +setfattr -n user.foo -v bar $testfile
> +new=$(_get_change_attr $testfile)
> +if [ $old = $new ]; then
> +       _fail "Change attr did not change after setxattr!"
> +fi
> +
> +# after removing xattr
> +old=$new
> +setfattr -x user.foo $testfile
> +new=$(_get_change_attr $testfile)
> +if [ $old = $new ]; then
> +       _fail "Change attr did not change after rmxattr!"
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/693.out b/tests/generic/693.out
> new file mode 100644
> index 000000000000..89ad553d911c
> --- /dev/null
> +++ b/tests/generic/693.out
> @@ -0,0 +1 @@
> +QA output created by 693
> --
> 2.37.2
>
