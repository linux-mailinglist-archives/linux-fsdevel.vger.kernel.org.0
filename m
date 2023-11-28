Return-Path: <linux-fsdevel+bounces-4103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EC47FCB97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1981F20F89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3761851
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="AZLqdM4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3A419B0
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 14:55:44 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58d98188dc0so1249548eaf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 14:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701212144; x=1701816944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wfgEOy2prfurtAfhJK/0Guihsou0dTaccer75iSoWso=;
        b=AZLqdM4x2Ov+Gtc2vniBfPL9kpW6zs9zKUkDKEfyXSOcwBfZPtK83z5HUXWvJNpFnS
         RYecGLTKbNkC9p6lTUjCmMS2mxypxaoIzP5FA2kW0/nYyZOrSi//Flk+BPnWi2hRsYwp
         bH2m2+0gyeOEmsBRpkCmMFUvuGQNzZ5MTeGb830pINMnNUvztmJn48jfIjWXAh2fqcFU
         eCwfIcAIpdzOI1r/3CPP6PsxzMxaOhs/E/kzfI6++l+YMRbEcfxvWt6nVoiKyoDKzxvl
         o5F4CHamlAW2pbzLTvV8RWfLc020m/YvE3HVhcPuxs7XzATl57IuY4q56qxpDLQTQCHk
         Y4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701212144; x=1701816944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfgEOy2prfurtAfhJK/0Guihsou0dTaccer75iSoWso=;
        b=Yx+RdF+4Ty/3Uvdmzu/qwQFWMLnv0qDMXsG7R27+iVQvA1UzwTFByUTS2+m/D2IvTu
         YMzDriTebAjawIxmjhqvXAB1A44Vydslnd+xNWxEhAke9FF39NXtbMySHD4GgXAmLylu
         7itJmd2QHx+KdqYw+nNssbZihhUrhyBtSC+vjvw9sxQwkq27eT9vzwN/dteKt75B3x/e
         2vNKgzi2YQc6oK3wILdtwPMP+DXbNLDDf/PpQLw3ZmSJHexadLnGqjPbohe0hT4yzgrc
         114a8vVRDtmSRJtjovuSFqj+cCloHuU73WziJF2ZNUl1Af+y03gxPLJA3B8UGAlI/u/I
         CcUw==
X-Gm-Message-State: AOJu0YyU4kejmPj4yNnGKNtNcRYE6D1ae29EnkguHXhzlAsjT5APeeOI
	Nv9PqRNypjAIWbjuQdbB/msBKGRvp4dJR+MG+5GO0Q==
X-Google-Smtp-Source: AGHT+IHisXYdh3pxH8NCFygwpTk8sa04O8TeLdxM3oMX+99Z92ajNHfOBhWjaeIXy0J8F2P4nyXD+nsTEaXIGG5EBsc=
X-Received: by 2002:a05:6358:724c:b0:16d:fb29:d78 with SMTP id
 i12-20020a056358724c00b0016dfb290d78mr15947280rwa.2.1701212143714; Tue, 28
 Nov 2023 14:55:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-6-pasha.tatashin@soleen.com> <8e1961c9-0359-4450-82d8-2b2fcb2c5557@arm.com>
In-Reply-To: <8e1961c9-0359-4450-82d8-2b2fcb2c5557@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 28 Nov 2023 17:55:07 -0500
Message-ID: <CA+CK2bDFAi1+397fd4cYetUgmHxqE2hUG4fa2m9Fi3weykQdpA@mail.gmail.com>
Subject: Re: [PATCH 05/16] iommu/io-pgtable-arm-v7s: use page allocation
 function provided by iommu-pages.h
To: Robin Murphy <robin.murphy@arm.com>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com, 
	jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com, joro@8bytes.org, 
	kevin.tian@intel.com, krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, mst@redhat.com, m.szyprowski@samsung.com, 
	netdev@vger.kernel.org, paulmck@kernel.org, rdunlap@infradead.org, 
	samuel@sholland.org, suravee.suthikulpanit@amd.com, sven@svenpeter.dev, 
	thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com, 
	vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"

> >               kmem_cache_free(data->l2_tables, table);

We only account page allocations, not subpages, however, this is
something I was surprised about this particular architecture of why do
we allocate l2 using kmem ? Are the second level tables on arm v7s
really sub-page in size?

Pasha

