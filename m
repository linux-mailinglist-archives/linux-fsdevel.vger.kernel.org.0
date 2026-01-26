Return-Path: <linux-fsdevel+bounces-75412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCpzB9fzdmkzZgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:55:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B7B840B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FA813037E42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 04:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C73F30E0F9;
	Mon, 26 Jan 2026 04:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gWlBf9ZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99A30DD31;
	Mon, 26 Jan 2026 04:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769403193; cv=none; b=afZ8vpE29z4CtLeB+4Cizik0y5kcsrxAe1EAGcpDu7I5/oRekghMesbsDWoD7nwgs1pvUQd49LliqQH8I/BcNNH0ucbWbth/CD22uQVCFPSrCZHwcHMpgebNmTOtG2iLj4yHM29++URd+Zq0WrcKmTsutcJmZNRcNETDaOw2MVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769403193; c=relaxed/simple;
	bh=tMwkvwjamzBjka0dnZOenvZhEtpXhFCLGCFU4+xWvZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKA+vIdDWCsQXGWDv+itk+K+Wks5vtSqGi5NFaNbaztRShWNVuduqpY2LASZ1/aPGBYuYgwZVLYb0nea6XUZjOnOHaKQukWSE3GotJo5jNwfTEgB5GHffqlBhDuz9lZyHZ5ICTBIdeylqLN70+zofvOQzIlPV2w+a7Fz3S6dWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gWlBf9ZW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vrtKFN0zfAFtK1JnTk5Zym8Eo3siqBa2qtIqSveER2o=; b=gWlBf9ZWlG4pYnHHlHsyJJ59E2
	65aM64aJH8qS1H5jH0DH+kpX1xa4s3eKSCadAjdmIlzxuzt1Yn9fq1J1ZXJWL5YRH3MK4Bg3wkPum
	jp3nqWaXkVqVlwNNg4PY458pCCLXuRdGOeebuap33q+9KPh1FCJhSIDaOjAa5f5IOMxf1pkoBkB7Z
	V6NPOsAKx4NRZ32kt6DWPNSBdbFHN3IVliGc5+boK84x4YJdRhxeCoFwia5BQkR+7oiSD3R3BZ6uA
	IAsa/lyuCzfRJIuCUxmZdtKoGiUz3JHdDPYTGtK+lZy3b4xeeiX5ezGdxcP3TWcvuk2tyxuFGz0rk
	CbXa60lg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkEb6-0000000BuSR-1XYV;
	Mon, 26 Jan 2026 04:53:08 +0000
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
	fsverity@lists.linux.dev
Subject: [PATCH 08/16] fsverity: kick off hash readahead at data I/O submission time
Date: Mon, 26 Jan 2026 05:50:54 +0100
Message-ID: <20260126045212.1381843-9-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-75412-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,lst.de:mid,lst.de:email,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3B7B840B3
X-Rspamd-Action: no action

Currently all reads of the fsverity hashes is kicked off from the data
I/O completion handler, leading to needlessly dependent I/O.  This is
worked around a bit by performing readahead on the level 0 nodes, but
still fairly ineffective.

Switch to a model where the ->read_folio and ->readahead methods instead
kick off explicit readahead of the fsverity hashed so they are usually
available at I/O completion time.

For 64k sequential reads on my test VM this improves read performance
from 2.4GB/s - 2.6GB/s to 3.5GB/s - 3.9GB/s.  The improvements for
random reads are likely to be even bigger.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: David Sterba <dsterba@suse.com> [btrfs]
---
 fs/btrfs/verity.c         |  4 +--
 fs/ext4/readpage.c        |  7 ++++
 fs/ext4/verity.c          | 13 +++++--
 fs/f2fs/data.c            |  7 ++++
 fs/f2fs/verity.c          | 13 +++++--
 fs/verity/pagecache.c     | 39 +++++++++++++-------
 fs/verity/read_metadata.c | 17 ++++++---
 fs/verity/verify.c        | 76 +++++++++++++++++++++++++--------------
 include/linux/fsverity.h  | 29 ++++++++++-----
 9 files changed, 145 insertions(+), 60 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index e7643c22a6bf..c152bef71e8b 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -697,7 +697,6 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
  *
  * @inode:         inode to read a merkle tree page for
  * @index:         page index relative to the start of the merkle tree
