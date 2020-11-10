Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02BB2AD507
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbgKJL3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:02 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11994 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730559AbgKJL2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007726; x=1636543726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LjZe5Xoe5pTP9Y53VSdJDUSVoh2ZKG8qiTFbp/0qTJE=;
  b=fVb6tHJwKqTVADWiHzj5WKnY8Ff9+Diaf8kVf2vhT4Tq05fcQbUAaFJu
   tPIKTR4xAWECMQIBVplYhhjMo28AZwm+QN2IANFobSfOk+A/lWFByBAdg
   EUBj1mxHMqd+TqrQ9wbNcUsaPUS1I5DU8W1dg8tEVePMyCkPCZAk6M6hr
   ehtuWxz+ZPa5WdKXpTps5T4CinadeGf4AbKImYfUKr8edvZLlo1198iCv
   ZdbvgfO5P6PhdQJO0U0FUbBMbVuYYyhhQKy2bbBqq79GbtJewVyuEZzPJ
   zNQjkyBeFy/tQ/Jzr0BuWm4HmgfONg2V03YvKBs4bhzqCldbMxmv/PO83
   g==;
IronPort-SDR: TlWHVnNfI/sCmRi6AnX0eG+Y9nLo5P/HIhcgJDPXyjQOnVzzQrnMlnXsNPgFewu7EE2DWgPFLw
 SBHY15syVIzWrgMnW/StM+yyR9BQMCT+RDGc4FExIW3NA1HtN+xMK5e1TTpaEMVDNYfFP7v0gb
 DCNRep9LukMUqvSahSwljs9+IdY7Rza04kp/gdj27rcKQVgSvL1iRX+wHJON+kDsQG1vOkOSsO
 RWP+SU9xQWqSBuLHFjKPt5eQMZVJyATgi06CEr2IKKS/XYxmYwN9YcZMXvbjqKpfnOI9izWwfV
 GZM=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376588"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:46 +0800
IronPort-SDR: 4UKjNrcRSsKnd5pgwyQmGC1XV6XBCEhW3GZoY4jT96jkNPldHAqE3L7/5UMh7JGZxxkTwHE1qF
 Gxt2GOaB239QVf1K1pOWshb9obqfOAbAqxlcL+CoKjADZH0T6S9YfFJPg7Qgm5xw8LJq8+Ks14
 JvpOO94J/kcK4HgtFU78LXt5llWMU9QhhomakZHtufrLzaBFIeSycPVIYGQa8UqRDfpbYR83Sb
 p9BYD/RDnkxCwpIBDfbDKZErEd+/oX5+hY1nwhYj21HS+lwKXdTLF9HHyPno0aSwOwlhTQhi2n
 YTyF+475kHsA8fzigbfdxhf0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:47 -0800
IronPort-SDR: pKt8FWIGxuy7FArfjg3ZLHx1ovn4y1reG6zkE9w4xkykqVqH0/O+EgAkqArJDekT8r1WkNII7k
 ZC2NuZpqtZjwsLiGf8IHzesrlZJ0IOtk6zUGk0nEohnIvCmrv24Mzh6fL6L9qiwmkoLI93Wsd4
 EGup2UVKycBpfvcAnDXflXb4+Fo69AkqdZ6smuDmaJg7wQ2TAPQWGApmEzTYAoQ2OS0t5Y1yYY
 OyGzXNz9Ntb3xBMwJR/EZwwzCKAR9VZMLbwImBU2hAFHFXA38MWLM00zNEJm/SM1ksD4Eq0ruj
 j/g=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:45 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v10 25/41] btrfs: use ZONE_APPEND write for ZONED btrfs
Date:   Tue, 10 Nov 2020 20:26:28 +0900
Message-Id: <3ee842f2daea5bee76e62997b843dd5a49183481.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c    | 12 +++++++-
 fs/btrfs/file.c         |  2 +-
 fs/btrfs/inode.c        |  4 +++
 fs/btrfs/ordered-data.c |  3 ++
 fs/btrfs/ordered-data.h |  8 +++++
 fs/btrfs/volumes.c      | 15 +++++++++
 fs/btrfs/zoned.c        | 68 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h        | 11 +++++++
 8 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b9b366f4d942..7f94fef3647b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2743,6 +2743,7 @@ static void end_bio_extent_writepage(struct bio *bio)
 	u64 start;
 	u64 end;
 	struct bvec_iter_all iter_all;
+	bool first_bvec = true;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
@@ -2769,6 +2770,11 @@ static void end_bio_extent_writepage(struct bio *bio)
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
@@ -3525,6 +3531,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	size_t blocksize;
 	int ret = 0;
 	int nr = 0;
+	int opf = REQ_OP_WRITE;
 	const unsigned int write_flags = wbc_to_write_flags(wbc);
 	bool compressed;
 
@@ -3537,6 +3544,9 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		return 1;
 	}
 
+	if (btrfs_is_zoned(inode->root->fs_info))
+		opf = REQ_OP_ZONE_APPEND;
+
 	/*
 	 * we don't want to touch the inode after unlocking the page,
 	 * so we update the mapping writeback index now
@@ -3597,7 +3607,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			       page->index, cur, end);
 		}
 
-		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
+		ret = submit_extent_page(opf | write_flags, wbc,
 					 page, offset, iosize, pg_offset,
 					 &epd->bio,
 					 end_bio_extent_writepage,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 68938a43081e..bdc268c91334 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2226,7 +2226,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * the current transaction commits before the ordered extents complete
 	 * and a power failure happens right after that.
 	 */
-	if (full_sync) {
+	if (full_sync || btrfs_is_zoned(fs_info)) {
 		ret = btrfs_wait_ordered_range(inode, start, len);
 	} else {
 		/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index df85d8dea37c..fe15441278de 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -51,6 +51,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -2676,6 +2677,9 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	bool clear_reserved_extent = true;
 	unsigned int clear_bits;
 
+	if (ordered_extent->disk)
+		btrfs_rewrite_logical_zoned(ordered_extent);
+
 	start = ordered_extent->file_offset;
 	end = start + ordered_extent->num_bytes - 1;
 
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 35ef25e39561..1a3b06713d0f 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -199,6 +199,9 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
+	entry->physical = (u64)-1;
+	entry->disk = NULL;
+	entry->partno = (u8)-1;
 	if (type != BTRFS_ORDERED_IO_DONE && type != BTRFS_ORDERED_COMPLETE)
 		set_bit(type, &entry->flags);
 
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index e346b03bd66a..084c609afd83 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -127,6 +127,14 @@ struct btrfs_ordered_extent {
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
index 683b3ed06226..c8187d704c89 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6503,6 +6503,21 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
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
 		bio_op(bio), bio->bi_opf, (u64)bio->bi_iter.bi_sector,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b56bfeaf8744..f38bd0200788 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1060,3 +1060,71 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans)
 	}
 	spin_unlock(&trans->releasing_ebs_lock);
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
+	bdev = bdget_disk(ordered->disk, ordered->partno);
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
index a7de80c313be..2872a0cbc847 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -45,6 +45,9 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
 void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
+void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
+				 struct bio *bio);
+void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -129,6 +132,14 @@ static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 					  struct extent_buffer *eb) { }
 static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
 
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

