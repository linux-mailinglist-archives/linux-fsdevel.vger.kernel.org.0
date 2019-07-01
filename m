Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD55B865
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 11:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfGAJtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 05:49:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40796 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfGAJtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:49:16 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so27317120ioc.7;
        Mon, 01 Jul 2019 02:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abxVXeccHHFb0+Whp7D1V+v/o0Mk6/SKpT3C/dtCC68=;
        b=Qd0RoIYgOmbLO4vcVd2bxbgA29YXziaH7L2dXbgMce9afQ20fYYlxvLzk9QGHlzSXe
         oyo3KD7aYkpLcrQQIv57wQANN4OwadpQcCdqDO0FZhPB0h11Ne6GBbsgzALWQ/q9jpZm
         B7VVZ9WTf6iaWQNgFH2YTOQYpoiVqyF5YbqJVuAjT2DSVF4jEoJyYblPj0f1nhq4tN62
         jAR9UXb5z6o26yuAhAT2hOJlIWGPoP78h76AeWV2pm5fgA4/DICl77NwjjT0/RnnUnSj
         stAj3ihu/wtnYI9YDTZy2fYUGqevmBqa6QUhKJhiJeF9XedtBGOjPE7GmSfWUjt0Svhq
         IASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abxVXeccHHFb0+Whp7D1V+v/o0Mk6/SKpT3C/dtCC68=;
        b=F9H8slxjZHyPh1ZxdNy4eTe6k6IBYPv0H8Eqqg4BUGj1j+BGIX4PcAFSoeAE9Snnwy
         Fzr9yL3UP7z0og6h8pxUWXeP7E977zYxZHK4sufWAE1CcqkkfTxvJvP+3gF9DJE+TOHe
         dTzk+vFqStlV2plHTPPHB6ilddzvgjuIFVuj8Z6UjAX7Y5h0gzLwNYYMrJYpehR7ShcE
         b5BB92CWd0S7bfuQNcajB6xia4hOJBmr6N75BCcG9YKzlhcowIJiVoLeB0hyLlWbn9Fi
         BmV64fFM8NSEfbLT6fMW3KNZiZcMoV+9IIyyTIZuGxbvSDvojO9B5CIkOmyAgblpdTIV
         g3cQ==
X-Gm-Message-State: APjAAAXyKkHgAGYIVbAQxtlPbv8HfDARJP66nRlOt3uBVBw4csYB1+IQ
        sNy5uQFxi1M1LfvMYmTZV3bcMGUKSagUD7e24XH9eGYH
X-Google-Smtp-Source: APXvYqzBksAhh+3gh8FH8ib5uVMRDD65qcRt5SUtnxTnRk497OcpAaHPQqHt5GicQge6gJ0TIVVCRkeEiYv5VTXoBcA=
X-Received: by 2002:a6b:7d49:: with SMTP id d9mr20509287ioq.50.1561974555680;
 Mon, 01 Jul 2019 02:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190629073020.22759-1-yuchao0@huawei.com> <afda5702-1d88-7634-d943-0c413ae3b28f@huawei.com>
 <a27e3502-db75-22fa-4545-e588abbbfbf2@huawei.com> <58511d64-aa7a-8ac2-0255-affe0e8d49de@huawei.com>
