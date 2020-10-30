Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EBC2A071E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgJ3NyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:54:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22001 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgJ3NxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065980; x=1635601980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2bGG7Tw0NSCWwI5DQkA2LqQtOto36WazeQt2f+80j2c=;
  b=CPVvZSkCPbuzOHUTpR9Vl5Ek8BxWDPcqzZOmKov0w8yYHDy2mutllTUu
   +m+kDCEKq8nB7P4uTO6AeSwNpJxUb2qo4/ivoFSj8xzM0n3FBqyOmMfaO
   D/sJtVHdi7xWEwFvN9HTDN/JuGmmMfB1xNJ4YrTKQM/OK1FcsG/O+wNel
   aHZCnBlZlUebPZV2ekuvZ09K+u6qcnmvlhg2FJjLeL1MkiXIAIjlCuFwz
   WelmLF9lHI80bL5CEzO5fv91DgS3K8j5rszTiTLUzi9vvhwPePK3N3fWP
   X9cUvXqN+0bkLnRYzg5wdfq4YPlNJRWLdF5kiXP+tbtUodiQIKOCizeFZ
   w==;
IronPort-SDR: 7ZuUG7v2abQWuceKehcBEG0ubnUnV/CUdUS/hnY0EjqcoHiLFLBSnIACFHytM/vsohCdBOdVif
 M0lWd9MO/iKuXAcuSXZg75YKfgX+6zKw0hLa+rSZXjO/RfmfXzIDF/OpfhGmInDc64fQla8S+C
 qqjIURPfNEbBgzOdcn+K2bdBm60N/i6uxqQyoyExxltivl298qfTEj7aWun1erkDqR+29qXAp7
 aOT7+S4j5v/Kg+Q945kY5pc7Y8tx5pqzDN9enWw3siS0KcFCiRzAkTLJWDX42OuNz7cskYHyj2
 mkQ=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806621"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:48 +0800
IronPort-SDR: +sTuIcLaIKAVCyfNNyFGEPWq/86+WOQki58JFnsjurtBMoF6jDXVUqExyHHeoy8myPalrcMNex
 LT+HrIGo8O8shenOmtq2j+J0gUByv1U58AU36i4FICs+difSwc5e/FOE55VjCcbQGySkvISWNz
 rL4saqhSPG3I4xTIo6gmc3zFAGFZ+Wg9uTI7kYuHAbaOa5ujZQeqMI6sCxWMKnbPLrjQHbYhiP
 IrcpGCztoI3Zpjc/f7wyQy8IgzKYqGm/dCrs4ItJc3TfNaCOW/DJHkmNgq2zol8ut533ar4qU2
 YufMVjQ19L7thbDrDtUkTRzh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:02 -0700
IronPort-SDR: NXeIUOWCLjsd/p5kPnEDctHFHKI3u8FDQfr0z7ig98BcW4iXb8q5SX6PwXx6PQfN8l6EsN3Duc
 TbF2YU+hP9H5xCLUx9JKJXjsbhBx6YCYO6lQCy2ig44vuD4zldLymDHHQ/vAykTzQFuhK1RZtV
 oCAqSxd/mqCEnql/mo/sShkU0/B1LCAx5msUHn1n4bfpyyzo/4u4jS9QaPjTwANW3/f/lfOhe3
 9GqLoloqM0pmTPaRmmXvjBGYw9vobpfVFdH0ZnulVmJEVg6znf1S7UtWtFeWlLmSddrPI4IMgD
 Fuc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:47 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 22/41] btrfs: handle REQ_OP_ZONE_APPEND as writing
Date:   Fri, 30 Oct 2020 22:51:29 +0900
Message-Id: <4f9bb21cb378fa0b123caf56c37c06dedccbbf1f.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ZONED btrfs uses REQ_OP_ZONE_APPEND bios for writing to actual devices. Let
btrfs_end_bio() and btrfs_op be aware of it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c |  4 ++--
 fs/btrfs/inode.c   | 10 +++++-----
 fs/btrfs/volumes.c |  8 ++++----
 fs/btrfs/volumes.h |  1 +
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9750b4e6d538..778716e223ff 100644
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
@@ -827,7 +827,7 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 	int async = check_async_write(fs_info, BTRFS_I(inode));
 	blk_status_t ret;
 
-	if (bio_op(bio) != REQ_OP_WRITE) {
+	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		/*
 		 * called for a read, do the setup so that checksum validation
 		 * can happen in the async kernel threads
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 936c3137c646..591ca539e444 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2192,7 +2192,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
 
-	if (bio_op(bio) != REQ_OP_WRITE) {
+	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
 		if (ret)
 			goto out;
@@ -7526,7 +7526,7 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	if (!refcount_dec_and_test(&dip->refs))
 		return;
 
-	if (bio_op(dip->dio_bio) == REQ_OP_WRITE) {
+	if (btrfs_op(dip->dio_bio) == BTRFS_MAP_WRITE) {
 		__endio_write_update_ordered(BTRFS_I(dip->inode),
 					     dip->logical_offset,
 					     dip->bytes,
@@ -7695,7 +7695,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_dio_private *dip = bio->bi_private;
-	bool write = bio_op(bio) == REQ_OP_WRITE;
+	bool write = btrfs_op(bio) == BTRFS_MAP_WRITE;
 	blk_status_t ret;
 
 	/* Check btrfs_submit_bio_hook() for rules about async submit. */
@@ -7746,7 +7746,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 							  struct inode *inode,
 							  loff_t file_offset)
 {
-	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
+	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	size_t dip_size;
 	struct btrfs_dio_private *dip;
@@ -7777,7 +7777,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		struct bio *dio_bio, loff_t file_offset)
 {
-	const bool write = (bio_op(dio_bio) == REQ_OP_WRITE);
+	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9e69222086ae..a0056b205964 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6446,7 +6446,7 @@ static void btrfs_end_bio(struct bio *bio)
 			struct btrfs_device *dev = btrfs_io_bio(bio)->device;
 
 			ASSERT(dev->bdev);
-			if (bio_op(bio) == REQ_OP_WRITE)
+			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
 				btrfs_dev_stat_inc_and_print(dev,
 						BTRFS_DEV_STAT_WRITE_ERRS);
 			else if (!(bio->bi_opf & REQ_RAHEAD))
@@ -6559,10 +6559,10 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
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
@@ -6585,7 +6585,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		dev = bbio->stripes[dev_nr].dev;
 		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
 						   &dev->dev_state) ||
-		    (bio_op(first_bio) == REQ_OP_WRITE &&
+		    (btrfs_op(first_bio) == BTRFS_MAP_WRITE &&
 		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
 			bbio_error(bbio, first_bio, logical);
 			continue;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 0249aca668fb..cff1f7689eac 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -410,6 +410,7 @@ static inline enum btrfs_map_op btrfs_op(struct bio *bio)
 	case REQ_OP_DISCARD:
 		return BTRFS_MAP_DISCARD;
 	case REQ_OP_WRITE:
+	case REQ_OP_ZONE_APPEND:
 		return BTRFS_MAP_WRITE;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.27.0

