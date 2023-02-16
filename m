Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C37F699F6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 22:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjBPVvN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 16:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjBPVuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:50:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3155053832
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 13:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676584138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8N2Hvl8ceKkhdFGfd9u1dmLYX9njBqFAAbBAETPUuY=;
        b=DrYxcuf7pJrOd7Sbhcrwn8fyg9UKC8ANuC7WYbCGhlC8m02k27ymRCXs8PO5toj5ET1EeC
        c+8qPRLBOaf83RjYOGT15fSouRXOvNL2o6SJA874LMyJSGmMXLICbSILpXleqPq0LDv8mw
        Tiff58SOFeaaqePCFFX9RCrSpvpsl9U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-1Vb9B6dEMhSH75lsjU4fxA-1; Thu, 16 Feb 2023 16:48:52 -0500
X-MC-Unique: 1Vb9B6dEMhSH75lsjU4fxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD6A0811E9C;
        Thu, 16 Feb 2023 21:48:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD28F2026D4B;
        Thu, 16 Feb 2023 21:48:49 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>
Subject: [PATCH 16/17] cifs: Remove unused code
Date:   Thu, 16 Feb 2023 21:47:44 +0000
Message-Id: <20230216214745.3985496-17-dhowells@redhat.com>
In-Reply-To: <20230216214745.3985496-1-dhowells@redhat.com>
References: <20230216214745.3985496-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove a bunch of functions that are no longer used and are commented out
after the conversion to use iterators throughout the I/O path.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org

Link: https://lore.kernel.org/r/164928621823.457102.8777804402615654773.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/165211421039.3154751.15199634443157779005.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/165348881165.2106726.2993852968344861224.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/165364827876.3334034.9331465096417303889.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/166126396915.708021.2010212654244139442.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/166697261080.61150.17513116912567922274.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166732033255.3186319.5527423437137895940.stgit@warthog.procyon.org.uk/ # rfc
---
 fs/cifs/file.c | 606 -------------------------------------------------
 1 file changed, 606 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 33779d184692..60949fc352ed 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2606,314 +2606,6 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 	return rc;
 }
 
