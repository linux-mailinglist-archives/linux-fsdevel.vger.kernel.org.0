Return-Path: <linux-fsdevel+bounces-75415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EKlAlXzdmkzZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:53:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7EA8400F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAF19300CCA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 04:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194530E0F9;
	Mon, 26 Jan 2026 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CYZu4Gfl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A113AA2F;
	Mon, 26 Jan 2026 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769403211; cv=none; b=OWxacUqrNnfMS7+om2GBTXxv3QYZi7VsPkHj9OhlF1JR27tg/TzceGYPGDCo9LB4Thfd/kaQTvRrixH/STU1p6QVxqH7HsHDT2QO6A5gEesRRm2Kam+QreDVEQ+tc62wLJrosGOODvVFV/bhr+EhMhM1BJPxJ8ehX4rxShU7eZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769403211; c=relaxed/simple;
	bh=X6yrccX1oBb275jlciXB570/zxYv3eKai2cWUpa70SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liyBCN3bawyEcenLKVK/f2HD43Os/uJaerrav/supLecfekzo6EYc7he+4brUwsm2bFQuRqTt9pRdy98pKtFZsZqk4/22OeexQsLHkzqxRriSZTQo5pmT8kSuSrGvOWfvq1liSdQn3W0eDGCbW7klp3M0BkKA5CadIuHkW8VMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CYZu4Gfl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kIAaZpZSlzMCC5Jcx0MQtMp7QgYjStI/1PvVB/7GYUs=; b=CYZu4GflHYC0/k/eL9VlAiPsBw
	/pOGdtSPtOtb1ezBTMkMiE/nmZLHG0BNRkXPXXvDgv7HwXEv7PYiQ3GGHgHF/XlJ2hRhdoukIPJJc
	PbsUyJem1pdLseF37Wfy97e4NWisI62PIZn7uWMzXoKChtpJKVueqKKIXbq/kioAL3ZDLc53zVN38
	vcAzbhPzoG1uHvFmhrAiNnFuRJdPW+kJCLJWEAWlIfpIc3sU7N2GdZUqNlafMEQoG/XibV7U0cb0E
	l+hNFLtc9rzmg062TS+2qqXVv67x0DC8yNArhN6hOhRGLmfI/lrk9efPdT5Toz8hGKQPojpO3Pzv9
	tbjhzEfw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkEbP-0000000BuTR-19xP;
	Mon, 26 Jan 2026 04:53:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 11/16] fsverity: push out fsverity_info lookup
Date: Mon, 26 Jan 2026 05:50:57 +0100
Message-ID: <20260126045212.1381843-12-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126045212.1381843-1-hch@lst.de>
References: <20260126045212.1381843-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-75415-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 7F7EA8400F
X-Rspamd-Action: no action

Pass a struct fsverity_info to the verification and readahead helpers,
and push the lookup into the callers.  Right now this is a very
dumb almost mechanic move that open codes a lot of fsverity_info_addr()
calls int the file systems.  The subsequent patches will clean this up.

This prepares for reducing the number of fsverity_info lookups, which
will allow to amortize them better when using a more expensive lookup
method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Acked-by: David Sterba <dsterba@suse.com> [btrfs]
---
 fs/btrfs/extent_io.c     |  3 ++-
 fs/buffer.c              |  4 +++-
 fs/ext4/readpage.c       | 10 +++++++---
 fs/f2fs/compress.c       |  4 +++-
 fs/f2fs/data.c           | 15 +++++++++++----
 fs/verity/verify.c       | 23 ++++++++++++-----------
 include/linux/fsverity.h | 31 ++++++++++++++++++++++---------
 7 files changed, 60 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a4b74023618d..21430b7d8f27 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -484,7 +484,8 @@ static bool btrfs_verify_folio(struct folio *folio, u64 start, u32 len)
 	    btrfs_folio_test_uptodate(fs_info, folio, start, len) ||
 	    start >= i_size_read(folio->mapping->host))
 		return true;
-	return fsverity_verify_folio(folio);
+	return fsverity_verify_folio(*fsverity_info_addr(folio->mapping->host),
+			folio);
 }
 
 static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 len)
diff --git a/fs/buffer.c b/fs/buffer.c
index 838c0c571022..3982253b6805 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -309,9 +309,11 @@ static void verify_bh(struct work_struct *work)
 	struct postprocess_bh_ctx *ctx =
 		container_of(work, struct postprocess_bh_ctx, work);
 	struct buffer_head *bh = ctx->bh;
+	struct inode *inode = bh->b_folio->mapping->host;
 	bool valid;
 
-	valid = fsverity_verify_blocks(bh->b_folio, bh->b_size, bh_offset(bh));
+	valid = fsverity_verify_blocks(*fsverity_info_addr(inode), bh->b_folio,
+				       bh->b_size, bh_offset(bh));
 	end_buffer_async_read(bh, valid);
 	kfree(ctx);
 }
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index e99072c8a619..bf65562da9c2 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -96,6 +96,7 @@ static void verity_work(struct work_struct *work)
 	struct bio_post_read_ctx *ctx =
 		container_of(work, struct bio_post_read_ctx, work);
 	struct bio *bio = ctx->bio;
