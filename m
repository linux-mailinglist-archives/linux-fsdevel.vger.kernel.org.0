Return-Path: <linux-fsdevel+bounces-32318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1F9A35CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B691C239A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66427191461;
	Fri, 18 Oct 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Adx2kk0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4918EFC9;
	Fri, 18 Oct 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233672; cv=none; b=VrLUEZiGa1Snz8PNUVwIl6IpEGhWSy2LXnx6HJgY0apc4FFaw5H2oWTSLbvwTSHDIbB1l3fjL9e2eUHQDAi2ir0QVBc8mWPbwetSIM834tUvUZjzWyxj6ryJeu6dvEsyZaf3j/xnZ43U4d7RTE3gDJib7z+JrUT7WajmgOzCqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233672; c=relaxed/simple;
	bh=Qqxb4WHT8bprxcMFQO92c1NKetq9casrAYfBRMVL0vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UXrrAGEhAGPBcs1RNs6Qt//THofZ8A7ygqQuJwso4afgD1KKaB6Knl0ZEaKrf2n3GHqJ0Z5ZLbzislqysg4tJ2CIQ1IUgC5AzgM4j9IM10twv7UjVVWwPzjTOY3Pcu/gJCGmUOB/z+bLpBViD4t0SKMjXXUFAavDuO8t4+00ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Adx2kk0j; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233670; x=1760769670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qqxb4WHT8bprxcMFQO92c1NKetq9casrAYfBRMVL0vQ=;
  b=Adx2kk0j5sX8sz+YILZ2GpPAFybtJzSXfIyGYFTFStPbUL6aVpeRH7zG
   UkrR6Au0w3B7vvWlUXO5viulnOJKjcYLeh0Ep5VbVNqc2uf4w0mKHuc+0
   PdH2fBzWyt4kFBWqs8yl/mVn7t4J9/wznHc+8pfYzaKSyz329CesaNTZ9
   AY3yDUBEqQs9dALVKgosNeavez/mqX+y/AuxYvaJOC7nyVqY621P/MwPd
   68MUwINM+3PjR1r+Ue9TlN/JUoCXrEVAq8QD7X0Q72v42nsBqVuEawUmt
   XmJUc7uSCOXk2vKjRYGLn2VspkAlSQ8saKgvW0ltfv2HJH4Z3fhwy/Eea
   g==;
X-CSE-ConnectionGUID: SVG1qsaJQOqklOxKz7Po5w==
X-CSE-MsgGUID: Zw8jxwK2SUmWUgxoWESP6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884904"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884904"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:03 -0700
X-CSE-ConnectionGUID: KzCXCTJiQFKm7BYr/a601A==
X-CSE-MsgGUID: e8EgEA8oSM6ZXNXDpKJJHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607525"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 23:41:03 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	zanussi@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mcgrof@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bfoster@redhat.com,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 09/13] mm: zswap: Config variable to enable compress batching in zswap_store().
Date: Thu, 17 Oct 2024 23:40:57 -0700
Message-Id: <20241018064101.336232-10-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new zswap config variable that controls whether zswap_store() will
compress a batch of pages, for instance, the pages in a large folio:

  CONFIG_ZSWAP_STORE_BATCHING_ENABLED

The existing CONFIG_CRYPTO_DEV_IAA_CRYPTO variable added in commit
ea7a5cbb4369 ("crypto: iaa - Add Intel IAA Compression Accelerator crypto
driver core") is used to detect if the system has the Intel Analytics
Accelerator (IAA), and the iaa_crypto module is available. If so, the
kernel build will prompt for CONFIG_ZSWAP_STORE_BATCHING_ENABLED. Hence,
users have the ability to set CONFIG_ZSWAP_STORE_BATCHING_ENABLED="y" only
on systems that have Intel IAA.

If CONFIG_ZSWAP_STORE_BATCHING_ENABLED is enabled, and IAA is configured
as the zswap compressor, zswap_store() will process the pages in a large
folio in batches, i.e., multiple pages at a time. Pages in a batch will be
compressed in parallel in hardware, then stored. On systems without Intel
IAA and/or if zswap uses software compressors, pages in the batch will be
compressed sequentially and stored.

The patch also implements a zswap API that returns the status of this
config variable.

Suggested-by: Ying Huang <ying.huang@intel.com>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/zswap.h |  6 ++++++
 mm/Kconfig            | 12 ++++++++++++
 mm/zswap.c            | 14 ++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index d961ead91bf1..74ad2a24b309 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -24,6 +24,7 @@ struct zswap_lruvec_state {
 	atomic_long_t nr_disk_swapins;
 };
 
+bool zswap_store_batching_enabled(void);
 unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
 bool zswap_load(struct folio *folio);
@@ -39,6 +40,11 @@ bool zswap_never_enabled(void);
 
 struct zswap_lruvec_state {};
 
+static inline bool zswap_store_batching_enabled(void)
+{
+	return false;
+}
+
 static inline bool zswap_store(struct folio *folio)
 {
 	return false;
diff --git a/mm/Kconfig b/mm/Kconfig
index 33fa51d608dc..26d1a5cee471 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -125,6 +125,18 @@ config ZSWAP_COMPRESSOR_DEFAULT
        default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
        default ""
 
+config ZSWAP_STORE_BATCHING_ENABLED
+	bool "Batching of zswap stores with Intel IAA"
+	depends on ZSWAP && CRYPTO_DEV_IAA_CRYPTO
+	default n
+	help
+	Enables zswap_store to swapout large folios in batches of 8 pages,
+	rather than a page at a time, if the system has Intel IAA for hardware
+	acceleration of compressions. If IAA is configured as the zswap
+	compressor, this will parallelize batch compression of upto 8 pages
+	in the folio in	hardware, thereby improving large folio compression
+	throughput and reducing swapout latency.
+
 choice
 	prompt "Default allocator"
 	depends on ZSWAP
diff --git a/mm/zswap.c b/mm/zswap.c
index 948c9745ee57..4893302d8c34 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -127,6 +127,15 @@ static bool zswap_shrinker_enabled = IS_ENABLED(
 		CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
 module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
 
+/*
+ * Enable/disable batching of compressions if zswap_store is called with a
+ * large folio. If enabled, and if IAA is the zswap compressor, pages are
+ * compressed in parallel in batches of say, 8 pages.
+ * If not, every page is compressed sequentially.
+ */
+static bool __zswap_store_batching_enabled = IS_ENABLED(
+	CONFIG_ZSWAP_STORE_BATCHING_ENABLED);
+
 bool zswap_is_enabled(void)
 {
 	return zswap_enabled;
@@ -241,6 +250,11 @@ static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpool))
 
+__always_inline bool zswap_store_batching_enabled(void)
+{
+	return __zswap_store_batching_enabled;
+}
+
 /*********************************
 * pool functions
 **********************************/
-- 
2.27.0


