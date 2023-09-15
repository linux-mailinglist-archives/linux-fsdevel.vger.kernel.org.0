Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336D57A25B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjIOS2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjIOS21 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:28:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166C5271C
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 11:27:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso2841853a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694802436; x=1695407236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TVRLEu9EJ9mGV2bipP8Xm97KGB9uZNTupnuQjSJdsE=;
        b=sKKT+kRRXdqHAoUZgMTugOxbcrbgqDgkkXjasxrWctWJd77Sw8TlsGuTd98pSRft9A
         jN/MMQ3oP4/QuTKHBD9/YypfLSNU+2cuvu8u73JxBHsdsSFjo1rojX5WJRXSO1lIrr4X
         Q/i++DKlLWUNrBbI96a2DUSv9ydwwnivZJKP06X04/cK0r2bQFBArjWiQF6VYJBobiMX
         PGK/u5s+F2yWQLPEdRhYCODQlNQ8S+qDRhy7Nh2noe1XmCVyac1kWiIlCNg4DMBP7SEd
         a3S1lxEG5glLqSDYO5PGcLNoSDLKwOIaoa1Db4onOn/2goDJ5rYfzEFwI2eODMv2KWvJ
         JQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802436; x=1695407236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TVRLEu9EJ9mGV2bipP8Xm97KGB9uZNTupnuQjSJdsE=;
        b=fdGZIz0vpF4yXcxvrgLcjRObObUAXyZuhdFGC/bIfIBvx3XBXzgbF6Qy3cChzysASN
         75njy9v4jLnOJ3i/V/9Q0w5e+H3LE7YkbCUF2iTtaqwsi8SESEumTjguZAkpC991O1Ku
         bhqK+9cVGQXyM5j1Zq/TPuF9SzaRrm5MptCKr7iaPnBMluIBWcKpspB+90leB4SVB9YD
         r/YLPBnqzf8kWquQPxv+946NkeiZbHf9al8JhwkjBcd8eTdubyezjiiEfbjW6hrzpci7
         z0peO0hW6MblXOJW3vzRpG/CSb+ul/h5yiyZWbgtHAa4rDC5JtEMJidlFNTaryMtd8rj
         DU1w==
X-Gm-Message-State: AOJu0YzQpnlg1wl5iatQlJWnUOdyfdINxZdLa+ka/ZKroaboDBY3M+U5
        brLmlkNkXHujELmr+4xZD9LMZPdHGJY2I8Bjx+H4MA==
X-Google-Smtp-Source: AGHT+IHg0l+d+9eXrE3JQYT1rNSzTJ30WS4x3AxsO8Su5H91K9tA7o+8Ltb2jJoMejIzZEOsQjI7O6t5d3aHWeK0K/E=
X-Received: by 2002:a17:907:75fb:b0:9a1:f3a6:b906 with SMTP id
 jz27-20020a17090775fb00b009a1f3a6b906mr2140406ejc.36.1694802436299; Fri, 15
 Sep 2023 11:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f@eucas1p2.samsung.com>
 <20230915095042.1320180-1-da.gomez@samsung.com> <20230915095042.1320180-7-da.gomez@samsung.com>
In-Reply-To: <20230915095042.1320180-7-da.gomez@samsung.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 15 Sep 2023 11:26:37 -0700
Message-ID: <CAJD7tkbU20tyGxtdL-cqJxrjf38ObG_dUttZdLstH3O2sUTKzw@mail.gmail.com>
Subject: Re: [PATCH 6/6] shmem: add large folios support to the write path
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 2:51=E2=80=AFAM Daniel Gomez <da.gomez@samsung.com>=
 wrote:
>
> Add large folio support for shmem write path matching the same high
> order preference mechanism used for iomap buffered IO path as used in
> __filemap_get_folio().
>
> Use the __folio_get_max_order to get a hint for the order of the folio
> based on file size which takes care of the mapping requirements.
>
> Swap does not support high order folios for now, so make it order 0 in
> case swap is enabled.

I didn't take a close look at the series, but I am not sure I
understand the rationale here. Reclaim will split high order shmem
folios anyway, right?

It seems like we only enable high order folios if the "noswap" mount
option is used, which is fairly recent. I doubt it is widely used.

>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  mm/shmem.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index adff74751065..26ca555b1669 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1683,13 +1683,19 @@ static struct folio *shmem_alloc_folio(gfp_t gfp,
>  }
>
>  static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode =
*inode,
> -               pgoff_t index, bool huge, unsigned int *order)
> +               pgoff_t index, bool huge, unsigned int *order,
> +               struct shmem_sb_info *sbinfo)
>  {
>         struct shmem_inode_info *info =3D SHMEM_I(inode);
>         struct folio *folio;
>         int nr;
>         int err;
>
> +       if (!sbinfo->noswap)
> +               *order =3D 0;
> +       else
> +               *order =3D (*order =3D=3D 1) ? 0 : *order;
> +
>         if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>                 huge =3D false;
>         nr =3D huge ? HPAGE_PMD_NR : 1U << *order;
> @@ -2032,6 +2038,8 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>                 return 0;
>         }
>
> +       order =3D mapping_size_order(inode->i_mapping, index, len);
> +
>         if (!shmem_is_huge(inode, index, false,
>                            vma ? vma->vm_mm : NULL, vma ? vma->vm_flags :=
 0))
>                 goto alloc_nohuge;
> @@ -2039,11 +2047,11 @@ static int shmem_get_folio_gfp(struct inode *inod=
e, pgoff_t index,
>         huge_gfp =3D vma_thp_gfp_mask(vma);
>         huge_gfp =3D limit_gfp_mask(huge_gfp, gfp);
>         folio =3D shmem_alloc_and_acct_folio(huge_gfp, inode, index, true=
,
> -                                          &order);
> +                                          &order, sbinfo);
>         if (IS_ERR(folio)) {
>  alloc_nohuge:
>                 folio =3D shmem_alloc_and_acct_folio(gfp, inode, index, f=
alse,
> -                                                  &order);
> +                                                  &order, sbinfo);
>         }
>         if (IS_ERR(folio)) {
>                 int retry =3D 5;
> @@ -2147,6 +2155,8 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>         if (folio_test_large(folio)) {
>                 folio_unlock(folio);
>                 folio_put(folio);
> +               if (order > 0)
> +                       order--;
>                 goto alloc_nohuge;
>         }
>  unlock:
> --
> 2.39.2
>
