Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FCE54F9A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 16:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382968AbiFQOsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382984AbiFQOsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:48:21 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0315639E;
        Fri, 17 Jun 2022 07:48:20 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id r15so1611152uaf.13;
        Fri, 17 Jun 2022 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcIHYHY7u1Wr/GV3aoIoPqYOsQGjAK4OcNkD/GU5M1M=;
        b=Jr2Rvzf2R+Qs10pfSCH3B8xV3k51eSIl1oRD/qlzgUF2B6Lqd1wzm0Qv7YmklySnfo
         pvgZFkH1pxaB0m7tTsV7h5COnS98IUw0oH6sBYhHswlxRx9IAP1IB2n3xAjWChFhcFZo
         10Vc8BMMA2QDUpz5PLEetN7sMcHshYY/bez8W8R1Q/Ytff9pSdpy5E58TFvwQDV9+p0G
         YHxVrn+y/sb+PCZ5CAjbiJdn/mSooNBm6GpXsEIqOZsAgtHrYJ988TJFfgFmwwk0Edpx
         lWpiT2MZbpsQU5JSqVG6QBzjn7bp27nxg69J1jHoJqEClHlgcAocv8HQlQeThxXd8gJX
         YjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcIHYHY7u1Wr/GV3aoIoPqYOsQGjAK4OcNkD/GU5M1M=;
        b=2lACKIK3RFZTJfDY2feY2zrfze1brS/1BTj62MXnsjJGiBmWPRNkJzOJblFfmfTexF
         Qi6PHlVbb7ZAUtsLuD6WViBHuvuglyLSteX+Pxx+C9GC0KxS4JusHmEHqeaIlfxmxHnv
         SEUxvpWHMytwuN3m+Bd1M8qYp6lwrFhDmaQcab/iFPYDonWm9gCOPnzeNgK1balGuvu2
         2s7uZDzeq+PO2q/RT2SHGOlNACwrnC+LSYOrq36/TkLxEfH9Zud0j8HHZJ5bZcYFH851
         o0g2kCYf6zWDoUqoXwGtRj+Sc13ixxP4C/8JtQTy94k6zxD08vQpG31uRoqXSkQLg9k4
         +Csw==
X-Gm-Message-State: AJIora989BKR4S9JCsR1A8bQQdPZkjB7gskqQdDpbfzTXq08MLSAW8w3
        th5cuzEccx3iRt22o6hG4UK2pXdS+jmntlNHwRw=
X-Google-Smtp-Source: AGRyM1vU628PZCHEasd5i6Kd/bfeF+tHIigArJiScOV/UHBidep3tKwiX3+yAzz0NhvMYJ/DqI8RbukFBG0ny0S6UFA=
X-Received: by 2002:a05:6130:21a:b0:37a:8e07:d495 with SMTP id
 s26-20020a056130021a00b0037a8e07d495mr4616073uac.80.1655477300037; Fri, 17
 Jun 2022 07:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190404165737.30889-1-amir73il@gmail.com> <20190404211730.GD26298@dastard>
 <CAOQ4uxjQNmxqmtA_VbYW0Su9rKRk2zobJmahcyeaEVOFKVQ5dw@mail.gmail.com>
 <20190407232728.GF26298@dastard> <CAOQ4uxgD4ErSUtbu0xqb5dSm_tM4J92qt6=hGH8GRc5KNGqP9A@mail.gmail.com>
 <20190408141114.GC15023@quack2.suse.cz> <CAOQ4uxhxgYASST1k-UaqfbLL9ERquHaKL2jtydB2+iF9aT8SRQ@mail.gmail.com>
 <20190409082605.GA8107@quack2.suse.cz>
In-Reply-To: <20190409082605.GA8107@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 17 Jun 2022 17:48:08 +0300
Message-ID: <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw workload
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Lukas Czerner <lczerner@redhat.com>,
        Theodore Tso <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>
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

