Return-Path: <linux-fsdevel+bounces-4086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE497FC9A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 23:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022D61C209C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 22:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C985024A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="mxP7V98N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862C21BF9
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:50 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-677fba00a49so1686946d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204589; x=1701809389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuhRNW8EraGxCVOazJoq98oeC/940DRf0iOPJkOnyXY=;
        b=mxP7V98N+v2ExEmrGV3kjkIxZ3YZw4TkJUgzcVhEZtxqitrZtR9Htey3aLkSXVUsx+
         pFynFqodwrSp9YjDLGvwDKL+/J3rsPQMFukyFPq2+Th8DDzgSRNPsfFi/V9+VPycoTDa
         w/DT3ped36LXQqliqeekqeSW1HY3nVD7a9M2t7dnNqsKZ1ieIUuhBCQfObycZinJ8/5i
         +ElAbqcrl3QyPtY68gfp98jSOrzGtFxZj+m6Dzo2knUgC4xWJTM4GbaPx2kn+IvIKCO5
         10iJjRHm/3KdlmiHMq9mhWafVGyvJEBaM36HP50twKo7oJ3LTT7UOCUQf+SQukLO+xbW
         uPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204589; x=1701809389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuhRNW8EraGxCVOazJoq98oeC/940DRf0iOPJkOnyXY=;
        b=Ayh+beZS5FbkbMiYPM8YbgmLjmyS/QecphThJG4WwKaiJz8xEc5xBFM7mg7cliiEWp
         hBjFugH7O9i2kAJRW4yD/D/vp7CIjAUiHOxeF6QHu2sdglnrVsekK5lIEi2+ZMBgpH7K
         hd4aIsg50vK6kju4/5sDqb5LK8aAi2g3RpFHRUORIQZm2MY1sxUsCildQMTTGVRV1ns5
         5vvZ4H7JPX7/cold7B7jn8r0dMws3TkOVwbCTt2HxVHlDvMDIyK6/qpxXvT2lIKETWxt
         mKTNsq523Rg2MtWvfkN3CHphMqSrxDsPiYLtu/Bd0kzM4HdFcVCrffLstjXRhz8P0PsZ
         7+3A==
X-Gm-Message-State: AOJu0Yzet6uvdAXvpQAv5VV1Dtr8OdfSmKwZ0jQoTcn5EeIdUJLSsCn7
	f4zpLBgls6X62s/1Z1vik7m/Mg==
X-Google-Smtp-Source: AGHT+IGPu3upFAdCP6yNYmrLD/qlosIlP36YcCIt0RdR7fCBV7LNnnJ4icXgqHOsHyLuFzh/n11wOA==
X-Received: by 2002:a05:6214:1c0b:b0:67a:4546:9895 with SMTP id u11-20020a0562141c0b00b0067a45469895mr14672496qvc.12.1701204589666;
        Tue, 28 Nov 2023 12:49:49 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:49 -0800 (PST)
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
Subject: [PATCH 09/16] iommu/iommufd: use page allocation function provided by iommu-pages.h
Date: Tue, 28 Nov 2023 20:49:31 +0000
Message-ID: <20231128204938.1453583-10-pasha.tatashin@soleen.com>
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

Convert iommu/iommufd/* files to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index 0a92c9eeaf7f..6b8575b93f17 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -253,7 +253,7 @@ struct iova_bitmap *iova_bitmap_alloc(unsigned long iova, size_t length,
 	bitmap->iova = iova;
 	bitmap->length = length;
 	mapped->iova = iova;
-	mapped->pages = (struct page **)__get_free_page(GFP_KERNEL);
+	mapped->pages = iommu_alloc_page(GFP_KERNEL);
 	if (!mapped->pages) {
 		rc = -ENOMEM;
 		goto err;
@@ -284,7 +284,7 @@ void iova_bitmap_free(struct iova_bitmap *bitmap)
 	iova_bitmap_put(bitmap);
 
 	if (mapped->pages) {
-		free_page((unsigned long)mapped->pages);
+		iommu_free_page(mapped->pages);
 		mapped->pages = NULL;
 	}
 
-- 
2.43.0.rc2.451.g8631bc7472-goog


