Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CECC3034D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbhAZF3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:17 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38250 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbhAZCf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628555; x=1643164555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SxJne3p2Xhpjjk7eFNWNTn3PUxOOwtkuubHw0ijL2hA=;
  b=qGPiYJbAY5+ax9O8ftxBMBtJl/UnS/2slkHEJ1yjyjDBIGbSgOq24Hsd
   1QaebAQQbI3/PJN3makuiD5ATGxH3FEVVn5+H9r+0c40qzd+bUU1ySSNg
   MxaQrOx3WS63niedgpJRg7aYdeNKaO4jEyzkTJNmC+7+GbUOYjF0e98XB
   r0pCG0UStuOXvLDBPh36THTk2l1Iobu07Eqnv81SHC/QXEcTHOm13zCDm
   fOe64VKDYJjkT4izuT5TiRH4zgc0B5QBEchl2PdgMO6IDX4iJaE+IPcbs
   dycToLPqXigiBheMqlsIBALAMfJDN2z7KutMkwPTUBBPOqCXFlvqsD7ZQ
   A==;
IronPort-SDR: gDAWA+lV3bZqY+x6woauad7Pt7moeH3NOVCdAHfa2yVE9TjJpqW/UtoxYq7onOHRk4lmnKf4AM
 nmhMoNjg544Hdjyd9gJ4IO9cQfVr/3b/hUisMSJKwVP1Q3EVAGjztG+b/NlRFGvhvY+02iGjux
 Qsx6JwdskiFZ/z9lahdfMk6UCM75EFV3kTl1n6odnxDBQZsNDOoQdjWQ/G69cYNUjeCN2P3kFb
 TjbFHQW+S3LrAbMAes2ugCytMhbuQ6P3aSDLlLZJnUNzJK1dalG69m8aLHPMg5Vev2bSQ97ENe
 mPo=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483550"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:35 +0800
IronPort-SDR: v0jnXDLIB5065BtUSEZVUPddA3UzJzr+RLtvcWgMk6ZhlLRlQm12la2PFOtCGMwlDQ2Naar74R
 nqv6O3hnXhneESOA9aDV2BeovbmIxIKc8Uzw+r3ycm0TdBkE3e+IY6ZvSjPfLdU4gum9jSQUpC
 5qadpcc4bF2Ubo15SqUWsWTisP1Ddsh5CuKyMhEcH0L7vJLE/RxrNtyA0cgVsd6ORkRFHsAC0x
 YK62o94iWU5YJdUpWzC++Rj4rTtojt9n3N0YXkAwnkysV1XQ9rQZt2eCQnFQQqqORCjiN7kEXg
 iwvsw7g1Hjwy1UWZmOoW/XUZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:01 -0800
IronPort-SDR: nFTAwLlpfgx3glSTIaxQxuOJtVN2pSVAXjEDDanId9rrJYlYb9h34fVMiVNOA5G9uIu4Ld6uKN
 FEPPb/FWrxPj/tsXd34xGC8RojBoSm5Qe7QURdz7UNn+JTkXTa7Bk71IOUQqBHRqwgH3KvpsjF
 HZ/VX3inFED+EzbfJXZKCZDvSPSJBy6hWE89GQfs/UlW3Dk/l+O+vJEOr1ZcWPGmP8sxl/0u9J
 gvy49nVVIrblSbk95uMy+o3SgCzcyIqYxmEJmk+0eQybA5o0Mov1jHFH1YP2RMh1uylzcKpgnf
 Yq8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:33 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 21/42] btrfs: handle REQ_OP_ZONE_APPEND as writing
Date:   Tue, 26 Jan 2021 11:24:59 +0900
Message-Id: <52be26da1c7d2521665c385744dd7115e09dc644.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ZONED btrfs uses REQ_OP_ZONE_APPEND bios for writing to actual devices. Let
btrfs_end_bio() and btrfs_op be aware of it.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c |  4 ++--
 fs/btrfs/inode.c   | 10 +++++-----
 fs/btrfs/volumes.c |  8 ++++----
 fs/btrfs/volumes.h |  1 +
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d530bceb8f9b..ba0ca953f7e5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -652,7 +652,7 @@ static void end_workqueue_bio(struct bio *bio)
 	fs_info = end_io_wq->info;
 	end_io_wq->status = bio->bi_status;
 
