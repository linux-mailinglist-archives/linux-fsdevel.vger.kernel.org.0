Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2496130F0B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhBDK1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:27:11 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54296 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbhBDK0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434402; x=1643970402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ilsh7Ge8V8xiJQX+1IPMIMQyrp09081CJ7cOYruSHnQ=;
  b=ic6IgtyHX7Mdw+KethFCG43+yHbjJQ1RhfZfVtZj8o+hE2AG8z565ekO
   hOnTP4Rhqt/Zlf200VTYJb5pcu7Z+JdqR29dnSl9hiybEvP9UhrwmMpRV
   vB7C+4SAou5oaA1FgL25BZv6AHAp/cjeA7FMR1NQw12jIv23snKKIBCq6
   diPd9OQER3uKVHxSzENuHVImRVRttNJfTcqbW54SEJNLWejGlxdJJa8UG
   G8hjxjElcW/4kjAKrC0IIHK5Yn+fUlfB7bq0Qui5OsHLaVcfDc8tkpQ5J
   nq1NLjGBheT5iQjrN9RIO+KqLbK2Az321mHR4756U2QsdAE9K2+FocU82
   g==;
IronPort-SDR: 5GWoy/FUad5VaMrIXIZ6pT+G/M8KUZr3AMVFF6yvicEl03qcrSj/pDQ8w5SZCUjwhuywkTUgkr
 GScB1POR5bUm5L1yWRED12Erj+RN99QPzkFLjCfC7vseMoTxtStXxub5ruDmtzCTmLQ48sPBky
 eB9Wy8lTQgVjJt4cwEjbBjuyb28/oohAGKFCQdE7kl7N+BKMxqwCmk6Acu2l1rskmlG4l15C19
 qAa3kIuw1d44tt46v0Jhtbt+OHakCKxlawaBoGsKCtkc3WkzfqhoIh3IelCp/E5+8XJvgJZC7F
 Kuo=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108013"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:23 +0800
IronPort-SDR: FvQEfYhzzwLIZNBI9CttbWhZKuPoU/vkkfEQRUn/FrC5QH73Y1Mn63VZpr+73AGYMF+juO4Cea
 Xq1vz1JklJFLgYkGSK0xXpxUjTFVVy2+bmeozbOY1KN0BGXLXYpNocWoOItmzXw5uZb3TNzihc
 D8AF1QDnEffLghJOy+mn6k4v/4KStS09IU+D/WyOfFkQRgK44zLjy/jQIpnzzKGU/6feC2IYN9
 QexiVWowmAfIu83+gQ1G53vElkVkxC8z61BSBWboLYM78QmnOn2g4dfjS64wITK+8TOvroKmsf
 IJTy55LYCuH9aXhzl+fy30Dc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:26 -0800
IronPort-SDR: ddouDU4WK8Mrij+QKnL6zLsAzKW+aiZjz1YFKN0m6G4HnyKdaeWIm0+f51s+rX7/yNvB6P1Irq
 lwrkjyEadPPYfdQm0Ab6RC/xQt9Vl6v3vUbGxc56O/Ze2MOfYaGlddEvRhz1AbIlpP7jOn1PVy
 Ei6eXntVMZYzU8xg7ZzIU6mV2z1yupAYBrq17v/Be86jLbOS9xKDXnal4beiQYkMyv4c1FuFgG
 yC0IUG/I8GrrU9LpZleEEEwWZoZH+RKLP43E62PJaN4ENO8C7sU50VArSzLRU1tNVHzO0A1L7N
 SiA=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:22 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 20/42] btrfs: zoned: handle REQ_OP_ZONE_APPEND as writing
Date:   Thu,  4 Feb 2021 19:21:59 +0900
Message-Id: <1e13940c0ba576f1e1f18d2f98c1a60ce35540b4.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zoned filesystems use REQ_OP_ZONE_APPEND bios for writing to actual
devices.

