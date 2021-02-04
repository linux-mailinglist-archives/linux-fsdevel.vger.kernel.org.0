Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1080830F0B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhBDK1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:27:24 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54283 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbhBDK1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434424; x=1643970424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XXS0lJkbOkA+iPE68KkSqE1R1W2sX5cgKt37F5O8CS8=;
  b=mk9T6IuUnrlvhRAwvbfzGJBmyNOwmftVv5lgGCSyU6EotDUSQ7sbDwF1
   oqPJ8/uKsMiedzyY+ooTrXIng2rd2uqTh7xSLpZM0rwI9JYq85/q4W+RB
   KObeJQIo95dlCaTYHPrQ7irZsW9zhKIcHScfaEmW4/K11BXJsucIqFRqB
   gMPgP09pCY+iXUS7VlWBkTGNMrJ8pf8TiFZGj30OvHgPYsYsfJTsHwhPu
   STNJ+AAFeMJjUsj7Lk/97/B1SW6AeFRi+TNmmb+O0+OO9pMDRWZaYgaSN
   ELfkGotqrF57hC0fHd700jBz4sCW+AyoIPqDgUV3b3+onj+ckzbMTBRWk
   A==;
IronPort-SDR: 3MyhkXuExbbPx1qGVAI+b7+pWY0RRMVghbsSjS0J9si0oL/gJXkVcAkaq/mJjpuLrICtC07dAh
 x25pFR/AoQrnskj/g+J04Zge996FLyOJxTKDcom6qhsGNbVlY78rTHkNDatERC+QvdctHQNBMo
 3QH1PMFmpsWs0kW9TH1O0VcNtTha+l7dN006iX2aA/nSrjxSumOfDF/ajmSLxtD/D3fhE2QNng
 j/YvV2ipb+frulV9cF+YWCVeHplBGQ+kApKe57lbD9byAckk8+MaSKLryQmlgu1w0jWuXYmFj0
 YEM=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108018"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:26 +0800
IronPort-SDR: N/xKJz3H3HQM5z6jnGT80R67arB5lDApIhfyrssXv/Ai4daAMOAjo5v8q+LDBJSliz0nZV8RbS
 +UCVCf16DZa25L5Nhm/eczyOnyvrWNn8orow/GLmroQuibwEjV1GCG5y/FXy86ZVMy/0NVNYZg
 ZGMB8K1Vqsy+QJH5Xt5sNyj6HAsOs0a7Ki7YFG+5ZcbDhMQDfmhFtGj2+q6XCLBOWKcWwsB4TQ
 csxirSgHZNXLGu0AG+zEEJxD/i3hdamAqwqcerMpNIOG5ZpcaMPSRxhd4n5P4VmI/2SSeo9jCa
 +FoVUlhXzYJNXDfyxFzlyUAK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:29 -0800
IronPort-SDR: +fdHMZBQkGF8VFWlYCzyey/bgA+yiUQEdov/0iplXWBRpoMKyZYivsMkN32PG8kKo0lhPnd3Ir
 S/gruOwxYCj8HvWhLynTOV2vuD6zumxiw2wAeWYxj1OGBUe4+b2/ytuBh5yGQPat4zxF7daggN
 L6ORXor6yV7lbjf+BzHdnWGNumuBMxbtzY+tfKV9YEyQrtJWhIL7XnUUWFyuaaJiKjM3Bj2a2J
 4plwjUULplatq0AOlx3D7twzRrK11EggfUG276Wf1lcm/I6LX8wcAgHuibl5EX8zBqiObyN3mI
 hjE=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:25 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v15 22/42] btrfs: zoned: check if bio spans across an ordered extent
Date:   Thu,  4 Feb 2021 19:22:01 +0900
Message-Id: <2118f2d9559cbd71356a55ad4f378b5705a43e22.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

To ensure that an ordered extent maps to a contiguous region on disk, we
need to maintain a "one bio == one ordered extent" rule.

Ensure that constructing bio does not span more than an ordered extent.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h     |  2 ++
 fs/btrfs/extent_io.c |  9 +++++++--
 fs/btrfs/inode.c     | 27 +++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a9b0521d9e89..10da47ab093a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3120,6 +3120,8 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 				 struct extent_state *orig, u64 split);
 int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 			     unsigned long bio_flags);
+bool btrfs_bio_fits_in_ordered_extent(struct page *page, struct bio *bio,
+				      unsigned int size);
 void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
 int btrfs_readpage(struct file *file, struct page *page);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 15503a435e98..72b1a23d17f9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3124,10 +3124,15 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
 	if (btrfs_bio_fits_in_stripe(page, size, bio, bio_flags))
 		return false;
 
-	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct page *first_page = bio_first_bvec_all(bio)->bv_page;
+
+		if (!btrfs_bio_fits_in_ordered_extent(first_page, bio, size))
+			return false;
 		ret = bio_add_zone_append_page(bio, page, size, pg_offset);
-	else
+	} else {
 		ret = bio_add_page(bio, page, size, pg_offset);
+	}
 
 	return ret == size;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 750482a06d67..31545e503b9e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2215,6 +2215,33 @@ static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
 }
 
+bool btrfs_bio_fits_in_ordered_extent(struct page *page, struct bio *bio,
+				      unsigned int size)
+{
+	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_ordered_extent *ordered;
+	u64 len = bio->bi_iter.bi_size + size;
+	bool ret = true;
+
+	ASSERT(btrfs_is_zoned(fs_info));
+	ASSERT(fs_info->max_zone_append_size > 0);
+	ASSERT(bio_op(bio) == REQ_OP_ZONE_APPEND);
+
+	/* Ordered extent not yet created, so we're good */
+	ordered = btrfs_lookup_ordered_extent(inode, page_offset(page));
+	if (!ordered)
+		return ret;
+
+	if ((bio->bi_iter.bi_sector << SECTOR_SHIFT) + len >
+	    ordered->disk_bytenr + ordered->disk_num_bytes)
+		ret = false;
+
+	btrfs_put_ordered_extent(ordered);
+
+	return ret;
+}
+
 static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
 					   struct bio *bio, loff_t file_offset)
 {
-- 
2.30.0

