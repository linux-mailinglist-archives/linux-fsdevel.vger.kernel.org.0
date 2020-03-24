Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4EE919144C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgCXPZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 11:25:17 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39883 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgCXPZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585063515; x=1616599515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8KcQf63Dqr8oNlcqCcTsYF2SuiRSRH0lprU902Zkvyw=;
  b=pW/bC9EM6F5hh8wqeCa2F8UVeP8ODb1O8wk3CMgP+5yLiRtZjWNHGPbd
   fTnQWC3JSNor5YCOFnyayY5zTbAkqyxkyeGztdlkEq/+WY+6JF62pcfYV
   1HtqxxQNvWo3IRGaumjuEcLzTYMHgm4OgVOHYvVv58azFwGfKJchWfjWu
   cn0JQC9s/lbKnIodxcRTsqL7N6WzKw2exNJ4KerfkId+vjfhQVgTkHC5I
   fQN3/cD7oMORmO1UccmCf+pBQ653n9+BanlJX8g1O6SQMI2XUBMxaGI2A
   mGqsMDr9xd2JISAsDaEIeNayXLORBRb5mCyloUD6HAVGaP/DxQuI/tl7M
   g==;
IronPort-SDR: jdzrDlubkCvv5w6Uye5pffAeEY/W2XeV6mKy5V7zwTSQtCdrmw2GlIRA8Htbr3L/OARQ84NzHW
 W5G5WnbMuhtKmBgnzdi9ceqV43s1y/OIvYHwlT1LNJwBnKoU4xBQNzcwkZi/psxNtwaU2fWONu
 azDMkO20RTuV6P78dZ8E/YRmq3tSQMRCD8bGqGCZ9YD9fT8B/6czfji4qB1dw39f7d0tOX334P
 x7UEVMPGEcbgr6VOakcj2fLwaiY0fIblX1oIcyb2WpUxtHXicyYCupl8/aW6KnYcdt216ultZe
 rBo=
X-IronPort-AV: E=Sophos;i="5.72,300,1580745600"; 
   d="scan'208";a="133371571"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 23:25:15 +0800
IronPort-SDR: dfkK8dAdFYP5XZFIgjiSccUN53zm5xXzduheFJTUXw5MuVFxs33B9q1W0gel4XjK8YEOLa7nSh
 r3NVBgqSA+CXqnsS/diDbCBN7AFc0rdBweQ+6czV0hwWLT0orarxZ39GUSi2XcA47Yv+zbQWeE
 l/D68cGs5Mb4oQwIKKwEZoTyNhpJpD74DLWXVqbecyxyeRDgG2fYRuWdnICC6oj8ux2n/fgZsP
 XT78kAOuZ7nYXHiy/QxfIudE2nvPW+qo4IC3FZk2UDey/mTJJUKKQpTLWIHzHKmvXfcTmGQe08
 s0KeDDfbCL4I5uBhvPrCjQ9x
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:16:55 -0700
IronPort-SDR: qVl9tbi8LbnJfuNSDLQelmp2N8WgIv2v/NTe08MBYST6q9tbV/0RGAs7cbVrnFwISXjMeRC1eG
 99aFRYSmpFmBp827BCGfj9D6Yh5IG53qNKuc1CcduvLZBtwf/sFF1uBU2/P9PLBmNs+kUxg9s7
 jKQFIvhiz5/JD5teQCsZHhmHP9nmoI3Fju8Aryzaz9oJqjKqbpebAYdAsChlTS25ji5QFMWfI+
 WQiZID9NRKK+Pz5QztM/ME5m+5TrRecMcU6tIuE+CFCcuGo8HtdAVnUKwBSmqONTnKyR3iwtWn
 cBM=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 08:25:13 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 07/11] scsi: sd_zbc: emulate ZONE_APPEND commands
Date:   Wed, 25 Mar 2020 00:24:50 +0900
Message-Id: <20200324152454.4954-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Emulate ZONE_APPEND for SCSI disks using a regular WRITE(16) with a
start LBA set to the target zone write pointer position.

In order to always know the write pointer position of a sequential write
zone, the queue flag QUEUE_FLAG_ZONE_WP_OFST is set to get an
initialized write pointer offset array attached to the device request
queue. The values of the cache are maintained in sync with the device
as follows:
1) the write pointer offset of a zone is reset to 0 when a
   REQ_OP_ZONE_RESET command completes.
