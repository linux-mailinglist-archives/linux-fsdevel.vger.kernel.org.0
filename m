Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D05064FED4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Dec 2022 13:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiLRMLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 07:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRMLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 07:11:16 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8F256;
        Sun, 18 Dec 2022 04:11:14 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id x65so3163408vkg.11;
        Sun, 18 Dec 2022 04:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=viWO3XQB/E23SP757AtwZ+2d2JLNvUvh+0hIbPgzY4k=;
        b=ZSMXyetp+cH6f2MQD4sWohfXxP5BS2HfMW9QMtfhv8cPEsggZkD7ug+f7JHN1a4pyW
         6hG31qoYmM8k7DH7Pf+kwcwLcKi81s4dbyHW00hgdYjBmvYb1QhhcByzqBh1+Er2ID1M
         VTgeoPsvBUXVkxgB3c9CXxp+mXMzTb5iEDgy9dyX6D0mkr5EZTwPPbuQbwB5oj0mpYI5
         Ax8EYWNbUi2tsU84r2b7zGhOIpVRibpNI1b6H5aOMdWNvHGxwD2wlF3R9PGvqOZ8UAak
         Wjl5a50WsOhInqbmVpawEPhOqoNF5WPabJJeZ82VmSIQpO1PR9wAbE5GMg1tei75YPYj
         mcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=viWO3XQB/E23SP757AtwZ+2d2JLNvUvh+0hIbPgzY4k=;
        b=zCXCJ8BQko4XsQjO3ZwxpW/3GneJhWlHez+BNs3eChq8enhwJq0vKghTUNwbSKjNGU
         QqduWBV7fXflgMtwK2rGs9fj9qI18Chra2sLefrofRmu8ldT+f9rjI7Jlmm8nVxC7JNE
         qK+dmeQSfo1iYQmlx9B/UPpZALMS/SERJLuy6AnELXGsKtSqcP/vNUpQlO8jNX+ECZIE
         zkZyweMsd+LVC+FeSxbEMXUIIxJKxbuCz+tHIhRYPueaeSHbcuHTmiaq8AKe3H9ag8VM
         iJ1Qxd9BooyUhM/9zVbuEZRft6UZCYoiIamtvtLb43dU8jerwBwsIbDqdp0vxfNoDHuK
         /yeQ==
X-Gm-Message-State: ANoB5pnilUO+8EPAYNnEjqiR+/tyGtpsP0vXGtp3qlLq/xPasaBuGwWM
        cs+WlwaFq92FncYqAY6Sdy5CDBrbxB1quATrxPyJl8ubWJE=
X-Google-Smtp-Source: AA0mqf7odwO0SRwN58aAm+UW0uOC3iwlWsozKfCVAv8PSJZXTq2zAwPFHeFNP/Y4H718KTPThCCbgxRtVBHoV5rF2sY=
X-Received: by 2002:a1f:9f8b:0:b0:3be:18d7:65a3 with SMTP id
 i133-20020a1f9f8b000000b003be18d765a3mr4114962vke.36.1671365473112; Sun, 18
 Dec 2022 04:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20221218103850.cbqdq3bmw7zl7iad@zlang-mailbox>
In-Reply-To: <20221218103850.cbqdq3bmw7zl7iad@zlang-mailbox>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 18 Dec 2022 14:11:01 +0200
Message-ID: <CAOQ4uxhmCgyorYVtD6=n=khqwUc=MPbZs+y=sqt09XbGoNm_tA@mail.gmail.com>
Subject: Re: Why fstests g/673 and g/683~687 suddently fail (on xfs, ext4...)
 on latest linux v6.1+ ?
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 18, 2022 at 1:06 PM Zorro Lang <zlang@redhat.com> wrote:
>
> Hi,
>
> fstests generic/673 and generic/683~687 are a series of test cases to
> verify suid and sgid bits are dropped properly. xfs-list writes these
> cases to verify xfs behavior follows vfs, e.g. [1]. And these cases
> test passed on xfs and ext4 for long time. Even on my last regression
> test on linux v6.1-rc8+, they were passed too.
>
> But now the default behavior looks like be changed again, xfs and ext4
> start to fail [2] on latest linux v6.1+ (HEAD [0]), So there must be
> changed. I'd like to make sure what's changed, and if it's expected?

I think that is expected and I assume Christian was planning to fix the tests.

See Christian's pull request:
https://lore.kernel.org/linux-fsdevel/20221212112053.99208-1-brauner@kernel.org/