-	if (bio_op(bio) == REQ_OP_WRITE) {
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
 		if (end_io_wq->metadata == BTRFS_WQ_ENDIO_METADATA)
 			wq = fs_info->endio_meta_write_workers;
 		else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_FREE_SPACE)
@@ -828,7 +828,7 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 	int async = check_async_write(fs_info, BTRFS_I(inode));
 	blk_status_t ret;
 
-	if (bio_op(bio) != REQ_OP_WRITE) {
+	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		/*
 		 * called for a read, do the setup so that checksum validation
 		 * can happen in the async kernel threads
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0dbe1aaa0b71..04b9efe4ca5a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2252,7 +2252,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
 
-	if (bio_op(bio) != REQ_OP_WRITE) {
+	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
 		if (ret)
 			goto out;
@@ -7684,7 +7684,7 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	if (!refcount_dec_and_test(&dip->refs))
 		return;
 
-	if (bio_op(dip->dio_bio) == REQ_OP_WRITE) {
+	if (btrfs_op(dip->dio_bio) == BTRFS_MAP_WRITE) {
 		__endio_write_update_ordered(BTRFS_I(dip->inode),
 					     dip->logical_offset,
 					     dip->bytes,
@@ -7850,7 +7850,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_dio_private *dip = bio->bi_private;
-	bool write = bio_op(bio) == REQ_OP_WRITE;
+	bool write = btrfs_op(bio) == BTRFS_MAP_WRITE;
 	blk_status_t ret;
 
 	/* Check btrfs_submit_bio_hook() for rules about async submit. */
@@ -7900,7 +7900,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 							  struct inode *inode,
 							  loff_t file_offset)
 {
-	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
+	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	size_t dip_size;
 	struct btrfs_dio_private *dip;
@@ -7930,7 +7930,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		struct bio *dio_bio, loff_t file_offset)
 {
-	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
+	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
 			     BTRFS_BLOCK_GROUP_RAID56_MASK);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2d52330f26b5..e69754af2eba 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6455,7 +6455,7 @@ static void btrfs_end_bio(struct bio *bio)
 			struct btrfs_device *dev = btrfs_io_bio(bio)->device;
 
 			ASSERT(dev->bdev);
-			if (bio_op(bio) == REQ_OP_WRITE)
+			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
 				btrfs_dev_stat_inc_and_print(dev,
 						BTRFS_DEV_STAT_WRITE_ERRS);
 			else if (!(bio->bi_opf & REQ_RAHEAD))
@@ -6568,10 +6568,10 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	atomic_set(&bbio->stripes_pending, bbio->num_stripes);
 
 	if ((bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
-	    ((bio_op(bio) == REQ_OP_WRITE) || (mirror_num > 1))) {
+	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
 		/* In this case, map_length has been set to the length of
 		   a single stripe; not the whole write */
-		if (bio_op(bio) == REQ_OP_WRITE) {
+		if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
 			ret = raid56_parity_write(fs_info, bio, bbio,
 						  map_length);
 		} else {
@@ -6594,7 +6594,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		dev = bbio->stripes[dev_nr].dev;
 		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
 						   &dev->dev_state) ||
-		    (bio_op(first_bio) == REQ_OP_WRITE &&
+		    (btrfs_op(first_bio) == BTRFS_MAP_WRITE &&
 		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
 			bbio_error(bbio, first_bio, logical);
 			continue;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 98a447badd6a..0bcf87a9e594 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -423,6 +423,7 @@ static inline enum btrfs_map_op btrfs_op(struct bio *bio)
 	case REQ_OP_DISCARD:
 		return BTRFS_MAP_DISCARD;
 	case REQ_OP_WRITE:
+	case REQ_OP_ZONE_APPEND:
 		return BTRFS_MAP_WRITE;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.27.0