2) the write pointer offset of a zone is set to the zone size when a
   REQ_OP_ZONE_FINISH command completes.
3) the write pointer offset of a zone is incremented by the number of
   512B sectors written when a write or a zone append command completes
4) the write pointer offset of all zones is reset to 0 when a
   REQ_OP_ZONE_RESET_ALL command completes.

Since the block layer does not write lock zones for zone append
commands, to ensure a sequential ordering of the write commands used for
the emulation, the target zone of a zone append command is locked when
the function sd_zbc_prepare_zone_append() is called from
sd_setup_read_write_cmnd(). If the zone write lock cannot be obtained
(e.g. a zone append is in-flight or a regular write has already locked
the zone), the zone append command dispatching is delayed by returning
BLK_STS_ZONE_RESOURCE.

Since zone reset and finish operations can be issued concurrently with
writes and zone append requests, ensure a coherent update of the zone
write pointer offsets by also write locking the target zones for these
zone management requests.

Finally, to avoid the need for write locking all zones for
REQ_OP_ZONE_RESET_ALL requests, use a spinlock to protect accesses and
modifications of the zone write pointer offsets. This spinlock is
initialized from sd_probe() using the new function sd_zbc_init().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/scsi/sd.c     |  28 +++-
 drivers/scsi/sd.h     |  36 ++++-
 drivers/scsi/sd_zbc.c | 316 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 363 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 707f47c0ec98..18584bf01e11 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1215,6 +1215,12 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	else
 		protect = 0;
 
+	if (req_op(rq) == REQ_OP_ZONE_APPEND) {
+		ret = sd_zbc_prepare_zone_append(cmd, &lba, nr_blocks);
+		if (ret)
+			return ret;
+	}
+
 	if (protect && sdkp->protection_type == T10_PI_TYPE2_PROTECTION) {
 		ret = sd_setup_rw32_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua);
@@ -1287,6 +1293,7 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
 		return sd_setup_flush_cmnd(cmd);
 	case REQ_OP_READ:
 	case REQ_OP_WRITE:
+	case REQ_OP_ZONE_APPEND:
 		return sd_setup_read_write_cmnd(cmd);
 	case REQ_OP_ZONE_RESET:
 		return sd_zbc_setup_zone_mgmt_cmnd(cmd, ZO_RESET_WRITE_POINTER,
@@ -2055,7 +2062,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 
  out:
 	if (sd_is_zoned(sdkp))
-		sd_zbc_complete(SCpnt, good_bytes, &sshdr);
+		good_bytes = sd_zbc_complete(SCpnt, good_bytes, &sshdr);
 
 	SCSI_LOG_HLCOMPLETE(1, scmd_printk(KERN_INFO, SCpnt,
 					   "sd_done: completed %d of %d bytes\n",
@@ -3370,6 +3377,8 @@ static int sd_probe(struct device *dev)
 	sdkp->first_scan = 1;
 	sdkp->max_medium_access_timeouts = SD_MAX_MEDIUM_TIMEOUTS;
 
+	sd_zbc_init_disk(sdkp);
+
 	sd_revalidate_disk(gd);
 
 	gd->flags = GENHD_FL_EXT_DEVT;
@@ -3663,19 +3672,26 @@ static int __init init_sd(void)
 	if (!sd_page_pool) {
 		printk(KERN_ERR "sd: can't init discard page pool\n");
 		err = -ENOMEM;
-		goto err_out_ppool;
+		goto err_out_cdb_pool;
 	}
 
+	err = sd_zbc_init();
+	if (err)
+		goto err_out_ppool;
+
 	err = scsi_register_driver(&sd_template.gendrv);
 	if (err)
-		goto err_out_driver;
+		goto err_out_zbc;
 
 	return 0;
 
-err_out_driver:
-	mempool_destroy(sd_page_pool);
+err_out_zbc:
+	sd_zbc_exit();
 
 err_out_ppool:
+	mempool_destroy(sd_page_pool);
+
+err_out_cdb_pool:
 	mempool_destroy(sd_cdb_pool);
 
 err_out_cache:
@@ -3705,6 +3721,8 @@ static void __exit exit_sd(void)
 	mempool_destroy(sd_page_pool);
 	kmem_cache_destroy(sd_cdb_cache);
 
+	sd_zbc_exit();
+
 	class_unregister(&sd_disk_class);
 
 	for (i = 0; i < SD_MAJORS; i++) {
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 50fff0bf8c8e..34641be1d434 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -79,6 +79,7 @@ struct scsi_disk {
 	u32		zones_optimal_open;
 	u32		zones_optimal_nonseq;
 	u32		zones_max_open;
+	spinlock_t	zone_wp_ofst_lock;
 #endif
 	atomic_t	openers;
 	sector_t	capacity;	/* size in logical blocks */
@@ -207,17 +208,33 @@ static inline int sd_is_zoned(struct scsi_disk *sdkp)
 
 #ifdef CONFIG_BLK_DEV_ZONED
 
+int __init sd_zbc_init(void);
+void sd_zbc_exit(void);
+
+void sd_zbc_init_disk(struct scsi_disk *sdkp);
 extern int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buffer);
 extern void sd_zbc_print_zones(struct scsi_disk *sdkp);
 blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
 					 unsigned char op, bool all);
-extern void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
-			    struct scsi_sense_hdr *sshdr);
+unsigned int sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
+			     struct scsi_sense_hdr *sshdr);
 int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
 
+blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
+				        unsigned int nr_blocks);
+
 #else /* CONFIG_BLK_DEV_ZONED */
 