- * @num_ra_pages:  number of pages to readahead. Optional, we ignore it
  *
  * The Merkle tree is stored in the filesystem btree, but its pages are cached
  * with a logical position past EOF in the inode's mapping.
@@ -705,8 +704,7 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
  * Returns the page we read, or an ERR_PTR on error.
  */
 static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
-						pgoff_t index,
-						unsigned long num_ra_pages)
+						pgoff_t index)
 {
 	struct folio *folio;
 	u64 off = (u64)index << PAGE_SHIFT;
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 267594ef0b2c..e99072c8a619 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -227,6 +227,7 @@ int ext4_mpage_readpages(struct inode *inode,
 	unsigned relative_block = 0;
 	struct ext4_map_blocks map;
 	unsigned int nr_pages, folio_pages;
+	bool first_folio = true;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
@@ -242,6 +243,12 @@ int ext4_mpage_readpages(struct inode *inode,
 		if (rac)
 			folio = readahead_folio(rac);
 
+		if (first_folio) {
+			if (ext4_need_verity(inode, folio->index))
+				fsverity_readahead(folio, nr_pages);
+			first_folio = false;
+		}
+
 		folio_pages = folio_nr_pages(folio);
 		prefetchw(&folio->flags);
 
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index a071860ad36a..54ae4d4a176c 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -358,11 +358,17 @@ static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
 }
 
 static struct page *ext4_read_merkle_tree_page(struct inode *inode,
-					       pgoff_t index,
-					       unsigned long num_ra_pages)
+					       pgoff_t index)
 {
 	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
-	return generic_read_merkle_tree_page(inode, index, num_ra_pages);
+	return generic_read_merkle_tree_page(inode, index);
+}
+
+static void ext4_readahead_merkle_tree(struct inode *inode, pgoff_t index,
+		unsigned long nr_pages)
+{
+	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
+	generic_readahead_merkle_tree(inode, index, nr_pages);
 }
 
 static int ext4_write_merkle_tree_block(struct file *file, const void *buf,
@@ -380,5 +386,6 @@ const struct fsverity_operations ext4_verityops = {
 	.end_enable_verity	= ext4_end_enable_verity,
 	.get_verity_descriptor	= ext4_get_verity_descriptor,
 	.read_merkle_tree_page	= ext4_read_merkle_tree_page,
+	.readahead_merkle_tree	= ext4_readahead_merkle_tree,
 	.write_merkle_tree_block = ext4_write_merkle_tree_block,
 };
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c30e69392a62..49bdc7e771f2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2359,6 +2359,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
 	int ret = 0;
+	bool first_folio = true;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
@@ -2383,6 +2384,12 @@ static int f2fs_mpage_readpages(struct inode *inode,
 			prefetchw(&folio->flags);
 		}
 
+		if (first_folio) {
+			if (f2fs_need_verity(inode, folio->index))
+				fsverity_readahead(folio, nr_pages);
+			first_folio = false;
+		}
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		index = folio->index;
 
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index d37e584423af..628e8eafa96a 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -256,11 +256,17 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
 }
 
 static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
-					       pgoff_t index,
-					       unsigned long num_ra_pages)
+					       pgoff_t index)
 {
 	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
-	return generic_read_merkle_tree_page(inode, index, num_ra_pages);
+	return generic_read_merkle_tree_page(inode, index);
+}
+
+static void f2fs_readahead_merkle_tree(struct inode *inode, pgoff_t index,
+		unsigned long nr_pages)
+{
+	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
+	generic_readahead_merkle_tree(inode, index, nr_pages);
 }
 
 static int f2fs_write_merkle_tree_block(struct file *file, const void *buf,
@@ -278,5 +284,6 @@ const struct fsverity_operations f2fs_verityops = {
 	.end_enable_verity	= f2fs_end_enable_verity,
 	.get_verity_descriptor	= f2fs_get_verity_descriptor,
 	.read_merkle_tree_page	= f2fs_read_merkle_tree_page,
+	.readahead_merkle_tree	= f2fs_readahead_merkle_tree,
 	.write_merkle_tree_block = f2fs_write_merkle_tree_block,
 };
diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
index 63393f0f5834..ee99d07754ff 100644
--- a/fs/verity/pagecache.c
+++ b/fs/verity/pagecache.c
@@ -10,14 +10,34 @@
  * generic_read_merkle_tree_page - generic ->read_merkle_tree_page helper
  * @inode:	inode containing the Merkle tree
  * @index:	0-based index of the page in the inode
- * @num_ra_pages: The number of Merkle tree pages that should be prefetched.
  *
  * The caller needs to adjust @index from the Merkle-tree relative index passed
  * to ->read_merkle_tree_page to the actual index where the Merkle tree is
  * stored in the page cache for @inode.
  */
-struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
-		unsigned long num_ra_pages)
+struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index)
+{
+	struct folio *folio;
+
+	folio = read_mapping_folio(inode->i_mapping, index, NULL);
+	if (IS_ERR(folio))
+		return ERR_CAST(folio);
+	return folio_file_page(folio, index);
+}
+EXPORT_SYMBOL_GPL(generic_read_merkle_tree_page);
+
+/**
+ * generic_readahead_merkle_tree() - generic ->readahead_merkle_tree helper
+ * @inode:	inode containing the Merkle tree
+ * @index:	0-based index of the first page to read ahead in the inode
+ * @nr_pages:	number of data pages to read ahead
+ *
+ * The caller needs to adjust @index from the Merkle-tree relative index passed
+ * to ->read_merkle_tree_page to the actual index where the Merkle tree is
+ * stored in the page cache for @inode.
+ */
+void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
+		unsigned long nr_pages)
 {
 	struct folio *folio;
 
@@ -26,14 +46,9 @@ struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
 	    !(IS_ERR(folio) && !folio_test_uptodate(folio))) {
 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 
-		if (!IS_ERR(folio))
-			folio_put(folio);
-		else if (num_ra_pages > 1)
-			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
-		folio = read_mapping_folio(inode->i_mapping, index, NULL);
-		if (IS_ERR(folio))
-			return ERR_CAST(folio);
+		page_cache_ra_unbounded(&ractl, nr_pages, 0);
 	}
