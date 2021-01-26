Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81782304912
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbhAZF3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:53 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38250 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732151AbhAZCig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628716; x=1643164716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7hQZD06/7MbLwbON8CoqRP3IpCmya3Zfmyf4RlqCOYg=;
  b=PeTVEZd7BbqdshzcZcOt4Bts0vkIiwYrzwAQE6KUuYd/ACBtcKYF/Ckw
   Kmg5BRqN9IuN8K5LKR7TZkjiwL+b2vYhY8k3h1sznrlpKUCTfQI4ndLKD
   X7c65xvnfbRhmA+Gz+46gU5HPbl/ZerdvS3c+npxSaOZWBwKuIQVRehMG
   hIc58iqDeU/yKdn6YuxZao1IybTkR0NtIRPc6818mn+o5r49ht/DWYr+9
   flG29JM5EvJtp6TA3XFFYD7sCNJnDN++cLltx0QNxj49ejv8NvAY2UaC7
   Kqsdu9ltXnq0YNCzwvxIxR2x6AxiMGTxgbBo5r6N3rLkFQJu4VosyoQW9
   Q==;
IronPort-SDR: A8dL2iIGLaGngi0GQ7M2W/O7mosIVR4MonHE5o0NHo9ZPAlWX5zXzGPIhKnxWq2zB+aNWYP/ZP
 E2ZY6i4M/eMSqpFJxHzWjDvEBYRMMGeZoy+yipEXxUtRW9Qg9gUgTTsVEQgGqCVCWmX6ROlodX
 lVXjbRTkSB1BM6quljfcUnvddE/DGc+D28kL2FmesqEw4a/YQ2jATp9bHqIxXUpqINDPpJogmH
 Gnr7iRdI8ctpAXZlMsZURlKtASbvZzRBMwlHLI/+Ah0CXwQqlGOX16My4JdzuGzvRzFVZBmRcP
 dwU=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483562"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:45 +0800
IronPort-SDR: gV+4HaXTBfSZgwNxBdRJJIuhsquGOYSHNSzPvZalvO/QK8E0dfKbpEPTJmsvdTL0ZQNC6bipfS
 hwjjYjBoNdd79wCo1TfKTAcfOb4TFRDVG3IYarcNM0BqVZGU0bGiD9BabzCoyddfW3adREwNmh
 TlCmfckjByi4NgYBNzHln6nNUkasU0psdfmoAxe+Z2R6C9LN5h0EuEXOQOP/SBHhWkFoq2X5z6
 YEVd/NK59Qu360phrqYv9tSFAiW450WE9gt1ABjkaRLgugDRXfbMzwEmzVs9CYHOT9B073niTo
 yTa5dOsXqIpma1/02uYe2foo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:11 -0800
IronPort-SDR: YrFNE2JW9NogaC4BcivPjrvJDZQ04SNKkptjUCGovujx0YgaAKID8th80I0xr+N9JUt4lHlPFk
 ii3Ssvuav9OPplFpd/CWreov+EzEeae1tBScrzz7uxCC7FqvDPPNGpfiWd5jcVtlL2QFiB7rLw
 cllFIOjFWjp/koSnRXw6S3sMlbNrkspcg1rguAMxZuB/0hDHlaMwPMt3uMeQm6ujWLmj1dnCfy
 3Eap1G7VdtR50VazLMdud8qgUoDV5y//gBfzwxNx7Io9eitMcDHekUhvU8Gxv4F7O9K3RU3rKj
 rhc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:43 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 27/42] btrfs: use ZONE_APPEND write for ZONED btrfs
Date:   Tue, 26 Jan 2021 11:25:05 +0900
Message-Id: <d3d74de60ef1f37c0c114fe20a921bd93ba850ee.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit enables zone append writing for zoned btrfs. When using zone
append, a bio is issued to the start of a target zone and the device
decides to place it inside the zone. Upon completion the device reports
the actual written position back to the host.

