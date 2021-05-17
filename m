Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E3383C6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbhEQShN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbhEQShL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 14:37:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9495EC061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 11:35:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p6so3652513plr.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VbxOJCYq8JSOEAJrTK39MYATUopuHkNjEjyqSmH0zGM=;
        b=m2JTwb7qTzQIa66kW5g3+PEcqai2g9AY/TYfyCylOB7oDec9OoJRBp55L1M8jBbcqR
         iv6+NMjf50FmX0h20txW3f6qczehibCoH3VpMUG7yQUiWboIaa0RVFj+FHDXtLjw5xc0
         B5/b/Sgowh2YH/p23gDZkWH7eUy6AADLXDlrmGrXis+N+qodBDZY665H1R+/2cW9wfWV
         XM/5UxQWjOkLwZWDFSXtTA1124UTrCYsLT6wh1b0yY7LBnvGahpZD4aipR5IkASDOJtD
         JfmUo79um9hwdp1HOCqaqYu6s2VtdeLBArteKhP6I2Ra/TfbMTSjO3fV4BJVBq6Kx/5l
         d5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VbxOJCYq8JSOEAJrTK39MYATUopuHkNjEjyqSmH0zGM=;
        b=Z7vrdJjGs1mLf9rrxFj0UDdyUmbCKBe3pjdiXUrzlzD43lC203MZHZcYUhwHezkYhh
         gxJBKQQ+WMuMHPblgIkVaeXP/0fq7xVmTsoSz9kUNzDw/UcOlHh9ZaM/IrWyXd9PRjzO
         QAqhISQQW29ToRqlklwXUs21IvFFYHfqci+XOpGofStFqa/B6Qu5unFuTJ2SYUQKSxUQ
         bU5dD80gPYh2u3+NvfGBJkW4iGzP7cQMDMEgRbk7KXhY+Gsv61yYcESSC1wEeUA2z3f1
         6KtaT/rQmrpXAkoRbMNm7YEoNW2FqUc803Bv/P13oHEz14McMTGNRAFESJcTfBZ7uwE7
         Mf0g==
X-Gm-Message-State: AOAM532GJvEp0QrpAs8h95aVqZm/UpaJbrf0OrR7S3L6vk9Hg+cY77w/
        HB/gxTTBXRLJjNOLTfiuwklMUvmlW7j9nw==
X-Google-Smtp-Source: ABdhPJxJmj2E5+I3r9ZTd/XK5ovz7nFdYhDKEV/bXFHxm7rL2kOWGoI4lehWU70i70zx0zsl5/Pogw==
X-Received: by 2002:a17:90a:da06:: with SMTP id e6mr463737pjv.183.1621276553369;
        Mon, 17 May 2021 11:35:53 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:19a9])
        by smtp.gmail.com with ESMTPSA id v15sm5498763pfm.187.2021.05.17.11.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 11:35:50 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RERESEND v9 4/9] btrfs: don't advance offset for compressed bios in btrfs_csum_one_bio()
Date:   Mon, 17 May 2021 11:35:22 -0700
Message-Id: <7d5c96bc72802a96b3793ac11abbb97bcbd218ab.1621276134.git.osandov@fb.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621276134.git.osandov@fb.com>
References: <cover.1621276134.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

btrfs_csum_one_bio() loops over each filesystem block in the bio while
keeping a cursor of its current logical position in the file in order to
look up the ordered extent to add the checksums to. However, this
doesn't make much sense for compressed extents, as a sector on disk does
not correspond to a sector of decompressed file data. It happens to work
because 1) the compressed bio always covers one ordered extent and 2)
the size of the bio is always less than the size of the ordered extent.
However, the second point will not always be true for encoded writes.

Let's add a boolean parameter to btrfs_csum_one_bio() to indicate that
it can assume that the bio only covers one ordered extent. Since we're
already changing the signature, let's get rid of the contig parameter
and make it implied by the offset parameter, similar to the change we
recently made to btrfs_lookup_bio_sums(). Additionally, let's rename
nr_sectors to blockcount to make it clear that it's the number of
filesystem blocks, not the number of 512-byte sectors.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c |  5 +++--
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/file-item.c   | 35 ++++++++++++++++-------------------
 fs/btrfs/inode.c       |  8 ++++----
 4 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 2bea01d23a5b..b6d9a9657c3a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -454,7 +454,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			BUG_ON(ret); /* -ENOMEM */
 
 			if (!skip_sum) {
-				ret = btrfs_csum_one_bio(inode, bio, start, 1);
+				ret = btrfs_csum_one_bio(inode, bio, start,
+							 true);
 				BUG_ON(ret); /* -ENOMEM */
 			}
 
