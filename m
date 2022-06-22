Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BBC554846
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 14:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355647AbiFVJAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 05:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355615AbiFVJAu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:00:50 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4382377E3;
        Wed, 22 Jun 2022 02:00:48 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id b4so4493159vkh.6;
        Wed, 22 Jun 2022 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wSGvewaTv5VVWLyqq6hpkmctKFHc04hrUq8r4Ufn1w=;
        b=lle8Qd/vhocRAJ4hHjHeBP7hZr0Z3ziRebNJ5aIOygnmYODud8eWo4h0ZnHfJi/BF0
         ZnY4Ikt5MPeAd5kY6NyU9cEKtvsH0U7IbHOA3RU2EFC36EhkklIWIFkkCNLndtSWVxHU
         V17YQVqzjE07ZOZ2ET80gMaj1ozDx2fAflzkDpK/6cy/TWNmNgJIqWo6eo11OoU2Y1te
         XqmeQT/74xlUSzXBjindfUYay3F3WhOTay4wGiN74fv+s/o6267zgLFqK86O6lS2dUp9
         +Ci9Pl0nso2mwSKhn4Nia+2rqFNc8TGFO2d2EK4vH6q5zc1I4ZAJ/VitaeunZSjvbZs7
         y3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wSGvewaTv5VVWLyqq6hpkmctKFHc04hrUq8r4Ufn1w=;
        b=sQTOB0L/8FOZspte3LzX+nF92BowFCn72Bw+O99PGdiE9cXtENBTBLYb5ND2FdDpyA
         xQZ0ka+yDng66aCiNHV5sYgRWQ6NOIrgo1Koiugzi5xpvmbYMEZ6uv1peZ0cH4dVyLwG
         DRrhu1iPFjd/rHU+dkHu/rvl1aGtEhKcX3CHgs19qZWMYLxX1sMI9jKHLBTPkOWDSlWR
         oK8ia5tWyCNpdDHaLmpSSzrciJyXIs7gc1uTBg8y0f6GAAdFasiMqftjt79NJEe/65sY
         9cw+DWEViz6gyOX1swb2C4YlM4iEWUzNKDMvH9jUEFqYbX++qQsRZFfnflKGrqXC5XhP
         uQ9w==
X-Gm-Message-State: AJIora8DoF7z6faTLZ1Kw04Y6N0dpuXPzt1zR6DBWXJ78jhCkSdbIZoL
        yVxRYfjZIRCQ4s9ioZ2PFSpzKaVIReA89bzjYbo=
X-Google-Smtp-Source: AGRyM1v5U9Ah3RPkhGKYzjEMubqfw1L18dzLkKxkoL/JV78XoMNpTOjiErc8EufcxnSQK4chhXAYht22c9PWbnPXiJQ=
X-Received: by 2002:a1f:eec2:0:b0:36c:1c9b:465f with SMTP id
 m185-20020a1feec2000000b0036c1c9b465fmr6013920vkh.3.1655888447736; Wed, 22
 Jun 2022 02:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190408141114.GC15023@quack2.suse.cz> <CAOQ4uxhxgYASST1k-UaqfbLL9ERquHaKL2jtydB2+iF9aT8SRQ@mail.gmail.com>
 <20190409082605.GA8107@quack2.suse.cz> <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
 <20220617151135.yc6vytge6hjabsuz@quack3> <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan> <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
 <20220621085956.y5wyopfgzmqkaeiw@quack3.lan> <CAOQ4uxheatf+GCHxbUDQ4s4YSQib3qeYVeXZwEicR9fURrEFBA@mail.gmail.com>
 <YrKLG6YhMS+qLl8B@casper.infradead.org>
In-Reply-To: <YrKLG6YhMS+qLl8B@casper.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 22 Jun 2022 12:00:35 +0300
Message-ID: <CAOQ4uxgYbVOSDwufPFvbNwsxnzzseNH9guwxZvP43vMmOFqq+Q@mail.gmail.com>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw workload
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