-#if 0 // TODO: Remove for iov_iter support
-static struct cifs_writedata *
-wdata_alloc_and_fillpages(pgoff_t tofind, struct address_space *mapping,
-			  pgoff_t end, pgoff_t *index,
-			  unsigned int *found_pages)
-{
-	struct cifs_writedata *wdata;
-
-	wdata = cifs_writedata_alloc((unsigned int)tofind,
-				     cifs_writev_complete);
-	if (!wdata)
-		return NULL;
-
-	*found_pages = find_get_pages_range_tag(mapping, index, end,
-				PAGECACHE_TAG_DIRTY, tofind, wdata->pages);
-	return wdata;
-}
-
-static unsigned int
-wdata_prepare_pages(struct cifs_writedata *wdata, unsigned int found_pages,
-		    struct address_space *mapping,
-		    struct writeback_control *wbc,
-		    pgoff_t end, pgoff_t *index, pgoff_t *next, bool *done)
-{
-	unsigned int nr_pages = 0, i;
-	struct page *page;
-
-	for (i = 0; i < found_pages; i++) {
-		page = wdata->pages[i];
-		/*
-		 * At this point we hold neither the i_pages lock nor the
-		 * page lock: the page may be truncated or invalidated
-		 * (changing page->mapping to NULL), or even swizzled
-		 * back from swapper_space to tmpfs file mapping
-		 */
-
-		if (nr_pages == 0)
-			lock_page(page);
-		else if (!trylock_page(page))
-			break;
-
-		if (unlikely(page->mapping != mapping)) {
-			unlock_page(page);
-			break;
-		}
-
-		if (!wbc->range_cyclic && page->index > end) {
-			*done = true;
-			unlock_page(page);
-			break;
-		}
-
-		if (*next && (page->index != *next)) {
-			/* Not next consecutive page */
-			unlock_page(page);
-			break;
-		}
-
-		if (wbc->sync_mode != WB_SYNC_NONE)
-			wait_on_page_writeback(page);
-
-		if (PageWriteback(page) ||
-				!clear_page_dirty_for_io(page)) {
-			unlock_page(page);
-			break;
-		}
-
-		/*
-		 * This actually clears the dirty bit in the radix tree.
-		 * See cifs_writepage() for more commentary.
-		 */
-		set_page_writeback(page);
-		if (page_offset(page) >= i_size_read(mapping->host)) {
-			*done = true;
-			unlock_page(page);
-			end_page_writeback(page);
-			break;
-		}
-
-		wdata->pages[i] = page;
-		*next = page->index + 1;
-		++nr_pages;
-	}
-
-	/* reset index to refind any pages skipped */
-	if (nr_pages == 0)
-		*index = wdata->pages[0]->index + 1;
-
-	/* put any pages we aren't going to use */
-	for (i = nr_pages; i < found_pages; i++) {
-		put_page(wdata->pages[i]);
-		wdata->pages[i] = NULL;
-	}
-
-	return nr_pages;
-}
-
-static int
-wdata_send_pages(struct cifs_writedata *wdata, unsigned int nr_pages,
-		 struct address_space *mapping, struct writeback_control *wbc)
-{
-	int rc;
-
-	wdata->sync_mode = wbc->sync_mode;
-	wdata->nr_pages = nr_pages;
-	wdata->offset = page_offset(wdata->pages[0]);
-	wdata->pagesz = PAGE_SIZE;
-	wdata->tailsz = min(i_size_read(mapping->host) -
-			page_offset(wdata->pages[nr_pages - 1]),
-			(loff_t)PAGE_SIZE);
-	wdata->bytes = ((nr_pages - 1) * PAGE_SIZE) + wdata->tailsz;
-	wdata->pid = wdata->cfile->pid;
-
-	rc = adjust_credits(wdata->server, &wdata->credits, wdata->bytes);
-	if (rc)
-		return rc;
-
-	if (wdata->cfile->invalidHandle)
-		rc = -EAGAIN;
-	else
-		rc = wdata->server->ops->async_writev(wdata,
-						      cifs_writedata_release);
-
-	return rc;
-}
-
-static int
-cifs_writepage_locked(struct page *page, struct writeback_control *wbc);
-
-static int cifs_write_one_page(struct page *page, struct writeback_control *wbc,
-		void *data)
-{
-	struct address_space *mapping = data;
-	int ret;
-
-	ret = cifs_writepage_locked(page, wbc);
-	unlock_page(page);
-	mapping_set_error(mapping, ret);
-	return ret;
-}
-
-static int cifs_writepages(struct address_space *mapping,
-			   struct writeback_control *wbc)
-{
-	struct inode *inode = mapping->host;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
-	struct TCP_Server_Info *server;
-	bool done = false, scanned = false, range_whole = false;
-	pgoff_t end, index;
-	struct cifs_writedata *wdata;
-	struct cifsFileInfo *cfile = NULL;
-	int rc = 0;
-	int saved_rc = 0;
-	unsigned int xid;
-
-	/*
-	 * If wsize is smaller than the page cache size, default to writing
-	 * one page at a time.
-	 */
-	if (cifs_sb->ctx->wsize < PAGE_SIZE)
-		return write_cache_pages(mapping, wbc, cifs_write_one_page,
-				mapping);
-
-	xid = get_xid();
-	if (wbc->range_cyclic) {
-		index = mapping->writeback_index; /* Start from prev offset */
-		end = -1;
-	} else {
-		index = wbc->range_start >> PAGE_SHIFT;
-		end = wbc->range_end >> PAGE_SHIFT;
-		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
-			range_whole = true;
-		scanned = true;
-	}
-	server = cifs_pick_channel(cifs_sb_master_tcon(cifs_sb)->ses);
-
-retry:
-	while (!done && index <= end) {
-		unsigned int i, nr_pages, found_pages, wsize;
-		pgoff_t next = 0, tofind, saved_index = index;
-		struct cifs_credits credits_on_stack;
-		struct cifs_credits *credits = &credits_on_stack;
-		int get_file_rc = 0;
-
-		if (cfile)
-			cifsFileInfo_put(cfile);
-
-		rc = cifs_get_writable_file(CIFS_I(inode), FIND_WR_ANY, &cfile);
-
-		/* in case of an error store it to return later */
-		if (rc)
-			get_file_rc = rc;
-
-		rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->wsize,
-						   &wsize, credits);
-		if (rc != 0) {
-			done = true;
-			break;
-		}
-
-		tofind = min((wsize / PAGE_SIZE) - 1, end - index) + 1;
-
-		wdata = wdata_alloc_and_fillpages(tofind, mapping, end, &index,
-						  &found_pages);
-		if (!wdata) {
-			rc = -ENOMEM;
-			done = true;
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
-
-		if (found_pages == 0) {
-			kref_put(&wdata->refcount, cifs_writedata_release);
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
-
-		nr_pages = wdata_prepare_pages(wdata, found_pages, mapping, wbc,
-					       end, &index, &next, &done);
-
-		/* nothing to write? */
-		if (nr_pages == 0) {
-			kref_put(&wdata->refcount, cifs_writedata_release);
-			add_credits_and_wake_if(server, credits, 0);
-			continue;
-		}
-
-		wdata->credits = credits_on_stack;
-		wdata->cfile = cfile;
-		wdata->server = server;
-		cfile = NULL;
-
-		if (!wdata->cfile) {
-			cifs_dbg(VFS, "No writable handle in writepages rc=%d\n",
-				 get_file_rc);
-			if (is_retryable_error(get_file_rc))
-				rc = get_file_rc;
-			else
-				rc = -EBADF;
-		} else
-			rc = wdata_send_pages(wdata, nr_pages, mapping, wbc);
-
-		for (i = 0; i < nr_pages; ++i)
-			unlock_page(wdata->pages[i]);
-
-		/* send failure -- clean up the mess */
-		if (rc != 0) {
-			add_credits_and_wake_if(server, &wdata->credits, 0);
-			for (i = 0; i < nr_pages; ++i) {
-				if (is_retryable_error(rc))
-					redirty_page_for_writepage(wbc,
-							   wdata->pages[i]);
-				else
-					SetPageError(wdata->pages[i]);
-				end_page_writeback(wdata->pages[i]);
-				put_page(wdata->pages[i]);
-			}
-			if (!is_retryable_error(rc))
-				mapping_set_error(mapping, rc);
-		}
-		kref_put(&wdata->refcount, cifs_writedata_release);
-
-		if (wbc->sync_mode == WB_SYNC_ALL && rc == -EAGAIN) {
-			index = saved_index;
-			continue;
-		}
-
-		/* Return immediately if we received a signal during writing */
-		if (is_interrupt_error(rc)) {
-			done = true;
-			break;
-		}
-
-		if (rc != 0 && saved_rc == 0)
-			saved_rc = rc;
-
-		wbc->nr_to_write -= nr_pages;
-		if (wbc->nr_to_write <= 0)
-			done = true;
-
-		index = next;
-	}
-
-	if (!scanned && !done) {
-		/*
-		 * We hit the last page and there is more work to be done: wrap
-		 * back to the start of the file
-		 */
-		scanned = true;
-		index = 0;
-		goto retry;
-	}
-
-	if (saved_rc != 0)
-		rc = saved_rc;
-
-	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
-		mapping->writeback_index = index;
-
-	if (cfile)
-		cifsFileInfo_put(cfile);
-	free_xid(xid);
-	/* Indication to update ctime and mtime as close is deferred */
-	set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
-	return rc;
-}
-#endif
-
 /*
  * Extend the region to be written back to include subsequent contiguously
  * dirty pages if possible, but don't sleep while doing so.
@@ -3509,49 +3201,6 @@ int cifs_flush(struct file *file, fl_owner_t id)
 	return rc;
 }
 
-#if 0 // TODO: Remove for iov_iter support
-static int
-cifs_write_allocate_pages(struct page **pages, unsigned long num_pages)
-{
-	int rc = 0;
-	unsigned long i;
-
-	for (i = 0; i < num_pages; i++) {
-		pages[i] = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
-		if (!pages[i]) {
-			/*
-			 * save number of pages we have already allocated and
-			 * return with ENOMEM error
-			 */
-			num_pages = i;
-			rc = -ENOMEM;
-			break;
-		}
-	}
-
-	if (rc) {
-		for (i = 0; i < num_pages; i++)
-			put_page(pages[i]);
-	}
-	return rc;
-}
-
-static inline
-size_t get_numpages(const size_t wsize, const size_t len, size_t *cur_len)
-{
-	size_t num_pages;
-	size_t clen;
-
-	clen = min_t(const size_t, len, wsize);
-	num_pages = DIV_ROUND_UP(clen, PAGE_SIZE);
-
-	if (cur_len)
-		*cur_len = clen;
-
-	return num_pages;
-}
-#endif
-
 static void
 cifs_uncached_writedata_release(struct kref *refcount)
 {
@@ -3584,50 +3233,6 @@ cifs_uncached_writev_complete(struct work_struct *work)
 	kref_put(&wdata->refcount, cifs_uncached_writedata_release);
 }
 
