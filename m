Return-Path: <linux-fsdevel+bounces-6880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A2A81DC7D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 22:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BBF81C209F7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 21:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C668FC11;
	Sun, 24 Dec 2023 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRTPNLji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C95EAD9
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d42ed4cdc7so135015ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 13:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703453452; x=1704058252; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7/MCgJrzTYbobYDGPWMaxVSPHC8aF5GoN3HBnQNC1yE=;
        b=SRTPNLjideYw9jSGZ8cUkT5/otA6oF+uTtO9hzMRBAtUksp1Ly6esmEEqd8Sz5RQtL
         u1QMSLwFrNxt0HO0byJUc+V9D2BXDnZrsamcGxitgSwSy0cu3zr4kYL/qLOeGj8kAJYo
         Vv/04MUWRZUKKQ9yGFHG9S0tL0ViVTHWXHDKuz8QiLHFd3uQ9DwJWh+Uywg6sRgxm5+f
         +LEE7uJjCSxXJG7VaVqyX/399wQBEHyxhtGEk7cx6ovrYGExu5VRdLOfEkNL1iBHUssj
         iLC7qVIriSD1e+LbEEvDQegtsmZUTubLjEb+Gs7JCHATC1208JN4rgoEURuG2uu7sDrX
         igSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703453452; x=1704058252;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/MCgJrzTYbobYDGPWMaxVSPHC8aF5GoN3HBnQNC1yE=;
        b=Tef2x5iOmr8n2PvgUD/edbjfQEBjHxt+pM3Aet+10K3DkzTeHhQr5btGG1EjX3CjPZ
         bV3u+LEPF9ker9PXcGCh8bY4gBdggq90tBuvWfB1LRWH894KjF8QSWg8u6/xPYJjkGg1
         PsjPkgjk+fKLBBpjxwrnailItY6keR/YauxVZYo+MCArJjyQ33tCfmIhQCAZcqcBD/OZ
         GgN72sQXn/lMrLlmN5YyVVVtjpz4wL/mG1ImpkaNhejEW805IzmVhtYVG3mx8LlFRVrW
         5o3tXyjYaXc1g2XbUQJwmwXc8WkHmgRxGO7WWc3Ifn9uQg1EICKZDZAVlbOC/QihLsi1
         De5A==
X-Gm-Message-State: AOJu0YzxLA/O/wCftheKNBIzGBqBq9UZbFtoOVf3aEth1IvOo9/8rWoL
	HTvL2rNrQlCGWtaga1RfLmMzsykL4KH3
X-Google-Smtp-Source: AGHT+IGEdm29d6jmw+nANphFK7SbhaR7mM9JSy5/jGKgQinKhgDaZxXLk5PDheL/k90mn9Ft6aU5hg==
X-Received: by 2002:a17:902:bb84:b0:1d4:55b3:45d9 with SMTP id m4-20020a170902bb8400b001d455b345d9mr28530pls.6.1703453451456;
        Sun, 24 Dec 2023 13:30:51 -0800 (PST)
Received: from [2620:0:1008:15:c723:e11e:854b:ac88] ([2620:0:1008:15:c723:e11e:854b:ac88])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902d50e00b001d3dacffde3sm6890413plg.226.2023.12.24.13.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:30:50 -0800 (PST)
Date: Sun, 24 Dec 2023 13:30:50 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: Andrew Morton <akpm@linux-foundation.org>, alim.akhtar@samsung.com, 
    alyssa@rosenzweig.io, asahi@lists.linux.dev, baolu.lu@linux.intel.com, 
    bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net, 
    david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
    iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
    joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
    linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
    linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
    mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
    rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
    suravee.suthikulpanit@amd.com, sven@svenpeter.dev, 
    thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com, 
    vdumpa@nvidia.com, wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH v2 01/10] iommu/vt-d: add wrapper functions for page
 allocations
In-Reply-To: <CA+CK2bA8iJ_w8CSx2Ed=d2cVSujrC0-TpO7U9j+Ow-gfk1nyfQ@mail.gmail.com>
Message-ID: <1fd66377-030c-2e48-e658-4669bbf037e9@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-2-pasha.tatashin@soleen.com> <776e17af-ae25-16a0-f443-66f3972b00c0@google.com> <CA+CK2bA8iJ_w8CSx2Ed=d2cVSujrC0-TpO7U9j+Ow-gfk1nyfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2003067076-655310594-1703453450=:2163178"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--2003067076-655310594-1703453450=:2163178
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 14 Dec 2023, Pasha Tatashin wrote:

> On Thu, Dec 14, 2023 at 12:58 PM David Rientjes <rientjes@google.com> wrote:
> >
> > On Thu, 30 Nov 2023, Pasha Tatashin wrote:
> >
> > > diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
> > > new file mode 100644
> > > index 000000000000..2332f807d514
> > > --- /dev/null
> > > +++ b/drivers/iommu/iommu-pages.h
> > > @@ -0,0 +1,199 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (c) 2023, Google LLC.
> > > + * Pasha Tatashin <pasha.tatashin@soleen.com>
> > > + */
> > > +
> > > +#ifndef __IOMMU_PAGES_H
> > > +#define __IOMMU_PAGES_H
> > > +
> > > +#include <linux/vmstat.h>
> > > +#include <linux/gfp.h>
> > > +#include <linux/mm.h>
> > > +
> > > +/*
> > > + * All page allocation that are performed in the IOMMU subsystem must use one of
> > > + * the functions below.  This is necessary for the proper accounting as IOMMU
> > > + * state can be rather large, i.e. multiple gigabytes in size.
> > > + */
> > > +
> > > +/**
> > > + * __iommu_alloc_pages_node - allocate a zeroed page of a given order from
> > > + * specific NUMA node.
> > > + * @nid: memory NUMA node id
> >
> > NUMA_NO_NODE if no locality requirements?
> 
> If no locality is required, there is a better interface:
> __iommu_alloc_pages(). That one will also take a look at the calling
> process policies to determine the proper NUMA node when nothing is
> specified. However, when policies should be ignored, and no locality
> required, NUMA_NO_NODE can be passed.
> 

Gotcha, thanks!

> >
> > > + * @gfp: buddy allocator flags
> > > + * @order: page order
> > > + *
> > > + * returns the head struct page of the allocated page.
> > > + */
> > > +static inline struct page *__iommu_alloc_pages_node(int nid, gfp_t gfp,
> > > +                                                 int order)
> > > +{
> > > +     struct page *pages;
> >
> > s/pages/page/ here and later in this file.
> 
> In this file, where there a page with an "order", I reference it with
> "pages", when no order (i.e. order = 0), I reference it with "page"
> 
> I.e.: __iommu_alloc_page vs. __iommu_alloc_pages
> 

Eh, the struct page points to a (potentially compound) page, not a set or 
list of pages.  I won't bikeshed on it, but "struct page *pages" never 
makes sense unless it's **pages or *pages[] :)
--2003067076-655310594-1703453450=:2163178--

