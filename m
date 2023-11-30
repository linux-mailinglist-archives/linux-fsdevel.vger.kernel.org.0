Return-Path: <linux-fsdevel+bounces-4509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87E07FFCDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 21:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36F9281762
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 20:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D05A0EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bPnoAUi9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D223173C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 12:15:17 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d856210057so803653a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 12:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701375316; x=1701980116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B42Ompk/0S+0FHWlF0c0WCUF97rKJOKtrfjrMLAbFqA=;
        b=bPnoAUi9Mqlaj2MW8DUbnk1HFhAILmRap6jsO2xBXzj5XkFCTRTucPKv31jqdjl+Ua
         3glj8AvwbiQ/xKX/TEpyhnxr+bOVUXGZaauETAuPQgN/25elsNdQjPvs3VBCY0Rjq1Jl
         15XMHYmZ9WMqF4gXdVM1jJ3S6y85kkD7MqhrjpZtaUStpLKdH2JHnmWjw4almXjf3r1R
         9JXkZn9Qk3PUHdlQj+40L2M/t2r4BWVq7xEZSBfxf8m0s0KSH3btJi5SlHr2Nzt9++KR
         3EV16pTiJ/CPh3YbYixmvFqt6DLb6LuhhsfFz6JSXN8fcmg/kVGXmOlm+/m5YPQezPID
         gTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375316; x=1701980116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B42Ompk/0S+0FHWlF0c0WCUF97rKJOKtrfjrMLAbFqA=;
        b=dxq05KJ1l8rXVVluNtf40mznycCe0HLLEZYcp5iqkHChtRpbIt3KdrvEwC2RpmaeEp
         +BjLAGtAnlme9FG25Lp8kig6BFP6AJLsUD1rj3/MK+8dZWMyA9zZYwOZvF/XB6hMxo4q
         5THjStyqKWWFB6ZPDSy73SeRt4EbZSEG+g8wOP+5zLQ2lawLIuhNSRRf/T/KQc0CHoM2
         MH2cFi66siNdjmyoNZGC5eE/gguL3z+L248k54axGC2J+01+arfFWeY1qIBmrm/+6LXp
         UV8onVcz1wO2C4Vg6iONO+ZaERjJ54M7u7ktQdC+uQUMIPUFMulXX9cNFk5ZvXqP2URj
         hbWw==
X-Gm-Message-State: AOJu0YyZyDjtk8pIWhKwWwVo3GlBlNGxPsFgnkIlTB9Y/Wl75tgs4J8s
	7sZO/48LQ2aeG6QsDnwlRzYRpg==
X-Google-Smtp-Source: AGHT+IFm2VZamMYGPMsf9vCHQb4stofA9P0lnINgFWclhv2SjMIVDU5Q4H8UbP8D1DLG6NZm/4QG2w==
X-Received: by 2002:a9d:7dd2:0:b0:6d7:f02f:dcc3 with SMTP id k18-20020a9d7dd2000000b006d7f02fdcc3mr809535otn.28.1701375316245;
        Thu, 30 Nov 2023 12:15:16 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id e1-20020a0cb441000000b0067a35608186sm795252qvf.28.2023.11.30.12.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:15:15 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
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
	jernej.skrabec@gmail.com,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	krzysztof.kozlowski@linaro.org,
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
	m.szyprowski@samsung.com,
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
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com
Subject: [PATCH v2 09/10] iommu: observability of the IOMMU allocations
Date: Thu, 30 Nov 2023 20:15:03 +0000
Message-ID: <20231130201504.2322355-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NR_IOMMU_PAGES into node_stat_item that counts number of pages
that are allocated by the IOMMU subsystem.

The allocations can be view per-node via:
/sys/devices/system/node/nodeN/vmstat.

For example:

$ grep iommu /sys/devices/system/node/node*/vmstat
/sys/devices/system/node/node0/vmstat:nr_iommu_pages 106025
/sys/devices/system/node/node1/vmstat:nr_iommu_pages 3464

The value is in page-count, therefore, in the above example
the iommu allocations amount to ~428M.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/iommu-pages.h | 30 ++++++++++++++++++++++++++++++
 include/linux/mmzone.h      |  3 +++
 mm/vmstat.c                 |  3 +++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index 2332f807d514..69895a355c0c 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -17,6 +17,30 @@
  * state can be rather large, i.e. multiple gigabytes in size.
  */
 
+/**
+ * __iommu_alloc_account - account for newly allocated page.
+ * @pages: head struct page of the page.
+ * @order: order of the page
+ */
+static inline void __iommu_alloc_account(struct page *pages, int order)
+{
+	const long pgcnt = 1l << order;
+
+	mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, pgcnt);
+}
+
+/**
+ * __iommu_free_account - account a page that is about to be freed.
+ * @pages: head struct page of the page.
+ * @order: order of the page
+ */
+static inline void __iommu_free_account(struct page *pages, int order)
+{
+	const long pgcnt = 1l << order;
+
+	mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, -pgcnt);
+}
+
 /**
  * __iommu_alloc_pages_node - allocate a zeroed page of a given order from
  * specific NUMA node.
@@ -35,6 +59,8 @@ static inline struct page *__iommu_alloc_pages_node(int nid, gfp_t gfp,
 	if (!pages)
 		return NULL;
 
+	__iommu_alloc_account(pages, order);
+
 	return pages;
 }
 
@@ -53,6 +79,8 @@ static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
 	if (!pages)
 		return NULL;
 
+	__iommu_alloc_account(pages, order);
+
 	return pages;
 }
 
@@ -89,6 +117,7 @@ static inline void __iommu_free_pages(struct page *pages, int order)
 	if (!pages)
 		return;
 
+	__iommu_free_account(pages, order);
 	__free_pages(pages, order);
 }
 
@@ -192,6 +221,7 @@ static inline void iommu_free_pages_list(struct list_head *pages)
 		struct page *p = list_entry(pages->prev, struct page, lru);
 
 		list_del(&p->lru);
+		__iommu_free_account(p, 0);
 		put_page(p);
 	}
 }
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3c25226beeed..1a4d0bba3e8b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -200,6 +200,9 @@ enum node_stat_item {
 #endif
 	NR_PAGETABLE,		/* used for pagetables */
 	NR_SECONDARY_PAGETABLE, /* secondary pagetables, e.g. KVM pagetables */
+#ifdef CONFIG_IOMMU_SUPPORT
+	NR_IOMMU_PAGES,		/* # of pages allocated by IOMMU */
+#endif
 #ifdef CONFIG_SWAP
 	NR_SWAPCACHE,
 #endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 359460deb377..801b58890b6c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1242,6 +1242,9 @@ const char * const vmstat_text[] = {
 #endif
 	"nr_page_table_pages",
 	"nr_sec_page_table_pages",
+#ifdef CONFIG_IOMMU_SUPPORT
+	"nr_iommu_pages",
+#endif
 #ifdef CONFIG_SWAP
 	"nr_swapcached",
 #endif
-- 
2.43.0.rc2.451.g8631bc7472-goog