-#if 0 // TODO: Remove for iov_iter support
-static int
-wdata_fill_from_iovec(struct cifs_writedata *wdata, struct iov_iter *from,
-		      size_t *len, unsigned long *num_pages)
-{
-	size_t save_len, copied, bytes, cur_len = *len;
-	unsigned long i, nr_pages = *num_pages;
-
-	save_len = cur_len;
-	for (i = 0; i < nr_pages; i++) {
-		bytes = min_t(const size_t, cur_len, PAGE_SIZE);
-		copied = copy_page_from_iter(wdata->pages[i], 0, bytes, from);
-		cur_len -= copied;
-		/*
-		 * If we didn't copy as much as we expected, then that
-		 * may mean we trod into an unmapped area. Stop copying
-		 * at that point. On the next pass through the big
-		 * loop, we'll likely end up getting a zero-length
-		 * write and bailing out of it.
-		 */
-		if (copied < bytes)
-			break;
-	}
-	cur_len = save_len - cur_len;
-	*len = cur_len;
-
-	/*
-	 * If we have no data to send, then that probably means that
-	 * the copy above failed altogether. That's most likely because
-	 * the address in the iovec was bogus. Return -EFAULT and let
-	 * the caller free anything we allocated and bail out.
-	 */
-	if (!cur_len)
-		return -EFAULT;
-
-	/*
-	 * i + 1 now represents the number of pages we actually used in
-	 * the copy phase above.
-	 */
-	*num_pages = i + 1;
-	return 0;
-}
-#endif
-
 static int
 cifs_resend_wdata(struct cifs_writedata *wdata, struct list_head *wdata_list,
 	struct cifs_aio_ctx *ctx)