+static inline int sd_zbc_init(void)
+{
+	return 0;
+}
+
+static inline void sd_zbc_exit(void) {}
+
+static inline void sd_zbc_init_disk(struct scsi_disk *sdkp) {}
+
 static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,
 				    unsigned char *buf)
 {
@@ -233,9 +250,18 @@ static inline blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
 	return BLK_STS_TARGET;
 }
 
-static inline void sd_zbc_complete(struct scsi_cmnd *cmd,
-				   unsigned int good_bytes,
-				   struct scsi_sense_hdr *sshdr) {}
+static inline unsigned int sd_zbc_complete(struct scsi_cmnd *cmd,
+			unsigned int good_bytes, struct scsi_sense_hdr *sshdr)
+{
+	return 0;
+}
+
+static inline blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd,
+						      sector_t *lba,
+						      unsigned int nr_blocks)
+{
+	return BLK_STS_TARGET;
+}
 
 #define sd_zbc_report_zones NULL
 
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index ee156fbf3780..17bdc50d29f3 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -19,6 +19,11 @@
 
 #include "sd.h"
 
+static struct kmem_cache *sd_zbc_zone_work_cache;
+static mempool_t *sd_zbc_zone_work_pool;
+
+#define SD_ZBC_ZONE_WORK_MEMPOOL_SIZE	8
+
 static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
 			       unsigned int idx, report_zones_cb cb, void *data)
 {
@@ -229,6 +234,152 @@ static blk_status_t sd_zbc_cmnd_checks(struct scsi_cmnd *cmd)
 	return BLK_STS_OK;
 }
 