On Tue, Apr 9, 2019 at 11:26 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 08-04-19 20:41:09, Amir Goldstein wrote:
> > On Mon, Apr 8, 2019 at 5:11 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 08-04-19 12:02:34, Amir Goldstein wrote:
> > > > On Mon, Apr 8, 2019 at 2:27 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > >
> > > > > On Fri, Apr 05, 2019 at 05:02:33PM +0300, Amir Goldstein wrote:
> > > > > > On Fri, Apr 5, 2019 at 12:17 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 04, 2019 at 07:57:37PM +0300, Amir Goldstein wrote:
> > > > > > > > This patch improves performance of mixed random rw workload
> > > > > > > > on xfs without relaxing the atomic buffered read/write guaranty
> > > > > > > > that xfs has always provided.
> > > > > > > >
> > > > > > > > We achieve that by calling generic_file_read_iter() twice.
> > > > > > > > Once with a discard iterator to warm up page cache before taking
> > > > > > > > the shared ilock and once again under shared ilock.
> > > > > > >
> > > > > > > This will race with thing like truncate, hole punching, etc that
> > > > > > > serialise IO and invalidate the page cache for data integrity
> > > > > > > reasons under the IOLOCK. These rely on there being no IO to the
> > > > > > > inode in progress at all to work correctly, which this patch
> > > > > > > violates. IOWs, while this is fast, it is not safe and so not a
> > > > > > > viable approach to solving the problem.
> > > > > > >
> > > > > >
> > > > > > This statement leaves me wondering, if ext4 does not takes
> > > > > > i_rwsem on generic_file_read_iter(), how does ext4 (or any other
> > > > > > fs for that matter) guaranty buffered read synchronization with
> > > > > > truncate, hole punching etc?
> > > > > > The answer in ext4 case is i_mmap_sem, which is read locked
> > > > > > in the page fault handler.
> > > > >
> > > > > Nope, the  i_mmap_sem is for serialisation of /page faults/ against
> > > > > truncate, holepunching, etc. Completely irrelevant to the read()
> > > > > path.
> > > > >
> > > >
> > > > I'm at lost here. Why are page faults completely irrelevant to read()
> > > > path? Aren't full pages supposed to be faulted in on read() after
> > > > truncate_pagecache_range()?
> > >
> > > During read(2), pages are not "faulted in". Just look at
> > > what generic_file_buffered_read() does. It uses completely separate code to
> > > add page to page cache, trigger readahead, and possibly call ->readpage() to
> > > fill the page with data. "fault" path (handled by filemap_fault()) applies
> > > only to accesses from userspace to mmaps.
> > >
> >
> > Oh! thanks for fixing my blind spot.
> > So if you agree with Dave that ext4, and who knows what other fs,
> > are vulnerable to populating page cache with stale "uptodate" data,
>
> Not that many filesystems support punching holes but you're right.
>
> > then it seems to me that also xfs is vulnerable via readahead(2) and
> > posix_fadvise().
>
> Yes, this is correct AFAICT.
>
> > Mind you, I recently added an fadvise f_op, so it could be used by
> > xfs to synchronize with IOLOCK.
>
> And yes, this should work.
>
> > Perhaps a better solution would be for truncate_pagecache_range()
> > to leave zeroed or Unwritten (i.e. lazy zeroed by read) pages in page
> > cache. When we have shared pages for files, these pages could be
> > deduped.
>
> No, I wouldn't really mess with sharing pages due to this. It would be hard
> to make that scale resonably and would be rather complex. We really need a
> proper and reasonably simple synchronization mechanism between operations
> removing blocks from inode and operations filling in page cache of the
> inode. Page lock was supposed to provide this but doesn't quite work
> because hole punching first remove pagecache pages and then go removing all
> blocks.
>
> So I agree with Dave that going for range lock is really the cleanest way
> forward here without causing big regressions for mixed rw workloads. I'm
> just thinking how to best do that without introducing lot of boilerplate
> code into each filesystem.

Hi Jan, Dave,

Trying to circle back to this after 3 years!
Seeing that there is no progress with range locks and
that the mixed rw workloads performance issue still very much exists.

Is the situation now different than 3 years ago with invalidate_lock?
Would my approach of pre-warm page cache before taking IOLOCK
be safe if page cache is pre-warmed with invalidate_lock held?

For the pNFS leases issue, as I wrote back in pre-COVID era,
I intend to opt-out of this optimization with
#ifndef CONFIG_EXPORTFS_BLOCK_OPS

Thanks,
Amir.