+	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
 
 	/*
 	 * fsverity_verify_bio() may call readahead() again, and although verity
@@ -108,7 +109,7 @@ static void verity_work(struct work_struct *work)
 	mempool_free(ctx, bio_post_read_ctx_pool);
 	bio->bi_private = NULL;
 
-	fsverity_verify_bio(bio);
+	fsverity_verify_bio(*fsverity_info_addr(inode), bio);
 
 	__read_end_io(bio);
 }
@@ -245,7 +246,8 @@ int ext4_mpage_readpages(struct inode *inode,
 
 		if (first_folio) {
 			if (ext4_need_verity(inode, folio->index))
-				fsverity_readahead(folio, nr_pages);
+				fsverity_readahead(*fsverity_info_addr(inode),
+						folio, nr_pages);
 			first_folio = false;
 		}
 
@@ -337,7 +339,9 @@ int ext4_mpage_readpages(struct inode *inode,
 					  folio_size(folio));
 			if (first_hole == 0) {
 				if (ext4_need_verity(inode, folio->index) &&
-				    !fsverity_verify_folio(folio))
+				    !fsverity_verify_folio(
+						*fsverity_info_addr(inode),
+						folio))
 					goto set_error_page;
 				folio_end_read(folio, true);
 				continue;
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 40a62f1dee4d..3de4a7e66959 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1814,7 +1814,9 @@ static void f2fs_verify_cluster(struct work_struct *work)
 		if (!rpage)
 			continue;
 
-		if (fsverity_verify_page(rpage))
+		if (fsverity_verify_page(
+				*fsverity_info_addr(rpage->mapping->host),
+				rpage))
 			SetPageUptodate(rpage);
 		else
 			ClearPageUptodate(rpage);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 49bdc7e771f2..bca1e34d327a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -185,15 +185,19 @@ static void f2fs_verify_bio(struct work_struct *work)
 
 		bio_for_each_folio_all(fi, bio) {
 			struct folio *folio = fi.folio;
+			struct fsverity_info *vi =
+				*fsverity_info_addr(folio->mapping->host);
 
 			if (!f2fs_is_compressed_page(folio) &&
-			    !fsverity_verify_page(&folio->page)) {
+			    !fsverity_verify_page(vi, &folio->page)) {
 				bio->bi_status = BLK_STS_IOERR;
 				break;
 			}
 		}
 	} else {
-		fsverity_verify_bio(bio);
+		struct inode *inode = bio_first_folio_all(bio)->mapping->host;
+
+		fsverity_verify_bio(*fsverity_info_addr(inode), bio);
 	}
 
 	f2fs_finish_read_bio(bio, true);
@@ -2121,7 +2125,9 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 zero_out:
 		folio_zero_segment(folio, 0, folio_size(folio));
 		if (f2fs_need_verity(inode, index) &&
-		    !fsverity_verify_folio(folio)) {
+		    !fsverity_verify_folio(
+				*fsverity_info_addr(folio->mapping->host),
+				folio)) {
 			ret = -EIO;
 			goto out;
 		}
@@ -2386,7 +2392,8 @@ static int f2fs_mpage_readpages(struct inode *inode,
 
 		if (first_folio) {
 			if (f2fs_need_verity(inode, folio->index))
-				fsverity_readahead(folio, nr_pages);
+				fsverity_readahead(*fsverity_info_addr(inode),
+						folio, nr_pages);
 			first_folio = false;
 		}
 
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 55f1078c645a..57aea5a2a0ee 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -39,6 +39,7 @@ static struct workqueue_struct *fsverity_read_workqueue;
 
 /**
  * fsverity_readahead() - kick off readahead on fsverity hashes
+ * @vi:			fsverity_info for the inode to be read
  * @folio:		first file data folio that is being read
  * @nr_pages:		number of file data pages to be read
  *
@@ -49,10 +50,10 @@ static struct workqueue_struct *fsverity_read_workqueue;
  * ensure that the hashes are already cached on completion of the file data
  * read if possible.
  */
