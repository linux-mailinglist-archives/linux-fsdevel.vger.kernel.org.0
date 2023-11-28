Return-Path: <linux-fsdevel+bounces-4089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43FF7FC9AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 23:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697E22823AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 22:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2178150266
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="SvWFKyrF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8281B1BC3
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:52 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5cd0af4a7d3so61689627b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204591; x=1701809391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwZxW20NTsAI6OtU2mg3WBn7dc7VhXurLb9lJcGaB3s=;
        b=SvWFKyrF6VDMtt35mvvjqHaCQnIBwza4Mio9j2jVB6Rc7q2c317f52e286/e8iTyVN
         isdvbCxLGYRUNn5tyh3Vq6cxnZ067QRRTWs9fC3vSHpHsrNqLfcKeRZzaBdFNPkgHJPO
         wxhb/RG7HZ/7KfAfppZEDRLgnoo43V8s3yKtIDuAM/tYdEsaujThmKQRrHXUq74EAMEb
         fXc12W2Y0/yVOB0ChfGsPdNYI4bEnoE2pIu9gVTOtH/iAFAJPijqEeq3z/o20oYa/tYO
         ctUOr8Cua2gAjiwdwfzdBY5R7PayKOoszFEDpaXxbQDKwav56fJF+kREwA/aoZnc1xHz
         JL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204591; x=1701809391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwZxW20NTsAI6OtU2mg3WBn7dc7VhXurLb9lJcGaB3s=;
        b=gcIa2aulsQWWsKmkf3jED2RT/WNqnaAdsz93D0TakB0zEeNBsVH0N2NBWKHc+e7W93
         qKzHErcaqlP70VD8LG4eE8B0NztBepegUJicau13nn3B3XeBLOuxG4KGsTxBlxDy/xbz
         J71XmnRGbj5z42o7fMKIL4Iz1Y26jxUSzQzVHEJsRmct2NrVN37vi2nW/IifibsyJI2D
         IKpKjTadg04+4bLp7R+UkEaH9SrEHHObN9X0BwR+lOElmfvdtLQeJUNrbGh0BTtTbKdh
         q+dEs7AQj9djvympDp/WESaJnLJDAeBnx4rrKnxuSCkWCQhPasvwq9Y2BpfLr4FwA+Eh
         8pTQ==
X-Gm-Message-State: AOJu0YwU0Yiux8NbVk21EPVncd/Lzgl/7jSVWbozZ4m78SqwGGFebJfj
	O17CKLCMsbjHNLRjiphpxnrjgA==
X-Google-Smtp-Source: AGHT+IHCcneC8xut0NvwO9Mjx/qxjTP4L7ixlY2hbUe9eNo80eBX8ekYQZcNVvvgdD6z0QrQuBV3MA==
X-Received: by 2002:a0d:d409:0:b0:5cb:5171:ab07 with SMTP id w9-20020a0dd409000000b005cb5171ab07mr16139567ywd.12.1701204591541;
        Tue, 28 Nov 2023 12:49:51 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:51 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alex.williamson@redhat.com,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jasowang@redhat.com,
	jernej.skrabec@gmail.com,
	jgg@ziepe.ca,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	kevin.tian@intel.com,
	krzysztof.kozlowski@linaro.org,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	mst@redhat.com,
	m.szyprowski@samsung.com,
	netdev@vger.kernel.org,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	virtualization@lists.linux.dev,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com
Subject: [PATCH 11/16] iommu/sun50i: use page allocation function provided by iommu-pages.h
Date: Tue, 28 Nov 2023 20:49:33 +0000
Message-ID: <20231128204938.1453583-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iommu/sun50i-iommu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/sun50i-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 41484a5a399b..172ddb717eb5 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -26,6 +26,8 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
+#include "iommu-pages.h"
+
 #define IOMMU_RESET_REG			0x010
 #define IOMMU_RESET_RELEASE_ALL			0xffffffff
 #define IOMMU_ENABLE_REG		0x020
@@ -679,8 +681,7 @@ sun50i_iommu_domain_alloc_paging(struct device *dev)
 	if (!sun50i_domain)
 		return NULL;
 
-	sun50i_domain->dt = (u32 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						    get_order(DT_SIZE));
+	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL, get_order(DT_SIZE));
 	if (!sun50i_domain->dt)
 		goto err_free_domain;
 
@@ -702,7 +703,7 @@ static void sun50i_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 
-	free_pages((unsigned long)sun50i_domain->dt, get_order(DT_SIZE));
+	iommu_free_pages(sun50i_domain->dt, get_order(DT_SIZE));
 	sun50i_domain->dt = NULL;
 
 	kfree(sun50i_domain);
-- 
2.43.0.rc2.451.g8631bc7472-goog