+#define SD_ZBC_INVALID_WP_OFST	~(0u)
+#define SD_ZBC_UPDATING_WP_OFST	(SD_ZBC_INVALID_WP_OFST - 1)
+
+struct sd_zbc_zone_work {
+	struct work_struct work;
+	struct scsi_disk *sdkp;
+	unsigned int zno;
+	char buf[SD_BUF_SIZE];
+};
+
+static int sd_zbc_update_wp_ofst_cb(struct blk_zone *zone, unsigned int idx,
+				    void *data)
+{
+	struct sd_zbc_zone_work *zwork = data;
+	struct scsi_disk *sdkp = zwork->sdkp;
+	struct request_queue *q = sdkp->disk->queue;
+	int ret;
+
+	spin_lock_bh(&sdkp->zone_wp_ofst_lock);
+	ret = blk_get_zone_wp_offset(zone, &q->seq_zones_wp_ofst[zwork->zno]);
+	if (ret)
+		q->seq_zones_wp_ofst[zwork->zno] = SD_ZBC_INVALID_WP_OFST;
+	spin_unlock_bh(&sdkp->zone_wp_ofst_lock);
+
+	return ret;
+}
+
+static void sd_zbc_update_wp_ofst_workfn(struct work_struct *work)
+{
+	struct sd_zbc_zone_work *zwork;
+	struct scsi_disk *sdkp;
+	int ret;
+
+	zwork = container_of(work, struct sd_zbc_zone_work, work);
+	sdkp = zwork->sdkp;
+
+	ret = sd_zbc_do_report_zones(sdkp, zwork->buf, SD_BUF_SIZE,
+				     zwork->zno * sdkp->zone_blocks, true);
+	if (!ret)
+		sd_zbc_parse_report(sdkp, zwork->buf + 64, 0,
+				    sd_zbc_update_wp_ofst_cb, zwork);
+
+	mempool_free(zwork, sd_zbc_zone_work_pool);
+	scsi_device_put(sdkp->device);
+}
+
+static blk_status_t sd_zbc_update_wp_ofst(struct scsi_disk *sdkp,
+					  unsigned int zno)
+{
+	struct sd_zbc_zone_work *zwork;
+
+	/*
+	 * We are about to schedule work to update a zone write pointer offset,
+	 * which will cause the zone append command to be requeued. So make
+	 * sure that the scsi device does not go away while the work is
+	 * being processed.
+	 */
+	if (scsi_device_get(sdkp->device))
+		return BLK_STS_IOERR;
+
+	zwork = mempool_alloc(sd_zbc_zone_work_pool, GFP_ATOMIC);
+	if (!zwork) {
+		/* Retry later */
+		scsi_device_put(sdkp->device);
+		return BLK_STS_RESOURCE;
+	}
+
+	memset(zwork, 0, sizeof(struct sd_zbc_zone_work));
+	INIT_WORK(&zwork->work, sd_zbc_update_wp_ofst_workfn);
+	zwork->sdkp = sdkp;
+	zwork->zno = zno;
+
+	sdkp->disk->queue->seq_zones_wp_ofst[zno] = SD_ZBC_UPDATING_WP_OFST;
+
+	schedule_work(&zwork->work);
+
+	return BLK_STS_RESOURCE;
+}
+
+/**
+ * sd_zbc_prepare_zone_append() - Prepare an emulated ZONE_APPEND command.
+ * @cmd: the command to setup
+ * @lba: the LBA to patch
+ * @nr_blocks: the number of LBAs to be written
+ *
+ * Called from sd_setup_read_write_cmnd() for REQ_OP_ZONE_APPEND.
+ * @sd_zbc_prepare_zone_append() handles the necessary zone wrote locking and
+ * patching of the lba for an emulated ZONE_APPEND command.
+ *
+ * In case the cached write pointer offset is %SD_ZBC_INVALID_WP_OFST it will
+ * schedule a REPORT ZONES command and return BLK_STS_IOERR.
+ */
+blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
+					unsigned int nr_blocks)
+{
+	struct request *rq = cmd->request;
+	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	unsigned int wp_ofst, zno = blk_rq_zone_no(rq);
+	blk_status_t ret;
+
+	ret = sd_zbc_cmnd_checks(cmd);
+	if (ret != BLK_STS_OK)
+		return ret;
+
+	if (!blk_rq_zone_is_seq(rq))
+		return BLK_STS_IOERR;
+
+	/* Unlock of the write lock will happen in sd_zbc_complete() */
+	if (!blk_req_zone_write_trylock(rq))
+		return BLK_STS_ZONE_RESOURCE;
+
+	spin_lock_bh(&sdkp->zone_wp_ofst_lock);
+
+	wp_ofst = rq->q->seq_zones_wp_ofst[zno];
+
+	if (wp_ofst == SD_ZBC_UPDATING_WP_OFST) {
+		/* Write pointer offset update in progress: ask for a requeue */
+		ret = BLK_STS_RESOURCE;
+		goto err;
+	}
+
+	if (wp_ofst == SD_ZBC_INVALID_WP_OFST) {
+		/* Invalid write pointer offset: trigger an update from disk */
+		ret = sd_zbc_update_wp_ofst(sdkp, zno);
+		goto err;
+	}
+
+	wp_ofst = sectors_to_logical(sdkp->device, wp_ofst);
+	if (wp_ofst + nr_blocks > sdkp->zone_blocks) {
+		ret = BLK_STS_IOERR;
+		goto err;
+	}
+
+	/* Set the LBA for the write command used to emulate zone append */
+	*lba += wp_ofst;
+
+	spin_unlock_bh(&sdkp->zone_wp_ofst_lock);
+
+	return BLK_STS_OK;
+
+err:
+	spin_unlock_bh(&sdkp->zone_wp_ofst_lock);
+	blk_req_zone_write_unlock(rq);
+	return ret;
+}
+
 /**
  * sd_zbc_setup_zone_mgmt_cmnd - Prepare a zone ZBC_OUT command. The operations
  *			can be RESET WRITE POINTER, OPEN, CLOSE or FINISH.
@@ -266,25 +417,75 @@ blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
 	cmd->transfersize = 0;
 	cmd->allowed = 0;
 
+	/* Only zone reset and zone finish need zone write locking */
+	if (op != ZO_RESET_WRITE_POINTER && op != ZO_FINISH_ZONE)
+		return BLK_STS_OK;
+
+	if (all) {
+		/* We do not write lock all zones for an all zone reset */
+		if (op == ZO_RESET_WRITE_POINTER)
+			return BLK_STS_OK;
+
+		/* Finishing all zones is not supported */
+		return BLK_STS_IOERR;
+	}
+
+	if (!blk_rq_zone_is_seq(rq))
+		return BLK_STS_IOERR;
+
+	if (!blk_req_zone_write_trylock(rq))
+		return BLK_STS_ZONE_RESOURCE;
+
 	return BLK_STS_OK;
 }
 
