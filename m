Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35EE3054F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 08:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhA0HsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 02:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbhA0Hp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:45:57 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7221C0613D6;
        Tue, 26 Jan 2021 23:45:16 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n25so1034018pgb.0;
        Tue, 26 Jan 2021 23:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTfYbJAap7yGynm8d/+sMaK1UOCcnfG0vCnXAvPBlz0=;
        b=sxAhR0Mk9LXCRMlMt8zcK3dONFgs2i0d+G/LaVHVWx3PrurCM+WtEY8d+6/51tiy7r
         NBh5Htci+KqjP1Zo+aIesW1nUnoUOjgUaDr7Tax/Aag3C+acfrmxPsb07tHcHdSMgZe7
         sam8tbDKGQbGN2Nvv0k6wju9GMPstmRAjpTwWI65iG+7W26ZkajObhoNscblHdnLPR5d
         0YUolJtkSG91GYIoGR/pj7UeajirGmn5t1MZCMPhO/db8QdiZp5uDoQPqcV3JnIH1vi6
         s2AS5mwX0ggCI7U8BQvOe8RQTVKNJ68rLJ7TeE5s+YM/93UoYbSZqSUNEa8jKj9Lgsmf
         Ok9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTfYbJAap7yGynm8d/+sMaK1UOCcnfG0vCnXAvPBlz0=;
        b=ZAQ3N3qwYmYD1y2w+lzD5k1XdindTRTmo0e3Q25sUzEFCU8HDgNsdjmytTYH7hBHXq
         dhIyQnsYiRpgAUOeIzhEiSAaxON9m9612cxcK1QlZrqhoZ+BwyQ8i6QjxJVLMiuVuhId
         U/EJQstrdXUijKU4PDBh19AWMXzif48tPVO88fVveNfl4D1S9jM8QLMi+95jefofKsdF
         +l19O0hbT57R10bbYWetHo/8uwDwSHhm1r1gmEJkaiZ4X/09dbJD8+c2a/zQaTq+3CPJ
         5quj+ZVn2hlI3etKTqXuTJe0Xo0l44SaFI8QAlcAwG4WaB5YpdRVc4muTVjs347GAjfV
         8yDg==
X-Gm-Message-State: AOAM530FbKDCivyMW+biTprQlE2jtp7mTVD5KS2xhoLubskCm6/P2Nrh
        8a5aKrDZjuSa2OLs+VHV2xOIOIE4SpHvLor4vY4=
X-Google-Smtp-Source: ABdhPJzOz9cyhS3OPBYhiCs+26hRU+EmgHfFR87lQhmweB0bdIjQgBfMkjgL5cmIfvI8MFGV15W+00ap3eIC0FYCniI=
X-Received: by 2002:a63:656:: with SMTP id 83mr9969603pgg.222.1611733516481;
 Tue, 26 Jan 2021 23:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20210126195907.2273494-1-maxtram95@gmail.com> <d3effbdc-12c2-c6aa-98ba-7bde006fc4e1@acm.org>
In-Reply-To: <d3effbdc-12c2-c6aa-98ba-7bde006fc4e1@acm.org>
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
Date:   Wed, 27 Jan 2021 09:44:50 +0200
Message-ID: <CAKErNvpCdTvg-Bx-U+k3jYiazoz-Pr0LwruaSh+LszH9yP5c8A@mail.gmail.com>
Subject: Re: [PATCH] Revert "block: simplify set_init_blocksize" to regain
 lost performance
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 6:23 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 1/26/21 11:59 AM, Maxim Mikityanskiy wrote:
> > The cited commit introduced a serious regression with SATA write speed,
> > as found by bisecting. This patch reverts this commit, which restores
> > write speed back to the values observed before this commit.
> >
> > The performance tests were done on a Helios4 NAS (2nd batch) with 4 HDDs
> > (WD8003FFBX) using dd (bs=1M count=2000). "Direct" is a test with a
> > single HDD, the rest are different RAID levels built over the first
> > partitions of 4 HDDs. Test results are in MB/s, R is read, W is write.
> >
> >                 | Direct | RAID0 | RAID10 f2 | RAID10 n2 | RAID6
> > ----------------+--------+-------+-----------+-----------+--------
> > 9011495c9466    | R:256  | R:313 | R:276     | R:313     | R:323
> > (before faulty) | W:254  | W:253 | W:195     | W:204     | W:117
> > ----------------+--------+-------+-----------+-----------+--------
> > 5ff9f19231a0    | R:257  | R:398 | R:312     | R:344     | R:391
> > (faulty commit) | W:154  | W:122 | W:67.7    | W:66.6    | W:67.2
> > ----------------+--------+-------+-----------+-----------+--------
> > 5.10.10         | R:256  | R:401 | R:312     | R:356     | R:375
> > unpatched       | W:149  | W:123 | W:64      | W:64.1    | W:61.5
> > ----------------+--------+-------+-----------+-----------+--------
> > 5.10.10         | R:255  | R:396 | R:312     | R:340     | R:393
> > patched         | W:247  | W:274 | W:220     | W:225     | W:121
> >
> > Applying this patch doesn't hurt read performance, while improves the
> > write speed by 1.5x - 3.5x (more impact on RAID tests). The write speed
> > is restored back to the state before the faulty commit, and even a bit
> > higher in RAID tests (which aren't HDD-bound on this device) - that is
> > likely related to other optimizations done between the faulty commit and
> > 5.10.10 which also improved the read speed.
> >
> > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> > Fixes: 5ff9f19231a0 ("block: simplify set_init_blocksize")
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > ---
> >  fs/block_dev.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index 3b8963e228a1..235b5042672e 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -130,7 +130,15 @@ EXPORT_SYMBOL(truncate_bdev_range);
> >
> >  static void set_init_blocksize(struct block_device *bdev)
> >  {
> > -     bdev->bd_inode->i_blkbits = blksize_bits(bdev_logical_block_size(bdev));
> > +     unsigned int bsize = bdev_logical_block_size(bdev);
> > +     loff_t size = i_size_read(bdev->bd_inode);
> > +
> > +     while (bsize < PAGE_SIZE) {
> > +             if (size & bsize)
> > +                     break;
> > +             bsize <<= 1;
> > +     }
> > +     bdev->bd_inode->i_blkbits = blksize_bits(bsize);
> >  }
> >
> >  int set_blocksize(struct block_device *bdev, int size)
>
> How can this patch affect write speed? I haven't found any calls of
> set_init_blocksize() in the I/O path. Did I perhaps overlook something?

I don't know the exact mechanism how this change affects the speed,
I'm not an expert in the block device subsystem (I'm a networking
guy). This commit was found by git bisect, and my performance test
confirmed that reverting it fixes the bug.

It looks to me as this function sets the block size as part of control
flow, and this size is used later in the fast path, and the commit
that removed the loop decreased this block size.

> Bart.
>
>