On Wed, Jun 22, 2022 at 6:23 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jun 21, 2022 at 03:53:33PM +0300, Amir Goldstein wrote:
> > On Tue, Jun 21, 2022 at 11:59 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 21-06-22 10:49:48, Amir Goldstein wrote:
> > > > > How exactly do you imagine the synchronization of buffered read against
> > > > > buffered write would work? Lock all pages for the read range in the page
> > > > > cache? You'd need to be careful to not bring the machine OOM when someone
> > > > > asks to read a huge range...
> > > >
> > > > I imagine that the atomic r/w synchronisation will remain *exactly* as it is
> > > > today by taking XFS_IOLOCK_SHARED around generic_file_read_iter(),
> > > > when reading data into user buffer, but before that, I would like to issue
> > > > and wait for read of the pages in the range to reduce the probability
> > > > of doing the read I/O under XFS_IOLOCK_SHARED.
> > > >
> > > > The pre-warm of page cache does not need to abide to the atomic read
> > > > semantics and it is also tolerable if some pages are evicted in between
> > > > pre-warn and read to user buffer - in the worst case this will result in
> > > > I/O amplification, but for the common case, it will be a big win for the
> > > > mixed random r/w performance on xfs.
> > > >
> > > > To reduce risk of page cache thrashing we can limit this optimization
> > > > to a maximum number of page cache pre-warm.
> > > >
> > > > The questions are:
> > > > 1. Does this plan sound reasonable?
> > >
> > > Ah, I see now. So essentially the idea is to pull the readahead (which is
> > > currently happening from filemap_read() -> filemap_get_pages()) out from under
> > > the i_rwsem. It looks like a fine idea to me.
> >
> > Great!
> > Anyone doesn't like the idea or has another suggestion?
>
> I guess I'm still confused.
>
> The problem was the the XFS IOLOCK was being held while we waited for
> readahead to complete.  To fix this, you're planning on waiting for
> readahead to complete with the invalidate lock held?  I don't see the
> benefit.
>
> I see the invalidate_lock as being roughly equivalent to the IOLOCK,
> just pulled up to the VFS.  Is that incorrect?
>

This question coming from you really shakes my confidence.

This entire story started from the observation that xfs performance
of concurrent mixed rw workload is two orders of magnitude worse
than ext4 on slow disk.

The reason for the difference was that xfs was taking the IOLOCK
shared on reads and ext4 did not.

That had two very different reasons:
1. POSIX atomic read/write semantics unique to xfs
2. Correctness w.r.t. races with punch hole etc, which lead to the
    conclusion that all non-xfs filesystems are buggy in that respect

The solution of pulling IOLOCK to vfs would have solved the bug
but at the cost of severely regressing the mix rw workload on all fs.

The point of Jan's work on invalidate_lock was to fix the bug and
avoid the regression. I hope that worked out, but I did not test
the mixed rw workload on ext4 after invalidate_lock.

IIUC, ideally, invalidate_lock was supposed to be taken only for
adding pages to page cache and locking them, but not during IO
in order to synchronize against truncating pages (punch hole).
But from this comment in filemap_create_folio() I just learned
that that is not exactly the case:
"...Note that we could release invalidate_lock after inserting the
 folio into the page cache as the locked folio would then be enough
 to synchronize with hole punching. But..."

Even so, because invalidate_lock is not taken by writers and reader
that work on existing pages and because invalidate_lock is not held
for the entire read/write operation, statistically it should be less
contended than IOLOCK for some workloads, but I am afraid that
for the workload I tested (bs=8K and mostly cold page cache) it will
be contended with current vfs code.

I am going to go find a machine with slow disk to test the random rw
workload again on both xfs and ext4 pre and post invalidate_lock and
to try out the pre-warm page cache solution.

The results could be:
a) ext4 random rw performance has been degraded by invalidate_lock
b) pre-warm page cache before taking IOLOCK is going to improve
    xfs random rw performance
c) A little bit of both

It would be great if you and Jan could agree on the facts and confirm
that my observations about invalidate_lock are correct until I get the
test results.

Thanks,
Amir.
