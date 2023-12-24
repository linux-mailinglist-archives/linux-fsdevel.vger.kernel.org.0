Return-Path: <linux-fsdevel+bounces-6890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B470581DCCE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 22:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E7E1C20AD0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 21:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9571078A;
	Sun, 24 Dec 2023 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z9mPQgBL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4FFC14
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-35ffc781b3bso59925ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 13:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703454581; x=1704059381; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O0HiuPkhATpCWAkLMW05BPxTgagJyPS45hssBqZfyJY=;
        b=z9mPQgBLpTmNdiIE+lLUIbokt+5Zsl88zuLfix0gYut1VGsyrvZEi4/UsUvsGMj6LT
         rZAGxqUwMmsrJxrrp7BFPKcNOMyw7lY1ZvGwC0cphM6X5N0AoORQyG9Fd+Dg84e9Iwga
         f+f74NsFtJm3OS5/pJgslIam6k6PcbhmpMKL1xx8DpiJTRMDcuQbQ7JyUlGzx7z2mGRF
         57p2VqwBB6VhZ+I2Dsy2FyHN/+sWl3HdzaffuIB6mIEahBtEZhqFgKq5WnlQ4wFeaPGu
         dmFoHsDQ8k2CQOoo4BwZqvabcJkg5AOM4Fe88Fy3oBpAouzAbkmnv27IbVirpdC9e20Y
         5ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703454581; x=1704059381;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0HiuPkhATpCWAkLMW05BPxTgagJyPS45hssBqZfyJY=;
        b=kuPya8GV6RZnCPoFKM8WJMQ5Ee+emTFfWiYwSSv+KLQHuNHEutJDEUCAA9I+/hIdN6
         FS/ACPIRX4i78PwlB3CVbvM5BF7DrKWvmi4Kt2HYpdVkV5ZuEgt/hoHJ4KKwtn646cUY
         /H0Fpo3TO20kEnd7teqTqZMlXE8sX4qIQwjd7Lpn/WFEHr9lXyTnASpLVb6HVe6K08fz
         EhoHHEXgNggp7zoTVD3QsyjaphXxjKaRbtJGfFPLB0pIHjvrQWNNUtI2NdraxXa8vPYU
         ODuU3B51t+eV72I3/+YSWgEnzEAZlVzww+uxqawfgIa7zA0dAbpcJiL6/iOo2yNCHPuI
         GN5w==
X-Gm-Message-State: AOJu0Yx2uSdLFICbDYLCtRov4oHskofTSffd4LX50P/lyPje2RVqlkcH
	gb1VlpnoPmxG9mes/2R2BZg49AeRFEaw
X-Google-Smtp-Source: AGHT+IHO1o4MpTmRsY4pG5iPw80zAps+6fJHAueY55ciRhpJtDvuIlpvxAKJ08/tY4qG55yyTyBfTQ==
X-Received: by 2002:a05:6e02:3001:b0:35f:b200:2fb5 with SMTP id bd1-20020a056e02300100b0035fb2002fb5mr495955ilb.11.1703454581205;
        Sun, 24 Dec 2023 13:49:41 -0800 (PST)
Received: from [2620:0:1008:15:c723:e11e:854b:ac88] ([2620:0:1008:15:c723:e11e:854b:ac88])
        by smtp.gmail.com with ESMTPSA id l18-20020a62be12000000b006ce95e37a40sm6824858pff.111.2023.12.24.13.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:49:40 -0800 (PST)
Date: Sun, 24 Dec 2023 13:49:39 -0800 (PST)
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
Subject: Re: [PATCH v2 00/10] IOMMU memory observability
In-Reply-To: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
Message-ID: <2913539c-68f1-5597-df64-99a884a60e0a@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> IOMMU subsystem may contain state that is in gigabytes. Majority of that
> state is iommu page tables. Yet, there is currently, no way to observe
> how much memory is actually used by the iommu subsystem.
> 
> This patch series solves this problem by adding both observability to
> all pages that are allocated by IOMMU, and also accountability, so
> admins can limit the amount if via cgroups.
> 
> The system-wide observability is using /proc/meminfo:
> SecPageTables:    438176 kB
> 
> Contains IOMMU and KVM memory.
> 
> Per-node observability:
> /sys/devices/system/node/nodeN/meminfo
> Node N SecPageTables:    422204 kB
> 
> Contains IOMMU and KVM memory memory in the given NUMA node.
> 
> Per-node IOMMU only observability:
> /sys/devices/system/node/nodeN/vmstat
> nr_iommu_pages 105555
> 
> Contains number of pages IOMMU allocated in the given node.
> 
> Accountability: using sec_pagetables cgroup-v2 memory.stat entry.
> 
> With the change, iova_stress[1] stops as limit is reached:
> 
> # ./iova_stress
> iova space:     0T      free memory:   497G
> iova space:     1T      free memory:   495G
> iova space:     2T      free memory:   493G
> iova space:     3T      free memory:   491G
> 
> stops as limit is reached.
> 

