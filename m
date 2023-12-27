Return-Path: <linux-fsdevel+bounces-6939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A611681EAF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 01:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6248F28333F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 00:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CE71FD9;
	Wed, 27 Dec 2023 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNW16Zt2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7978D23C2
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Dec 2023 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso464555ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Dec 2023 16:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703636732; x=1704241532; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yhvNEPy1OdHxiHajFepdZmy+iFIGCud+lbMtAIqjO0=;
        b=RNW16Zt25HZlvdgAj3JTlgY7UzNeT6dqABvLneLoxoT6r5i93Tp0RrDipmAgUte3SH
         Ohi9Ej4ZH6vkJw4CZbP6v6GnuFERbyT2Y1gR56FS1oZME3S7Gp5k2IKfzkR40+nO3YFb
         vNbMsdkOGTcGcLZ3eqEUepvsO77lTXhIsTde5OteRPQ+/0UnxiqBcvQV+naL7GBMFw/Z
         p5eXjpRwbmRch1E2QMFirvCZL/G9yKV34ZWGHeN5+8V6awa2rLLAHcqCM7GxiivyNVrs
         MS8Nm6299+VSrfHnhN2vyKO89PE+Oj17n/JJtm8ZgLrSksFE83kHkj+GEyJ0+9dcNynj
         3Znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703636732; x=1704241532;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yhvNEPy1OdHxiHajFepdZmy+iFIGCud+lbMtAIqjO0=;
        b=kJVRA+nsC3cddXLP97MCvpQ2Dulw4WxWhGNEOVGfVobO6iiKG6b0SM45Ro/1UmJVd0
         EzqFLX7c4p6zCISF93+XuhJYU/kBi62rZ0HkUQqEi/2sE85XkxeN1/SdqnQIWdcvjuXX
         CPNnI9DO6jrPjQsEkQKMpl1TDphKJkrxQBdkqNnMuU/mZWqqeC57vkdAhVQI3AQZPiQq
         wkjHI5Mb6EkIXcIzjSy6cZ4ZhGGLpRiWxrr78c58NYMDFMceSmQlmJ2Q+gRN6X6wbpsH
         A8J3S7acmgk45zvkQi8RgxTAK/ayzYaqKwcNe9Pq72fGzWduRH2EwCnBMY1vvewBBecw
         HtBQ==
X-Gm-Message-State: AOJu0YzYlT6vjvC2x3ixCUGgTzHAuzhkAQl0gpdfTYmlP/T435RqelvA
	89LPTncGAg5FvPzbPQUFgx+s5bzkNiLY
X-Google-Smtp-Source: AGHT+IHfrTTFDhOmLPe/BcyhT6xcBiwDnUGm4X46zMrKWUIrGhjoY17pKeWHle6/bW8eRgBmSHtD6g==
X-Received: by 2002:a17:902:f684:b0:1d4:55b3:465f with SMTP id l4-20020a170902f68400b001d455b3465fmr239910plg.25.1703636731663;
        Tue, 26 Dec 2023 16:25:31 -0800 (PST)
Received: from [2620:0:1008:15:5a8c:89e6:ca2f:ea30] ([2620:0:1008:15:5a8c:89e6:ca2f:ea30])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b001d072365b87sm10636289plg.106.2023.12.26.16.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 16:25:31 -0800 (PST)
Date: Tue, 26 Dec 2023 16:25:30 -0800 (PST)
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
Subject: Re: [PATCH v3 10/10] iommu: account IOMMU allocated memory
In-Reply-To: <20231226200205.562565-11-pasha.tatashin@soleen.com>
Message-ID: <fc77b844-618d-1873-1588-15d59b8604e2@google.com>
References: <20231226200205.562565-1-pasha.tatashin@soleen.com> <20231226200205.562565-11-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 26 Dec 2023, Pasha Tatashin wrote:

> In order to be able to limit the amount of memory that is allocated
> by IOMMU subsystem, the memory must be accounted.
> 
> Account IOMMU as part of the secondary pagetables as it was discussed
> at LPC.
> 
> The value of SecPageTables now contains mmeory allocation by IOMMU
> and KVM.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>