Three parts are necessary to enable zone append in btrfs. First, modify
the bio to use REQ_OP_ZONE_APPEND in btrfs_submit_bio_hook() and adjust
the bi_sector to point the beginning of the zone.

Secondly, records the returned physical address (and disk/partno) to the
ordered extent in end_bio_extent_writepage() after the bio has been
completed. We cannot resolve the physical address to the logical address
because we can neither take locks nor allocate a buffer in this end_bio
context. So, we need to record the physical address to resolve it later in
btrfs_finish_ordered_io().

And finally, rewrites the logical addresses of the extent mapping and
checksum data according to the physical address (using __btrfs_rmap_block).
If the returned address matches the originally allocated address, we can
skip this rewriting process.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c    | 15 +++++++--
 fs/btrfs/file.c         |  6 +++-
 fs/btrfs/inode.c        |  4 +++
 fs/btrfs/ordered-data.c |  3 ++
 fs/btrfs/ordered-data.h |  8 +++++
 fs/btrfs/volumes.c      | 15 +++++++++
 fs/btrfs/zoned.c        | 73 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h        | 12 +++++++
 8 files changed, 133 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6092ca6edc86..75df05193eb8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2734,6 +2734,7 @@ static void end_bio_extent_writepage(struct bio *bio)
 	u64 start;
 	u64 end;
 	struct bvec_iter_all iter_all;
+	bool first_bvec = true;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
@@ -2760,6 +2761,11 @@ static void end_bio_extent_writepage(struct bio *bio)
 		start = page_offset(page);
 		end = start + bvec->bv_offset + bvec->bv_len - 1;
 
+		if (first_bvec) {
+			btrfs_record_physical_zoned(inode, start, bio);
+			first_bvec = false;
+		}
+
 		end_extent_writepage(page, error, start, end);
 		end_page_writeback(page);
 	}
@@ -3582,6 +3588,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	struct extent_map *em;
 	int ret = 0;
 	int nr = 0;
+	int opf = REQ_OP_WRITE;
 	const unsigned int write_flags = wbc_to_write_flags(wbc);
 	bool compressed;
 
@@ -3628,6 +3635,10 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 
 		/* Note that em_end from extent_map_end() is exclusive */
 		iosize = min(em_end, end + 1) - cur;
+
+		if (btrfs_use_zone_append(inode, em))
+			opf = REQ_OP_ZONE_APPEND;
+
 		free_extent_map(em);
 		em = NULL;
 
@@ -3653,8 +3664,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			       page->index, cur, end);
 		}
 
-		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
-					 page, disk_bytenr, iosize,
+		ret = submit_extent_page(opf | write_flags, wbc, page,
+					 disk_bytenr, iosize,
 					 cur - page_offset(page), &epd->bio,
 					 end_bio_extent_writepage,
 					 0, 0, 0, false);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d81ae1f518f2..eaa1e473e75e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2174,8 +2174,12 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * commit waits for their completion, to avoid data loss if we fsync,
 	 * the current transaction commits before the ordered extents complete
 	 * and a power failure happens right after that.
+	 *
+	 * For zoned btrfs, if a write IO uses a ZONE_APPEND command, the
+	 * logical address recorded in the ordered extent may change. We
+	 * need to wait for the IO to stabilize the logical address.
 	 */