-	return folio_file_page(folio, index);
+	if (!IS_ERR(folio))
+		folio_put(folio);
 }
-EXPORT_SYMBOL_GPL(generic_read_merkle_tree_page);
+EXPORT_SYMBOL_GPL(generic_readahead_merkle_tree);
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index cba5d6af4e04..81b82e9ddb1d 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -28,24 +28,31 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 	if (offset >= end_offset)
 		return 0;
 	offs_in_page = offset_in_page(offset);
+	index = offset >> PAGE_SHIFT;
 	last_index = (end_offset - 1) >> PAGE_SHIFT;
 
+	/*
+	 * Kick off readahead for the range we are going to read to ensure a
+	 * single large sequential read instead of lots of small ones.
+	 */
+	if (inode->i_sb->s_vop->readahead_merkle_tree) {
+		inode->i_sb->s_vop->readahead_merkle_tree(inode, index,
+				last_index - index + 1);
+	}
+
 	/*
 	 * Iterate through each Merkle tree page in the requested range and copy
 	 * the requested portion to userspace.  Note that the Merkle tree block
 	 * size isn't important here, as we are returning a byte stream; i.e.,
 	 * we can just work with pages even if the tree block size != PAGE_SIZE.
 	 */
-	for (index = offset >> PAGE_SHIFT; index <= last_index; index++) {
-		unsigned long num_ra_pages =
-			min_t(unsigned long, last_index - index + 1,
-			      inode->i_sb->s_bdi->io_pages);
+	for (; index <= last_index; index++) {
 		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
 						   PAGE_SIZE - offs_in_page);
 		struct page *page;
 		const void *virt;
 
-		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
+		page = vops->read_merkle_tree_page(inode, index);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			fsverity_err(inode,
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 86067c8b40cf..32cadb71953c 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -9,6 +9,7 @@
 
 #include <linux/bio.h>
 #include <linux/export.h>
+#include <linux/pagemap.h>
 
 #define FS_VERITY_MAX_PENDING_BLOCKS 2
 
@@ -21,7 +22,6 @@ struct fsverity_pending_block {
 struct fsverity_verification_context {
 	struct inode *inode;
 	struct fsverity_info *vi;
-	unsigned long max_ra_pages;
 
 	/*
 	 * This is the queue of data blocks that are pending verification.  When
@@ -37,6 +37,49 @@ struct fsverity_verification_context {
 
 static struct workqueue_struct *fsverity_read_workqueue;
 
+/**
+ * fsverity_readahead() - kick off readahead on fsverity hashes
+ * @folio:		first file data folio that is being read
+ * @nr_pages:		number of file data pages to be read
+ *
+ * Start readahead on the fsverity hashes that are needed to verity the file
+ * data in the range from folio->index to folio->index + nr_pages.
+ *
+ * To be called from the file systems' ->read_folio and ->readahead methods to
+ * ensure that the hashes are already cached on completion of the file data
+ * read if possible.
+ */
+void fsverity_readahead(struct folio *folio, unsigned long nr_pages)
+{
+	struct inode *inode = folio->mapping->host;
+	const struct fsverity_info *vi = *fsverity_info_addr(inode);
+	const struct merkle_tree_params *params = &vi->tree_params;
+	u64 start_hidx = (u64)folio->index << params->log_blocks_per_page;
+	u64 end_hidx = (((u64)folio->index + nr_pages) <<
+			params->log_blocks_per_page) - 1;
+	int level;
+
+	if (!inode->i_sb->s_vop->readahead_merkle_tree)
+		return;
+
+	for (level = 0; level < params->num_levels; level++) {
+		unsigned long level_start = params->level_start[level];
+		unsigned long next_start_hidx = start_hidx >> params->log_arity;
+		unsigned long next_end_hidx = end_hidx >> params->log_arity;
+		pgoff_t long start_idx = (level_start + next_start_hidx) >>
+				params->log_blocks_per_page;
+		pgoff_t end_idx = (level_start + next_end_hidx) >>
+				params->log_blocks_per_page;
+
+		inode->i_sb->s_vop->readahead_merkle_tree(inode, start_idx,
+				end_idx - start_idx + 1);
+
+		start_hidx = next_start_hidx;
+		end_hidx = next_end_hidx;
+	}
+}
+EXPORT_SYMBOL_GPL(fsverity_readahead);
+
 /*
  * Returns true if the hash block with index @hblock_idx in the tree, located in
  * @hpage, has already been verified.
@@ -114,8 +157,7 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
  * Return: %true if the data block is valid, else %false.
  */
 static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
-			      const struct fsverity_pending_block *dblock,
-			      unsigned long max_ra_pages)
+			      const struct fsverity_pending_block *dblock)
 {
 	const u64 data_pos = dblock->pos;
 	const struct merkle_tree_params *params = &vi->tree_params;
@@ -200,8 +242,7 @@ static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			  (params->block_size - 1);
 
 		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
-				hpage_idx, level == 0 ? min(max_ra_pages,
-					params->tree_pages - hpage_idx) : 0);
+				hpage_idx);
 		if (IS_ERR(hpage)) {
 			fsverity_err(inode,
 				     "Error %ld reading Merkle tree page %lu",
@@ -272,14 +313,12 @@ static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
 
 static void
 fsverity_init_verification_context(struct fsverity_verification_context *ctx,
-				   struct inode *inode,
-				   unsigned long max_ra_pages)
+				   struct inode *inode)
 {
 	struct fsverity_info *vi = *fsverity_info_addr(inode);
 
 	ctx->inode = inode;
 	ctx->vi = vi;
-	ctx->max_ra_pages = max_ra_pages;
 	ctx->num_pending = 0;
 	if (vi->tree_params.hash_alg->algo_id == HASH_ALGO_SHA256 &&
 	    sha256_finup_2x_is_optimized())
@@ -322,8 +361,7 @@ fsverity_verify_pending_blocks(struct fsverity_verification_context *ctx)
 	}
 
 	for (i = 0; i < ctx->num_pending; i++) {
-		if (!verify_data_block(ctx->inode, vi, &ctx->pending_blocks[i],
-				       ctx->max_ra_pages))
+		if (!verify_data_block(ctx->inode, vi, &ctx->pending_blocks[i]))
 			return false;
 	}
 	fsverity_clear_pending_blocks(ctx);
@@ -373,7 +411,7 @@ bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset)
 {
 	struct fsverity_verification_context ctx;
 
-	fsverity_init_verification_context(&ctx, folio->mapping->host, 0);
+	fsverity_init_verification_context(&ctx, folio->mapping->host);
 
 	if (fsverity_add_data_blocks(&ctx, folio, len, offset) &&
 	    fsverity_verify_pending_blocks(&ctx))
@@ -403,22 +441,8 @@ void fsverity_verify_bio(struct bio *bio)
 	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
 	struct fsverity_verification_context ctx;
 	struct folio_iter fi;
-	unsigned long max_ra_pages = 0;
-
-	if (bio->bi_opf & REQ_RAHEAD) {
-		/*
-		 * If this bio is for data readahead, then we also do readahead
-		 * of the first (largest) level of the Merkle tree.  Namely,
-		 * when a Merkle tree page is read, we also try to piggy-back on
-		 * some additional pages -- up to 1/4 the number of data pages.
-		 *
-		 * This improves sequential read performance, as it greatly
-		 * reduces the number of I/O requests made to the Merkle tree.
-		 */
-		max_ra_pages = bio->bi_iter.bi_size >> (PAGE_SHIFT + 2);
-	}
 
-	fsverity_init_verification_context(&ctx, inode, max_ra_pages);
+	fsverity_init_verification_context(&ctx, inode);
 
 	bio_for_each_folio_all(fi, bio) {
 		if (!fsverity_add_data_blocks(&ctx, fi.folio, fi.length,
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 121703625cc8..bade511cf3aa 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -97,10 +97,6 @@ struct fsverity_operations {
 	 *
 	 * @inode: the inode
 	 * @index: 0-based index of the page within the Merkle tree
-	 * @num_ra_pages: The number of Merkle tree pages that should be
-	 *		  prefetched starting at @index if the page at @index
-	 *		  isn't already cached.  Implementations may ignore this
-	 *		  argument; it's only a performance optimization.
 	 *
 	 * This can be called at any time on an open verity file.  It may be
 	 * called by multiple processes concurrently, even with the same page.
@@ -110,8 +106,23 @@ struct fsverity_operations {
 	 * Return: the page on success, ERR_PTR() on failure
 	 */
 	struct page *(*read_merkle_tree_page)(struct inode *inode,
-					      pgoff_t index,
-					      unsigned long num_ra_pages);
+					      pgoff_t index);
+
+	/**
+	 * Perform readahead of a Merkle tree for the given inode.
+	 *
+	 * @inode: the inode
+	 * @index: 0-based index of the first page within the Merkle tree
+	 * @nr_pages: number of pages to be read ahead.
+	 *
+	 * This can be called at any time on an open verity file.  It may be
+	 * called by multiple processes concurrently, even with the same range.
+	 *
+	 * Optional method so that ->read_merkle_tree_page preferably finds
+	 * cached data instead of issuing dependent I/O.
+	 */
+	void (*readahead_merkle_tree)(struct inode *inode, pgoff_t index,
+			unsigned long nr_pages);
 
 	/**
 	 * Write a Merkle tree block to the given inode.
@@ -308,8 +319,10 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
 }
 
 void fsverity_cleanup_inode(struct inode *inode);
+void fsverity_readahead(struct folio *folio, unsigned long nr_pages);
 
-struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
-		unsigned long num_ra_pages);
+struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index);
+void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
+		unsigned long nr_pages);
 
 #endif	/* _LINUX_FSVERITY_H */
-- 
2.47.3


