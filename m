Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A18C3D59FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 15:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhGZMXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 08:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231874AbhGZMW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627304608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGNIpIsmHVsxBMU4UuRo09+EWFGkpjab3tHKGtaAqJI=;
        b=VETI/bNIjI+DY1843n+Kr23O9DWk3dNS4wpWIecmIs8A7sIQzUYIj9nKFnNJEqMlaPQbUJ
        SG5Inj38NkYlUJIOIuxhfjoX4xlOelTd+8xyn/WgOLEadm8qgh20NmTkYboN5nl6SArAU9
        lZvf8dvx7bI+316+SAUAqAfiaqR+GKo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-il40E-HBOgqGYSRZv1gBqw-1; Mon, 26 Jul 2021 09:03:27 -0400
X-MC-Unique: il40E-HBOgqGYSRZv1gBqw-1
Received: by mail-wr1-f69.google.com with SMTP id o8-20020a5d4a880000b029013a10564614so4702208wrq.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 06:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGNIpIsmHVsxBMU4UuRo09+EWFGkpjab3tHKGtaAqJI=;
        b=hT/yPRlESTsmvWkVD3CBt7T0XUbglGyfLVuIgvaeOwajiKjHrdRZkDYw0/5Nc8mprz
         D2jMklq9pbN0u65yVFs0ZyJ6ejDImQaFCkEA15TkbkBsanUvBMhnooprE0RHfzsn0TBz
         W4zJU2xNs/+aYI7DaNA2+h8VelcFZkdRWH7HSGNFVFI9iD4EeN/S/mH/YSBIwlP12Y9e
         unub8N/t/7f8LBMJJ9UNmNNhl5VTbZbv4rj2VhnKbKA6T8/hym4zIrJNnT+JeGLN6PSE
         DVgRuo749K+ZgEE3HngE90Mt+CuN6GB/S9J271hkWKkrDRt5d+s+6fw+AfGJGsyY/cPC
         AaUw==
X-Gm-Message-State: AOAM530lfAP0BnJw82hdDcmFQoSsxSEIpu5VbYmS8NY7KP86eVkm05Tl
        n9XNg8NqUY8mfTSIkgyQuxcMJ8fYhWJhGaTev5Cz7vvQ8HV2Sh51aUqyBZKUwZ+uZXZTHxa1+uc
        eqcMJH9Bz9vBMsm1rxdJlDywPNmSV7XvsTbLayM+5qQ==
X-Received: by 2002:a1c:2282:: with SMTP id i124mr17049217wmi.166.1627304605744;
        Mon, 26 Jul 2021 06:03:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzez+Dg/KjFXB2/t8rmE8mp4VEy7yq4UcgU/E1xnbCT/hQKvCXLclyMSKPeyOlhURK+emV0LZWpNj9vRYVNLFM=
X-Received: by 2002:a1c:2282:: with SMTP id i124mr17049182wmi.166.1627304605390;
 Mon, 26 Jul 2021 06:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com> <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local> <20210726110611.459173-1-agruenba@redhat.com>
 <YP6rTi/I3Vd+pbeT@casper.infradead.org>
In-Reply-To: <YP6rTi/I3Vd+pbeT@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 26 Jul 2021 15:03:14 +0200
Message-ID: <CAHc6FU6RhzfRSaX3qB6i6F+ELPZ=Q0q-xA0Tfu_MuDzo77d7zQ@mail.gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 2:33 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, Jul 26, 2021 at 01:06:11PM +0200, Andreas Gruenbacher wrote:
> > @@ -671,11 +683,11 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> >       void *addr;
> >
> >       WARN_ON_ONCE(!PageUptodate(page));
> > -     BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +     BUG_ON(!iomap_inline_data_size_valid(iomap));
> >
> >       flush_dcache_page(page);
> >       addr = kmap_atomic(page);
> > -     memcpy(iomap->inline_data + pos, addr + pos, copied);
> > +     memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
> >       kunmap_atomic(addr);
> >
> >       mark_inode_dirty(inode);
>
> Only tangentially related ... why do we memcpy the data into the tail
> at write_end() time instead of at writepage() time?  I see there's a
> workaround for that in gfs2's page_mkwrite():
>
>         if (gfs2_is_stuffed(ip)) {
>                 err = gfs2_unstuff_dinode(ip);
>
> (an mmap store cannot change the size of the file, so this would be
> unnecessary)

Not sure if an additional __set_page_dirty_nobuffers is needed in that
case, but doing the writeback at writepage time should work just as
well. It's just that gfs2 did it at write time historically. The
un-inlining in gfs2_page_mkwrite() could probably also be removed.

I can give this a try, but I'll unfortunately be AFK for the next
couple of days.

> Something like this ...
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 87ccb3438bec..3aeebe899fc5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -665,9 +665,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>         return copied;
>  }
>
> -static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> -               struct iomap *iomap, loff_t pos, size_t copied)
> +static int iomap_write_inline_data(struct inode *inode, struct page *page,
> +               struct iomap *iomap)
>  {
> +       size_t size = i_size_read(inode) - page_offset(page);

You surely mean inode->i_size - iomap->offset.

>         void *addr;
>
>         WARN_ON_ONCE(!PageUptodate(page));
> @@ -675,11 +676,10 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
>
>         flush_dcache_page(page);
>         addr = kmap_atomic(page);
> -       memcpy(iomap->inline_data + pos, addr + pos, copied);
> +       memcpy(iomap->inline_data, addr, size);
>         kunmap_atomic(addr);
>
> -       mark_inode_dirty(inode);
> -       return copied;
> +       return 0;
>  }
>
>  /* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
> @@ -691,9 +691,7 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>         loff_t old_size = inode->i_size;
>         size_t ret;
>
> -       if (srcmap->type == IOMAP_INLINE) {
> -               ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
> -       } else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
> +       if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
>                 ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
>                                 page, NULL);
>         } else {
> @@ -1314,6 +1312,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>
>         WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
>
> +       if (wpc->iomap.type == IOMAP_INLINE)
> +               return iomap_write_inline_data(inode, page, iomap);
> +
>         /*
>          * Walk through the page to find areas to write back. If we run off the
>          * end of the current map or find the current map invalid, grab a new
> @@ -1328,8 +1329,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>                 error = wpc->ops->map_blocks(wpc, inode, file_offset);
>                 if (error)
>                         break;
> -               if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
> -                       continue;
>                 if (wpc->iomap.type == IOMAP_HOLE)
>                         continue;
>                 iomap_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
>

Thanks,
Andreas