-void fsverity_readahead(struct folio *folio, unsigned long nr_pages)
+void fsverity_readahead(struct fsverity_info *vi, struct folio *folio,
+			unsigned long nr_pages)
 {
 	struct inode *inode = folio->mapping->host;
-	const struct fsverity_info *vi = *fsverity_info_addr(inode);
 	const struct merkle_tree_params *params = &vi->tree_params;
 	u64 start_hidx = (u64)folio->index << params->log_blocks_per_page;
 	u64 end_hidx = (((u64)folio->index + nr_pages) <<
@@ -314,11 +315,9 @@ static bool verify_data_block(const struct fsverity_info *vi,
 
 static void
 fsverity_init_verification_context(struct fsverity_verification_context *ctx,
-				   struct inode *inode)
+				   const struct fsverity_info *vi)
 {
-	const struct fsverity_info *vi = *fsverity_info_addr(inode);
-
-	ctx->inode = inode;
+	ctx->inode = vi->inode;
 	ctx->vi = vi;
 	ctx->num_pending = 0;
 	if (vi->tree_params.hash_alg->algo_id == HASH_ALGO_SHA256 &&
@@ -398,6 +397,7 @@ static bool fsverity_add_data_blocks(struct fsverity_verification_context *ctx,
 
 /**
  * fsverity_verify_blocks() - verify data in a folio
+ * @vi: fsverity_info for the inode to be read
  * @folio: the folio containing the data to verify
  * @len: the length of the data to verify in the folio
  * @offset: the offset of the data to verify in the folio
@@ -408,11 +408,12 @@ static bool fsverity_add_data_blocks(struct fsverity_verification_context *ctx,
  *
  * Return: %true if the data is valid, else %false.
  */
-bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset)
+bool fsverity_verify_blocks(struct fsverity_info *vi, struct folio *folio,
+			    size_t len, size_t offset)
 {
 	struct fsverity_verification_context ctx;
 
-	fsverity_init_verification_context(&ctx, folio->mapping->host);
+	fsverity_init_verification_context(&ctx, vi);
 
 	if (fsverity_add_data_blocks(&ctx, folio, len, offset) &&
 	    fsverity_verify_pending_blocks(&ctx))
@@ -425,6 +426,7 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
 #ifdef CONFIG_BLOCK
 /**
  * fsverity_verify_bio() - verify a 'read' bio that has just completed
+ * @vi: fsverity_info for the inode to be read
  * @bio: the bio to verify
  *
  * Verify the bio's data against the file's Merkle tree.  All bio data segments
@@ -437,13 +439,12 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
  * filesystems) must instead call fsverity_verify_page() directly on each page.
  * All filesystems must also call fsverity_verify_page() on holes.
  */
-void fsverity_verify_bio(struct bio *bio)
+void fsverity_verify_bio(struct fsverity_info *vi, struct bio *bio)
 {
-	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
 	struct fsverity_verification_context ctx;
 	struct folio_iter fi;
 
-	fsverity_init_verification_context(&ctx, inode);
+	fsverity_init_verification_context(&ctx, vi);
 
 	bio_for_each_folio_all(fi, bio) {
 		if (!fsverity_add_data_blocks(&ctx, fi.folio, fi.length,
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index bade511cf3aa..1d70b270e90a 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -197,12 +197,20 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
 
 /* verify.c */
 
-bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
-void fsverity_verify_bio(struct bio *bio);
+bool fsverity_verify_blocks(struct fsverity_info *vi, struct folio *folio,
+			    size_t len, size_t offset);
+void fsverity_verify_bio(struct fsverity_info *vi, struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
 
 #else /* !CONFIG_FS_VERITY */
 
+/*
+ * Provide a stub to allow code using this to compile.  All callsites should be
+ * guarded by compiler dead code elimination, and this forces a link error if
+ * not.
+ */
+struct fsverity_info **fsverity_info_addr(const struct inode *inode);
+
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 {
 	return NULL;
@@ -251,14 +259,16 @@ static inline int fsverity_ioctl_read_metadata(struct file *filp,
 
 /* verify.c */
 
-static inline bool fsverity_verify_blocks(struct folio *folio, size_t len,
+static inline bool fsverity_verify_blocks(struct fsverity_info *vi,
+					  struct folio *folio, size_t len,
 					  size_t offset)
 {
 	WARN_ON_ONCE(1);
 	return false;
 }
 
-static inline void fsverity_verify_bio(struct bio *bio)
+static inline void fsverity_verify_bio(struct fsverity_info *vi,
+				       struct bio *bio)
 {
 	WARN_ON_ONCE(1);
 }
@@ -270,14 +280,16 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
 
 #endif	/* !CONFIG_FS_VERITY */
 
-static inline bool fsverity_verify_folio(struct folio *folio)
+static inline bool fsverity_verify_folio(struct fsverity_info *vi,
+					 struct folio *folio)
 {
-	return fsverity_verify_blocks(folio, folio_size(folio), 0);
+	return fsverity_verify_blocks(vi, folio, folio_size(folio), 0);
 }
 
-static inline bool fsverity_verify_page(struct page *page)
+static inline bool fsverity_verify_page(struct fsverity_info *vi,
+					struct page *page)
 {
-	return fsverity_verify_blocks(page_folio(page), PAGE_SIZE, 0);
+	return fsverity_verify_blocks(vi, page_folio(page), PAGE_SIZE, 0);
 }
 
 /**
@@ -319,7 +331,8 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
 }
 
 void fsverity_cleanup_inode(struct inode *inode);
-void fsverity_readahead(struct folio *folio, unsigned long nr_pages);
+void fsverity_readahead(struct fsverity_info *vi, struct folio *folio,
+		unsigned long nr_pages);
 
 struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index);
 void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
-- 
2.47.3


