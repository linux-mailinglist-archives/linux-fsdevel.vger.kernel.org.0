Return-Path: <linux-fsdevel+bounces-2702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB4E7E797A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 07:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06715B2105B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 06:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723361FAB;
	Fri, 10 Nov 2023 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyA6wDm2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23F15B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 06:38:17 +0000 (UTC)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33A27A81
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:38:15 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-45d9ceeb8b8so811178137.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 22:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699598295; x=1700203095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jH5IhpgEzfdurHerG2NpsqVrKF1YGxTuMxeW0D7XPb0=;
        b=MyA6wDm2gDyyUXKUXmheHdxfhI80OqEHl7F1MJIWn0Qkj3+5FRVK7ERmfkiBMk7IbM
         4ujAlaSfNBJu6h/ONX7ll2qkeH4HuwkgBdu0jSGK62xePbBV9SMOwxrcG0y1LEQqwv+r
         RBPsOIVFACaVehK6mOEOzu5+DZf1Cd3KJXDXc2sLCwcE2QEEGwuCjVlIhy+7Hy3clnHn
         6u9miXS/Y+uUSA4SwLsjyCiWkrxaGE+DkWCsfTnFoNyPy3VfatVUgm3Q+dlENWFV4+Mq
         e84jyuUy53tn0JkwYc3eLrs/9YkyocZ8jNeE/w4cBhZVnqD9xXiJ5kz6LAcHdo6NeqKZ
         pEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598295; x=1700203095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jH5IhpgEzfdurHerG2NpsqVrKF1YGxTuMxeW0D7XPb0=;
        b=ZrzsP0QiIZyQPwmTi1w8bXgous8nIEKw4Jv5AbgrZquQahfCrCTjdQQa+grvgpsjdM
         oIcNP2EBrBGNGlVoKmpqXjIzGwKzcsQITQyCzWlzTGlj8eTosk5m7oXGpUeD3Y70BF85
         zdTZaXGjaDcsXJqeiBk30oOKflXwN/qV2uVF3WFDT6Vczf8mn1IyBetb3epwUQqdBLQA
         VSRMwt8zyc+2yeSEpWSA/5G/SVFaTPSG3OTLJtrmpMJQHtXut5p9331Oy4GuOmYAUQhU
         58mCY8EQ/kSt2BJQxx7Am7LMImdIDpDKNhS+Qx+J9ExP866idMoxBPnG9Wv+hQoCDRO9
         H1CA==
X-Gm-Message-State: AOJu0YxsCgqscM4MTyF3RAt8suJMxwYp2tKyHsKCoU67xELJyMAQRjZr
	SD9cIuG9V09VfVJrsUsBdI8/mR6uex/+rBC0GRQ=
X-Google-Smtp-Source: AGHT+IGigyiTnZywsmBA0eHX8ZlKjuzXGXnEzQbMn5ItBVvOwRRo4YwlcrFeAMFg5VRN3kC3xIY0ijLoROJQRuzQ/YU=
X-Received: by 2002:a67:e782:0:b0:45d:9083:f876 with SMTP id
 hx2-20020a67e782000000b0045d9083f876mr8012968vsb.6.1699598294917; Thu, 09 Nov
 2023 22:38:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109210608.2252323-1-willy@infradead.org> <20231109210608.2252323-4-willy@infradead.org>
In-Reply-To: <20231109210608.2252323-4-willy@infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 10 Nov 2023 15:37:58 +0900
Message-ID: <CAKFNMokB=jtjLTnu_qTKUvCbrxACq3X2+gQzJOqJkB68pO_Ogg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] buffer: Fix grow_buffers() for block size > PAGE_SIZE
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hannes Reinecke <hare@suse.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 6:06=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
>
> We must not shift by a negative number so work in terms of a byte
> offset to avoid the awkward shift left-or-right-depending-on-sign
> option.  This means we need to use check_mul_overflow() to ensure
> that a large block number does not result in a wrap.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/buffer.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 44e0c0b7f71f..9c3f49cf8d28 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1085,26 +1085,21 @@ static bool grow_dev_folio(struct block_device *b=
dev, sector_t block,
>  static bool grow_buffers(struct block_device *bdev, sector_t block,
>                 unsigned size, gfp_t gfp)
>  {
> -       pgoff_t index;
> -       int sizebits;
> -
> -       sizebits =3D PAGE_SHIFT - __ffs(size);
> -       index =3D block >> sizebits;
> +       loff_t pos;
>
>         /*
> -        * Check for a block which wants to lie outside our maximum possi=
ble
> -        * pagecache index.  (this comparison is done using sector_t type=
s).
> +        * Check for a block which lies outside our maximum possible
> +        * pagecache index.
>          */
> -       if (unlikely(index !=3D block >> sizebits)) {
> -               printk(KERN_ERR "%s: requested out-of-range block %llu fo=
r "
> -                       "device %pg\n",
> +       if (check_mul_overflow(block, size, &pos) || pos > MAX_LFS_FILESI=
ZE) {
> +               printk(KERN_ERR "%s: requested out-of-range block %llu fo=
r device %pg\n",
>                         __func__, (unsigned long long)block,
>                         bdev);
>                 return false;
>         }
>
>         /* Create a folio with the proper size buffers */
> -       return grow_dev_folio(bdev, block, index, size, gfp);

> +       return grow_dev_folio(bdev, block, pos / PAGE_SIZE, size, gfp);

"pos" has a loff_t type (=3D long long type).
Was it okay to do C division directly on 32-bit architectures?

Regards,
Ryusuke Konishi

>  }
>
>  static struct buffer_head *
> --
> 2.42.0
>
>