"Note, that some xfstests will now fail as these patches will cause the setgid
bit to be lost in certain conditions for unprivileged users modifying a setgid
file when they would've been kept otherwise. I think this risk is worth taking
and I explained and mentioned this multiple times on the list:
https://lore.kernel.org/linux-fsdevel/20221122142010.zchf2jz2oymx55qi@wittgenstein"

Thanks,
Amir.

>
> Thanks,
> Zorro
>
> [0]
> commit f9ff5644bcc04221bae56f922122f2b7f5d24d62
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sat Dec 17 08:55:19 2022 -0600
>
>     Merge tag 'hsi-for-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-h
>
> [1]
> commit e014f37db1a2d109afa750042ac4d69cf3e3d88e
> Author: Darrick J. Wong <djwong@kernel.org>
> Date:   Tue Mar 8 10:51:16 2022 -0800
>
>     xfs: use setattr_copy to set vfs inode attributes
>
> [2]
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/s390x ibm-z-510 6.1.0+ #1 SMP Sat Dec 17 13:23:59 EST 2022
> MKFS_OPTIONS  -- -f -m crc=1,finobt=1,reflink=1,rmapbt=0,bigtime=1,inobtcount=1 -b size=1024 /dev/loop1
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR
>
> generic/673       - output mismatch (see /var/lib/xfstests/results//generic/673.out.bad)
>     --- tests/generic/673.out   2022-12-17 13:57:40.336589178 -0500
>     +++ /var/lib/xfstests/results//generic/673.out.bad  2022-12-18 00:00:53.627210256 -0500
>     @@ -51,7 +51,7 @@
>      310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
>      2666 -rw-rwSrw- SCRATCH_MNT/a
>      3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
>     -2666 -rw-rwSrw- SCRATCH_MNT/a
>     +666 -rw-rw-rw- SCRATCH_MNT/a
>
>      Test 10 - qa_user, group-exec file, only sgid
>     ...
>     (Run 'diff -u /var/lib/xfstests/tests/generic/673.out /var/lib/xfstests/results//generic/673.out.bad'  to see the entire diff)
> Ran: generic/673
> Failures: generic/673
> Failed 1 of 1 tests
>
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/s390x ibm-z-510 6.1.0+ #1 SMP Sat Dec 17 13:23:59 EST 2022
> MKFS_OPTIONS  -- -f -m crc=1,finobt=1,reflink=1,rmapbt=0,bigtime=1,inobtcount=1 -b size=1024 /dev/loop1
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR
>
> generic/683       - output mismatch (see /var/lib/xfstests/results//generic/683.out.bad)
>     --- tests/generic/683.out   2022-12-17 13:57:40.696589178 -0500
>     +++ /var/lib/xfstests/results//generic/683.out.bad  2022-12-18 00:04:55.297220255 -0500
>     @@ -33,7 +33,7 @@
>
>      Test 9 - qa_user, non-exec file falloc, only sgid
>      2666 -rw-rwSrw- TEST_DIR/683/a
>     -2666 -rw-rwSrw- TEST_DIR/683/a
>     +666 -rw-rw-rw- TEST_DIR/683/a
>
>      Test 10 - qa_user, group-exec file falloc, only sgid
>     ...
>     (Run 'diff -u /var/lib/xfstests/tests/generic/683.out /var/lib/xfstests/results//generic/683.out.bad'  to see the entire diff)
> Ran: generic/683
> Failures: generic/683
> Failed 1 of 1 tests
>
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/s390x ibm-z-510 6.1.0+ #1 SMP Sat Dec 17 13:23:59 EST 2022
> MKFS_OPTIONS  -- -f -m crc=1,finobt=1,reflink=1,rmapbt=0,bigtime=1,inobtcount=1 -b size=1024 /dev/loop1
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR
>
> generic/684       - output mismatch (see /var/lib/xfstests/results//generic/684.out.bad)
>     --- tests/generic/684.out   2022-12-17 13:57:40.766589178 -0500
>     +++ /var/lib/xfstests/results//generic/684.out.bad  2022-12-18 00:05:27.597220255 -0500
>     @@ -33,7 +33,7 @@
>
>      Test 9 - qa_user, non-exec file fpunch, only sgid
>      2666 -rw-rwSrw- TEST_DIR/684/a
>     -2666 -rw-rwSrw- TEST_DIR/684/a
>     +666 -rw-rw-rw- TEST_DIR/684/a
>
>      Test 10 - qa_user, group-exec file fpunch, only sgid
>     ...
>     (Run 'diff -u /var/lib/xfstests/tests/generic/684.out /var/lib/xfstests/results//generic/684.out.bad'  to see the entire diff)
> Ran: generic/684
> Failures: generic/684
> Failed 1 of 1 tests
> ....
> ....
>
>
> Thanks,
> Zorro
>
