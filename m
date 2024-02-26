Return-Path: <linux-fsdevel+bounces-12771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49769867024
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE60428B7C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE161651B2;
	Mon, 26 Feb 2024 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="bRv8Wx5c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B427063517;
	Mon, 26 Feb 2024 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940999; cv=none; b=W6PbpF4Q9NToLleOraylGa617nRdcwL7bbsphggN8Xgu9S8pyz5f9RfHR1BwvKfgAkpATZXeKjkXo5vEoNDVQAuXJLvqwDDP1/GHy21KNweO27ZzCKLIyhp7TIgshuZeIxZnw74aMGLcFWgpMvajC91qJlhMKdy+0ebcTt1IBFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940999; c=relaxed/simple;
	bh=jlHABLKNapSS9lIteDzKyffRmTxjtJQluocjrZHWOJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyNCLFoMa84qcF9lvtzl//2FYFKu1pTno/zTGyvXqfh5yFAxu/mlS0EOz4OQTtMS0mKYSjA/4nML2IJGTzQcUQFVs2Pue7l9CLdEKBLr4whGiYtEtIcuKuD+zdrLnd/rleLYdc1ggNVANQzyYjewbt9vfa6KAJNzryG9pgM8Zys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=bRv8Wx5c; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Tjwnt1tBzz9sTM;
	Mon, 26 Feb 2024 10:49:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1708940994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UE/+ngzUW37ueqbuDmtoyKLgw47SUrAWwA7DBQ7fmXA=;
	b=bRv8Wx5cvk1xd9wVeRlOtaJZztEuuuk3hMBOtenVjKOEhVioQUed98THwPiUUu1f9r9DH7
	wVd6ZXgT96T6EnmbVf914Uc1jQ24dL54EHczA3owM2IwVEsCOd+na63QUB+HW4d9qUx1k4
	bp9FGTWx3r3Ga4N411mN/gefo51B/cN3YxgI8XUjBXEjt1A0bW5GTLmIo6bAvCkwJmSYZr
	yCwDty8PFIfD+eTzomhQEytKQGuLbLueIt3c2sw5+totLREcGF7IRnsOPc6FjNyCRSOSsq
	lnNJkHsVkyCXiILF76ixMcjR7kuA4Zp24E1MDjwHFSTRTXs+gDEU8TW1r1YJXQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	ziy@nvidia.com,
	hare@suse.de,
	djwong@kernel.org,
	gost.dev@samsung.com,
	linux-mm@kvack.org,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 03/13] filemap: align the index to mapping_min_order in the page cache
Date: Mon, 26 Feb 2024 10:49:26 +0100
Message-ID: <20240226094936.2677493-4-kernel@pankajraghav.com>
In-Reply-To: <20240226094936.2677493-1-kernel@pankajraghav.com>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Tjwnt1tBzz9sTM

From: Luis Chamberlain <mcgrof@kernel.org>

Supporting mapping_min_order implies that we guarantee each folio in the
page cache has at least an order of mapping_min_order. So when adding new
folios to the page cache we must ensure the index used is aligned to the
mapping_min_order as the page cache requires the index to be aligned to
the order of the folio.

A higher order folio than min_order by definition is a multiple of the
min_order. If an index is aligned to an order higher than a min_order, it
will also be aligned to the min order.

This effectively introduces no new functional changes when min order is
not set other than a few rounding computations that should result in the
same value.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/pagemap.h |  8 ++++++++
 mm/filemap.c            | 22 +++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index fc8eb9c94e9c..fe8e1fbb667d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1328,6 +1328,14 @@ struct readahead_control {
 		._index = i,						\
 	}
 
+#define DEFINE_READAHEAD_ALIGNED(ractl, f, r, m, i)			\
+	struct readahead_control ractl = {				\
+		.file = f,						\
+		.mapping = m,						\
+		.ra = r,						\
+		._index = mapping_align_start_index(m, i),		\
+	}
+
 #define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
 
 void page_cache_ra_unbounded(struct readahead_control *,
diff --git a/mm/filemap.c b/mm/filemap.c
index 2b00442b9d19..bdf4f65f597c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2478,11 +2478,11 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
 	struct file_ra_state *ra = &filp->f_ra;
-	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
-	pgoff_t last_index;
+	pgoff_t index, last_index;
 	struct folio *folio;
 	int err = 0;
 
+	index = mapping_align_start_index(mapping, iocb->ki_pos >> PAGE_SHIFT);
 	/* "last_index" is the index of the page beyond the end of the read */
 	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
 retry:
@@ -2500,8 +2500,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	if (!folio_batch_count(fbatch)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
-		err = filemap_create_folio(filp, mapping,
-				iocb->ki_pos >> PAGE_SHIFT, fbatch);
+		err = filemap_create_folio(filp, mapping, index, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
@@ -3093,7 +3092,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
-	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
+	DEFINE_READAHEAD_ALIGNED(ractl, file, ra, mapping, vmf->pgoff);
 	struct file *fpin = NULL;
 	unsigned long vm_flags = vmf->vma->vm_flags;
 	unsigned int mmap_miss;
@@ -3147,7 +3146,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
 	ra->size = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
-	ractl._index = ra->start;
+	ractl._index = mapping_align_start_index(mapping, ra->start);
 	page_cache_ra_order(&ractl, ra, 0);
 	return fpin;
 }
@@ -3162,7 +3161,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 {
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
-	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
+	DEFINE_READAHEAD_ALIGNED(ractl, file, ra, file->f_mapping, vmf->pgoff);
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
@@ -3211,11 +3210,12 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	struct file *fpin = NULL;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
-	pgoff_t max_idx, index = vmf->pgoff;
+	pgoff_t max_idx, index;
 	struct folio *folio;
 	vm_fault_t ret = 0;
 	bool mapping_locked = false;
 
+	index = mapping_align_start_index(mapping, vmf->pgoff);
 	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
@@ -3321,7 +3321,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 	}
 
-	vmf->page = folio_file_page(folio, index);
+	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
+			folio);
+
+	vmf->page = folio_file_page(folio, vmf->pgoff);
 	return ret | VM_FAULT_LOCKED;
 
 page_not_uptodate:
@@ -3657,6 +3660,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 	struct folio *folio;
 	int err;
 
+	index = mapping_align_start_index(mapping, index);
 	if (!filler)
 		filler = mapping->a_ops->read_folio;
 repeat:
-- 
2.43.0


