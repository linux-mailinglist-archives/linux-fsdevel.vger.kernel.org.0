Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97D27A146
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Sep 2020 15:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgI0Nsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Sep 2020 09:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgI0Nsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Sep 2020 09:48:51 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ABFC0613CE;
        Sun, 27 Sep 2020 06:48:51 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x69so8482083oia.8;
        Sun, 27 Sep 2020 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=KfGP6KxBrJsaHNsj9qV9Idxwe/PAV3lU5maxdt+TBPs=;
        b=VHr/W8FjEwgd2PPqSyitcSpv/sgqSJpg/CkXBF5SbKSrBW9BvSzYSg1x8qVfr2YVi1
         Nli89lgugSNpS1Oub6YhGrm72loZIPReZcvdBgatZADjNoHWyVKozF6kO550Q0rIbL4f
         JcY60vz7xbsRupb3P3oVcRNNFzFnTdOIXhlJIQa7liBq/js1vK7X/njUKx2IWstLR3Cp
         Qib0fIpnPrmLU4SltE2mepQKr1v/3bN9qy0H4qqWupe4G2DEC7ZTJsMG58P+bGr4Kmj/
         MYGaLFgWnZ3cEIbJjpMsy/LKzMWu8kXfZSIZ2wjOOl6Zwq/tbnFquH//g/N1GCoWLcOv
         HDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=KfGP6KxBrJsaHNsj9qV9Idxwe/PAV3lU5maxdt+TBPs=;
        b=mc2344NwiMqczQcozJCNxynat/vJVtZd2HnlGHJ9kfzR2KJIliu//6SZvS7MXEbRYk
         u1hsayZultHBTmXxzecTxIT2uB09e8Nr8CtqvNqwvbLVzu7ymDklk6A/bxwtbYXM983P
         RlJkrlDTF44incrbC8cDHHdfOVmmsLxsnVK3g0h4q/62/22u60yQ+qABwb3aNnItixJF
         jEJiJxXaqeO8Db4pjeTcyVIJM3c5uXk5JNUPEgqRq+cQSkX/1f6Bpb1R9gD7bg2q4j/C
         HwCKf0HP+u+0RtLcejXFAyVehR+GxOoD9VZGdJuOUh8zhfJduiop8Y1FbGvFboIrzUbP
         cO/Q==
X-Gm-Message-State: AOAM531Up/FxeyuuxTN2bZEYzjzIOy1YHEJ/5iptUBJ5Z3U+l4esRDrJ
        vcEltVc3i7URxwywgX6lAzYGLfzhJkgDXcroK84=
X-Google-Smtp-Source: ABdhPJzdGwwZNIF5FqArlEGVaz9efr4rjO3ndrU2yBFemnQiYnOETORc525LEkHjCD3cbVM/fZxtYoDy/wsq/we44Dk=
X-Received: by 2002:aca:ec50:: with SMTP id k77mr3595278oih.35.1601214531160;
 Sun, 27 Sep 2020 06:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org> <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org> <CA+icZUWcx5hBjU35tfY=7KXin7cA5AAY8AMKx-pjYnLCsQywGw@mail.gmail.com>
 <CA+icZUWMs5Xz5vMP370uUBCqzgjq6Aqpy+krZMNg-5JRLxaALA@mail.gmail.com>
 <20200925134608.GE32101@casper.infradead.org> <CA+icZUV9tNMbTC+=MoKp3rGmhDeO9ScW7HC+WUTCCvSMpih7DA@mail.gmail.com>
 <20200925155340.GG32101@casper.infradead.org> <CA+icZUWmF_7P7r-qmxzR7oz36u_Wy5HA6fh5zFFZd1D-aZiwkQ@mail.gmail.com>
 <20200927120435.GC7714@casper.infradead.org>
In-Reply-To: <20200927120435.GC7714@casper.infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 27 Sep 2020 15:48:39 +0200
Message-ID: <CA+icZUWSHf9YbkuEYeG4azSrPt=GYu-MmHxj3+uGvxPW-HHjjQ@mail.gmail.com>
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

