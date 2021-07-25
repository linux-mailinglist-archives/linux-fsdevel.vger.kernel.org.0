Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704E33D5029
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jul 2021 23:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhGYU7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jul 2021 16:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGYU7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jul 2021 16:59:34 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F65C061757;
        Sun, 25 Jul 2021 14:40:03 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id l126so9415454ioa.12;
        Sun, 25 Jul 2021 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8N2idTt3koqse72Yl74x+xxuDdMO4ULLt5JkM0YAoM=;
        b=jiTMOw6D+zBqM0I6CP9tirn/UVvd5jdwfd9RO5E4J96x0YOIce2j75yuAIU/Wx2eiO
         aQKe4ByT32OSnNByKqfDAkG3TpOonuDZimMe5r/R8KrexgNwpNT9ITK0ALnSWpNhbL6C
         ++b3ht9CrAcxZQP52BN3koJ0lZViUEkcSoU6KIA7HpH025tT0bg4uv+i4k7HF5at+pib
         G3Y49g/1WyuW+GZhYCeVHkKzxI5UvU/YScgVpfIFkNpCcS2a5cTFAE3QH9U7R3iikMTO
         rOrmrimERIPBPezbMV3WE+ksCWcTuTZSU4a2tKgRi+Rlq19gAOTh1SVZpqvO7NHuhuxM
         u+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8N2idTt3koqse72Yl74x+xxuDdMO4ULLt5JkM0YAoM=;
        b=EBSNPXUIjNcgZc9BKTohXAPdCOlmh1O47Um9xoTU8WuJDkMBbVm+BNMM82/PPqbmH1
         IN8QFcIMfeA1QLnWFd5zsLaZ7bHjaL4rBItq5K+2xmSaWnq3uuZvXwR8gu60vi05Ugp8
         CUIdx6I46K3j8RC0nW9/ESFZibFIfIdwMO9Y/thft0LWVPvsP6QuXAPakBI1SxHE92aB
         9MSbanZdW8zEzD84xfgoQ8Uqy6nsphnZKNLQdXk+E9r2u5RvQD5nsoa28rhNkVanhPcj
         2nqq3F3KJf2HZz7IXC3j4Eg9bA3cqAdiaeu76idE4XhbgR4T/y/AfRd2cxGWN+9yDhea
         9ZUw==
X-Gm-Message-State: AOAM531d2VW3oR1BcJv5CD2fU4zMm/YUFFxyWym6tm0dDk87vR+nUx6L
        0SQDC/uRc2cYGJXga3LYpXXvxNPzpG/eX/9j+wH3lxnv
X-Google-Smtp-Source: ABdhPJzk/Oj/RPTtXb3Jv/kizeBU59TDKSIbyA9Q0/T7y8SK1OisClHf4ZhF8yBE20iV2GK2xlKbTI0J26Xz26lXrk4=
X-Received: by 2002:a05:6638:22f:: with SMTP id f15mr13383793jaq.141.1627249202569;
 Sun, 25 Jul 2021 14:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Sun, 25 Jul 2021 23:39:51 +0200
Message-ID: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Fr., 23. Juli 2021 um 19:41 Uhr schrieb Gao Xiang
<hsiangkao@linux.alibaba.com>:
> Add support for reading inline data content into the page cache from
> nonzero page-aligned file offsets.  This enables the EROFS tailpacking
> mode where the last few bytes of the file are stored right after the
> inode.
>
> The buffered write path remains untouched since EROFS cannot be used
> for testing. It'd be better to be implemented if upcoming real users
> care and provide a real pattern rather than leave untested dead code
> around.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v6: https://lore.kernel.org/r/20210722031729.51628-1-hsiangkao@linux.alibaba.com
> changes since v6:
>  - based on Christoph's reply;
>  - update commit message suggested by Darrick;
>  - disable buffered write path until some real fs users.
>
>  fs/iomap/buffered-io.c | 42 ++++++++++++++++++++++++++----------------
>  fs/iomap/direct-io.c   | 10 ++++++----
>  include/linux/iomap.h  | 14 ++++++++++++++
>  3 files changed, 46 insertions(+), 20 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 87ccb3438bec..f351e1f9e3f6 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -205,25 +205,29 @@ struct iomap_readpage_ctx {
>         struct readahead_control *rac;
>  };
>
> -static void
> -iomap_read_inline_data(struct inode *inode, struct page *page,
> -               struct iomap *iomap)
> +static int iomap_read_inline_data(struct inode *inode, struct page *page,
> +               struct iomap *iomap, loff_t pos)