-	if (full_sync) {
+	if (full_sync || btrfs_is_zoned(fs_info)) {
 		ret = btrfs_wait_ordered_range(inode, start, len);
 	} else {
 		/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 419f4290bdf8..e3e4b4f7c0d7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -50,6 +50,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -2878,6 +2879,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
+	if (ordered_extent->disk)
+		btrfs_rewrite_logical_zoned(ordered_extent);
+
 	btrfs_free_io_failure_record(inode, start, end);
 
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 7c061146ead9..4d36cc87a3f7 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -199,6 +199,9 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
+	entry->physical = (u64)-1;
+	entry->disk = NULL;
+	entry->partno = (u8)-1;
 
 	ASSERT(type == BTRFS_ORDERED_REGULAR ||
 	       type == BTRFS_ORDERED_NOCOW ||
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index c400be75a3f1..6cb35df00d21 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -139,6 +139,14 @@ struct btrfs_ordered_extent {
 	struct completion completion;
 	struct btrfs_work flush_work;
 	struct list_head work_list;
+
+	/*
+	 * used to reverse-map physical address returned from ZONE_APPEND
+	 * write command in a workqueue context.
+	 */
+	u64 physical;
+	struct gendisk *disk;
+	u8 partno;
 };
 
 /*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e69754af2eba..4cb5e940356e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6507,6 +6507,21 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 	btrfs_io_bio(bio)->device = dev;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
+	/*
+	 * For zone append writing, bi_sector must point the beginning of the
+	 * zone
+	 */
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		if (btrfs_dev_is_sequential(dev, physical)) {
+			u64 zone_start = round_down(physical,
+						    fs_info->zone_size);
+
+			bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
+		} else {
+			bio->bi_opf &= ~REQ_OP_ZONE_APPEND;
+			bio->bi_opf |= REQ_OP_WRITE;
+		}
+	}
 	btrfs_debug_in_rcu(fs_info,
 	"btrfs_map_bio: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
 		bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index abe6b415de98..4f1801b71458 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1252,3 +1252,76 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
 
 	return ret;
 }
+
+void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
+				 struct bio *bio)
+{
+	struct btrfs_ordered_extent *ordered;
+	u64 physical = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
+
+	if (bio_op(bio) != REQ_OP_ZONE_APPEND)
+		return;
+
+	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode), file_offset);
+	if (WARN_ON(!ordered))
+		return;
+
+	ordered->physical = physical;
+	ordered->disk = bio->bi_disk;
+	ordered->partno = bio->bi_partno;
+
+	btrfs_put_ordered_extent(ordered);
+}
+
+void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
+{
+	struct extent_map_tree *em_tree;
+	struct extent_map *em;
+	struct inode *inode = ordered->inode;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_ordered_sum *sum;
+	struct block_device *bdev;
+	u64 orig_logical = ordered->disk_bytenr;
+	u64 *logical = NULL;
+	int nr, stripe_len;
+
+	/*
+	 * Zoned devices should not have partitions. So, we can assume it
+	 * is 0.
+	 */
+	ASSERT(ordered->partno == 0);
+	bdev = bdgrab(ordered->disk->part0);
+	if (WARN_ON(!bdev))
+		return;
+
+	if (WARN_ON(btrfs_rmap_block(fs_info, orig_logical, bdev,
+				     ordered->physical, &logical, &nr,
+				     &stripe_len)))
+		goto out;
+
+	WARN_ON(nr != 1);
+
+	if (orig_logical == *logical)
+		goto out;
+
+	ordered->disk_bytenr = *logical;
+
+	em_tree = &BTRFS_I(inode)->extent_tree;
+	write_lock(&em_tree->lock);
+	em = search_extent_mapping(em_tree, ordered->file_offset,
+				   ordered->num_bytes);
+	em->block_start = *logical;
+	free_extent_map(em);
+	write_unlock(&em_tree->lock);
+
+	list_for_each_entry(sum, &ordered->list, list) {
+		if (*logical < orig_logical)
+			sum->bytenr -= orig_logical - *logical;
+		else
+			sum->bytenr += *logical - orig_logical;
+	}
+
+out:
+	kfree(logical);
+	bdput(bdev);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 92888eb86055..cf420964305f 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -47,6 +47,9 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em);
+void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
+				 struct bio *bio);
+void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -139,6 +142,15 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
 {
 	return false;
 }
+
+static inline void btrfs_record_physical_zoned(struct inode *inode,
+					       u64 file_offset, struct bio *bio)
+{
+}
+
+static inline void btrfs_rewrite_logical_zoned(
+				struct btrfs_ordered_extent *ordered) { }
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

