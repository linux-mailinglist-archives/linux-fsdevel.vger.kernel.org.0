Return-Path: <linux-fsdevel+bounces-2672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767957E7834
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 04:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BBBB21039
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 03:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F61852;
	Fri, 10 Nov 2023 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGDwh5U3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011D517E8
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 03:44:00 +0000 (UTC)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8125444BD
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 19:44:00 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7ba170ac211so663998241.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 19:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699587839; x=1700192639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuFoI2Na3rqFjozzgKTbKsyvOJ0n/F0y8lqQAccbUmM=;
        b=JGDwh5U3ZvT7QiXFf0/9oELPNvP5jOWbaGhLp7tx9pXjm1SWjw6sFLEg0ALU46WjqF
         6OH8fVcmznZCfrEn3ypMBJGYAE+nHh24TO2IFwC+U+bCf+PU0eggB7jLTozws3L0ZtuC
         laxlbO0iH0heWw+l8NsR1i8bFjNCs3AsOBYMPYRbU7gx0He1QxAkZRXieJXnehiUmbt9
         9Xg5hK1l88w4+P0bKX3O600AyAUuwuFaSfp6wWy8us5Ne2mPiemGFghvgrJtAQZ0yxNt
         3t9PkD6lbkyAiSA9Yj7tRVyAI4pDB9D8NDlwcW4+lnunHJ44auqJXoKpNb0k0/EFcKJE
         nWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699587839; x=1700192639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuFoI2Na3rqFjozzgKTbKsyvOJ0n/F0y8lqQAccbUmM=;
        b=mei+vRK+18EI5xbjJRNvxX2jK6CVe8pskPagJSy1LqsazXUtHxUbmohoR7BuF9P0Wx
         H9z2ZwNycebQCRiYlCJ1VDbq2oJClUbaaWwKQTW7Ul8cCylYw/zVdQs5WRboeBPSR2qe
         Wi/vhEtLaKdzWnw0tQEBwLM4nMRKpCZ4FdAY9BtqbPp9Gi8lT62+1RSZGuOQ0+JvX4r3
         JaueU4+SQg6NsNjfGx73AY/PAooARGxLLk3VpSnIOGBFwbEEVirs9B6HdSe93L6Nfj3+
         lCPis5pIQUWXLBMkLZ3q1Mc9ka+TSdCj85Odiw82fE0T27I2Cymmo4OgXPQelUcil8Yd
         ndvw==
X-Gm-Message-State: AOJu0Yxfyi4aaLmYXDpr5U7H2JtHHbdi3lb/zaguQWcDY3xZi4T5HDBq
	bOwkePgxFsdVPim7RVefjE3wpmsn3U6zE0vsnUwLM06+6uw=
X-Google-Smtp-Source: AGHT+IGGXTarWmCUIUNavfSsRKMw8vbhwTWEYJXQ7rrTgieopNbo8hZMdsnMudRkoM4SqO2vKhXzKiJmrnL4pU7wug0=
X-Received: by 2002:a67:cc0a:0:b0:45d:9d0c:2e07 with SMTP id
 q10-20020a67cc0a000000b0045d9d0c2e07mr6984808vsl.6.1699587839496; Thu, 09 Nov
 2023 19:43:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109210608.2252323-1-willy@infradead.org> <20231109210608.2252323-2-willy@infradead.org>
