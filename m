Return-Path: <linux-fsdevel+bounces-11337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C679852C80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512611C23138
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD548381B6;
	Tue, 13 Feb 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="MssUC8Ev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776C3364C5;
	Tue, 13 Feb 2024 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817061; cv=none; b=KbHG8oVHn24wy03C1/8MWQW4Ur4WydycNM/RgEf9nPgMdh+U7HpK1RHzU31ym8f6ORnq/T9YPa3VRafXMa/kIOBKo5bbDwOjkxEQcrY8dS62pQhA9naA9EgoCFrYDxBy8KmAFhslu4w+elBikVCJeNHWciw7qQkJwsPdlKIn6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817061; c=relaxed/simple;
	bh=8MdY3QQ4ZN+th5q5qQ6k768r1LiNi0uKAdJ0YctqX2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMl+FgYzdRFUOkt0cNmjNjCkSl46NOp+T2FG5948+sYGECr+6Tn6o/cIoWpaByRsRXBHLy4iC/SFwEgnpshGQsdGx7/GZoWTdns2sH3Zax79FXrO83rtQbOanPMJ3Dr+a6SXkEezCgUENte65mHvx4XxlQCxOvhBvC0kpZm0Vec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=MssUC8Ev; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TYx7Z18lWz9swL;
	Tue, 13 Feb 2024 10:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707817050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9ziATPUggPlhgislum4xTFLvTMOz0MhHtv1RpfgBms=;
	b=MssUC8EvZXGuZKgwffeP8hZBO3/nI8BUTOn+lQ37ROHXeTh/hED181KRtCHW6PELMLF0UE
	DEYwufaeT4jV1tuqEVGeSMTaAwMDle5ktiI2EYlKQPjJTQp/vX6/rgh4t8muYPfvrXpcjV
	hl09EmSpiojQVTrmt2iVgR6ncEJxJK4SW2dbrCqna7p8ayxhpiMmQpfs1UXv1lF/PX5iP4
	m8xTmQzMzVSGJz1P+oVrwsTiU4/m/f9+f8Im/vqTieSDlf28XAOIkW0Qd8LCWRGkPeNIvu
	z48iIrv01XiHn1kxa2oJFgIu9wdVvN1Un6+RzVnIo1BkcnvB0SUBi8zi64m4MA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org,
	gost.dev@samsung.com,
	akpm@linux-foundation.org,
	kbusch@kernel.org,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	p.raghav@samsung.com,
	linux-kernel@vger.kernel.org,
	hare@suse.de,
	willy@infradead.org,
	linux-mm@kvack.org,
	david@fromorbit.com
Subject: [RFC v2 03/14] filemap: use mapping_min_order while allocating folios
Date: Tue, 13 Feb 2024 10:37:02 +0100
Message-ID: <20240213093713.1753368-4-kernel@pankajraghav.com>
In-Reply-To: <20240213093713.1753368-1-kernel@pankajraghav.com>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

filemap_create_folio() and do_read_cache_folio() were always allocating
folio of order 0. __filemap_get_folio was trying to allocate higher
order folios when fgp_flags had higher order hint set but it will default
to order 0 folio if higher order memory allocation fails.

As we bring the notion of mapping_min_order, make sure these functions
allocate at least folio of mapping_min_order as we need to guarantee it
in the page cache.

Add some additional VM_BUG_ON() in page_cache_delete[batch] and
__filemap_add_folio to catch errors where we delete or add folios that
has order less than min_order.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/filemap.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 323a8e169581..7a6e15c47150 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -127,6 +127,7 @@
 static void page_cache_delete(struct address_space *mapping,
 				   struct folio *folio, void *shadow)
 {
+	unsigned int min_order = mapping_min_folio_order(mapping);
 	XA_STATE(xas, &mapping->i_pages, folio->index);
 	long nr = 1;
 
@@ -135,6 +136,7 @@ static void page_cache_delete(struct address_space *mapping,
 	xas_set_order(&xas, folio->index, folio_order(folio));
 	nr = folio_nr_pages(folio);
 
+	VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	xas_store(&xas, shadow);
@@ -277,6 +279,7 @@ void filemap_remove_folio(struct folio *folio)
 static void page_cache_delete_batch(struct address_space *mapping,
 			     struct folio_batch *fbatch)
 {
+	unsigned int min_order = mapping_min_folio_order(mapping);
 	XA_STATE(xas, &mapping->i_pages, fbatch->folios[0]->index);
 	long total_pages = 0;
 	int i = 0;
@@ -305,6 +308,7 @@ static void page_cache_delete_batch(struct address_space *mapping,
 
 		WARN_ON_ONCE(!folio_test_locked(folio));
 
+		VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
 		folio->mapping = NULL;
 		/* Leave folio->index set: truncation lookup relies on it */
 
@@ -846,6 +850,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	int huge = folio_test_hugetlb(folio);
 	bool charged = false;
 	long nr = 1;
+	unsigned int min_order = mapping_min_folio_order(mapping);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
@@ -896,6 +901,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 			}
 		}
 
+		VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
 		xas_store(&xas, folio);
 		if (xas_error(&xas))
 			goto unlock;
@@ -1847,6 +1853,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp)
 {
 	struct folio *folio;
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
+
+	index = round_down(index, min_nrpages);
 
 repeat:
 	folio = filemap_get_entry(mapping, index);
@@ -1886,7 +1896,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_wait_stable(folio);
 no_page:
 	if (!folio && (fgp_flags & FGP_CREAT)) {
-		unsigned order = FGF_GET_ORDER(fgp_flags);
+		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
 		int err;
 
 		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
@@ -1914,8 +1924,13 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order == 1)
 				order = 0;
+			if (order < min_order)
+				order = min_order;
 			if (order > 0)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
+
+			VM_BUG_ON(index & ((1UL << order) - 1));
+
 			folio = filemap_alloc_folio(alloc_gfp, order);
 			if (!folio)
 				continue;
@@ -1929,7 +1944,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 				break;
 			folio_put(folio);
 			folio = NULL;
-		} while (order-- > 0);
+		} while (order-- > min_order);
 
 		if (err == -EEXIST)
 			goto repeat;
@@ -2424,7 +2439,8 @@ static int filemap_create_folio(struct file *file,
 	struct folio *folio;
 	int error;
 
-	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
+				    mapping_min_folio_order(mapping));
 	if (!folio)
 		return -ENOMEM;
 
@@ -3682,7 +3698,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
-		folio = filemap_alloc_folio(gfp, 0);
+		folio = filemap_alloc_folio(gfp,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		err = filemap_add_folio(mapping, folio, index, gfp);
-- 
2.43.0


