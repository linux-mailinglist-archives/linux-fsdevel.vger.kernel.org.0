Return-Path: <linux-fsdevel+bounces-6919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D23C81E8AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 18:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835F71C20FE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 17:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828B34FF64;
	Tue, 26 Dec 2023 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XG8NXn4F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF04F88F
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-427e1a9cc12so4197651cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703610912; x=1704215712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=znBescOeGDyEd/eBwZlWM7zCSH3WtYT9hTuxQY/0ciQ=;
        b=XG8NXn4Fr+o6AFgkb7X5OPcfBqq+fpn7iaghciF2mBPh/76Z2Gl1GjtDqFoZCjWXCq
         25dZxF+i90zFauBaUQNVn/qUPfAvXqJCdbrGfCheQf51Je/x8+jLj6NnWT8TPEV3dVSZ
         u5LjEdKRw1h9nyn8cTp+m6kJOPOpbX3qqRN4NMpixyXeXeHoOfa/SrvpalKAo97CSmqt
         H9HhBbupSM09x9RC8oDJEl0tkapBhgK4he/2p4f67NS3gUCmLiLqKkIlMDdtydWoaPAy
         Qj6N0Mfr5QSSwMaMkZ9oUzjT6UXbGvupaByjQMg5+QHcGFUUXGRHUXX1MnPXAX/J3elA
         fADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703610912; x=1704215712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znBescOeGDyEd/eBwZlWM7zCSH3WtYT9hTuxQY/0ciQ=;
        b=Xl/HPhOCDgsmUc6DPujmsk2ylhD6qP/bpVyZjxwLBgIG8GZnsjO3tvKIuf9PO2NkCV
         37lvmm6ex8L3/3zrDHYprmh+PhDKh6IASq68NVyETQA+2pomGtGxWCavnUIf9DoYN54j
         YxcindjMaxtGuCaFXlVEEjYCIZiG01xcEMWANEAhCsy2YSKYtwDOQdXOwk3euzbQ54xG
         qMuGAL8LrmpeezC8ALMkdAoUtvAtVn2FffYpguaUd+WYHJ6erMpO/ZJXKclIPcsc+2X2
         CREAA+Yn1C5pDS2qA5dVNaK0m8b5bhfgwEZiVhJEqW/+yaD4CDmIH0BPnUiL1WdJkAws
         UPPQ==
X-Gm-Message-State: AOJu0YzlXc72UO3d4QJX5DsoT2fqh9aYJyg+c+R6fDWDiSnFxfnJmgHa
	kGM6vClC9lbPnubOUUYf7MqefhNQ1sFCNz8hxFIRk6zQFtpKRQ==
X-Google-Smtp-Source: AGHT+IHyQ5pm+vKsp8dlt+xdHnTW6C3uPhOZpDSwoY++VClJ/nDwEbMxRN02tbeUhgBwD4pSJVi4TOSqszJhqwYmmj4=
X-Received: by 2002:ac8:5bc2:0:b0:425:a28f:ddd8 with SMTP id
 b2-20020ac85bc2000000b00425a28fddd8mr8563250qtb.137.1703610912560; Tue, 26
 Dec 2023 09:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
 <20231130201504.2322355-2-pasha.tatashin@soleen.com> <776e17af-ae25-16a0-f443-66f3972b00c0@google.com>
 <CA+CK2bA8iJ_w8CSx2Ed=d2cVSujrC0-TpO7U9j+Ow-gfk1nyfQ@mail.gmail.com> <0ba8e579-2b6f-4e9f-a38c-097694f14d3c@intel.com>
In-Reply-To: <0ba8e579-2b6f-4e9f-a38c-097694f14d3c@intel.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Dec 2023 12:14:35 -0500
Message-ID: <CA+CK2bBGHv3f2AM999C5zoo018yzFdQpygUaPn0AVoJ7cX+Sbg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] iommu/vt-d: add wrapper functions for page allocations
To: "Liu, Jingqi" <jingqi.liu@intel.com>
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jernej.skrabec@gmail.com, 
	jonathanh@nvidia.com, joro@8bytes.org, krzysztof.kozlowski@linaro.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	lizefan.x@bytedance.com, marcan@marcan.st, mhiramat@kernel.org, 
	m.szyprowski@samsung.com, paulmck@kernel.org, rdunlap@infradead.org, 
	robin.murphy@arm.com, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, will@kernel.org, 
	yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"

> >> Document the locking requirements for this?
> >
> > Thank you for the review. I will add info about locking requirements,
> > in fact they are very relaxed.
> >
> > These pages are added to the list by unmaps or remaps operation in
> > Intel IOMMU implementation. These calls assume that whoever is doing
> > those operations has exclusive access to the VA range in the page
> > table of that operation. The pages in this freelist only belong to the
> > former page-tables from the IOVA range for those operations.
>
> These pages maybe be accessed concurrently by thread contexts other than
> the IOMMU driver (such as debugfs).

Good point regarding debugfs. While, it does not change any locking
assumptions, for this series. It might change some design decisions
that we need to make when freeing pages on unmaps (a separate RFC
series that I sent). I will have to study how debugfs affect refcnt
and mapcount, and whether we could use per-page page table locking if
needed.

Thanks,
Pasha

