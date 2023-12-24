Return-Path: <linux-fsdevel+bounces-6884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A046A81DCA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 22:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A381C213D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 21:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F03FC1C;
	Sun, 24 Dec 2023 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8GClNcA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50A4FC01
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36000a26f8aso26035ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 13:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703453845; x=1704058645; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVxyPMcJnzxVjqwUrIgqhLO2uo1Gd7uHiOR5G5u7XjE=;
        b=D8GClNcAylxB8/4XLIU8Ozmd5YzJa6fpOQBoT1Fgmg8X3wD5QJsIn6YQC1hnZuulRM
         JxeRVTy++c/85wd9HgT5V7HPSUC5AKhD5W2fwEDZ7u6dT1umceh2eGqRB7Hn20mqRjtN
         +GN33hnhrcbK/eDF9i/ItoxWK+jgDB9pt0Pfyf/jIw0IUyzKCGNInQS9lV53weoc9s3R
         3kCJZos4OryWy3XdAtEwps1dZ+iqGS7mj2FhTqtk8HD27KjQZ5SNNUJP4IbLxYllXVUF
         Lr0OvtN/Of5lLiBrXvDGiBOEt/niJP0b+xtvdI7tFMZxfAY5W7w0nmhCwy8/JdjYAQWm
         Yojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703453845; x=1704058645;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVxyPMcJnzxVjqwUrIgqhLO2uo1Gd7uHiOR5G5u7XjE=;
        b=cflY/0JK3+9//Vby6hfzCH8SW+snxM7guGYHoc2sdou+Y+lT1HPyV2eNhVo2YRXEmO
         DQF3Cmmo76mRebJHckQkdGgiWjtE9O83dk4pQIL4L5yuc7BrGUbxw9pWvyquEHheHX5D
         c+jO4XH0upQONtX2OsCcGgfqLp4LX4I0Ct1fTguBY6fAoZcZc+RHyPG3VlZd/Nd8z9MB
         3OJsNornhDGSG5qDo1gzx4uZPYtYd7TWiFlvGX5qGM4faI3jElACP4ZQLKzWKA68NnYm
         A09PU5aNArI3Jh1yzueE+fIVXl0wLAt2o2ZRxowUwAkM0zxwmFocUkELZKb/scDi8VL4
         9qug==
X-Gm-Message-State: AOJu0Yy3GwOhqSN6A4vb0RwLgKX+aOxLmsXxFXQDlM7UX+gJvl+E6HYi
	2gPxqYR90PxFdk00kS5BNvnxsBf+Mtq4
X-Google-Smtp-Source: AGHT+IEltSw2it/AyEQL4TJEReIP7j1yGavDmVQF3lJZLlbsuLGoO+wANiaULFEhAWOlUQIZqn8B1g==
X-Received: by 2002:a05:6e02:1110:b0:35f:eb24:6e67 with SMTP id u16-20020a056e02111000b0035feb246e67mr189109ilk.7.1703453845125;
        Sun, 24 Dec 2023 13:37:25 -0800 (PST)
Received: from [2620:0:1008:15:c723:e11e:854b:ac88] ([2620:0:1008:15:c723:e11e:854b:ac88])
        by smtp.gmail.com with ESMTPSA id x2-20020aa784c2000000b006d99cbe22f5sm3116025pfn.217.2023.12.24.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:37:24 -0800 (PST)
Date: Sun, 24 Dec 2023 13:37:23 -0800 (PST)
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
Subject: Re: [PATCH v2 05/10] iommu/exynos: use page allocation function
 provided by iommu-pages.h
In-Reply-To: <20231130201504.2322355-6-pasha.tatashin@soleen.com>
Message-ID: <5c2d33b4-3360-10f3-7d97-5cdcb29e4d73@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-6-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> Convert iommu/exynos-iommu.c to use the new page allocation functions
> provided in iommu-pages.h.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>