In-Reply-To: <20231109210608.2252323-2-willy@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 10 Nov 2023 12:43:43 +0900
Message-ID: <CAKFNMo=1yLxL9RR4XBY6=SkWej7tstTEiFQjUFWjxMs+5=YPFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] buffer: Return bool from grow_dev_folio()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hannes Reinecke <hare@suse.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 6:07=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
>
> Rename grow_dev_page() to grow_dev_folio() and make it return a bool.
> Document what that bool means; it's more subtle than it first appears.
> Also rename the 'failed' label to 'unlock' beacuse it's not exactly
> 'failed'.  It just hasn't succeeded.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/buffer.c | 50 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 967f34b70aa8..8dad6c691e14 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1024,40 +1024,43 @@ static sector_t folio_init_buffers(struct folio *=
folio,
>  }
>
>  /*
> - * Create the page-cache page that contains the requested block.
> + * Create the page-cache folio that contains the requested block.
>   *
>   * This is used purely for blockdev mappings.
> + *
> + * Returns false if we have a 'permanent' failure.  Returns true if
> + * we succeeded, or the caller should retry.
>   */
> -static int
> -grow_dev_page(struct block_device *bdev, sector_t block,
> -             pgoff_t index, int size, int sizebits, gfp_t gfp)
> +static bool grow_dev_folio(struct block_device *bdev, sector_t block,
> +               pgoff_t index, unsigned size, int sizebits, gfp_t gfp)
>  {
>         struct inode *inode =3D bdev->bd_inode;
>         struct folio *folio;
>         struct buffer_head *bh;
> -       sector_t end_block;
> -       int ret =3D 0;
> +       sector_t end_block =3D 0;
>
>         folio =3D __filemap_get_folio(inode->i_mapping, index,
>                         FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
>         if (IS_ERR(folio))
> -               return PTR_ERR(folio);
> +               return false;
>
>         bh =3D folio_buffers(folio);
>         if (bh) {
>                 if (bh->b_size =3D=3D size) {
>                         end_block =3D folio_init_buffers(folio, bdev,
>                                         (sector_t)index << sizebits, size=
);
> -                       goto done;
> +                       goto unlock;
>                 }
> +
> +               /* Caller should retry if this call fails */
> +               end_block =3D ~0ULL;
>                 if (!try_to_free_buffers(folio))
> -                       goto failed;
> +                       goto unlock;
>         }
>

> -       ret =3D -ENOMEM;
>         bh =3D folio_alloc_buffers(folio, size, gfp | __GFP_ACCOUNT);
>         if (!bh)
> -               goto failed;
> +               goto unlock;

Regarding this folio_alloc_buffers() error path,
If folio_buffers() was NULL, here end_block is 0, so this function
returns false (which means "have a permanent failure").

But, if folio_buffers() existed and they were freed with
try_to_free_buffers() because of bh->b_size !=3D size, here end_block
has been set to ~0ULL, so it seems to return true ("succeeded").

Does this semantic change match your intent?

Otherwise, I think end_block should be set to 0 just before calling
folio_alloc_buffers().

Regards,
Ryusuke Konishi

>
>         /*
>          * Link the folio to the buffers and initialise them.  Take the
> @@ -1069,20 +1072,19 @@ grow_dev_page(struct block_device *bdev, sector_t=
 block,
>         end_block =3D folio_init_buffers(folio, bdev,
>                         (sector_t)index << sizebits, size);
>         spin_unlock(&inode->i_mapping->private_lock);
> -done:
> -       ret =3D (block < end_block) ? 1 : -ENXIO;
> -failed:
> +unlock:
>         folio_unlock(folio);
>         folio_put(folio);
> -       return ret;
> +       return block < end_block;
>  }
>
>  /*
> - * Create buffers for the specified block device block's page.  If
> - * that page was dirty, the buffers are set dirty also.
> + * Create buffers for the specified block device block's folio.  If
> + * that folio was dirty, the buffers are set dirty also.  Returns false
> + * if we've hit a permanent error.
>   */
> -static int
> -grow_buffers(struct block_device *bdev, sector_t block, int size, gfp_t =
gfp)
> +static bool grow_buffers(struct block_device *bdev, sector_t block,
> +               unsigned size, gfp_t gfp)
>  {
>         pgoff_t index;
>         int sizebits;
> @@ -1099,11 +1101,11 @@ grow_buffers(struct block_device *bdev, sector_t =
block, int size, gfp_t gfp)
>                         "device %pg\n",
>                         __func__, (unsigned long long)block,
>                         bdev);
> -               return -EIO;
> +               return false;
>         }
>
> -       /* Create a page with the proper size buffers.. */
> -       return grow_dev_page(bdev, block, index, size, sizebits, gfp);
> +       /* Create a folio with the proper size buffers */
> +       return grow_dev_folio(bdev, block, index, size, sizebits, gfp);
>  }
>
>  static struct buffer_head *
> @@ -1124,14 +1126,12 @@ __getblk_slow(struct block_device *bdev, sector_t=
 block,
>
>         for (;;) {
>                 struct buffer_head *bh;
> -               int ret;
>
>                 bh =3D __find_get_block(bdev, block, size);
>                 if (bh)
>                         return bh;
>
> -               ret =3D grow_buffers(bdev, block, size, gfp);
> -               if (ret < 0)
> +               if (!grow_buffers(bdev, block, size, gfp))
>                         return NULL;
>         }
>  }
> --
> 2.42.0
>
>