I think this is *very* useful to provide visibility into a significant 
amount of memory that we currently cannot observe on a host.  It can help 
to uncover bugs and shed light onto a particularly large amount of memory 
that would otherwise be mysterious.

Joerg, Will, Robin, I think this series would go through the 
git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tree since it 
depends on a common framework for all other IOMMU implementations to then 
use?

Any concerns about this patch series?  It would be very useful for us to 
create visibility into this memory.


Pasha: any chance of adding a selftest that can be run that will test the 
value of nr_iommu_pages?  I could imagine in the future that a bug could 
be introduced where either an allocation or free is done through 
alloc_pages() directly and its paired alloc/free function now results in a 
leak or underflow.

> This series encorporates suggestions that came from the discussion
> at LPC [2].
> ----------------------------------------------------------------------
> [1] https://github.com/soleen/iova_stress
> [2] https://lpc.events/event/17/contributions/1466
> ----------------------------------------------------------------------
> Previous versions
> v1: https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com
> ----------------------------------------------------------------------
> 
> Pasha Tatashin (10):
>   iommu/vt-d: add wrapper functions for page allocations
>   iommu/amd: use page allocation function provided by iommu-pages.h
>   iommu/io-pgtable-arm: use page allocation function provided by
>     iommu-pages.h
>   iommu/io-pgtable-dart: use page allocation function provided by
>     iommu-pages.h
>   iommu/exynos: use page allocation function provided by iommu-pages.h
>   iommu/rockchip: use page allocation function provided by iommu-pages.h
>   iommu/sun50i: use page allocation function provided by iommu-pages.h
>   iommu/tegra-smmu: use page allocation function provided by
>     iommu-pages.h
>   iommu: observability of the IOMMU allocations
>   iommu: account IOMMU allocated memory
> 
>  Documentation/admin-guide/cgroup-v2.rst |   2 +-
>  Documentation/filesystems/proc.rst      |   4 +-
>  drivers/iommu/amd/amd_iommu.h           |   8 -
>  drivers/iommu/amd/init.c                |  91 +++++-----
>  drivers/iommu/amd/io_pgtable.c          |  13 +-
>  drivers/iommu/amd/io_pgtable_v2.c       |  20 +-
>  drivers/iommu/amd/iommu.c               |  13 +-
>  drivers/iommu/exynos-iommu.c            |  14 +-
>  drivers/iommu/intel/dmar.c              |  10 +-
>  drivers/iommu/intel/iommu.c             |  47 ++---
>  drivers/iommu/intel/iommu.h             |   2 -
>  drivers/iommu/intel/irq_remapping.c     |  10 +-
>  drivers/iommu/intel/pasid.c             |  12 +-
>  drivers/iommu/intel/svm.c               |   7 +-
>  drivers/iommu/io-pgtable-arm.c          |   7 +-
>  drivers/iommu/io-pgtable-dart.c         |  37 ++--
>  drivers/iommu/iommu-pages.h             | 231 ++++++++++++++++++++++++
>  drivers/iommu/rockchip-iommu.c          |  14 +-
>  drivers/iommu/sun50i-iommu.c            |   7 +-
>  drivers/iommu/tegra-smmu.c              |  18 +-
>  include/linux/mmzone.h                  |   5 +-
>  mm/vmstat.c                             |   3 +
>  22 files changed, 390 insertions(+), 185 deletions(-)
>  create mode 100644 drivers/iommu/iommu-pages.h
> 
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 
> 
> 

