Return-Path: <linux-fsdevel+bounces-6115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D016813945
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5DA2830AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7F67E67;
	Thu, 14 Dec 2023 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="db3UtXdY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6757F122
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 09:59:59 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0b40bb704so6025ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 09:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702576799; x=1703181599; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ9x6kLcBYiEdBJWGUfxINmlIVM3g2sEltrcooCIdH0=;
        b=db3UtXdY8aBQieI3huxs2sGIoL44TLlJEKvRJ9MvuvbUxHU3JVbetHrCOko0PxaYDd
         SQzKmE6QChugPbwUT8s/lxkPf0UkAvt13KrFtZEXZX4rMQQ650K0dr3DZdsC3NRgB36i
         pBHhOCpCZ3YMqMvG6wGirj87knntUgZv78I8GG5CeRAJcy1ANUplXaVb8+Y5jpz0dz+l
         xnzL/RKfGWhpmAsEroo7eEdvUqC+IZ2x6mUqhBBS8m17QwES3aBg/C28cZhbTAzVNMwY
         udJ6WpTCp61nq+q2eb+sqa8Fv5xeOHLW8EmjI0dSzAwryZO613j/HxQP66J/x51yjoM5
         64oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576799; x=1703181599;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ9x6kLcBYiEdBJWGUfxINmlIVM3g2sEltrcooCIdH0=;
        b=FB7J5jhZZqAsE0R4eQqA0YmRVL7d+ogwq+jPi4YH4KEaBOtB6vzOMK8AcRflmeDRHc
         EJSPhmESOpcFIzsddEguLviwoAbQejRsPCcvN7qlNWgKs3o+uLf1vklj1Q8fHuEaZSHV
         rkq4J0ThDODoOTrAr1gW8APyOqEE2K4f/hD98QKiaP4qFLFVtaw1kxc2d21HUR/yKyQ7
         G9XY9t4rdaNadyXv+nOvA8K8qUYw3c2zGLUNsAOM4Vb/qbS+GLRtfEvnZ2/XlcEIzw6O
         05OtjPjnFklHosj3uE8C/oHSkWTZc8Hqxan1n7jlL6mJvSNbPDmFQjiyjpl1QyYj0okL
         kEWA==
X-Gm-Message-State: AOJu0YycsvtdO9pni/BgMxZmR5MLnTR1X03qnZPYYXX5HyOZtHEwOyzW
	4Xw5hHNscITnSwLOlxxzHhV+Mw==
X-Google-Smtp-Source: AGHT+IH5RplbwvbCKQv+ptuR7ZWj127uLmsE7SQkvEwRe0Gbuexa/KME9clMyovQW6MkVTsfPUZxog==
X-Received: by 2002:a17:902:d2d2:b0:1d3:7d54:be3d with SMTP id n18-20020a170902d2d200b001d37d54be3dmr49997plc.6.1702576798577;
        Thu, 14 Dec 2023 09:59:58 -0800 (PST)
Received: from [2620:0:1008:15:740b:4c24:bdb6:a42a] ([2620:0:1008:15:740b:4c24:bdb6:a42a])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001cfc2e0a82fsm12675679plr.26.2023.12.14.09.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:59:58 -0800 (PST)
Date: Thu, 14 Dec 2023 09:59:57 -0800 (PST)
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
Subject: Re: [PATCH v2 09/10] iommu: observability of the IOMMU allocations
In-Reply-To: <20231130201504.2322355-10-pasha.tatashin@soleen.com>
Message-ID: <88519685-abfb-e2f8-38b4-d94340b40d1d@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-10-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> Add NR_IOMMU_PAGES into node_stat_item that counts number of pages
> that are allocated by the IOMMU subsystem.
> 
> The allocations can be view per-node via:
> /sys/devices/system/node/nodeN/vmstat.
> 
> For example:
> 
> $ grep iommu /sys/devices/system/node/node*/vmstat
> /sys/devices/system/node/node0/vmstat:nr_iommu_pages 106025
> /sys/devices/system/node/node1/vmstat:nr_iommu_pages 3464
> 
> The value is in page-count, therefore, in the above example
> the iommu allocations amount to ~428M.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>

