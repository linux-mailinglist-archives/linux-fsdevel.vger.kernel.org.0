Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C563D5431
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 09:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhGZGm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 02:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232391AbhGZGm3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627284178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MeX8qL0FAIQm9lCQlUw2wK9bVyGC91/TUjMa+ErGo/I=;
        b=ToAJdIJn8rfd0EmqNWaEB+J2vab67sbpKMOOOFGHC54Pop8C7qg6p6hbWgsWzfF8LVptUI
        Z1dbfGNILFG4VvlIKH8HeH5s44E2z4P9itUutvgYl0L94QugAYCErBS2kQDGkgXgwfPWVy
        aSg7Zf9Mtv4vjHBak1NcAsxWuE3dVSc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-n6NkRqpxO_Shwl8LovHHjg-1; Mon, 26 Jul 2021 03:22:54 -0400
X-MC-Unique: n6NkRqpxO_Shwl8LovHHjg-1
Received: by mail-wr1-f72.google.com with SMTP id d13-20020adfc3cd0000b02901531b0b7c89so3817722wrg.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 00:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MeX8qL0FAIQm9lCQlUw2wK9bVyGC91/TUjMa+ErGo/I=;
        b=PzJJyr/IaBNFexn0Hjbu0SARZRr9PYroGsfugqb99vXfQQSQJWEbo6gtsaqabwrf8c
         EHKp32zs3zjKmg0JGXodKuvPaDvM57RUrEm0TKZYT1I0WUyhpVQY5KKZ8uYulGFX2qXx
         +Z6EIlHTvDc8jKRuETSExWYlf3Uw6/C9Ba2UbXu7Y/booXsVK1Q6vskc1AFLDot1hCs8
         ElQrjgcryUeYPyg144R4zrKQ89CkJ818OG9s8Iv0VOovZ9jWLaTSh8f0P1+Z/yd5t+Sa
         fgJS/aNzb0rINvBg94pbhgsEPgPybIJ3U4yrW5qybglDTMZwfZNZ4VEPHbeGBpmBBO2W
         QkPg==
X-Gm-Message-State: AOAM531orpQri8Xa6HaM0Nn/tNnS7NLp+1VqvsrFnPMLViFwBEDvvw1s
        anKcVTsdH43wwPU7wKI5bd/vpPkGLkO5wp2CYnsXhwVhpUjRbbltrkHHsseocMzcV3ksqfigRZ/
        q4+RdfDL5/FlfWpc2rcWkR3Y+W8smW3EZuidPTBe8BQ==
X-Received: by 2002:a05:6000:227:: with SMTP id l7mr6209240wrz.289.1627284172732;
        Mon, 26 Jul 2021 00:22:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMPTPi7uK/DcXtzBz0a+yMSxtuUyKKbFDoQbZm98a8p/STZCbLR5hh1hXULHMPYI9hzTrryt893dSga4drXhc=
X-Received: by 2002:a05:6000:227:: with SMTP id l7mr6209224wrz.289.1627284172598;
 Mon, 26 Jul 2021 00:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com> <20210725221639.426565-1-agruenba@redhat.com>
 <YP4fk75mr/mIotDy@B-P7TQMD6M-0146.local>
In-Reply-To: <YP4fk75mr/mIotDy@B-P7TQMD6M-0146.local>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 26 Jul 2021 09:22:41 +0200
Message-ID: <CAHc6FU7904K4XrUhOoHp8uoBrDN0kyZ+q54anMXrJUBVCNA29A@mail.gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 4:36 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> On Mon, Jul 26, 2021 at 12:16:39AM +0200, Andreas Gruenbacher wrote:
> > Here's a fixed and cleaned up version that passes fstests on gfs2.
> >
> > I see no reason why the combination of tail packing + writing should
> > cause any issues, so in my opinion, the check that disables that
> > combination in iomap_write_begin_inline should still be removed.
>
> Since there is no such fs for tail-packing write, I just do a wild
> guess, for example,
>  1) the tail-end block was not inlined, so iomap_write_end() dirtied
>     the whole page (or buffer) for the page writeback;
>  2) then it was truncated into a tail-packing inline block so the last
>     extent(page) became INLINE but dirty instead;
>  3) during the late page writeback for dirty pages,
>     if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
>     would be triggered in iomap_writepage_map() for such dirty page.
>
> As Matthew pointed out before,
> https://lore.kernel.org/r/YPrms0fWPwEZGNAL@casper.infradead.org/
> currently tail-packing inline won't interact with page writeback, but
> I'm afraid a supported tail-packing write fs needs to reconsider the
> whole stuff how page, inode writeback works and what the pattern is
> with the tail-packing.
>
> >
> > It turns out that returning the number of bytes copied from
> > iomap_read_inline_data is a bit irritating: the function is really used
> > for filling the page, but that's not always the "progress" we're looking
> > for.  In the iomap_readpage case, we actually need to advance by an
> > antire page, but in the iomap_file_buffered_write case, we need to
> > advance by the length parameter of iomap_write_actor or less.  So I've
> > changed that back.
> >
> > I've also renamed iomap_inline_buf to iomap_inline_data and I've turned
> > iomap_inline_data_size_valid into iomap_within_inline_data, which seems
> > more useful to me.
> >
> > Thanks,
> > Andreas
> >
> > --
> >
> > Subject: [PATCH] iomap: Support tail packing
> >
> > The existing inline data support only works for cases where the entire
> > file is stored as inline data.  For larger files, EROFS stores the
> > initial blocks separately and then can pack a small tail adjacent to the
> > inode.  Generalise inline data to allow for tail packing.  Tails may not
> > cross a page boundary in memory.
> >
> > We currently have no filesystems that support tail packing and writing,
> > so that case is currently disabled (see iomap_write_begin_inline).  I'm
> > not aware of any reason why this code path shouldn't work, however.
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> > Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
> >  fs/iomap/direct-io.c   | 11 ++++++-----
> >  include/linux/iomap.h  | 22 +++++++++++++++++++++-
> >  3 files changed, 50 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 87ccb3438bec..334bf98fdd4a 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -205,25 +205,29 @@ struct iomap_readpage_ctx {
> >       struct readahead_control *rac;
> >  };
> >
> > -static void
> > -iomap_read_inline_data(struct inode *inode, struct page *page,
> > +static int iomap_read_inline_data(struct inode *inode, struct page *page,
> >               struct iomap *iomap)
> >  {
> > -     size_t size = i_size_read(inode);
> > +     size_t size = i_size_read(inode) - iomap->offset;
>
> I wonder why you use i_size / iomap->offset here,

This function is supposed to copy the inline or tail data at
iomap->inline_data into the page passed to it. Logically, the inline
data starts at iomap->offset and extends until i_size_read(inode).
Relative to the page, the inline data starts at offset 0 and extends
until i_size_read(inode) - iomap->offset. It's as simple as that.

> and why you completely ignoring iomap->length field returning by fs.

In the iomap_readpage case (iomap_begin with flags == 0),
iomap->length will be the amount of data up to the end of the inode.
In the iomap_file_buffered_write case (iomap_begin with flags ==
IOMAP_WRITE), iomap->length will be the size of iomap->inline_data.
(For extending writes, we need to write beyond the current end of
inode.) So iomap->length isn't all that useful for
iomap_read_inline_data.

> Using i_size here instead of iomap->length seems coupling to me in the
> beginning (even currently in practice there is some limitation.)

And what is that?

Thanks,
Andreas

