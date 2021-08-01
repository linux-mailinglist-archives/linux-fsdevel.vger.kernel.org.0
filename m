Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A683DCB7D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Aug 2021 14:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhHAMBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Aug 2021 08:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231461AbhHAMBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Aug 2021 08:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627819264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2Qsqj3eg7Y62YHz7lXIkUtLBdOZ/xxN1uxBArGh02w8=;
        b=YqIkYqPcffBBR2WWX5GwQ2hyIZ1JSb5d5KKUgb8JPmfeHkZFo1LCYMhr1UHdAZLsknmN65
        udlugmXdz6ECSMeQA/wE9G3015lhyNIDC7/bkeQMnEJnMCYCZ7DbfFnWJTjz3PTG02vDH1
        vWBSP9J5/tE8lIWQj2t/NPM/5tW3b/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-WUWs4zXhMtmtHzQg7xRiJg-1; Sun, 01 Aug 2021 08:01:03 -0400
X-MC-Unique: WUWs4zXhMtmtHzQg7xRiJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15B16100E421;
        Sun,  1 Aug 2021 12:01:02 +0000 (UTC)
Received: from max.com (unknown [10.40.193.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 949BB421F;
        Sun,  1 Aug 2021 12:01:00 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] iomap: Fix some typos and bad grammar
Date:   Sun,  1 Aug 2021 14:00:58 +0200
Message-Id: <20210801120058.839839-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix some typos and bad grammar in buffered-io.c to make the comments
easier to read.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 72 +++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 87ccb3438bec..3cc9da24fa83 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -36,7 +36,7 @@ static inline struct iomap_page *to_iomap_page(struct page *page)
 {
 	/*
 	 * per-block data is stored in the head page.  Callers should
-	 * not be dealing with tail pages (and if they are, they can
+	 * not be dealing with tail pages, and if they are, they can
 	 * call thp_head() first.
 	 */
 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
@@ -98,7 +98,7 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	unsigned last = (poff + plen - 1) >> block_bits;
 
 	/*
-	 * If the block size is smaller than the page size we need to check the
+	 * If the block size is smaller than the page size, we need to check the
 	 * per-block uptodate status and adjust the offset and length if needed
 	 * to avoid reading in already uptodate ranges.
 	 */
@@ -126,7 +126,7 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	}
 
 	/*
-	 * If the extent spans the block that contains the i_size we need to
+	 * If the extent spans the block that contains the i_size, we need to
 	 * handle both halves separately so that we properly zero data in the
 	 * page cache for blocks that are entirely outside of i_size.
 	 */
@@ -307,7 +307,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 done:
 	/*
 	 * Move the caller beyond our range so that it keeps making progress.
-	 * For that we have to include any leading non-uptodate ranges, but
+	 * For that, we have to include any leading non-uptodate ranges, but
 	 * we can skip trailing ones as they will be handled in the next
 	 * iteration.
 	 */
@@ -344,9 +344,9 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 	}
 
 	/*
-	 * Just like mpage_readahead and block_read_full_page we always
+	 * Just like mpage_readahead and block_read_full_page, we always
 	 * return 0 and just mark the page as PageError on errors.  This
-	 * should be cleaned up all through the stack eventually.
+	 * should be cleaned up throughout the stack eventually.
 	 */
 	return 0;
 }
@@ -467,7 +467,7 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
 	/*
 	 * mm accommodates an old ext3 case where clean pages might not have had
 	 * the dirty bit cleared. Thus, it can send actual dirty pages to
-	 * ->releasepage() via shrink_active_list(), skip those here.
+	 * ->releasepage() via shrink_active_list(); skip those here.
 	 */
 	if (PageDirty(page) || PageWriteback(page))
 		return 0;