Let btrfs_end_bio() and btrfs_op be aware of it, by mapping
REQ_OP_ZONE_APPEND to BTRFS_MAP_WRITE and using btrfs_op() instead of
bio_op().

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c |  4 ++--
 fs/btrfs/inode.c   | 10 +++++-----
 fs/btrfs/volumes.c |  8 ++++----
 fs/btrfs/volumes.h |  1 +
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index eb1afd7d89f7..70621184a731 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -709,7 +709,7 @@ static void end_workqueue_bio(struct bio *bio)
 	fs_info = end_io_wq->info;
 	end_io_wq->status = bio->bi_status;
 
-	if (bio_op(bio) == REQ_OP_WRITE) {
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
 		if (end_io_wq->metadata == BTRFS_WQ_ENDIO_METADATA)
 			wq = fs_info->endio_meta_write_workers;
 		else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_FREE_SPACE)
@@ -885,7 +885,7 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 	int async = check_async_write(fs_info, BTRFS_I(inode));
 	blk_status_t ret;
 
-	if (bio_op(bio) != REQ_OP_WRITE) {
+	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		/*
 		 * called for a read, do the setup so that checksum validation
 		 * can happen in the async kernel threads
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5522e9d09c8a..d7a9c770dc3b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2250,7 +2250,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
 
-	if (bio_op(bio) != REQ_OP_WRITE) {
+	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
 		if (ret)
 			goto out;
@@ -7681,7 +7681,7 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	if (!refcount_dec_and_test(&dip->refs))
 		return;
 
-	if (bio_op(dip->dio_bio) == REQ_OP_WRITE) {
+	if (btrfs_op(dip->dio_bio) == BTRFS_MAP_WRITE) {
 		__endio_write_update_ordered(BTRFS_I(dip->inode),
 					     dip->logical_offset,
 					     dip->bytes,
@@ -7847,7 +7847,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_dio_private *dip = bio->bi_private;
-	bool write = bio_op(bio) == REQ_OP_WRITE;
+	bool write = btrfs_op(bio) == BTRFS_MAP_WRITE;
 	blk_status_t ret;
 
 	/* Check btrfs_submit_bio_hook() for rules about async submit. */
@@ -7897,7 +7897,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 							  struct inode *inode,
 							  loff_t file_offset)
 {
-	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
+	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	size_t dip_size;
 	struct btrfs_dio_private *dip;
@@ -7927,7 +7927,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		struct bio *dio_bio, loff_t file_offset)
 {
-	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
+	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
 			     BTRFS_BLOCK_GROUP_RAID56_MASK);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 10401def16ef..400375aaa197 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6448,7 +6448,7 @@ static void btrfs_end_bio(struct bio *bio)
 			struct btrfs_device *dev = btrfs_io_bio(bio)->device;
 
 			ASSERT(dev->bdev);
-			if (bio_op(bio) == REQ_OP_WRITE)
+			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
 				btrfs_dev_stat_inc_and_print(dev,
 						BTRFS_DEV_STAT_WRITE_ERRS);
 			else if (!(bio->bi_opf & REQ_RAHEAD))
@@ -6561,10 +6561,10 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
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
@@ -6587,7 +6587,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		dev = bbio->stripes[dev_nr].dev;
 		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
 						   &dev->dev_state) ||
-		    (bio_op(first_bio) == REQ_OP_WRITE &&
+		    (btrfs_op(first_bio) == BTRFS_MAP_WRITE &&
 		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
 			bbio_error(bbio, first_bio, logical);
 			continue;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 598ac225176d..d3bbdb4175df 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -424,6 +424,7 @@ static inline enum btrfs_map_op btrfs_op(struct bio *bio)
 	case REQ_OP_DISCARD:
 		return BTRFS_MAP_DISCARD;
 	case REQ_OP_WRITE:
+	case REQ_OP_ZONE_APPEND:
 		return BTRFS_MAP_WRITE;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.30.0

