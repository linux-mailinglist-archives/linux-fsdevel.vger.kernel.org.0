Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CC87A5266
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjIRS4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjIRS4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:56:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F40111
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 11:56:15 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b962c226ceso79577381fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695063373; x=1695668173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXz4cq66mHWtvTDRMK7RDIs9CKkcwkIB/OuEfXB14i8=;
        b=cWzT2L6gq0U8CHE4gMU/E2T1aUscXny7l5fWXEScREMS7yJB/jwsP/B+ePnugpPOYf
         tojZPUTB9nz4I31h3W35TTdFAFx0nUmQu7TkB9RrHybvoW1WU5dsV+VOUAHv5LaMNqEE
         tRtazd67n6ml/KGYdi5GqBl0eyP5r++jc98z8vNyOPSsofF98G0T26wJ9Z4nBfy/o+nG
         LT7rkPNAyOYZ+P//2r6nsBQ1PxYz8OcGNBjHKr+48zKb+DtlYtT5Dz2jM42vwNz8fa8P
         JdjYEcIzebUIB362VkO1kvkzI31jBSjeh8WxoDZcBgvE/pnrc05YhNY9DvEPEtJ+hupC
         KjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063373; x=1695668173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXz4cq66mHWtvTDRMK7RDIs9CKkcwkIB/OuEfXB14i8=;
        b=RRTibnezCSh+/ODCYrlf8ob0P7FqsVJ2quCFk6iY5lle3BwzrK6yyeXlmYpb2AYLyg
         JxB3aRIxmxlTdwSIEdw2PKq+iOnhJH0psyWC2KT8rj1Q4/r6+EDk9iigIeOqyCiD9RzD
         eVyfT37m3UBCyFBHsUOAyRpLB/mteDl2cQPvv0WWhkLaHs6bmOVbFvHKJrGicktF0Ujl
         xLNSKgE2eCSCeSJpA8LfMHBn8/DHtfdjJbY4iLI5BaOw5NJhETw4J1ViBkYqcFzQePCx
         kWUuv8DZmHudmEkmuzSvIpIEy5e+tpes+nwKfq6uq68gAiE0f13PKaIRBMIEcjtaStA3
         gtVw==
X-Gm-Message-State: AOJu0YyHQtCE9N1xx3qr1OKhxfNi8tivTrYn7a5jdb1zFV6pJ7n7Gt4w
        CDuA1JP20Lf+yOjCsdoGZohzWei3DqkbW79lX9EveA==
X-Google-Smtp-Source: AGHT+IEHASyFmV1bd4FBQakOmDWzBWx3Rbg9ZbcFyr5AJUmZLMEwiCsc+/HpjVvZHJQElwIa+nplDGt/Kg+T7jbrlPc=
X-Received: by 2002:a05:651c:210b:b0:2c0:1385:8c86 with SMTP id
 a11-20020a05651c210b00b002c013858c86mr2901745ljq.25.1695063373292; Mon, 18
 Sep 2023 11:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230915095133eucas1p267bade2888b7fcd2e1ea8e13e21c495f@eucas1p2.samsung.com>
 <20230915095042.1320180-1-da.gomez@samsung.com> <20230915095042.1320180-7-da.gomez@samsung.com>
 <CAJD7tkbU20tyGxtdL-cqJxrjf38ObG_dUttZdLstH3O2sUTKzw@mail.gmail.com> <20230918075758.vlufrhq22es2dhuu@sarkhan>
In-Reply-To: <20230918075758.vlufrhq22es2dhuu@sarkhan>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 18 Sep 2023 11:55:34 -0700
Message-ID: <CAJD7tkZSST8Kc6duUWt6a9igrsn=ucUPSVPWWGDWEUxBs3b4bg@mail.gmail.com>
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

On Mon, Sep 18, 2023 at 1:00=E2=80=AFAM Daniel Gomez <da.gomez@samsung.com>=
 wrote:
