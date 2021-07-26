Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EEB3D5973
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 14:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhGZLq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 07:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGZLq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:46:56 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF7DC061757;
        Mon, 26 Jul 2021 05:27:24 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id c3so8700627ilh.3;
        Mon, 26 Jul 2021 05:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5AHF2oAD71DeTWUNBFjQquVzfkKr1vrVF/VPD6Sz0E=;
        b=eqP4qyJnBWxjfTvhxOrzirUmRswssbH2cu7lRtxpZOk91zZQMBtVKbvT89iSg9zxOO
         UcVZGeeYnJHwkUV30pe/9tzswg3vN+JjFAe1FYW6XQc01NcQvZNP0WKzo3GM2qnd1vWh
         ErmZpR7UPbEndqQAh9hcVETTS0Zu4pmicsqDFIgqOOr5t8ZPwu6J1LmHhAdObtIWmtx/
         pfdu1E4y3SwROCDhjWaYaRNzqT+R9xOrFMRgEJHvw7/puQf6pOOClOGEPzteEHSbd1sx
         peb89XtpmZUfX0PJiFDawf7iFlinbLYeuQadAtzB/WorVHGTrnvBZ71It9HYdq0gfp1x
         70xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5AHF2oAD71DeTWUNBFjQquVzfkKr1vrVF/VPD6Sz0E=;
        b=P2HKrqA8mBxbAZ0DO6ZONMFGmRFFqOJKe5vXxiCAgQDRWqDri0Dn3m8YE1XDspWaAp
         QcNQ87gxl8byekd/cguL3G3dRSV1m2dKV9a5EO2++/vP+YUkUACYK7ev8S5rdjIZSYIe
         fph396vdtpnkdn9f/L+VScky2opZyOVeCqu7TYM3mWjEPYpLUQX3njJ9NuMghhpbDJju
         2JjaT3B67XIrmq6rBLOfkYetGbFUwgn840/JPdrTco3YSSUeoqvA27+FDoZ3yN4wdv+i
         LOdl6zZtGy3JxOVCAXp02TgCGq+GS/wzZtE1T/K7toEKtbVhLCRx4BrBS5AyUyZlHyut
         zxpw==
X-Gm-Message-State: AOAM532qt0S2YoXInc6IS7agzzT0Tjk7yJi5b2U9a7E6vytZpYePYFT2
        YU+5QttzD2r2Lm2Az0CT5lqhW+l74Jf+AWbrpRg=
X-Google-Smtp-Source: ABdhPJzG5jKWBAyqeJ4cbWptYmY1gOuSr1JLfz5y7rWv/LuJNdeLRATTmfeUMI6/n8WwMUjZLKMzjQVx1y+6Y2OmLNo=
X-Received: by 2002:a92:d451:: with SMTP id r17mr13257263ilm.109.1627302443653;
 Mon, 26 Jul 2021 05:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com> <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local> <20210726110611.459173-1-agruenba@redhat.com>
 <20210726121702.GA528@lst.de>
In-Reply-To: <20210726121702.GA528@lst.de>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Mon, 26 Jul 2021 14:27:12 +0200
Message-ID: <CAHpGcMJhuSApy4eg9jKe2pYq4d7bY-Lg-Bmo9tOANghQ2Hxo-A@mail.gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mo., 26. Juli 2021 um 14:17 Uhr schrieb Christoph Hellwig <hch@lst.de>:
>
> > Subject: iomap: Support tail packing
>
> I can't say I like this "tail packing" language here when we have the
> perfectly fine inline wording.  Same for various comments in the actual
> code.
>
> > +     /* inline and tail-packed data must start page aligned in the file */
> > +     if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> > +             return -EIO;
> > +     if (WARN_ON_ONCE(size > PAGE_SIZE - offset_in_page(iomap->inline_data)))
> > +             return -EIO;
>
> Why can't we use iomap_inline_data_size_valid here?

We can now. Gao, can you change that?

> That is how can size be different from iomap->length?

Quoting from my previous reply,

"In the iomap_readpage case (iomap_begin with flags == 0),
iomap->length will be the amount of data up to the end of the inode.
In the iomap_file_buffered_write case (iomap_begin with flags ==
IOMAP_WRITE), iomap->length will be the size of iomap->inline_data.
(For extending writes, we need to write beyond the current end of
inode.) So iomap->length isn't all that useful for
iomap_read_inline_data."

> Shouldn't the offset_in_page also go into iomap_inline_data_size_valid,
> which should probably be called iomap_inline_data_valid then?

Hmm, not sure what you mean: iomap_inline_data_size_valid does take
offset_in_page(iomap->inline_data) into account.

> >       if (iomap->type == IOMAP_INLINE) {
> > +             int ret = iomap_read_inline_data(inode, page, iomap);
> > +             return ret ?: PAGE_SIZE;
>
> The ?: expression without the first leg is really confuing.  Especially
> if a good old if is much more readable here.

I'm sure Gao can change this.

>                 int ret = iomap_read_inline_data(inode, page, iomap);
>
>                 if (ret)
>                         return ret;
>                 return PAGE_SIZE;
>
> > +             copied = copy_from_iter(iomap_inline_data(iomap, pos), length, iter);
>
>
> > +             copied = copy_to_iter(iomap_inline_data(iomap, pos), length, iter);
>
> Pleae avoid the overly long lines.

I thought people were okay with 80 character long lines?

Thanks,
Andreas
