Return-Path: <linux-fsdevel+bounces-11335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CFF852C7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AB32872A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD542E64E;
	Tue, 13 Feb 2024 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="aXtgjhd1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6492C68A;
	Tue, 13 Feb 2024 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817057; cv=none; b=XgEr06jKE7j3EMuurD6nN4abQ1Fs0l8eb8I/87jPXPIescqcjzY8wlL/5hxN1MabI1cug/cUYbLbRHlC6+ZzPikOP2Ne20tbEbINyXkrvUd+W4uYs+KwyXkJKYYk1YtSudXIGWKhPkRPjoP3Dhgmkgx9CbK9LxkkxAMrdbbHy/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817057; c=relaxed/simple;
	bh=cG5SVOvDDNw/cZjZuDOukkzQqJjGokx8ur32PBsSpcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEwuDx0+vTSG6IcT7uccQx0+1XT6/1CvZlkmis1gS66N4cZIYva2VJEQNRoXh81j5+ZV8QfL9s0BN5HVudm+ctXJ3YCiQWig1R5p4KRYzvD0N18lezmeTOZmS8hbogkqKlLUlRAkOKWfShVZmaJuPiUUUjNMuGbz4rKbkpUt19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=aXtgjhd1; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TYx7V3jchz9smV;
	Tue, 13 Feb 2024 10:37:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707817046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1pKcMbFRFRAPVwFIcuNop7Fe4l/PLjOYcOBcxoLFyo=;
	b=aXtgjhd1b//XRwpHD3/R1kk0mMTstSjUb1ouVBf6fckgb8rZuNI8zTh5DEfERSatuEP7pk
	8r5YZ81b978D/uP1iocDT3hJ0DAMvsePx0hbDmXJc9fXVhf/Umqd3qoeywBTAMUWEkLzBc
	vtPR/X4NoIYAa+boy6TQjlTNfkn8RNxra5BUp+2y9fcjIv/1CtJ/6sZEPGCZgSCQqAxIvE
	3thP6Rsg48Qm50MXNeztGsGj45DAUmbTwN4x4ViCWqPcJT8qc7mVogI7IwJNiQjIzN9/1H
	Z+3XDCrnf0weMSLu5URLoEZIWi8/LyMh3ZET8GObGX6Kn0hq/Rz6GqEnzMZ0iw==
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
Subject: [RFC v2 02/14] filemap: align the index to mapping_min_order in the page cache
Date: Tue, 13 Feb 2024 10:37:01 +0100
Message-ID: <20240213093713.1753368-3-kernel@pankajraghav.com>
In-Reply-To: <20240213093713.1753368-1-kernel@pankajraghav.com>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TYx7V3jchz9smV

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
 mm/filemap.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 750e779c23db..323a8e169581 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2479,14 +2479,16 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
+	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
 	struct file_ra_state *ra = &filp->f_ra;
-	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
+	pgoff_t index = round_down(iocb->ki_pos >> PAGE_SHIFT, min_nrpages);
 	pgoff_t last_index;
 	struct folio *folio;
 	int err = 0;
 
 	/* "last_index" is the index of the page beyond the end of the read */
 	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
+	last_index = round_up(last_index, min_nrpages);
 retry:
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -2502,8 +2504,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	if (!folio_batch_count(fbatch)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
-		err = filemap_create_folio(filp, mapping,
-				iocb->ki_pos >> PAGE_SHIFT, fbatch);
+		err = filemap_create_folio(filp, mapping, index, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
@@ -3095,7 +3096,10 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
-	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int min_nrpages = mapping_min_folio_nrpages(file->f_mapping);
+	pgoff_t index = round_down(vmf->pgoff, min_nrpages);
+	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
 	struct file *fpin = NULL;
 	unsigned long vm_flags = vmf->vma->vm_flags;
 	unsigned int mmap_miss;
@@ -3147,10 +3151,11 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
+	ra->start = round_down(ra->start, min_nrpages);
 	ra->size = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
 	ractl._index = ra->start;
-	page_cache_ra_order(&ractl, ra, 0);
+	page_cache_ra_order(&ractl, ra, min_order);
 	return fpin;
 }
 
@@ -3164,7 +3169,9 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 {
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
-	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
+	unsigned int min_nrpages = mapping_min_folio_nrpages(file->f_mapping);
+	pgoff_t index = round_down(vmf->pgoff, min_nrpages);
+	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, index);
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
@@ -3212,13 +3219,17 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	struct file *file = vmf->vma->vm_file;
 	struct file *fpin = NULL;
 	struct address_space *mapping = file->f_mapping;
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int nrpages = 1UL << min_order;
 	struct inode *inode = mapping->host;
-	pgoff_t max_idx, index = vmf->pgoff;
+	pgoff_t max_idx, index = round_down(vmf->pgoff, nrpages);
 	struct folio *folio;
 	vm_fault_t ret = 0;
 	bool mapping_locked = false;
 
 	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	max_idx = round_up(max_idx, nrpages);
+
 	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
 
@@ -3317,13 +3328,17 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * We must recheck i_size under page lock.
 	 */
 	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	max_idx = round_up(max_idx, nrpages);
+
 	if (unlikely(index >= max_idx)) {
 		folio_unlock(folio);
 		folio_put(folio);
 		return VM_FAULT_SIGBUS;
 	}
 
-	vmf->page = folio_file_page(folio, index);
+	VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
+
+	vmf->page = folio_file_page(folio, vmf->pgoff);
 	return ret | VM_FAULT_LOCKED;
 
 page_not_uptodate:
@@ -3658,6 +3673,9 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 {
 	struct folio *folio;
 	int err;
+	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
+
+	index = round_down(index, min_nrpages);
 
 	if (!filler)
 		filler = mapping->a_ops->read_folio;
-- 
2.43.0