In-Reply-To: <58511d64-aa7a-8ac2-0255-affe0e8d49de@huawei.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Mon, 1 Jul 2019 11:49:04 +0200
Message-ID: <CAHpGcMK4ihE1nv7ME0yKKUdBj+Rdr9nBMnxAtQfFFOmK9aEY_A@mail.gmail.com>
Subject: Re: [PATCH RFC] iomap: introduce IOMAP_TAIL
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        chao@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mo., 1. Juli 2019 um 10:04 Uhr schrieb Gao Xiang <gaoxiang25@huawei.com>:
> On 2019/7/1 14:40, Chao Yu wrote:
> > Hi Xiang,
> >
> > On 2019/6/29 17:34, Gao Xiang wrote:
> >> Hi Chao,
> >>
> >> On 2019/6/29 15:30, Chao Yu wrote:
> >>> Some filesystems like erofs/reiserfs have the ability to pack tail
> >>> data into metadata, however iomap framework can only support mapping
> >>> inline data with IOMAP_INLINE type, it restricts that:
> >>> - inline data should be locating at page #0.
> >>> - inline size should equal to .i_size
> >>> So we can not use IOMAP_INLINE to handle tail-packing case.
> >>>
> >>> This patch introduces new mapping type IOMAP_TAIL to map tail-packed
> >>> data for further use of erofs.
> >>>
> >>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>> ---
> >>>  fs/iomap.c            | 22 ++++++++++++++++++++++
> >>>  include/linux/iomap.h |  1 +
> >>>  2 files changed, 23 insertions(+)
> >>>
> >>> diff --git a/fs/iomap.c b/fs/iomap.c
> >>> index 12654c2e78f8..ae7777ce77d0 100644
> >>> --- a/fs/iomap.c
> >>> +++ b/fs/iomap.c
> >>> @@ -280,6 +280,23 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
> >>>     SetPageUptodate(page);
> >>>  }
> >>>
> >>> +static void
> >>> +iomap_read_tail_data(struct inode *inode, struct page *page,
> >>> +           struct iomap *iomap)
> >>> +{
> >>> +   size_t size = i_size_read(inode) & (PAGE_SIZE - 1);
> >>> +   void *addr;
> >>> +
> >>> +   if (PageUptodate(page))
> >>> +           return;
> >>> +
> >>> +   addr = kmap_atomic(page);
> >>> +   memcpy(addr, iomap->inline_data, size);
> >>> +   memset(addr + size, 0, PAGE_SIZE - size);
> >>
> >> need flush_dcache_page(page) here for new page cache page since
> >> it's generic iomap code (althrough not necessary for x86, arm), I am not sure...
> >> see commit d2b2c6dd227b and c01778001a4f...
> >
> > Thanks for your reminding, these all codes were copied from
> > iomap_read_inline_data(), so I think we need a separated patch to fix this issue
> > if necessary.
>
> Yes, just a reminder, it is good as it-is.

Not sure if that means that IOMAP_INLINE as is works for you now. In
any case, if the inline data isn't transparently copied into the page
cache at index 0, memory-mapped I/O isn't going to work.

The code further assumes that "packed" files consist of exactly one
IOMAP_INLINE mapping; no IOMAP_MAPPED or other mappings may follow. Is
it that assumption that's causing you trouble? If so, what's the
layout at the filesystem level you want to support?

Thanks,
Andreas

> Thanks,
> Gao Xiang
>
> >
> > Thanks,
> >
> >>
> >> Thanks,
> >> Gao Xiang
> >>
> >>> +   kunmap_atomic(addr);
> >>> +   SetPageUptodate(page);
> >>> +}
> >>> +
> >>>  static loff_t
> >>>  iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >>>             struct iomap *iomap)
> >>> @@ -298,6 +315,11 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >>>             return PAGE_SIZE;
> >>>     }
> >>>
> >>> +   if (iomap->type == IOMAP_TAIL) {
> >>> +           iomap_read_tail_data(inode, page, iomap);
> >>> +           return PAGE_SIZE;
> >>> +   }
> >>> +
> >>>     /* zero post-eof blocks as the page may be mapped */
> >>>     iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
> >>>     if (plen == 0)
> >>> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> >>> index 2103b94cb1bf..7e1ee48e3db7 100644
> >>> --- a/include/linux/iomap.h
> >>> +++ b/include/linux/iomap.h
> >>> @@ -25,6 +25,7 @@ struct vm_fault;
> >>>  #define IOMAP_MAPPED       0x03    /* blocks allocated at @addr */
> >>>  #define IOMAP_UNWRITTEN    0x04    /* blocks allocated at @addr in unwritten state */
> >>>  #define IOMAP_INLINE       0x05    /* data inline in the inode */
> >>> +#define IOMAP_TAIL 0x06    /* tail data packed in metdata */
> >>>
> >>>  /*
> >>>   * Flags for all iomap mappings:
> >>>
> >> .
> >>
