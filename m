Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE906F49CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 20:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjEBSjF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 14:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjEBSjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 14:39:03 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BE21988
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 11:39:01 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9d9dad9edfso5358284276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683052740; x=1685644740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OMnp8U2QsJWbp6tha1jAHM6ardwied5yoCJwV56xmU=;
        b=3ehzpeirHytbRrfF5r15fGVpzpJxZb0E9v2Om0wdN+yxZYUTa6qWTLOkd2mbDRoF7W
         pnmov0ApI+qMvdAzFDA6SgZGTRYRpWWsYOopta6Rj30LnCXbPu9oQBdK0uh0n1fbuy01
         vsylwS4eNoSnK4OdPa0qDxCeqjOu7PunOoJTEi+RY4izp9SK5YNPQKHVdbCsFRn4WM2A
         p7jtWEQHZwcMmuy2lRysHMVwpnEcRz/iqKNa76N07gsayvlYQtmcsOsujw7J6qYIBTdy
         xedsqCxK32iKWHMMSwGqO7eBE4zSMlkGqF+0tcmMmy368s/N5nkgeAf/BqbdsSOgzCG8
         xgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683052740; x=1685644740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OMnp8U2QsJWbp6tha1jAHM6ardwied5yoCJwV56xmU=;
        b=Ucm3xRrXEuSc5GnjNqdOgHX4BsB+XkStfA59x4QPUAsMCmXGGDhla5mOcE/I01Igog
         oqDDUHO2TdMbVs+44yp6S6dzDNfzXPEVVfdghZIcRjb00IYGm9pizOV3hzBMtNhJdMIp
         cjaWoQj5orGxav09Jkpyo2cK9wg+7wX7Hrdsu2uMnqsir3dM4Wg3+m76QaAgp/0orApL
         af4KH9mn4BvA+DaJmU81lCBLxN1hOSlOgiU4tQDO0JG9EJUtOpgcs/x5kXqiJ+K2UzE/
         HIe2v9hfxVpeDql8tMTm7Y/fm1FQd4pzrmzgcuCQOHun1SypkYXe3oB6ZT8YYf2H4IOe
         xGjg==
X-Gm-Message-State: AC+VfDy3sNnQ+zEeexKUjWRBbmR5W7cXEkzaiKjlZraj1c5ZmDG83tPe
        L0oPlcdY0VV3DX69rAMq9nf6KwR1M0X/B0w/4A1Aow==
X-Google-Smtp-Source: ACHHUZ45HYLTxHMIOq01xnBNZQQ3FvjzAGWMuhj5eqXhI0sjJMLvrbYm8scdp84P5QMdOuWonlr1sN9pxx8UWuINaFw=
X-Received: by 2002:a25:420f:0:b0:b9e:4fbc:8a7f with SMTP id
 p15-20020a25420f000000b00b9e4fbc8a7fmr5707930yba.1.1683052740029; Tue, 02 May
 2023 11:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com> <20230501165450.15352-20-surenb@google.com>
 <20230502175052.43814202@meshulam.tesarici.cz>
In-Reply-To: <20230502175052.43814202@meshulam.tesarici.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 May 2023 11:38:49 -0700
Message-ID: <CAJuCfpGSLK50eKQ2-CE41qz1oDPM6kC8RmqF=usZKwFXgTBe8g@mail.gmail.com>
Subject: Re: [PATCH 19/40] change alloc_pages name in dma_map_ops to avoid
 name conflicts
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
        paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 2, 2023 at 8:50=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@tesaric=