+static inline bool sd_zbc_zone_needs_write_unlock(struct request *rq)
+{
+	/*
+	 * For zone append, the zone was locked in sd_zbc_prepare_zone_append().
+	 * For zone reset and zone finish, the zone was locked in
+	 * sd_zbc_setup_zone_mgmt_cmnd().
+	 * For regular writes, the zone is unlocked by the block layer elevator.
+	 */
+	return req_op(rq) == REQ_OP_ZONE_APPEND ||
+		req_op(rq) == REQ_OP_ZONE_RESET ||
+		req_op(rq) == REQ_OP_ZONE_FINISH;
+}
+
+static bool sd_zbc_need_zone_wp_update(struct request *rq)
+{
+	if (req_op(rq) == REQ_OP_WRITE ||
+	    req_op(rq) == REQ_OP_WRITE_ZEROES ||
+	    req_op(rq) == REQ_OP_WRITE_SAME)
+		return blk_rq_zone_is_seq(rq);
+
+	if (req_op(rq) == REQ_OP_ZONE_RESET_ALL)
+		return true;
+
+	return sd_zbc_zone_needs_write_unlock(rq);
+}
+
 /**
  * sd_zbc_complete - ZBC command post processing.
  * @cmd: Completed command
  * @good_bytes: Command reply bytes
  * @sshdr: command sense header
  *
- * Called from sd_done(). Process report zones reply and handle reset zone
- * and write commands errors.
+ * Called from sd_done() to handle zone commands errors and updates to the
+ * device queue zone write pointer offset cahce.
  */
