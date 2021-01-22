Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DB12FFCAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbhAVG1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:27:41 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51031 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbhAVG0d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296792; x=1642832792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m8HW66vMHAbw2Hs4DnX6UYtfb9TX4vO8e6FqIcm3MCc=;
  b=G5E7zCGNVo8Cr4YX6A8nZa+fQ0B7LBJatARk+MULL7nNeZiI2aXZDyIF
   kJMX6NqsFc9ejXSeY7qZevSASq20OduhewuOlaRmluubRb01Ov/yVcXU+
   bjIMUSuV0+IIB0aHcTjAiU0tFomJ3OMpVf8TbXO8HjtkSB69DR3nC6pG2
   NwH6A8nsH4XOl591Tz68SYhliLhPGnUNZUbu8iTS1pm1JADORjABUvmhC
   KkoCzlVznYXwv+lPW2iwPfohR0I11gb8HWwDFClHw/evkZBODtXo11j4L
   0NSd0oyFedDz/cNQ3s5pUQ8FvtX/98jwGraJdGaUlIyzqDsnF0QXnPcds
   Q==;
IronPort-SDR: I0hawge27db28yCblhy4gzDPw3+pZ5RzWlGabd/7Yux8DCL6EDkaUxY6p3mjsKqjRVB3QFTHex
 gP/u/iIKz+aIksJD0a+Try4hopEdCzSAjiCNU0TxknBD/VSOKN668U3OM5QouD3qgwOGz9RjnF
 qQDFcCCeL5xbF8pjFi7S7PLuD8NA0NFpyqg/ayyV/0IBYncCGRgvKp7tiPaO8i0317sbkueCOH
 mkYhb8QgWLY/RVOkGMCFg+c4V+WoLqrD9sAQwkUMbdI4Nm/aIQGTisUN8d13k+x7a1RFEEg8c1
 mzQ=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392014"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:59 +0800
IronPort-SDR: mCA0vNFfknlbxOEP12l+0wAehAnOFWHqIGJ5l4ECklJVYR9caWO7aorI27Cz+BkEIQAkhUmIOP
 JtaUNFRerHi7gog7HiE+q6GmYoJXkWfwnYUtP+guFKg/4emq7mCu1z9ZznyYvDdjA+eMJjGaAV
 lNnqI/UKz3BtSWzV+IgNGl9xZvtaXhUpM4eHM40YqM+BWZb5Pr+6oYAQMFsT2YTuzap+weVu2u
 YB6zpmzoNmr36d/MoOBAAmFmAMqCbJ4KtlXPUEFqe3wOHIxNS/t18HyxLIIsvViCfsHaruX952
 ssLJHw4c4thpM+H5TmFSWx5i
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:31 -0800
IronPort-SDR: lNlzhjCuNG+Q/zVK6J2NnZmM1qRYkiuUTkdIAvKps8xcEi2L937VlKvNUPy50ogCD/vfwqEBUA
 cdpew1pfsWCJwTpF674uWUmHYtAqcB8m7WQhtO0VHZVxZK6EdhddDWEbxlZ49k+iYFTVABAVVX
 18rREj8w19uf0ZFUMmx3KghKsqI1o3i5aiWN/cxtLoV2ccKveO0aS8WlgRzPA9KTtXdK91YOCt
 GzqrQB7NG0fyMOSOgNh3CzF94zvcRinw4lA7jKslnp8dNnTAjqFuinZ1a34WQhY6ZR/J4s+7mZ
 6VE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:57 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v13 23/42] btrfs: check if bio spans across an ordered extent
Date:   Fri, 22 Jan 2021 15:21:23 +0900
Message-Id: <b82f4a6510eea4dd567251d52311add6dcb8e4b9.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
---
 fs/btrfs/ctree.h     |  2 ++
 fs/btrfs/extent_io.c |  9 +++++++--
 fs/btrfs/inode.c     | 29 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4b2e19daed40..1b6f66575471 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3116,6 +3116,8 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 				 struct extent_state *orig, u64 split);
 int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 			     unsigned long bio_flags);
+bool btrfs_bio_fits_in_ordered_extent(struct page *page, struct bio *bio,
+				      unsigned int size);
 void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
 int btrfs_readpage(struct file *file, struct page *page);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9c8faaf260ee..b9fefa624760 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3097,10 +3097,15 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
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
index ab97d4349515..286eee122657 100644
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