i.cz> wrote:
>
> On Mon,  1 May 2023 09:54:29 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
>
> > After redefining alloc_pages, all uses of that name are being replaced.
> > Change the conflicting names to prevent preprocessor from replacing the=
m
> > when it's not intended.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  arch/x86/kernel/amd_gart_64.c | 2 +-
> >  drivers/iommu/dma-iommu.c     | 2 +-
> >  drivers/xen/grant-dma-ops.c   | 2 +-
> >  drivers/xen/swiotlb-xen.c     | 2 +-
> >  include/linux/dma-map-ops.h   | 2 +-
> >  kernel/dma/mapping.c          | 4 ++--
> >  6 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_6=
4.c
> > index 56a917df410d..842a0ec5eaa9 100644
> > --- a/arch/x86/kernel/amd_gart_64.c
> > +++ b/arch/x86/kernel/amd_gart_64.c
> > @@ -676,7 +676,7 @@ static const struct dma_map_ops gart_dma_ops =3D {
> >       .get_sgtable                    =3D dma_common_get_sgtable,
> >       .dma_supported                  =3D dma_direct_supported,
> >       .get_required_mask              =3D dma_direct_get_required_mask,
> > -     .alloc_pages                    =3D dma_direct_alloc_pages,
> > +     .alloc_pages_op                 =3D dma_direct_alloc_pages,
> >       .free_pages                     =3D dma_direct_free_pages,
> >  };
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 7a9f0b0bddbd..76a9d5ca4eee 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1556,7 +1556,7 @@ static const struct dma_map_ops iommu_dma_ops =3D=
 {
> >       .flags                  =3D DMA_F_PCI_P2PDMA_SUPPORTED,
> >       .alloc                  =3D iommu_dma_alloc,
> >       .free                   =3D iommu_dma_free,
> > -     .alloc_pages            =3D dma_common_alloc_pages,
> > +     .alloc_pages_op         =3D dma_common_alloc_pages,
> >       .free_pages             =3D dma_common_free_pages,
> >       .alloc_noncontiguous    =3D iommu_dma_alloc_noncontiguous,
> >       .free_noncontiguous     =3D iommu_dma_free_noncontiguous,
> > diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> > index 9784a77fa3c9..6c7d984f164d 100644
> > --- a/drivers/xen/grant-dma-ops.c
> > +++ b/drivers/xen/grant-dma-ops.c
> > @@ -282,7 +282,7 @@ static int xen_grant_dma_supported(struct device *d=
ev, u64 mask)
> >  static const struct dma_map_ops xen_grant_dma_ops =3D {
> >       .alloc =3D xen_grant_dma_alloc,
> >       .free =3D xen_grant_dma_free,
> > -     .alloc_pages =3D xen_grant_dma_alloc_pages,
> > +     .alloc_pages_op =3D xen_grant_dma_alloc_pages,
> >       .free_pages =3D xen_grant_dma_free_pages,
> >       .mmap =3D dma_common_mmap,
> >       .get_sgtable =3D dma_common_get_sgtable,
> > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > index 67aa74d20162..5ab2616153f0 100644
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -403,6 +403,6 @@ const struct dma_map_ops xen_swiotlb_dma_ops =3D {
> >       .dma_supported =3D xen_swiotlb_dma_supported,
> >       .mmap =3D dma_common_mmap,
> >       .get_sgtable =3D dma_common_get_sgtable,
> > -     .alloc_pages =3D dma_common_alloc_pages,
> > +     .alloc_pages_op =3D dma_common_alloc_pages,
> >       .free_pages =3D dma_common_free_pages,
> >  };
> > diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> > index 31f114f486c4..d741940dcb3b 100644
> > --- a/include/linux/dma-map-ops.h
> > +++ b/include/linux/dma-map-ops.h
> > @@ -27,7 +27,7 @@ struct dma_map_ops {
> >                       unsigned long attrs);
> >       void (*free)(struct device *dev, size_t size, void *vaddr,
> >                       dma_addr_t dma_handle, unsigned long attrs);
> > -     struct page *(*alloc_pages)(struct device *dev, size_t size,
> > +     struct page *(*alloc_pages_op)(struct device *dev, size_t size,
> >                       dma_addr_t *dma_handle, enum dma_data_direction d=
ir,
> >                       gfp_t gfp);
> >       void (*free_pages)(struct device *dev, size_t size, struct page *=
vaddr,
> > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > index 9a4db5cce600..fc42930af14b 100644
> > --- a/kernel/dma/mapping.c
> > +++ b/kernel/dma/mapping.c
> > @@ -570,9 +570,9 @@ static struct page *__dma_alloc_pages(struct device=
 *dev, size_t size,
> >       size =3D PAGE_ALIGN(size);
> >       if (dma_alloc_direct(dev, ops))
> >               return dma_direct_alloc_pages(dev, size, dma_handle, dir,=
 gfp);
> > -     if (!ops->alloc_pages)
> > +     if (!ops->alloc_pages_op)
> >               return NULL;
> > -     return ops->alloc_pages(dev, size, dma_handle, dir, gfp);
> > +     return ops->alloc_pages_op(dev, size, dma_handle, dir, gfp);
> >  }
> >
> >  struct page *dma_alloc_pages(struct device *dev, size_t size,
>
> I'm not impressed. This patch increases churn for code which does not
> (directly) benefit from the change, and that for limitations in your
> tooling?
>
> Why not just rename the conflicting uses in your local tree, but then
> remove the rename from the final patch series?

With alloc_pages function becoming a macro, the preprocessor ends up
replacing all instances of that name, even when it's not used as a
function. That what necessitates this change. If there is a way to
work around this issue without changing all alloc_pages() calls in the
source base I would love to learn it but I'm not quite clear about
your suggestion and if it solves the issue. Could you please provide
more details?

>
> Just my two cents,
> Petr T
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