@@ -4214,83 +3819,6 @@ cifs_uncached_readv_complete(struct work_struct *work)
 	kref_put(&rdata->refcount, cifs_readdata_release);
 }
 
-#if 0 // TODO: Remove for iov_iter support
-
-static int
-uncached_fill_pages(struct TCP_Server_Info *server,
-		    struct cifs_readdata *rdata, struct iov_iter *iter,
-		    unsigned int len)
-{
-	int result = 0;
-	unsigned int i;
-	unsigned int nr_pages = rdata->nr_pages;
-	unsigned int page_offset = rdata->page_offset;
-
-	rdata->got_bytes = 0;
-	rdata->tailsz = PAGE_SIZE;
-	for (i = 0; i < nr_pages; i++) {
-		struct page *page = rdata->pages[i];
-		size_t n;
-		unsigned int segment_size = rdata->pagesz;
-
-		if (i == 0)
-			segment_size -= page_offset;
-		else
-			page_offset = 0;
-
-
-		if (len <= 0) {
-			/* no need to hold page hostage */
-			rdata->pages[i] = NULL;
-			rdata->nr_pages--;
-			put_page(page);
-			continue;
-		}
-
-		n = len;
-		if (len >= segment_size)
-			/* enough data to fill the page */
-			n = segment_size;
-		else
-			rdata->tailsz = len;
-		len -= n;
-
-		if (iter)
-			result = copy_page_from_iter(
-					page, page_offset, n, iter);
-#ifdef CONFIG_CIFS_SMB_DIRECT
-		else if (rdata->mr)
-			result = n;
-#endif
-		else
-			result = cifs_read_page_from_socket(
-					server, page, page_offset, n);
-		if (result < 0)
-			break;
-
-		rdata->got_bytes += result;
-	}
-
-	return result != -ECONNABORTED && rdata->got_bytes > 0 ?
-						rdata->got_bytes : result;
-}
-
-static int
-cifs_uncached_read_into_pages(struct TCP_Server_Info *server,
-			      struct cifs_readdata *rdata, unsigned int len)
-{
-	return uncached_fill_pages(server, rdata, NULL, len);
-}
-
-static int
-cifs_uncached_copy_into_pages(struct TCP_Server_Info *server,
-			      struct cifs_readdata *rdata,
-			      struct iov_iter *iter)
-{
-	return uncached_fill_pages(server, rdata, iter, iter->count);
-}
-#endif
-
 static int cifs_resend_rdata(struct cifs_readdata *rdata,
 			struct list_head *rdata_list,
 			struct cifs_aio_ctx *ctx)
@@ -4900,140 +4428,6 @@ int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return rc;
 }
 