-void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
+unsigned int sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
 		     struct scsi_sense_hdr *sshdr)
 {
 	int result = cmd->result;
 	struct request *rq = cmd->request;
+	struct request_queue *q = rq->q;
+	struct gendisk *disk = rq->rq_disk;
+	struct scsi_disk *sdkp = scsi_disk(disk);
+	enum req_opf op = req_op(rq);
+	unsigned int zno;
 
-	if (op_is_zone_mgmt(req_op(rq)) &&
+	if (op_is_zone_mgmt(op) &&
 	    result &&
 	    sshdr->sense_key == ILLEGAL_REQUEST &&
 	    sshdr->asc == 0x24) {
@@ -294,7 +495,69 @@ void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
 		 * so be quiet about the error.
 		 */
 		rq->rq_flags |= RQF_QUIET;
+		goto unlock_zone;
+	}
+
+	if (!sd_zbc_need_zone_wp_update(rq))
+		goto unlock_zone;
+
+	/*
+	 * If we got an error for a command that needs updating the write
+	 * pointer offset cache, we must mark the zone wp offset entry as
+	 * invalid to force an update from disk the next time a zone append
+	 * command is issued.
+	 */
+	zno = blk_rq_zone_no(rq);
+	spin_lock_bh(&sdkp->zone_wp_ofst_lock);
+
+	if (result && op != REQ_OP_ZONE_RESET_ALL) {
+		if (op == REQ_OP_ZONE_APPEND) {
+			/* Force complete completion (no retry) */
+			good_bytes = 0;
+			scsi_set_resid(cmd, blk_rq_bytes(rq));
+		}
+
+		/*
+		 * Force an update of the zone write pointer offset on
+		 * the next zone append access.
+		 */
+		if (q->seq_zones_wp_ofst[zno] != SD_ZBC_UPDATING_WP_OFST)
+			q->seq_zones_wp_ofst[zno] = SD_ZBC_INVALID_WP_OFST;
+		goto unlock_wp_ofst;
 	}
+
+	switch (op) {
+	case REQ_OP_ZONE_APPEND:
+		rq->__sector += q->seq_zones_wp_ofst[zno];
+		/* fallthrough */
+	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_WRITE_SAME:
+	case REQ_OP_WRITE:
+		if (q->seq_zones_wp_ofst[zno] < sd_zbc_zone_sectors(sdkp))
+			q->seq_zones_wp_ofst[zno] += good_bytes >> SECTOR_SHIFT;
+		break;
+	case REQ_OP_ZONE_RESET:
+		q->seq_zones_wp_ofst[zno] = 0;
+		break;
+	case REQ_OP_ZONE_FINISH:
+		q->seq_zones_wp_ofst[zno] = sd_zbc_zone_sectors(sdkp);
+		break;
+	case REQ_OP_ZONE_RESET_ALL:
+		memset(q->seq_zones_wp_ofst, 0,
+		       sdkp->nr_zones * sizeof(unsigned int));
+		break;
+	default:
+		break;
+	}
+
+unlock_wp_ofst:
+	spin_unlock_bh(&sdkp->zone_wp_ofst_lock);
+
+unlock_zone:
+	if (sd_zbc_zone_needs_write_unlock(rq))
+		blk_req_zone_write_unlock(rq);
+
+	return good_bytes;
 }
 
 /**
@@ -399,6 +662,7 @@ static int sd_zbc_check_capacity(struct scsi_disk *sdkp, unsigned char *buf,
 int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 {
 	struct gendisk *disk = sdkp->disk;
+	struct request_queue *q = disk->queue;
 	unsigned int nr_zones;
 	u32 zone_blocks = 0;
 	int ret;
@@ -421,9 +685,12 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 		goto err;
 
 	/* The drive satisfies the kernel restrictions: set it up */
-	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, sdkp->disk->queue);
-	blk_queue_required_elevator_features(sdkp->disk->queue,
-					     ELEVATOR_F_ZBD_SEQ_WRITE);
+	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+	blk_queue_flag_set(QUEUE_FLAG_ZONE_WP_OFST, q);
+	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
+	blk_queue_max_zone_append_sectors(q,
+		min_t(u32, logical_to_sectors(sdkp->device, zone_blocks),
+		      q->limits.max_segments << (PAGE_SHIFT - SECTOR_SHIFT)));
 	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
 
 	/* READ16/WRITE16 is mandatory for ZBC disks */
@@ -475,3 +742,38 @@ void sd_zbc_print_zones(struct scsi_disk *sdkp)
 			  sdkp->nr_zones,
 			  sdkp->zone_blocks);
 }
+
+void sd_zbc_init_disk(struct scsi_disk *sdkp)
+{
+	if (!sd_is_zoned(sdkp))
+		return;
+
+	spin_lock_init(&sdkp->zone_wp_ofst_lock);
+}
+
+int __init sd_zbc_init(void)
+{
+	sd_zbc_zone_work_cache =
+		kmem_cache_create("sd_zbc_zone_work",
+				  sizeof(struct sd_zbc_zone_work),
+                                  0, 0, NULL);
+	if (!sd_zbc_zone_work_cache)
+		return -ENOMEM;
+
+	sd_zbc_zone_work_pool =
+		mempool_create_slab_pool(SD_ZBC_ZONE_WORK_MEMPOOL_SIZE,
+					 sd_zbc_zone_work_cache);
+	if (!sd_zbc_zone_work_pool) {
+		kmem_cache_destroy(sd_zbc_zone_work_cache);
+		printk(KERN_ERR "sd_zbc: create zone work pool failed\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void sd_zbc_exit(void)
+{
+	mempool_destroy(sd_zbc_zone_work_pool);
+	kmem_cache_destroy(sd_zbc_zone_work_cache);
+}
-- 
2.24.1