>
> On Fri, Sep 15, 2023 at 11:26:37AM -0700, Yosry Ahmed wrote:
> > On Fri, Sep 15, 2023 at 2:51=E2=80=AFAM Daniel Gomez <da.gomez@samsung.=
com> wrote:
> > >
> > > Add large folio support for shmem write path matching the same high
> > > order preference mechanism used for iomap buffered IO path as used in
> > > __filemap_get_folio().
> > >
> > > Use the __folio_get_max_order to get a hint for the order of the foli=
o
> > > based on file size which takes care of the mapping requirements.
> > >
> > > Swap does not support high order folios for now, so make it order 0 i=
n
> > > case swap is enabled.
> >
> > I didn't take a close look at the series, but I am not sure I
> > understand the rationale here. Reclaim will split high order shmem
> > folios anyway, right?
>
> For context, this is part of the enablement of large block sizes (LBS)
> effort [1][2][3], so the assumption here is that the kernel will
> reclaim memory with the same (large) block sizes that were written to
> the device.
>
> I'll add more context in the V2.
>
> [1] https://kernelnewbies.org/KernelProjects/large-block-size
> [2] https://docs.google.com/spreadsheets/d/e/2PACX-1vS7sQfw90S00l2rfOKm83=
Jlg0px8KxMQE4HHp_DKRGbAGcAV-xu6LITHBEc4xzVh9wLH6WM2lR0cZS8/pubhtml#
> [3] https://lore.kernel.org/all/ZQfbHloBUpDh+zCg@dread.disaster.area/
> >
> > It seems like we only enable high order folios if the "noswap" mount
> > option is used, which is fairly recent. I doubt it is widely used.
>
> For now, I skipped the swap path as it currently lacks support for
> high order folios. But I'm currently looking into it as part of the LBS
> effort (please check spreadsheet at [2] for that).

Thanks for the context, but I am not sure I understand.

IIUC we are skipping allocating large folios in shmem if swap is
enabled in this patch. Swap does not support swapping out large folios
as a whole (except THPs), but page reclaim will split those large
folios and swap them out as order-0 pages anyway. So I am not sure I
understand why we need to skip allocating large folios if swap is
enabled.


> >
> > >
> > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > ---
> > >  mm/shmem.c | 16 +++++++++++++---
> > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index adff74751065..26ca555b1669 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -1683,13 +1683,19 @@ static struct folio *shmem_alloc_folio(gfp_t =
gfp,
> > >  }
> > >
> > >  static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct in=
ode *inode,
> > > -               pgoff_t index, bool huge, unsigned int *order)
> > > +               pgoff_t index, bool huge, unsigned int *order,
> > > +               struct shmem_sb_info *sbinfo)
> > >  {
> > >         struct shmem_inode_info *info =3D SHMEM_I(inode);
> > >         struct folio *folio;
> > >         int nr;
> > >         int err;
> > >
> > > +       if (!sbinfo->noswap)
> > > +               *order =3D 0;
> > > +       else
> > > +               *order =3D (*order =3D=3D 1) ? 0 : *order;
> > > +
> > >         if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > >                 huge =3D false;
> > >         nr =3D huge ? HPAGE_PMD_NR : 1U << *order;
> > > @@ -2032,6 +2038,8 @@ static int shmem_get_folio_gfp(struct inode *in=
ode, pgoff_t index,
> > >                 return 0;
> > >         }
> > >
> > > +       order =3D mapping_size_order(inode->i_mapping, index, len);
> > > +
> > >         if (!shmem_is_huge(inode, index, false,
> > >                            vma ? vma->vm_mm : NULL, vma ? vma->vm_fla=
gs : 0))
> > >                 goto alloc_nohuge;
> > > @@ -2039,11 +2047,11 @@ static int shmem_get_folio_gfp(struct inode *=
inode, pgoff_t index,
> > >         huge_gfp =3D vma_thp_gfp_mask(vma);
> > >         huge_gfp =3D limit_gfp_mask(huge_gfp, gfp);
> > >         folio =3D shmem_alloc_and_acct_folio(huge_gfp, inode, index, =
true,
> > > -                                          &order);
> > > +                                          &order, sbinfo);
> > >         if (IS_ERR(folio)) {
> > >  alloc_nohuge:
> > >                 folio =3D shmem_alloc_and_acct_folio(gfp, inode, inde=
x, false,
> > > -                                                  &order);
> > > +                                                  &order, sbinfo);
> > >         }
> > >         if (IS_ERR(folio)) {
> > >                 int retry =3D 5;
> > > @@ -2147,6 +2155,8 @@ static int shmem_get_folio_gfp(struct inode *in=
ode, pgoff_t index,
> > >         if (folio_test_large(folio)) {
> > >                 folio_unlock(folio);
> > >                 folio_put(folio);
> > > +               if (order > 0)
> > > +                       order--;
> > >                 goto alloc_nohuge;
> > >         }
> > >  unlock:
> > > --
> > > 2.39.2
> > >
