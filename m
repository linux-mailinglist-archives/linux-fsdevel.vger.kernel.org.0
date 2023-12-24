Return-Path: <linux-fsdevel+bounces-6881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0353A81DC87
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 22:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0091C20DD7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 21:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45373FC0E;
	Sun, 24 Dec 2023 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPGJXL0R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142BEAE8
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d42ed4cdc7so135335ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 13:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703453645; x=1704058445; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=19k96QXnbMagvx60gm9Q3bYlRQY8OEapphIAobKuCbg=;
        b=ZPGJXL0R71PwVR3MCcIyXT04X3X4fpdBs57SiGJEEbP9avwknKt4TU6lcVI6V/1x4o
         d3ela5bGeMXPrH+jhCkNCw/BfXXx2PTBR6bywVFoFOmQUv3DRjyrHX53UBXVGlFM6LMn
         ul2QNkzO0VGXadfV4VrLpYab4+QqH8UEEBPZ/ljLdymjxTXV3mhAvhvkkAuq5HH8AKDS
         Td+qbfo7DAh9f2L7t5e+QCo4i6l+ClpLRNJT+0w1qFMMRogO8C07v3ZfYMXDMolRJyhr
         EyThTuvBBGo7inY1tTcHmRagHOaUeDNEOhzfwNjYrR9kodRNG9TrrSFNvT7oasCdPS16
         B3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703453645; x=1704058445;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19k96QXnbMagvx60gm9Q3bYlRQY8OEapphIAobKuCbg=;
        b=MA/lBFFRq0i/kT3cSZ+jq4Hj8+cYRGzGNVWHPSkmW1uQcaJ7z7/KwIeW6wZzIUGZdK
         IHDzShV0FquEBsCW0pyUqkTL6xyEi+d+CTpZ3p2tzFUiRItgOvYv98zVLZ0gYcvMacUl
         MuWsVSsWyAdCoJsO3yjCKrzJ/TUB5LQw7TpTLzgK07gW/mJIx0RX8FrYEKBfeeWOJpvh
         YWvkTzX9aJ1vL1yssv+kw51HN1OzR3Pmtk4irk349+9Ptein9qZ2yP/mMsV/BFEcoVxV
         kV1GmdvgIYMDMDE5Y6Rn+sns0mz9Gy+D7/H1L24JjihzPpLecN1itZCSQFH+fZREi8af
         FsLw==
X-Gm-Message-State: AOJu0YwPNmmPdsNxu/i7owFF9Vvcn2zcSM07fM166Dmq9QgGaujb9Wyc
	Gd798OjLPta0DRf6i3nocjAo67grFxTT
X-Google-Smtp-Source: AGHT+IGegIDK1SiERqRo6gqK2h3wZ3T0rNk/SXpnhPjqekqQBeNJ+EefZk9MMaDh4fgCcjIJBnmJeg==
X-Received: by 2002:a17:903:1248:b0:1d4:cae:9a03 with SMTP id u8-20020a170903124800b001d40cae9a03mr251305plh.23.1703453645061;
        Sun, 24 Dec 2023 13:34:05 -0800 (PST)
Received: from [2620:0:1008:15:c723:e11e:854b:ac88] ([2620:0:1008:15:c723:e11e:854b:ac88])
        by smtp.gmail.com with ESMTPSA id n7-20020a056a000d4700b006d9bbc8d785sm400894pfv.141.2023.12.24.13.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:34:04 -0800 (PST)
Date: Sun, 24 Dec 2023 13:34:03 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
    asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
    cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
    dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
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
Subject: Re: [PATCH v2 02/10] iommu/amd: use page allocation function provided
 by iommu-pages.h
In-Reply-To: <20231130201504.2322355-3-pasha.tatashin@soleen.com>
Message-ID: <56409bdf-3f9d-e521-814f-3c8e854db3bf@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> Convert iommu/amd/* files to use the new page allocation functions
> provided in iommu-pages.h.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>

Although any feedback from Suravee and Joerg would be very useful on the 
overall approach and whether this looks good to them.

