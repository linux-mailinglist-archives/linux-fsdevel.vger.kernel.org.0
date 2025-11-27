Return-Path: <linux-fsdevel+bounces-69990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C7C8D837
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 10:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B0483444E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876A7329C6B;
	Thu, 27 Nov 2025 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXD6WbzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE93C328241;
	Thu, 27 Nov 2025 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235458; cv=none; b=XBDW8Cbcnlklth4yPuDerOK3CGlyFDSNFAWa6BJAgnaOHS45C27X+lCWp3FQkMdh1FqaOs5wbNUHEvLg6w2KvYQTfw1W1giZdigmxZOs7/Wo2n+/jFtN3LLOonfn3vZPywB4ocXU830VdAX4quNT5r+vBVoaDpxcfKthnw6eJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235458; c=relaxed/simple;
	bh=XlyfUYuWkICDUfkFcCQCj16yl/DMg/jjxI+jKDmBYg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WH0tYE7AjCmmQVEdulD5YGg14IoEfUVgsXkNBQjTqMX2WZArf9RigdH+OxKcWN20UEK7bO3NvyiqtUd8qCzAR78GXykKY46HWS91DdjT64KJ2g0xIf+48wULtWuQBO2HzzEafD9vBvYO/D/vcBlVmKz3fgJ+eb0Oy5Sk5atrp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXD6WbzY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764235456; x=1795771456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XlyfUYuWkICDUfkFcCQCj16yl/DMg/jjxI+jKDmBYg0=;
  b=hXD6WbzYi+eWmyuv1GPnb/YFjj+qZw6Mri0uMZd74HKO7L8novy7cK38
   PSdFKDqyWmt04mPuqTseYEVI0JAhvrYHDqgcZxJvg1UhgFWTkrXeDi/s7
   JFXnl2mMfoAK65dF98tUU3QyIXV/D/5krRQguo/stIHM/F6HHV4eiiD3Q
   20KSRvFAlVXoaW46ZqL/h2AcE3ffKtFWHuHFckrQIVTznCYu3ahMnyH4L
   RmQpwSWJK4ufK+xaLDfMoSpxJmOtjikW/YdvRRjkF/m5CLWHhEpj90eOd
   o7voCZlP3auLSaY6AuLjvqZzJlESqnJJQi7o43x2D8FzpXuSYJq3Xhn34
   Q==;
X-CSE-ConnectionGUID: DmLioPkxTBKM92Z+Q/HRmw==
X-CSE-MsgGUID: VSvjSZrIRG6fEEtMqwX6dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66226343"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="66226343"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:24:16 -0800
X-CSE-ConnectionGUID: DlvEOMD2R++DjwHq95mBvQ==
X-CSE-MsgGUID: jGxafr28T76J8iM+e4YXaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="223888066"
Received: from jsokolow-alderlakeclientplatform.igk.intel.com ([172.28.176.71])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 01:24:14 -0800
From: Jan Sokolowski <jan.sokolowski@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Jan Sokolowski <jan.sokolowski@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/1] idr: do not create idr if new id would be outside given range
Date: Thu, 27 Nov 2025 10:27:32 +0100
Message-ID: <20251127092732.684959-2-jan.sokolowski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127092732.684959-1-jan.sokolowski@intel.com>
References: <20251127092732.684959-1-jan.sokolowski@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A scenario was found where trying to add id in range 0,1
would return an id of 2, which is outside the range and thus
now what the user would expect.

Return -EINVAL if new id would fall outside the range.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 lib/idr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/idr.c b/lib/idr.c
index e2adc457abb4..8c786e50f2da 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -74,6 +74,7 @@ EXPORT_SYMBOL_GPL(idr_alloc_u32);
  * exclude simultaneous writers.
  *
  * Return: The newly allocated ID, -ENOMEM if memory allocation failed,
+ * -EINVAL is start value is less than 0 or if new id would be in wrong range,
  * or -ENOSPC if no free IDs could be found.
  */
 int idr_alloc(struct idr *idr, void *ptr, int start, int end, gfp_t gfp)
@@ -88,6 +89,11 @@ int idr_alloc(struct idr *idr, void *ptr, int start, int end, gfp_t gfp)
 	if (ret)
 		return ret;
 
+	if (WARN_ON_ONCE(id < start || (id >= end && end != 0))) {
+		idr_remove(idr, id);
+		return -EINVAL;
+	}
+
 	return id;
 }
 EXPORT_SYMBOL_GPL(idr_alloc);
@@ -112,6 +118,7 @@ EXPORT_SYMBOL_GPL(idr_alloc);
  * exclude simultaneous writers.
  *
  * Return: The newly allocated ID, -ENOMEM if memory allocation failed,
+ * -EINVAL if new id would be in wrong range,
  * or -ENOSPC if no free IDs could be found.
  */
 int idr_alloc_cyclic(struct idr *idr, void *ptr, int start, int end, gfp_t gfp)
@@ -130,6 +137,11 @@ int idr_alloc_cyclic(struct idr *idr, void *ptr, int start, int end, gfp_t gfp)
 	if (err)
 		return err;
 
+	if (WARN_ON_ONCE(id < start || (id >= end && end != 0))) {
+		idr_remove(idr, id);
+		return -EINVAL;
+	}
+
 	idr->idr_next = id + 1;
 	return id;
 }
-- 
2.43.0


