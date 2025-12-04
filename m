Return-Path: <linux-fsdevel+bounces-70672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F8DCA4060
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF89304064D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A7F335089;
	Thu,  4 Dec 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="WCjS6MFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4BE336ED5;
	Thu,  4 Dec 2025 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764858421; cv=pass; b=a+dt6kCWglen+/IlZM4kF9gNxuUfrN8tIdoDt9uPSfTXul1X8rg4S00EBeepT3AGn7It9GBTdR+e4ywjoobI/sGWTEjM/ad75dJDaT+JSPUh8XTmwMQA0WquAxruWokpKPfyL59puTxtDYkmE/Vmrv19NqmtynF96Nmj/NsyEd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764858421; c=relaxed/simple;
	bh=THCKeTVFVHMviMN82TK+XqkvXT7lhhS4qjF9VkpzQ9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nQg7hmh/w1X8RPMnl30cLkd8t8gvAcM2uJaRcJjrYNou6zDzhaKiUBTnAHoszMtZ9uYrDcebHqkIK6qBOZdG524nu1vmxKiqewNLIVMuGdZWIYR3Pm+oEdLKll6fQWaTWSbzOJnePIWFw17l8mEb7Gh6W9B3rI86r/JTgcU6tYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=WCjS6MFX; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1764858403; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TTQgZYZz/WhyLTUquTxhTANp/z34+MLx25M9GEfDYH7mJ5eZxtKUTZzMRYXFDMvkWJF5YActSjZ/ExiwhYO0OFiqTBlbppKOahlXzpz7skiHkudg9xnIxMF7kZpLg8VCsv/IP8BortDp5KunJYKwT6A0ULkZ1lxNI9Uj3fe4GL8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764858403; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vwd613HLQXIyOP+YbNB/nPdle55ky5l9YRnVAz5wTxM=; 
	b=V3zxTrrfa1I9dHIyC0Yi0Xg1/9Ro1JDMFPCHvw6AgOMCrVwkgjWj1pMOa7QW/iuBgvEQU/GlqUvjWThbNYKfLWJ8lp65HuWyoIoQjBwA13CBr+ns25J2X/bIAYWol4sPdJhIwicZ7XmSnVPiJjT6NA49JiOsZRpKPZsQaHL8mUI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764858403;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=vwd613HLQXIyOP+YbNB/nPdle55ky5l9YRnVAz5wTxM=;
	b=WCjS6MFXQVRZZWATobxQyrmOQYFdqIWJ5xiw22MmXdLGIuMcRgJ4LyXrW7H3Pse6
	btQ6Df6IjMyvS9G4X/81wzrhhjE+kOfQ+iRnWdIbpS7TPWqiDWEhDFnxds3oIu9HVW3
	6ekPCO0+f8MS0mjx4ROsWo26IbBMjERkmK3UCSRE=
Received: by mx.zohomail.com with SMTPS id 1764858402454442.7495368017717;
	Thu, 4 Dec 2025 06:26:42 -0800 (PST)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dev.jain@arm.com,
	david@kernel.org,
	shardulsb08@gmail.com,
	janak@mpiricsoftware.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v4] lib: xarray: free unused spare node in xas_create_range()
Date: Thu,  4 Dec 2025 19:56:25 +0530
Message-Id: <20251204142625.1763372-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

xas_create_range() is typically called in a retry loop that uses
xas_nomem() to handle -ENOMEM errors. xas_nomem() may allocate a spare
xa_node and store it in xas->xa_alloc for use in the retry.

If the lock is dropped after xas_nomem(), another thread can expand the
xarray tree in the meantime. On the next retry, xas_create_range() can
then succeed without consuming the spare node stored in xas->xa_alloc.
If the function returns without freeing this spare node, it leaks.

xas_create_range() calls xas_create() multiple times in a loop for
different index ranges. A spare node that isn't needed for one range
iteration might be needed for the next, so we cannot free it after each
xas_create() call. We can only safely free it after xas_create_range()
completes.

Fix this by calling xas_destroy() at the end of xas_create_range() to
free any unused spare node. This makes the API safer by default and
prevents callers from needing to remember cleanup.

This fixes a memory leak in mm/khugepaged.c and potentially other
callers that use xas_nomem() with xas_create_range().

Link: https://syzkaller.appspot.com/bug?id=a274d65fc733448ed518ad15481ed575669dd98c
Link: https://lore.kernel.org/all/20251201074540.3576327-1-shardul.b@mpiricsoftware.com/ ("v3")
Fixes: cae106dd67b9 ("mm/khugepaged: refactor collapse_file control flow")
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 v4:
 - Drop redundant `if (xa_alloc)` around xas_destroy(), as xas_destroy()
   already checks xa_alloc internally.
 v3:
 - Move fix from collapse_file() to xas_create_range() as suggested by Matthew Wilcox
 - Fix in library function makes API safer by default, preventing callers from needing
   to remember cleanup
 - Use shared cleanup label that both restore: and success: paths jump to
 - Clean up unused spare node on both success and error exit paths
 v2:
 - Call xas_destroy() on both success and failure
 - Explained retry semantics and xa_alloc / concurrency risk
 - Dropped cleanup_empty_nodes from previous proposal

 lib/xarray.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 9a8b4916540c..f49ccfa5f57d 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -744,11 +744,16 @@ void xas_create_range(struct xa_state *xas)
 	xas->xa_shift = shift;
 	xas->xa_sibs = sibs;
 	xas->xa_index = index;
-	return;
+	goto cleanup;
+
 success:
 	xas->xa_index = index;
 	if (xas->xa_node)
 		xas_set_offset(xas);
+
+cleanup:
+	/* Free any unused spare node from xas_nomem() */
+	xas_destroy(xas);
 }
 EXPORT_SYMBOL_GPL(xas_create_range);
 
-- 
2.34.1