This is completely broken. This function is about filling the page
cache. All the information needed for that is in struct iomap; the
start position of an iomap operation has nothing to do with it.

>  {
> -       size_t size = i_size_read(inode);
> +       size_t size = iomap->length + iomap->offset - pos;
>         void *addr;
>
>         if (PageUptodate(page))
> -               return;
> +               return PAGE_SIZE;
>
> -       BUG_ON(page_has_private(page));
> -       BUG_ON(page->index);
> -       BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       /* inline data must start page aligned in the file */
> +       if (WARN_ON_ONCE(offset_in_page(pos)))
> +               return -EIO;
> +       if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
> +               return -EIO;
> +       if (WARN_ON_ONCE(page_has_private(page)))
> +               return -EIO;
>
>         addr = kmap_atomic(page);
> -       memcpy(addr, iomap->inline_data, size);
> +       memcpy(addr, iomap_inline_buf(iomap, pos), size);
>         memset(addr + size, 0, PAGE_SIZE - size);
>         kunmap_atomic(addr);
>         SetPageUptodate(page);
> +       return PAGE_SIZE;
>  }
>
>  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> @@ -246,11 +250,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>         unsigned poff, plen;
>         sector_t sector;
>
> -       if (iomap->type == IOMAP_INLINE) {
> -               WARN_ON_ONCE(pos);
> -               iomap_read_inline_data(inode, page, iomap);
> -               return PAGE_SIZE;
> -       }
> +       if (iomap->type == IOMAP_INLINE)
> +               return iomap_read_inline_data(inode, page, iomap, pos);
>
>         /* zero post-eof blocks as the page may be mapped */
>         iop = iomap_page_create(inode, page);
> @@ -589,6 +590,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>         return 0;
>  }
>
> +static int iomap_write_begin_inline(struct inode *inode,
> +               struct page *page, struct iomap *srcmap)
> +{
> +       /* needs more work for the tailpacking case, disable for now */
> +       if (WARN_ON_ONCE(srcmap->offset != 0))
> +               return -EIO;
> +       return iomap_read_inline_data(inode, page, srcmap, 0);
> +}
> +
>  static int
>  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>                 struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> @@ -618,14 +628,14 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>         }
>
>         if (srcmap->type == IOMAP_INLINE)
> -               iomap_read_inline_data(inode, page, srcmap);
> +               status = iomap_write_begin_inline(inode, page, srcmap);
>         else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>                 status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>         else
>                 status = __iomap_write_begin(inode, pos, len, flags, page,
>                                 srcmap);
>
> -       if (unlikely(status))
> +       if (unlikely(status < 0))
>                 goto out_unlock;
>
>         *pagep = page;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..a6aaea2764a5 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -378,23 +378,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>                 struct iomap_dio *dio, struct iomap *iomap)
>  {
>         struct iov_iter *iter = dio->submit.iter;
> +       void *dst = iomap_inline_buf(iomap, pos);
>         size_t copied;
>
> -       BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
> +               return -EIO;
>
>         if (dio->flags & IOMAP_DIO_WRITE) {
>                 loff_t size = inode->i_size;
>
>                 if (pos > size)
> -                       memset(iomap->inline_data + size, 0, pos - size);
> -               copied = copy_from_iter(iomap->inline_data + pos, length, iter);
> +                       memset(iomap_inline_buf(iomap, size), 0, pos - size);
> +               copied = copy_from_iter(dst, length, iter);
>                 if (copied) {
>                         if (pos + copied > size)
>                                 i_size_write(inode, pos + copied);
>                         mark_inode_dirty(inode);
>                 }
>         } else {
> -               copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> +               copied = copy_to_iter(dst, length, iter);
>         }
>         dio->size += copied;
>         return copied;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 479c1da3e221..56b118c6d05c 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -97,6 +97,20 @@ iomap_sector(struct iomap *iomap, loff_t pos)
>         return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
>  }
>
> +static inline void *iomap_inline_buf(const struct iomap *iomap, loff_t pos)
> +{
> +       return iomap->inline_data - iomap->offset + pos;
> +}
> +
> +/*
> + * iomap->inline_data is a potentially kmapped page, ensure it never crosses a
> + * page boundary.
> + */
> +static inline bool iomap_inline_data_size_valid(const struct iomap *iomap)
> +{
> +       return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
> +}
> +
>  /*
>   * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
>   * and page_done will be called for each page written to.  This only applies to
> --
> 2.24.4
>

Andreas
