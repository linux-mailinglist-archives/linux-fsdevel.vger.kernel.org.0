Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6711D27A09D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Sep 2020 13:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgI0Lb3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Sep 2020 07:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgI0Lb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Sep 2020 07:31:28 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E5FC0613CE;
        Sun, 27 Sep 2020 04:31:28 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id t3so1891012ook.8;
        Sun, 27 Sep 2020 04:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=EvNYJ68tDLRwoC65KusTy0iig3L17Xrs7ri6XgMlgQY=;
        b=WdCZY6lnpjJIuupcKdSYDk3IKOeD3IqAyXNu5TzRg8rc9f16XwGQq9HZQeUZOgQpqF
         g4R59pXxkNnkaJ/KtLgr3eFDpNdIOK3cTtVNTuqq/L56YJ6JMOq3q63rj+SFmmbIckMh
         XH4EbU8+jpGs/K64bSmIk19ROTb4SOniDf836Ri2N5xl64ou+s38RnODpNeFPqTZ07p6
         ca3QOBpExz71HKwuMvg0lyYpB91Ojwn/al5rBX52ypWSUhTzjS4HXQIlbz7jWwbLE4r8
         RFYRlOBVkB5abJTjOR7+TfPnDs9QYsCSjyypQdX3zLsuqPrzv6PUJEJs97IQfHKUhbUz
         eX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=EvNYJ68tDLRwoC65KusTy0iig3L17Xrs7ri6XgMlgQY=;
        b=AobqqPIbPDPAtGdLwtuQnytCQvBwvBW2TPbZrZ/se4nkjR2hqBqaOMGNovkgSc6oE4
         et4kdUl2o0QC7HLYSUlvjm65lbc2iuee9FPbiA9KbvkqL3eliglfSsMwlhbLC96mdaiN
         0d38ovX3VEtkoSxsba0UyzIxC21hQl6vjCmbdXV19cqWTmgm/odMfN8Hssm3NX7AyekJ
         3v66dSBXPRt1T4ditwzqEZL2NCxGaDRDwHDFyNntM6vOxwxS3KmKMniGHWGKJr8M7UFA
         skDHy4+0JFv/m+7KTj9bnlBYX88r23U4yTqQaSstHfib9AahoSDWkv5e9Dse4lRJBpMS
         TZ4Q==
X-Gm-Message-State: AOAM533vSgs6SucP1MPVrzLi9afk7RM18NlRTEOomGD0AubssRvLV5FO
        I3lfHPk62gSJSKCcvvctOEP2nKp99QlgIJ1QLjw=
X-Google-Smtp-Source: ABdhPJzV+Mf7vpgligjwcFTSmK53v/F8zJ6OVuaDz0kQmB8PyqfX2HhMV8FZuWiWeH9ruFGBLrFRV2Gtx3fZ0XuOq9s=
X-Received: by 2002:a4a:2c02:: with SMTP id o2mr6360089ooo.24.1601206286897;
 Sun, 27 Sep 2020 04:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
 <f623da731d7c2e96e3a37b091d0ec99095a6386b.camel@redhat.com>
 <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org> <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org> <CA+icZUWcx5hBjU35tfY=7KXin7cA5AAY8AMKx-pjYnLCsQywGw@mail.gmail.com>
 <CA+icZUWMs5Xz5vMP370uUBCqzgjq6Aqpy+krZMNg-5JRLxaALA@mail.gmail.com>
 <20200925134608.GE32101@casper.infradead.org> <CA+icZUV9tNMbTC+=MoKp3rGmhDeO9ScW7HC+WUTCCvSMpih7DA@mail.gmail.com>
 <20200925155340.GG32101@casper.infradead.org>
In-Reply-To: <20200925155340.GG32101@casper.infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 27 Sep 2020 13:31:15 +0200
Message-ID: <CA+icZUWmF_7P7r-qmxzR7oz36u_Wy5HA6fh5zFFZd1D-aZiwkQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 25, 2020 at 5:53 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Sep 25, 2020 at 04:01:02PM +0200, Sedat Dilek wrote:
> > On Fri, Sep 25, 2020 at 3:46 PM Matthew Wilcox <willy@infradead.org> wrote:

[...]

