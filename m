Return-Path: <linux-fsdevel+bounces-70295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9A9C960BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 08:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F219F342E83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 07:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55C2D738E;
	Mon,  1 Dec 2025 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="bbY9ibHh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender3-of-o55.zoho.com (sender3-of-o55.zoho.com [136.143.184.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0923EA88;
	Mon,  1 Dec 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764575180; cv=pass; b=hIjrfPYgZ/wuIBuBFuYU6rL49h1pjwIXNAfZ7kyLiWUzK/I+uTU8l4rMWRJ5Mjr4txL2pLQ2fmUznuZAvkOs6OaEjy8deFL/1j472M+O7Nf/W/u3Y9uud8VEm06wrhCNQqqXcDTDoMSu+KLA2NJo4MeEIWaCffUcUT7cQqJViZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764575180; c=relaxed/simple;
	bh=jbAPKfkUMIe0eMFIS8kY4GVhNBnztWreVjEp9qy4MkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0muWIrhF1vLPpgccNZD6ejVNUrTXecTzhE67dY3QYJ8Rg88n+46LywCwourCwZ7wavVFm6aE/KWwXewGL8AGCr4Npaxgm3exUT83LbEobRHHgH5EZXFttWBgScq+zWBXA2sV8GWbhuwBE0HscZAVBy+D2xagZKdx3j7s3pT7hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=bbY9ibHh; arc=pass smtp.client-ip=136.143.184.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1764575151; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RM7FSSWt5ExfvBZPfoyhTHrKSp6ZrNpCaVo7QjvCe4BJHFUwLsGUKV7p+ga0W3+Yl0ht2eWId3X/uDnfV85DDT0qDnmtZOMFwekY9MkQqhyB6JbRR2mmCweIm9tarvkQwncP7M2AoZLoVxiDBgoai9wC/Shmxrv9+RBae6A7+io=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764575151; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7w3dSfaWrYwjp4+7lWC1VjH2NSXdXNvxA1hcZmWSbHc=; 
	b=Lo87pcVh831pbfvXxxZR8Io9dVhXV5WAybxq9BUy0CFW33IHzLRtdKgKJ6sCbEj+OUiG0alF/Wvn8LVojq1tDpklo8STv8vFGCWy/FPZ8Nu+dOS9tQqn9XtsgR0h4HZasCIAgWuWBtUoH48sbFHqRqoPLAPHkw5rq5Iem61hm8I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764575151;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=7w3dSfaWrYwjp4+7lWC1VjH2NSXdXNvxA1hcZmWSbHc=;
	b=bbY9ibHhMS1qr1Nslgiuwwvt5NShzKJwlwUSbM+Sk+doS+yr+xCksSfvDiT44+Kx
	hKOW0KZrdRyDbgsz3ii1sh2BxDL8yJf/FrpzgXVzLExeV6bV/i4grix3fU32b4A/qXP
	scSKjBMWYtWleF/AbQpBRzL9zkShQXifU3+JYhEc=
Received: by mx.zohomail.com with SMTPS id 1764575148860438.9814188033906;
	Sun, 30 Nov 2025 23:45:48 -0800 (PST)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: willy@infradead.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: dev.jain@arm.com,
	david@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shardulsb08@gmail.com,
	janak@mpiricsoftware.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v3] lib: xarray: free unused spare node in xas_create_range()
Date: Mon,  1 Dec 2025 13:15:40 +0530
Message-Id: <20251201074540.3576327-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7a31f01ac0d63788e5fbac15192c35229e1f980a.camel@mpiricsoftware.com>
References: <7a31f01ac0d63788e5fbac15192c35229e1f980a.camel@mpiricsoftware.com>
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
Fixes: cae106dd67b9 ("mm/khugepaged: refactor collapse_file control flow")
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
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
 lib/xarray.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 9a8b4916540c..a924421c0c4c 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -744,11 +744,17 @@ void xas_create_range(struct xa_state *xas)
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
+	if (xas->xa_alloc)
+		xas_destroy(xas);
 }
 EXPORT_SYMBOL_GPL(xas_create_range);
 
-- 
2.34.1


