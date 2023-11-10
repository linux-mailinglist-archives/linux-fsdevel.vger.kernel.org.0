Return-Path: <linux-fsdevel+bounces-2706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3795D7E79D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 08:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA8C2816B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5B6FD0;
	Fri, 10 Nov 2023 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWuwp4bm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DAA6ABB
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 07:48:20 +0000 (UTC)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7123186B5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 23:48:19 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-45da062101bso824586137.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 23:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699602498; x=1700207298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iiC78e6+ZJ3Pewjf0JiBNivCAkbOmRohLcjfJ+Rglw=;
        b=AWuwp4bmoPI+GTsbLf4TdVMkgMCOW6Rl9AANR5uo7FI3ea4h6pQvF4U+3LAz5jUjGt
         7EXbeS4n6C5x3PrCmkXMQpyUOy0EVMHroSVEPPH0LhcJyzV6uAAHQtL+4Ipk30/qjVAV
         rThgo6NEn4p9DtThq0LujdtlUfFCSUX/1Zv7sZvP/Umdze4+AMD/Ig/96pEDdDaXVd8b
         8ZkleBsN1tKD6swDYyQ8bf5mkWUqp1vm9FNBybJ9ZpVHSJMAcl4AV5QrH/QhfKs6uGx0
         cfY9MBw+Ga8hoOj+VsABZAyAdBLEFqd5I87Ag7wQ9hXYmXiPikOYBVl01qW1xpqczT1V
         N/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699602498; x=1700207298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iiC78e6+ZJ3Pewjf0JiBNivCAkbOmRohLcjfJ+Rglw=;
        b=QrsseHCjLGnEiO8Rz9u9wokJLvcTEFA1i20gtUTkI7KvwSFnFxHp/pLc4HCRyP2C/b
         36/nrAtTkOzN9dEj8sd1SKoFqoNoPOP4tghzWAjTxDbuMFvDCDx5uQFeZAHrorLz4fhA
         CSpYWh8FdRlDgon4QRGF0ORJ3OF3EhGXEPJP7Y8l6UNBvEYCphqpsDf1F36BegUxXBS2
         gLHdv85FfcSgurU0iA8ZWtHKvnT5nEsyBqLoD0osGSH38Cvnd+wQulipmAGmu2j7lqZF
         u1hYFGcozhtz/x5ANj7maSE48rJhZzS1IstS6g401a/jQPv4Z8FY8RkOSomI3agSoxr2
         p84g==
X-Gm-Message-State: AOJu0Yzb6ecGIFs+KZBco0kNb03oEU9JpDDgPzEIJGa0tRNlIBkoLr+M
	9qqwE9O5buQoIhSkcEkPMWq4koKad/6dF9UaaJ/Z+9JzIa4=
X-Google-Smtp-Source: AGHT+IEuaBZ58Ew4O8rfCdIOsaIzcEvLiaCqe+1EO5koe9HplB3HUTReR78FkErhEKQalmF2I3PIm3dCFA1Qy/REMNk=
X-Received: by 2002:a67:c29c:0:b0:45d:9113:328f with SMTP id
 k28-20020a67c29c000000b0045d9113328fmr7302203vsj.34.1699602498505; Thu, 09
 Nov 2023 23:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109210608.2252323-1-willy@infradead.org> <20231109210608.2252323-6-willy@infradead.org>
In-Reply-To: <20231109210608.2252323-6-willy@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 10 Nov 2023 16:48:02 +0900
Message-ID: <CAKFNMokuZFWqoX_1uWm0-vTcbo_gESkNpv8J8Pw1G-Vwd=-D+w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] buffer: Fix various functions for block size > PAGE_SIZE
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hannes Reinecke <hare@suse.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 6:06=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
>
> If i_blkbits is larger than PAGE_SHIFT, we shift by a negative number,
> which is undefined.  It is safe to shift the block left as a block
> device must be smaller than MAX_LFS_FILESIZE, which is guaranteed to
> fit in loff_t.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/buffer.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ab345fd4da12..faf1916200c2 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -199,7 +199,7 @@ __find_get_block_slow(struct block_device *bdev, sect=
or_t block)
>         int all_mapped =3D 1;
>         static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
>
> -       index =3D block >> (PAGE_SHIFT - bd_inode->i_blkbits);
> +       index =3D ((loff_t)block << bd_inode->i_blkbits) / PAGE_SIZE;

Multiple 64-bit divisions are used in this patch, but why not use two
stage shifts as shown below if there is no left shift overflow and the
sign bit will not be set ?

       index =3D ((loff_t)block << bd_inode->i_blkbits) >> PAGE_SHIFT;

Regards,
Ryusuke Konishi

>         folio =3D __filemap_get_folio(bd_mapping, index, FGP_ACCESSED, 0)=
;
>         if (IS_ERR(folio))
>                 goto out;
> @@ -1693,13 +1693,13 @@ void clean_bdev_aliases(struct block_device *bdev=
, sector_t block, sector_t len)
>         struct inode *bd_inode =3D bdev->bd_inode;
>         struct address_space *bd_mapping =3D bd_inode->i_mapping;
>         struct folio_batch fbatch;
> -       pgoff_t index =3D block >> (PAGE_SHIFT - bd_inode->i_blkbits);
> +       pgoff_t index =3D ((loff_t)block << bd_inode->i_blkbits) / PAGE_S=
IZE;
>         pgoff_t end;
>         int i, count;
>         struct buffer_head *bh;
>         struct buffer_head *head;
>
> -       end =3D (block + len - 1) >> (PAGE_SHIFT - bd_inode->i_blkbits);
> +       end =3D ((loff_t)(block + len - 1) << bd_inode->i_blkbits) / PAGE=
_SIZE;
>         folio_batch_init(&fbatch);
>         while (filemap_get_folios(bd_mapping, &index, end, &fbatch)) {
>                 count =3D folio_batch_count(&fbatch);
> @@ -2660,8 +2660,8 @@ int block_truncate_page(struct address_space *mappi=
ng,
>                 return 0;
>
>         length =3D blocksize - length;
> -       iblock =3D (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
> -
> +       iblock =3D ((loff_t)index * PAGE_SIZE) >> inode->i_blkbits;
> +
>         folio =3D filemap_grab_folio(mapping, index);
>         if (IS_ERR(folio))
>                 return PTR_ERR(folio);
> --
> 2.42.0
>
>