-#if 0 // TODO: Remove for iov_iter support
-
-static void
-cifs_readv_complete(struct work_struct *work)
-{
-	unsigned int i, got_bytes;
-	struct cifs_readdata *rdata = container_of(work,
-						struct cifs_readdata, work);
-
-	got_bytes = rdata->got_bytes;
-	for (i = 0; i < rdata->nr_pages; i++) {
-		struct page *page = rdata->pages[i];
-
-		if (rdata->result == 0 ||
-		    (rdata->result == -EAGAIN && got_bytes)) {
-			flush_dcache_page(page);
-			SetPageUptodate(page);
-		} else
-			SetPageError(page);
-
-		if (rdata->result == 0 ||
-		    (rdata->result == -EAGAIN && got_bytes))
-			cifs_readpage_to_fscache(rdata->mapping->host, page);
-
-		unlock_page(page);
-
-		got_bytes -= min_t(unsigned int, PAGE_SIZE, got_bytes);
-
-		put_page(page);
-		rdata->pages[i] = NULL;
-	}
-	kref_put(&rdata->refcount, cifs_readdata_release);
-}
-
-static int
-readpages_fill_pages(struct TCP_Server_Info *server,
-		     struct cifs_readdata *rdata, struct iov_iter *iter,
-		     unsigned int len)
-{
-	int result = 0;
-	unsigned int i;
-	u64 eof;
-	pgoff_t eof_index;
-	unsigned int nr_pages = rdata->nr_pages;
-	unsigned int page_offset = rdata->page_offset;
-
-	/* determine the eof that the server (probably) has */
-	eof = CIFS_I(rdata->mapping->host)->server_eof;
-	eof_index = eof ? (eof - 1) >> PAGE_SHIFT : 0;
-	cifs_dbg(FYI, "eof=%llu eof_index=%lu\n", eof, eof_index);
-
-	rdata->got_bytes = 0;
-	rdata->tailsz = PAGE_SIZE;
-	for (i = 0; i < nr_pages; i++) {
-		struct page *page = rdata->pages[i];
-		unsigned int to_read = rdata->pagesz;
-		size_t n;
-
-		if (i == 0)
-			to_read -= page_offset;
-		else
-			page_offset = 0;
-
-		n = to_read;
-
-		if (len >= to_read) {
-			len -= to_read;
-		} else if (len > 0) {
-			/* enough for partial page, fill and zero the rest */
-			zero_user(page, len + page_offset, to_read - len);
-			n = rdata->tailsz = len;
-			len = 0;
-		} else if (page->index > eof_index) {
-			/*
-			 * The VFS will not try to do readahead past the
-			 * i_size, but it's possible that we have outstanding
-			 * writes with gaps in the middle and the i_size hasn't
-			 * caught up yet. Populate those with zeroed out pages
-			 * to prevent the VFS from repeatedly attempting to
-			 * fill them until the writes are flushed.
-			 */
-			zero_user(page, 0, PAGE_SIZE);
-			flush_dcache_page(page);
-			SetPageUptodate(page);
-			unlock_page(page);
-			put_page(page);
-			rdata->pages[i] = NULL;
-			rdata->nr_pages--;
-			continue;
-		} else {
-			/* no need to hold page hostage */
-			unlock_page(page);
-			put_page(page);
-			rdata->pages[i] = NULL;
-			rdata->nr_pages--;
-			continue;
-		}
-
-		if (iter)
-			result = copy_page_from_iter(
-					page, page_offset, n, iter);
-#ifdef CONFIG_CIFS_SMB_DIRECT
-		else if (rdata->mr)
-			result = n;
-#endif
-		else
-			result = cifs_read_page_from_socket(
-					server, page, page_offset, n);
-		if (result < 0)
-			break;
-
-		rdata->got_bytes += result;
-	}
-
-	return result != -ECONNABORTED && rdata->got_bytes > 0 ?
-						rdata->got_bytes : result;
-}
-
-static int
-cifs_readpages_read_into_pages(struct TCP_Server_Info *server,
-			       struct cifs_readdata *rdata, unsigned int len)
-{
-	return readpages_fill_pages(server, rdata, NULL, len);
-}
-
-static int
-cifs_readpages_copy_into_pages(struct TCP_Server_Info *server,
-			       struct cifs_readdata *rdata,
-			       struct iov_iter *iter)
-{
-	return readpages_fill_pages(server, rdata, iter, iter->count);
-}
-#endif
-
 /*
  * Unlock a bunch of folios in the pagecache.
  */

