Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B69C3034DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbhAZF3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:20 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38256 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732097AbhAZCgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628578; x=1643164578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gvbD4z5IB2RF0Zbskb8h6rGcV0uN7PdkjCyrNVFHGfE=;
  b=WiOjE9/BX02hKw5PlZezYyMcZzFMyklMGODLH9zkiYjGCm7Fwrs95Ze4
   M7ovt9iit3arAt8kKpz7gYbet3ZkgBM1lJnPCz56etbvc9r39SF44CIQG
   tkaCRRwAoZhSQyD320XCxX+IUHYcW3HffacM+OyLRmsPIovOaTf8nnHP1
   nCFfhxKqXy32rxm4M5ah+ZR9iwjRijGhUHlVEDrlJXV3BVvrC7bidcfi7
   1JIVsBKWtUzh9uaVAH2Y3oD+UG8owX+C+e/TECbKzyBgsCDB8FVX4E4ai
   e6cLpmma2c92OaEEv2S3DHTckIGcmAStNoiJM48fIA4YgaAqaVxG/1JsQ
   Q==;
IronPort-SDR: k4LpN99b4XT6Zq4bWdw3begrLZ1qMvF1Km7vc3jqgxHj0n/aVGmk/AJBEbV6qDcpfW14NxBrPw
 Fy9OwDmS/mqg+j92Y8Qcm0h3eginUXnqe7yAS9+hrD+0zhEGmQumg9sFEMV17vavRgsaktL6Qa
 VvKTilUgsuVDTasZo1o8EuH3Mfc36QTGLpzevMKgxypNYE3WfhnkOWuu6IqK+JkziQoed+0c8V
 UnbMbu4nKVQOnDXrWlVPSzZxeQE+IxNhnUjgoQgpsiEDoK0HbnMfWYMhdPs5xrdMW2XP8DPKYA
 5Ik=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483555"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:38 +0800
IronPort-SDR: d6fKTtOpH5EemapAftatn7Ai4/mAeMEZMRW5V4JnSIn+r4fEW7jaIaTHSFUKajOEwzT838460f
 vmwJkSwRi9gqeyeN3Z6W738TbGRoRRCFcnd+H8uhX97WpZuuaSckXtYeA8LCXwz3mElYTbW1fG
 +vhIel9gXquIzZehQ86xpRLnno9pZghFCrSz5PHWWr43E1sV4M2nqlrHrFTRIFNT1MxxizvNsp
 acOG1wzky3YHn638EqJhlZg52iPTzObflYwaazdWjmKOCs1y3bgbhVPXikNC7PmVB4OVAFriE+
 xjvwpHD8OIhkBUjfmDMDmntR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:05 -0800
IronPort-SDR: SlkyZqQhJEYFkVpk8OrMkvn61ZlafXC45jpVCdvH7dC6G4WihOx1dSlpm4KI2EQwlgP8yatPEP
 N/dwpEwV0fDtTsLrTDLmGSP5XfM5ovAX38fjuY46IfNvmTCHGy8ddtyrlSE+G1Vu95bEBPhSP9
 DVBzPyTbF2W75EkhDT+yBN2NpXK+6WHtRhjSoD/kkHI6z7HFDK8ZeH1DMRqVXaerhrSTSPvF2+
 5UM0xpPn7dEEzg4NqNkloTCd1R5ko+fzmQ7tZribXcbj2P/MlNTpYyy8g3g545SMe2sSNOHmLO
 c9s=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:36 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 23/42] btrfs: check if bio spans across an ordered extent
Date:   Tue, 26 Jan 2021 11:25:01 +0900
Message-Id: <430fac31a56a9d251c42f1e3036d7614abe56be4.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

To ensure that an ordered extent maps to a contiguous region on disk, we
need to maintain a "one bio == one ordered extent" rule.

This commit ensures that constructing bio does not span across an ordered
extent.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h     |  2 ++
 fs/btrfs/extent_io.c |  9 +++++++--
 fs/btrfs/inode.c     | 29 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 29976d37f4f9..6c4ff56eeb5e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3119,6 +3119,8 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 				 struct extent_state *orig, u64 split);
 int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 			     unsigned long bio_flags);
+bool btrfs_bio_fits_in_ordered_extent(struct page *page, struct bio *bio,
+				      unsigned int size);
 void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
 int btrfs_readpage(struct file *file, struct page *page);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ad19757d685d..6092ca6edc86 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3098,10 +3098,15 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
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
index 92fae7654a3a..419f4290bdf8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2217,6 +2217,35 @@ static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
 }
 
+
+
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
2.27.0