@@ -482,7 +482,7 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 	trace_iomap_invalidatepage(page->mapping->host, offset, len);
 
 	/*
-	 * If we are invalidating the entire page, clear the dirty state from it
+	 * If we're invalidating the entire page, clear the dirty state from it
 	 * and release it to avoid unnecessary buildup of the LRU.
 	 */
 	if (offset == 0 && len == PAGE_SIZE) {
@@ -650,13 +650,13 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	/*
 	 * The blocks that were entirely written will now be uptodate, so we
 	 * don't have to worry about a readpage reading them and overwriting a
-	 * partial write.  However if we have encountered a short write and only
+	 * partial write.  However, if we've encountered a short write and only
 	 * partially written into a block, it will not be marked uptodate, so a
 	 * readpage might come in and destroy our partial write.
 	 *
-	 * Do the simplest thing, and just treat any short write to a non
-	 * uptodate page as a zero-length write, and force the caller to redo
-	 * the whole thing.
+	 * Do the simplest thing and just treat any short write to a
+	 * non-uptodate page as a zero-length write, and force the caller to
+	 * redo the whole thing.
 	 */
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
@@ -744,7 +744,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			bytes = length;
 
 		/*
-		 * Bring in the user page that we will copy from _first_.
+		 * Bring in the user page that we'll copy from _first_.
 		 * Otherwise there's a nasty deadlock on copying from the
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
@@ -1153,7 +1153,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
  * Submit the final bio for an ioend.
  *
  * If @error is non-zero, it means that we have a situation where some part of
- * the submission process has failed after we have marked paged for writeback
+ * the submission process has failed after we've marked pages for writeback
  * and unlocked them.  In this situation, we need to fail the bio instead of
  * submitting it.  This typically only happens on a filesystem shutdown.
  */
@@ -1168,7 +1168,7 @@ iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
 		error = wpc->ops->prepare_ioend(ioend, error);
 	if (error) {
 		/*
-		 * If we are failing the IO now, just mark the ioend with an
+		 * If we're failing the IO now, just mark the ioend with an
 		 * error and finish it.  This will run IO completion immediately
 		 * as there is only one reference to the ioend at this point in
 		 * time.
@@ -1210,7 +1210,7 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 /*
  * Allocate a new bio, and chain the old bio to the new one.
  *
- * Note that we have to do perform the chaining in this unintuitive order
+ * Note that we have to perform the chaining in this unintuitive order
  * so that the bi_private linkage is set up in the right direction for the
  * traversal in iomap_finish_ioend().
  */
@@ -1249,7 +1249,7 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
 
 /*
  * Test to see if we have an existing ioend structure that we could append to
- * first, otherwise finish off the current ioend and start another.
+ * first; otherwise finish off the current ioend and start another.
  */
 static void
 iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
@@ -1287,9 +1287,9 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 /*
  * We implement an immediate ioend submission policy here to avoid needing to
  * chain multiple ioends and hence nest mempool allocations which can violate
- * forward progress guarantees we need to provide. The current ioend we are
- * adding blocks to is cached on the writepage context, and if the new block
- * does not append to the cached ioend it will create a new ioend and cache that
+ * the forward progress guarantees we need to provide. The current ioend we're
+ * adding blocks to is cached in the writepage context, and if the new block
+ * doesn't append to the cached ioend, it will create a new ioend and cache that
  * instead.
  *
  * If a new ioend is created and cached, the old ioend is returned and queued
@@ -1351,7 +1351,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	if (unlikely(error)) {
 		/*
 		 * Let the filesystem know what portion of the current page
-		 * failed to map. If the page wasn't been added to ioend, it
+		 * failed to map. If the page hasn't been added to ioend, it
 		 * won't be affected by I/O completion and we must unlock it
 		 * now.
 		 */
@@ -1368,7 +1368,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	unlock_page(page);
 
 	/*
-	 * Preserve the original error if there was one, otherwise catch
+	 * Preserve the original error if there was one; catch
 	 * submission errors here and propagate into subsequent ioend
 	 * submissions.
 	 */
@@ -1395,8 +1395,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 /*
  * Write out a dirty page.
  *
- * For delalloc space on the page we need to allocate space and flush it.
- * For unwritten space on the page we need to start the conversion to
+ * For delalloc space on the page, we need to allocate space and flush it.
+ * For unwritten space on the page, we need to start the conversion to
  * regular allocated space.
  */
 static int
@@ -1411,7 +1411,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 	trace_iomap_writepage(inode, page_offset(page), PAGE_SIZE);
 
 	/*
-	 * Refuse to write the page out if we are called from reclaim context.
+	 * Refuse to write the page out if we're called from reclaim context.
 	 *
 	 * This avoids stack overflows when called from deeply used stacks in
 	 * random callers for direct reclaim or memcg reclaim.  We explicitly
@@ -1456,20 +1456,20 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
 
 		/*
-		 * Skip the page if it is fully outside i_size, e.g. due to a
-		 * truncate operation that is in progress. We must redirty the
+		 * Skip the page if it's fully outside i_size, e.g. due to a
+		 * truncate operation that's in progress. We must redirty the
 		 * page so that reclaim stops reclaiming it. Otherwise
 		 * iomap_vm_releasepage() is called on it and gets confused.
 		 *
-		 * Note that the end_index is unsigned long, it would overflow
-		 * if the given offset is greater than 16TB on 32-bit system
-		 * and if we do check the page is fully outside i_size or not
-		 * via "if (page->index >= end_index + 1)" as "end_index + 1"
-		 * will be evaluated to 0.  Hence this page will be redirtied
-		 * and be written out repeatedly which would result in an
-		 * infinite loop, the user program that perform this operation
-		 * will hang.  Instead, we can verify this situation by checking
-		 * if the page to write is totally beyond the i_size or if it's
+		 * Note that the end_index is unsigned long.  If the given
+		 * offset is greater than 16TB on a 32-bit system then if we
+		 * checked if the page is fully outside i_size with
+		 * "if (page->index >= end_index + 1)", "end_index + 1" would
+		 * overflow and evaluate to 0.  Hence this page would be
+		 * redirtied and written out repeatedly, which would result in
+		 * an infinite loop; the user program performing this operation
+		 * would hang.  Instead, we can detect this situation by
+		 * checking if the page is totally beyond i_size or if its
 		 * offset is just equal to the EOF.
 		 */
 		if (page->index > end_index ||
-- 
2.26.3