> > How does the assertion look like in the logs?
> > You have an example.
>
> I happen to have one from my testing last night:
>
> 0006 ------------[ cut here ]------------
> 0006 WARNING: CPU: 5 PID: 1417 at fs/iomap/buffered-io.c:80 iomap_page_release+0xb1/0xc0
> 0006 bam!
> 0006 Modules linked in:
> 0006 CPU: 5 PID: 1417 Comm: fio Kdump: loaded Not tainted 5.8.0-00001-g51f85a97ccdd-dirty #54
> 0006 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1 04/01/2014
> 0006 RIP: 0010:iomap_page_release+0xb1/0xc0
> 0006 Code: 45 d9 48 8b 03 48 c1 e8 02 83 e0 01 75 13 38 d0 75 18 4c 89 ef e8 1f 6a f8 ff 5b 41 5c 41 5d 5d c3 eb eb e8 e1 07 f4 ff eb 8c <0f> 0b eb e4 0f 0b eb a8 0f 0b eb ac 0f 1f 00 55 48 89 e5 41 56 41
> 0006 RSP: 0018:ffffc90001ed3a40 EFLAGS: 00010202
> 0006 RAX: 0000000000000001 RBX: ffffea0001458ec0 RCX: ffffffff81cf75a7
> 0006 RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880727d1f90
> 0006 RBP: ffffc90001ed3a58 R08: 0000000000000000 R09: ffff888051ddd6e8
> 0006 R10: 0000000000000005 R11: 0000000000000230 R12: 0000000000000004
> 0006 R13: ffff8880727d1f80 R14: 0000000000000005 R15: ffffea0001458ec0
> 0006 FS:  00007fe4bdd9df00(0000) GS:ffff88807f540000(0000) knlGS:0000000000000000
> 0006 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 0006 CR2: 00007fe4bdd50000 CR3: 000000006f7e6005 CR4: 0000000000360ea0
> 0006 Call Trace:
> 0006  iomap_releasepage+0x58/0xc0
> 0006  try_to_release_page+0x4b/0x60
> 0006  invalidate_inode_pages2_range+0x38b/0x3f0
>
> I would suggest that you try applying just the assertion to Linus'
> kernel, then try to make it fire.  Then apply the fix and see if you
> can still make the assertion fire.
>
> FWIW, I got it to fire with generic/095 from the xfstests test suite.

With...

Linux v5.9-rc6+ up to commit a1bf fa48 745a ("Merge tag 'scsi-fixes'
of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi")
...and...

 xfstests-dev up to commit 75bd80f900ea ("src/t_mmap_dio: do not build
if !HAVE_AIO")

...I have seen in my first run of...

[ generic/095 ]

dileks@iniza:~/src/xfstests-dev/git$ sudo ./check generic/095
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 iniza 5.9.0-rc6-7-amd64-clang-cfi
#7~bullseye+dileks1 SMP 2020-
09-27
MKFS_OPTIONS  -- /dev/sdb1
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb1 /mnt/scratch

generic/095      24s
Ran: generic/095
Passed all 1 tests

[ LC_ALL=C dmesg -T ]

[Sun Sep 27 13:05:17 2020] run fstests generic/095 at 2020-09-27 13:05:17
[Sun Sep 27 13:05:28 2020] EXT4-fs (sdb1): mounted filesystem with
ordered data mode. Opts: acl,user_xattr
[Sun Sep 27 13:05:29 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[Sun Sep 27 13:05:29 2020] File: /mnt/scratch/file1 PID: 21389 Comm: kworker/3:1
[Sun Sep 27 13:05:29 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[Sun Sep 27 13:05:29 2020] File: /mnt/scratch/file2 PID: 21389 Comm: kworker/3:1
[Sun Sep 27 13:05:29 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[Sun Sep 27 13:05:29 2020] File: /mnt/scratch/file1 PID: 22228 Comm: kworker/3:2
[Sun Sep 27 13:05:29 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[Sun Sep 27 13:05:29 2020] File: /mnt/scratch/file1 PID: 22228 Comm: kworker/3:2
[Sun Sep 27 13:05:29 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[Sun Sep 27 13:05:29 2020] File: /mnt/scratch/file1 PID: 22578 Comm: kworker/3:3
[Sun Sep 27 13:05:29 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[Sun Sep 27 13:05:29 2020] File: /mnt/scratch/file1 PID: 22579 Comm: kworker/3:4
[Sun Sep 27 13:05:29 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[Sun Sep 27 13:05:29 2020] File: /mnt/scratch/file1 PID: 21389 Comm: kworker/3:1
[Sun Sep 27 13:05:29 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[Sun Sep 27 13:05:29 2020] File: /mnt/scratch/file1 PID: 22578 Comm: kworker/3:3
[Sun Sep 27 13:05:29 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[Sun Sep 27 13:05:29 2020] File: /mnt/scratch/file1 PID: 22558 Comm: fio
[Sun Sep 27 13:05:29 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[Sun Sep 27 13:05:29 2020] File: /mnt/scratch/file1 PID: 22527 Comm: fio

In the next 5 runs I have not seen similar in my logs.

- Sedat -

P.S.: My local.config

# Ideally define at least these 4 to match your environment
# The first 2 are required.
# See README for other variables which can be set.
#
# Note: SCRATCH_DEV >will< get overwritten!

export TEST_DEV=/dev/sdc5
export TEST_DIR=/mnt/test
export SCRATCH_DEV=/dev/sdb1
export SCRATCH_MNT=/mnt/scratch

- EOT -
