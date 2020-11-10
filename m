Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA582AD502
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbgKJL2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:54 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12008 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbgKJL2m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007721; x=1636543721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aLK/wkq3EbfLhHOYD2vou6jXpNPWIkCcEfwQ4r7wf1M=;
  b=DA5OAuGRikY11/elydBNy7nTO8mdk33250eWrsQiF1FeDTXrUuXsJbC2
   M1jpKFlnSKed4jGf/gPjfGlG9s6WZlsw/pTQ7DZDrMwJ7Sw2hmJFYkNWz
   prCfCO4G22g2tL+OztBdT+QMbkGPHkJ7sG90iTFrR9lFRzESv0gH3+YzJ
   2rSedOokOIgh1QaNyMtpygPncpGCI1WY1hY327ZiXUinNoldKsXQJ4oqb
   v7X1Y3DBLJmHvwBc6HiSgcgXfySp1fi3wmxBSYpSpKqOJijLwiyqEQhSe
   ZQxfJnctevYvGrCYFrn5Y7mBP42ZskYNW2YWGLzpXNOIKk6VNRfZWejfl
   g==;
IronPort-SDR: mhYVlWnh+2gtAThKI90OwKdnP9bhK+o3C0tbQVe/X6U7wwVMbBosw4jfmyGI9JRSeJqCFVfXRa
 ZWgz/RHEIHG/HUNvRQMFoaP79/GziHQuA2mNHeYtQmpLBg35TFxjKlxdtvGAgWIoqJxzXq9F74
 kV7+2zqOUuj1VZV26qxIV7JTLosBkxVsJoLCu97UgKOhq/blEAKfxW1hFNqpiP+Jj5vT79q0Pg
 3M/fjHeQG6jkNkcokkzKMoRJ6kzcS1VtHdtBaIfR9W9/YQdYXVrBo+PlNDVF1SZs2+kl71Qj99
 V4A=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376569"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:41 +0800
IronPort-SDR: CLTatmkL6ZcniUIoDJ2hH8rz6dKHalor6LP4WZ2vBsu/4s0EkwxN5IF4+9AkOtb9PwP4Rk7idA
 N+Nb+PxFrdpwH0k0bxF0BkDE80PZ047COtzy2SzrbXRWC9pSJsym0WyPuY8IzgXFxLrDzqfiet
 qn94WdXNB9ao9eXF/0AI/eHShOPV/qfnR9HR1/kpsLWP226FIgwfpUQmXFXA/ym57MiJHW+wZM
 t4jWyzNQ3FowGf/DhePEIShE2GtAOZythQ2SQpd46SUo2chNMIWSnmmreIp5J14ltIqj3JvfnX
 s07lLmibCRlH0jCMGS1fuu6K
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:42 -0800
IronPort-SDR: pWydRBFS8zbWq/5w4AssesrTYi10Wuo2u/aofmEgBNnTMix/tjTMfIFEpI9imftUXupXlHDwNo
 KGL3davSODbwqqTP/VlyCm0pH26o/utQh9Um1UmunLSWL1YOqPSCRSeyrO5i1OsfHrTgCh8575
 bi5Bkbut8YIxBaQGmmMjiH8KI/k9jZcYxjLJZXPgMJ11e5FNNyJRLXmvCe/DvoMbZ4kxsyzKDb
 9TJd73t+upHvdgcv7ijh6uI6Y8kTaVXrIjL3REM9iMbratQKUl1ZmARfh6rqPoMp24x9dibh61
 P1A=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:40 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 22/41] btrfs: handle REQ_OP_ZONE_APPEND as writing
Date:   Tue, 10 Nov 2020 20:26:25 +0900
Message-Id: <08be135868502b85ae7612df919624e26a8c0b2d.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
index c0180fbd5c78..8acf1ed75889 100644
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
index c0e27c1e2559..683b3ed06226 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6451,7 +6451,7 @@ static void btrfs_end_bio(struct bio *bio)
 			struct btrfs_device *dev = btrfs_io_bio(bio)->device;
 
 			ASSERT(dev->bdev);
-			if (bio_op(bio) == REQ_OP_WRITE)
+			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
 				btrfs_dev_stat_inc_and_print(dev,
 						BTRFS_DEV_STAT_WRITE_ERRS);
 			else if (!(bio->bi_opf & REQ_RAHEAD))
@@ -6564,10 +6564,10 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
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
@@ -6590,7 +6590,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
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