@@ -486,7 +487,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	BUG_ON(ret); /* -ENOMEM */
 
 	if (!skip_sum) {
-		ret = btrfs_csum_one_bio(inode, bio, start, 1);
+		ret = btrfs_csum_one_bio(inode, bio, start, true);
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 938d8ebf4cf3..178ad516eaaa 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3082,7 +3082,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
 blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-				u64 file_start, int contig);
+				u64 offset, bool one_ordered);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 294602f139ef..8f755ef20aaa 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -615,28 +615,28 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
  * btrfs_csum_one_bio - Calculates checksums of the data contained inside a bio
  * @inode:	 Owner of the data inside the bio
  * @bio:	 Contains the data to be checksummed
- * @file_start:  offset in file this bio begins to describe
- * @contig:	 Boolean. If true/1 means all bio vecs in this bio are
- *		 contiguous and they begin at @file_start in the file. False/0
- *		 means this bio can contains potentially discontigous bio vecs
- *		 so the logical offset of each should be calculated separately.
+ * @offset:      If (u64)-1, @bio may contain discontiguous bio vecs, so the
+ *               file offsets are determined from the page offsets in the bio.
+ *               Otherwise, this is the starting file offset of the bio vecs in
+ *               @bio, which must be contiguous.
+ * @one_ordered: If true, @bio only refers to one ordered extent.
  */
 blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
-		       u64 file_start, int contig)
+				u64 offset, bool one_ordered)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_ordered_extent *ordered = NULL;
+	const bool page_offsets = (offset == (u64)-1);
 	char *data;
 	struct bvec_iter iter;
 	struct bio_vec bvec;
 	int index;
-	int nr_sectors;
+	int blockcount;
 	unsigned long total_bytes = 0;
 	unsigned long this_sum_bytes = 0;
 	int i;
-	u64 offset;
 	unsigned nofs_flag;
 
 	nofs_flag = memalloc_nofs_save();
@@ -650,18 +650,13 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	sums->len = bio->bi_iter.bi_size;
 	INIT_LIST_HEAD(&sums->list);
 
-	if (contig)
-		offset = file_start;
-	else
-		offset = 0; /* shut up gcc */
-
 	sums->bytenr = bio->bi_iter.bi_sector << 9;
 	index = 0;
 
 	shash->tfm = fs_info->csum_shash;
 
 	bio_for_each_segment(bvec, bio, iter) {
-		if (!contig)
+		if (page_offsets)
 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
 
 		if (!ordered) {
@@ -669,13 +664,14 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 			BUG_ON(!ordered); /* Logic error */
 		}
 
-		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info,
+		blockcount = BTRFS_BYTES_TO_BLKS(fs_info,
 						 bvec.bv_len + fs_info->sectorsize
 						 - 1);
 
-		for (i = 0; i < nr_sectors; i++) {
-			if (offset >= ordered->file_offset + ordered->num_bytes ||
-			    offset < ordered->file_offset) {
+		for (i = 0; i < blockcount; i++) {
+			if (!one_ordered &&
+			    (offset >= ordered->file_offset + ordered->num_bytes ||
+			     offset < ordered->file_offset)) {
 				unsigned long bytes_left;
 
 				sums->len = this_sum_bytes;
@@ -706,7 +702,8 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 					    sums->sums + index);
 			kunmap_atomic(data);
 			index += fs_info->csum_size;
-			offset += fs_info->sectorsize;
+			if (!one_ordered)
+				offset += fs_info->sectorsize;
 			this_sum_bytes += fs_info->sectorsize;
 			total_bytes += fs_info->sectorsize;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 955d0f5849e3..b96206bb5b52 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2230,7 +2230,7 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
 					   u64 dio_file_offset)
 {
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
+	return btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
 }
 
 bool btrfs_bio_fits_in_ordered_extent(struct page *page, struct bio *bio,
@@ -2420,7 +2420,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 					  0, btrfs_submit_bio_start);
 		goto out;
 	} else if (!skip_sum) {
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
+		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
 		if (ret)
 			goto out;
 	}
@@ -7999,7 +7999,7 @@ static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
 						     struct bio *bio,
 						     u64 dio_file_offset)
 {
-	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, 1);
+	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, false);
 }
 
 static void btrfs_end_dio_bio(struct bio *bio)
@@ -8058,7 +8058,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		 * If we aren't doing async submit, calculate the csum of the
 		 * bio now.
 		 */
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, 1);
+		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, false);
 		if (ret)
 			goto err;
 	} else {
-- 
2.31.1