On Sun, Sep 27, 2020 at 2:04 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Sep 27, 2020 at 01:31:15PM +0200, Sedat Dilek wrote:
> > > I would suggest that you try applying just the assertion to Linus'
> > > kernel, then try to make it fire.  Then apply the fix and see if you
> > > can still make the assertion fire.
> > >
> > > FWIW, I got it to fire with generic/095 from the xfstests test suite.
> >
> > With...
> >
> > Linux v5.9-rc6+ up to commit a1bf fa48 745a ("Merge tag 'scsi-fixes'
> > of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi")
> > ...and...
> >
> >  xfstests-dev up to commit 75bd80f900ea ("src/t_mmap_dio: do not build
> > if !HAVE_AIO")
> >
> > ...I have seen in my first run of...
> >
> > [ generic/095 ]
> >
> > dileks@iniza:~/src/xfstests-dev/git$ sudo ./check generic/095
> > FSTYP         -- ext4
>
> There's the first problem in your setup; you need to be checking XFS
> to see this problem.  ext4 doesn't use iomap for buffered IO yet.
>
> > PLATFORM      -- Linux/x86_64 iniza 5.9.0-rc6-7-amd64-clang-cfi
> > #7~bullseye+dileks1 SMP 2020-
> > 09-27
> > MKFS_OPTIONS  -- /dev/sdb1
>
> I'm using "-m reflink=1,rmapbt=1 -i sparse=1 -b size=1024"
>

Sorry, for being pedantic...

With your patch and assertion diff I hit the same issue like with Ext4-FS...

[So Sep 27 15:40:18 2020] run fstests generic/095 at 2020-09-27 15:40:19
[So Sep 27 15:40:26 2020] XFS (sdb1): Mounting V5 Filesystem
[So Sep 27 15:40:26 2020] XFS (sdb1): Ending clean mount
[So Sep 27 15:40:26 2020] xfs filesystem being mounted at /mnt/scratch
supports timestamps until 2038 (0x7fffffff)
[So Sep 27 15:40:28 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[So Sep 27 15:40:28 2020] File: /mnt/scratch/file1 PID: 12 Comm: kworker/0:1
[So Sep 27 15:40:29 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[So Sep 27 15:40:29 2020] File: /mnt/scratch/file1 PID: 73 Comm: kworker/0:2
[So Sep 27 15:40:30 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[So Sep 27 15:40:30 2020] File: /mnt/scratch/file2 PID: 12 Comm: kworker/0:1
[So Sep 27 15:40:30 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[So Sep 27 15:40:30 2020] File: /mnt/scratch/file2 PID: 3271 Comm: fio
[So Sep 27 15:40:30 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[So Sep 27 15:40:30 2020] File: /mnt/scratch/file2 PID: 3273 Comm: fio
[So Sep 27 15:40:31 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[So Sep 27 15:40:31 2020] File: /mnt/scratch/file1 PID: 3308 Comm: fio
[So Sep 27 15:40:36 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[So Sep 27 15:40:36 2020] File: /mnt/scratch/file1 PID: 73 Comm: kworker/0:2
[So Sep 27 15:40:43 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[So Sep 27 15:40:43 2020] File: /mnt/scratch/file1 PID: 73 Comm: kworker/0:2
[So Sep 27 15:40:52 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[So Sep 27 15:40:52 2020] File: /mnt/scratch/file2 PID: 73 Comm: kworker/0:2
[So Sep 27 15:40:56 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[So Sep 27 15:40:56 2020] File: /mnt/scratch/file2 PID: 12 Comm: kworker/0:1

Is that a different issue?

- Sedat -

P.S.: Current git diff

dileks@iniza:~/src/linux-kernel/git$ git diff
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..b421e4efc4bd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -53,7 +53,10 @@ iomap_page_create(struct inode *inode, struct page *page)
       atomic_set(&iop->read_count, 0);
       atomic_set(&iop->write_count, 0);
       spin_lock_init(&iop->uptodate_lock);
-       bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+       if (PageUptodate(page))
+               bitmap_fill(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
+       else
+               bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);

       /*
        * migrate_page_move_mapping() assumes that pages with private data have
@@ -67,11 +70,15 @@ static void
iomap_page_release(struct page *page)
{
       struct iomap_page *iop = detach_page_private(page);
+       unsigned int nr_blocks = PAGE_SIZE / i_blocksize(page->mapping->host);

       if (!iop)
               return;
       WARN_ON_ONCE(atomic_read(&iop->read_count));
       WARN_ON_ONCE(atomic_read(&iop->write_count));
+       WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
+                       PageUptodate(page));
+
       kfree(iop);
}

- EOT -
