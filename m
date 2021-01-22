Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC3B2FFCA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbhAVG0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:26:41 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51100 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbhAVG0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296790; x=1642832790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pgsN3LbRWcYhTz/c3eMHZXbqSnd3OFOK49SDAdOmhZQ=;
  b=qiuwFjWP12hkQZSuOMzhm3nBIUNR96b9Bm8SqcbkgCcZn0+LNuFKexIK
   9otFFFyA6b4Z40QzjWDSVUaw2X9RsURAG6y/L7K6QoQABa73eDxQPLb6h
   5fJypMlbFXMcm4KEmsjxjT3TwM00KNDcKOZWz3GJRMUICaOd0IVY+FN6H
   gHX9TxtVwJmP9RR9LdvLEya97Ap3Rbmbu8ZRVdoMsllwxee381+v9/BFq
   PdWKbROtunvhPksuWA1ZjkJT3GfeOKjvxPWChaUArU9bg4ImsLkIdHqyc
   rzQ2CT5H2fjDqsZA8lJcsJizXfLSZrFKxNBYmJcE199YvI3Np+2VgXWZr
   g==;
IronPort-SDR: yrC/EHI5ewdaPVQF0PHuhGjmrZOK/XHoyIZpdOkYxg/mNIdP7AjthW5myIFSsMmVMhyvFCCQBY
 5jYqkEo9WUUC/cqzUm2dQ3dj7bcsFz/x+hZC9qEouhFLHQO0hOD1d3bmDHpegSYiJM5rqG83Ji
 qUm3/FIPX5HWDqKlydtq8NJD3a3gCY7gt3z5Cjk80By0Y9C07wIqtAjCHjwkikLGkh0ilj2l85
 HTNyQFe+91/MpdHum16GvJ+fsY7vviBK2RVC8Z22+gzVKbLCTq0jYvwodaVemSYs7FTs9OqkJm
 dbw=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392008"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:55 +0800
IronPort-SDR: +fsgt/UaDB2+Oxc3X5oyTru6W/hb1ub7O1uKY27aOByOTURV9cNaQi5EZnRA6T+N2lUjjIiCiP
 06b+rpIRS/jpuRX4/Oh+4pRH0joOVJeLaIWTRDlF/IWjtgZoP+L8PhM7MU/36G467+crHlV8iT
 BZuJpopmtd/e7Ojwvb+HJ6XZvFogvVtk2Fb4jMvUznaaBaTeQvUatyb2GP3j6gzZnJqLFkD1Hc
 fTC9D/PAe1bUb15RgihMIJ9jMcLN2OU+LfPFT7Zr+ch5kBNKrFNgyN0QVMw4L3wQyYjY6oF+l4
 UtED5vPRksi9kB9St5u25oCj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:27 -0800
IronPort-SDR: wClXVor2ktw31FZiTWm3Itr/b5Biuhb/BenM5sb9yeJgKPCfAvVSpErVANVuPcPGH2WOzwujoH
 0Hik7XOvZwnaJSmnwsv459rUWtL/TzID/Pu/mlXWaLD0M50xD8Abn6zeUh7277B7YivDoAPwqD
 9eR14DEjxw53vP5lJzCx+TIzPBydV8QXaVyFShSd/egCVlTS6/WUT1gHrvpJaiXtbtEq1raUtH
 j6bAPHc7k/VUVzx50my56C9YIqQKjiTe/CRoQysLsei7DlG0n5GLiZUD7s7NJ16jIHOkqDaWM2
 89M=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:54 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 21/42] btrfs: handle REQ_OP_ZONE_APPEND as writing
Date:   Fri, 22 Jan 2021 15:21:21 +0900
Message-Id: <0b48ccedf7a0982cca507db3b973a8a57a1f277a.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index ef6cb7b620d0..2e1c1f37b3f6 100644
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
@@ -7682,7 +7682,7 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	if (!refcount_dec_and_test(&dip->refs))
 		return;
 
-	if (bio_op(dip->dio_bio) == REQ_OP_WRITE) {
+	if (btrfs_op(dip->dio_bio) == BTRFS_MAP_WRITE) {
 		__endio_write_update_ordered(BTRFS_I(dip->inode),
 					     dip->logical_offset,
 					     dip->bytes,
@@ -7848,7 +7848,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_dio_private *dip = bio->bi_private;
-	bool write = bio_op(bio) == REQ_OP_WRITE;
+	bool write = btrfs_op(bio) == BTRFS_MAP_WRITE;
 	blk_status_t ret;
 
 	/* Check btrfs_submit_bio_hook() for rules about async submit. */
@@ -7898,7 +7898,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 							  struct inode *inode,
 							  loff_t file_offset)
 {
-	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
+	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	size_t dip_size;
 	struct btrfs_dio_private *dip;
@@ -7928,7 +7928,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
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

