Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9AC19D4D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390614AbgDCKNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 06:13:13 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56746 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390533AbgDCKNL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585908790; x=1617444790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eEX5KZTm4CCQ20eiS+LE5MXXQEhYT9xoa9Z3UK+4rB0=;
  b=qazQb6+g3iraTOJCvgt7rZZa7w1xNZ6pvZJTn3okTvz6B3NOWtR8blqr
   Nc/iGQ2tfbRSTkFYUguSOO/7r75jDsEHdsFi5wQj+cnSlzu4MSYbI2GzE
   55dj7c0hC0m5WP0RBiXQcdr6RaUhPFL1TiZMsl35NVH4U2Uu67a4TLHdk
   gnTc/zZLsb3cCbWiOw930+MA8kqVUkSt2Gyw6zNlmj8aFW3+5EfpRSPdS
   Lx9hQUWd3TAsQSqu5vY8cKpqW3hwayJxYzmtSo3g1s3LH4ZTN4G+nJJJN
   lcR6HnqT1kKjvXFvXFOVW1wTpr1XBGTUa6DmtN1TxakbZ4ygqbq0iKzyN
   Q==;
IronPort-SDR: 9XeFCEL8kB0Ya2QGORYbGWwJ4UXfebW30iJ1Wx91mKJMCNeSCkmRGherzqhhwuOvinTsWfdr8+
 tyx6X3mgLzS/4SF+kumUz1IeZNI5fcHoFNM3RIug+vN1k+QW9Z/E9xD0vCodRUDpIecBoGGRLe
 DvVvQjKr2QC0oYq7CbDYhmiKW7JYaiT0EX3Xy6zGelbZ58HR8mvOCJd9Bg2olq1Mmi8pwoZTXv
 1AV97iA/UUfZmGIB2bBueEkypxR4Y68Jh1v0Z03hKC17ShPB26eT4vi6hPygX3yNRPaizz4Rpv
 VeQ=
X-IronPort-AV: E=Sophos;i="5.72,339,1580745600"; 
   d="scan'208";a="135956035"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2020 18:13:10 +0800
IronPort-SDR: D83eAP6UTN7pTuvqB5WkziFbGkuzBKZx1qJt3LGfW525WU8ImC0JCSx0niaYeub0QbTQ1kIIMO
 P80W/G0p53qXmXCI+XDjEQaZjzRWulqK4EY2Q+wAnMlWY47gfcLxl57JD68JlKz07hLXCTVS21
 FOTNxHeWO6pO5oeXvV9RQH9wuwasUZe+vSNuXiLV8kXh9uEO37fbd26X1zjKuUtV6JlI79hvzR
 N+DkaDriqIJKtzKjC/BkpLKYs+kPO3VWvfKo2jeAJPQXu8B9rhhgPwNwXvxfmXZ7Lq+wmkxHz9
 oy3jL6sboUBHWhhHeEVOXqSN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 03:03:59 -0700
IronPort-SDR: ujMkS8uqJszUZ/YAgLyMBsWG7W55KuMHTYCuSQcZmfRBCYF8WTBoUzfcJazasK4xUuT2hHXpjG
 JsTtyeGqsvMZTeQC0lTASggdtgPmAOkvCx+iaEmbRRwOL2MmnR3/gHMAmQP7YQ55vsd24QbOVB
 FXO/oKwPWN4jbeF+JMzIHSHFHW41pswL/sVJjQanBYni9fOgY3Yf/PG52poj8vX4qYfm55r+d1
 a00aQ8Kg4z0uXn7rlzhLZ/QBmoa4oQQdPlij643zRr0YBJyUCO5Q9GcjmBrYTAcoquQ2OE7mjW
 DrI=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Apr 2020 03:13:07 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Date:   Fri,  3 Apr 2020 19:12:47 +0900
Message-Id: <20200403101250.33245-8-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
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
 drivers/scsi/sd.c     |  26 ++-
 drivers/scsi/sd.h     |  38 ++++-
 drivers/scsi/sd_zbc.c | 367 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 413 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 2710a0e5ae6d..569b22ab394e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1206,6 +1206,14 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 		}
 	}
 
+	if (req_op(rq) == REQ_OP_ZONE_APPEND) {
+		ret = sd_zbc_prepare_zone_append(cmd, &lba, nr_blocks);
+		if (ret) {
+			scsi_mq_uninit_cmd(cmd);
+			return ret;
+		}
+	}
+
 	fua = rq->cmd_flags & REQ_FUA ? 0x8 : 0;
 	dix = scsi_prot_sg_count(cmd);
 	dif = scsi_host_dif_capable(cmd->device->host, sdkp->protection_type);
@@ -1287,6 +1295,7 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
 		return sd_setup_flush_cmnd(cmd);
 	case REQ_OP_READ:
 	case REQ_OP_WRITE:
+	case REQ_OP_ZONE_APPEND:
 		return sd_setup_read_write_cmnd(cmd);
 	case REQ_OP_ZONE_RESET:
 		return sd_zbc_setup_zone_mgmt_cmnd(cmd, ZO_RESET_WRITE_POINTER,
@@ -2055,7 +2064,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 
  out:
 	if (sd_is_zoned(sdkp))
-		sd_zbc_complete(SCpnt, good_bytes, &sshdr);
+		good_bytes = sd_zbc_complete(SCpnt, good_bytes, &sshdr);
 
 	SCSI_LOG_HLCOMPLETE(1, scmd_printk(KERN_INFO, SCpnt,
 					   "sd_done: completed %d of %d bytes\n",
@@ -3371,6 +3380,10 @@ static int sd_probe(struct device *dev)
 	sdkp->first_scan = 1;
 	sdkp->max_medium_access_timeouts = SD_MAX_MEDIUM_TIMEOUTS;
 
+	error = sd_zbc_init_disk(sdkp);
+	if (error)
+		goto out_free_index;
+
 	sd_revalidate_disk(gd);
 
 	gd->flags = GENHD_FL_EXT_DEVT;
@@ -3408,6 +3421,7 @@ static int sd_probe(struct device *dev)
  out_put:
 	put_disk(gd);
  out_free:
+	sd_zbc_release_disk(sdkp);
 	kfree(sdkp);
  out:
 	scsi_autopm_put_device(sdp);
@@ -3484,6 +3498,8 @@ static void scsi_disk_release(struct device *dev)
 	put_disk(disk);
 	put_device(&sdkp->device->sdev_gendev);
 
+	sd_zbc_release_disk(sdkp);
+
 	kfree(sdkp);
 }
 
@@ -3664,19 +3680,19 @@ static int __init init_sd(void)
 	if (!sd_page_pool) {
 		printk(KERN_ERR "sd: can't init discard page pool\n");
 		err = -ENOMEM;
-		goto err_out_ppool;
+		goto err_out_cdb_pool;
 	}
 
 	err = scsi_register_driver(&sd_template.gendrv);
 	if (err)
-		goto err_out_driver;
+		goto err_out_ppool;
 
 	return 0;
 
-err_out_driver:
+err_out_ppool:
 	mempool_destroy(sd_page_pool);
 
-err_out_ppool:
+err_out_cdb_pool:
 	mempool_destroy(sd_cdb_pool);
 
 err_out_cache:
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 50fff0bf8c8e..74448c250fea 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -79,6 +79,10 @@ struct scsi_disk {
 	u32		zones_optimal_open;
 	u32		zones_optimal_nonseq;
 	u32		zones_max_open;
+	u32		*zones_wp_ofst;
+	spinlock_t	zones_wp_ofst_lock;
+	struct work_struct zone_wp_ofst_work;
+	char		*zone_wp_update_buf;
 #endif
 	atomic_t	openers;
 	sector_t	capacity;	/* size in logical blocks */
@@ -207,17 +211,32 @@ static inline int sd_is_zoned(struct scsi_disk *sdkp)
 
 #ifdef CONFIG_BLK_DEV_ZONED
 
+int sd_zbc_init_disk(struct scsi_disk *sdkp);
+void sd_zbc_release_disk(struct scsi_disk *sdkp);
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
+static inline void sd_zbc_release_disk(struct scsi_disk *sdkp) {}
+
 static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,
 				    unsigned char *buf)
 {
@@ -233,9 +252,18 @@ static inline blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
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
index ee156fbf3780..49c78040fa84 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -42,6 +42,30 @@ static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
 	return cb(&zone, idx, data);
 }
 
+static unsigned int sd_zbc_get_zone_wp_ofst(struct blk_zone *zone)
+{
+	if (zone->type == ZBC_ZONE_TYPE_CONV)
+		return 0;
+
+	switch (zone->cond) {
+	case BLK_ZONE_COND_IMP_OPEN:
+	case BLK_ZONE_COND_EXP_OPEN:
+	case BLK_ZONE_COND_CLOSED:
+		return zone->wp - zone->start;
+	case BLK_ZONE_COND_FULL:
+		return zone->len;
+	case BLK_ZONE_COND_EMPTY:
+	case BLK_ZONE_COND_OFFLINE:
+	case BLK_ZONE_COND_READONLY:
+	default:
+		/*
+		 * Offline and read-only zones do not have a valid
+		 * write pointer. Use 0 as for an empty zone.
+		 */
+		return 0;
+	}
+}
+
 /**
  * sd_zbc_do_report_zones - Issue a REPORT ZONES scsi command.
  * @sdkp: The target disk
@@ -229,6 +253,134 @@ static blk_status_t sd_zbc_cmnd_checks(struct scsi_cmnd *cmd)
 	return BLK_STS_OK;
 }
 
+#define SD_ZBC_INVALID_WP_OFST	~(0u)
+#define SD_ZBC_UPDATING_WP_OFST	(SD_ZBC_INVALID_WP_OFST - 1)
+
+static int sd_zbc_update_wp_ofst_cb(struct blk_zone *zone, unsigned int idx,
+				    void *data)
+{
+	struct scsi_disk *sdkp = data;
+
+	lockdep_assert_held(&sdkp->zones_wp_ofst_lock);
+
+	sdkp->zones_wp_ofst[idx] = sd_zbc_get_zone_wp_ofst(zone);
+
+	return 0;
+}
+
+static void sd_zbc_update_wp_ofst_workfn(struct work_struct *work)
+{
+	struct scsi_disk *sdkp;
+	unsigned int zno;
+	int ret;
+
+	sdkp = container_of(work, struct scsi_disk, zone_wp_ofst_work);
+
+	spin_lock_bh(&sdkp->zones_wp_ofst_lock);
+	for (zno = 0; zno < sdkp->nr_zones; zno++) {
+		if (sdkp->zones_wp_ofst[zno] != SD_ZBC_UPDATING_WP_OFST)
+			continue;
+
+		spin_unlock_bh(&sdkp->zones_wp_ofst_lock);
+		ret = sd_zbc_do_report_zones(sdkp, sdkp->zone_wp_update_buf,
+					     SD_BUF_SIZE,
+					     zno * sdkp->zone_blocks, true);
+		spin_lock_bh(&sdkp->zones_wp_ofst_lock);
+		if (!ret)
+			sd_zbc_parse_report(sdkp, sdkp->zone_wp_update_buf + 64,
+					    zno, sd_zbc_update_wp_ofst_cb,
+					    sdkp);
+	}
+	spin_unlock_bh(&sdkp->zones_wp_ofst_lock);
+
+	scsi_device_put(sdkp->device);
+}
+
+static blk_status_t sd_zbc_update_wp_ofst(struct scsi_disk *sdkp,
+					  unsigned int zno)
+{
+	/*
+	 * We are about to schedule work to update a zone write pointer offset,
+	 * which will cause the zone append command to be requeued. So make
+	 * sure that the scsi device does not go away while the work is
+	 * being processed.
+	 */
+	if (scsi_device_get(sdkp->device))
+		return BLK_STS_IOERR;
+
+	sdkp->zones_wp_ofst[zno] = SD_ZBC_UPDATING_WP_OFST;
+
+	schedule_work(&sdkp->zone_wp_ofst_work);
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
+	spin_lock_bh(&sdkp->zones_wp_ofst_lock);
+
+	wp_ofst = sdkp->zones_wp_ofst[zno];
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
+	spin_unlock_bh(&sdkp->zones_wp_ofst_lock);
+
+	return BLK_STS_OK;
+
+err:
+	spin_unlock_bh(&sdkp->zones_wp_ofst_lock);
+	blk_req_zone_write_unlock(rq);
+	return ret;
+}
+
 /**
  * sd_zbc_setup_zone_mgmt_cmnd - Prepare a zone ZBC_OUT command. The operations
  *			can be RESET WRITE POINTER, OPEN, CLOSE or FINISH.
@@ -266,19 +418,139 @@ blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
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
+	switch (req_op(rq)) {
+	case REQ_OP_ZONE_APPEND:
+	case REQ_OP_ZONE_FINISH:
+	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_RESET_ALL:
+		return true;
+	case REQ_OP_WRITE:
+	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_WRITE_SAME:
+		return blk_rq_zone_is_seq(rq);
+	default:
+		return false;
+	}
+}
+
+/**
+ * sd_zbc_zone_wp_update - Update cached zone write pointer upon cmd completion
+ * @cmd: Completed command
+ * @good_bytes: Command reply bytes
+ *
+ * Called from sd_zbc_complete() to handle the update of the cached zone write
+ * pointer value in case an update is needed.
+ */
+static unsigned int sd_zbc_zone_wp_update(struct scsi_cmnd *cmd,
+					  unsigned int good_bytes)
+{
+	int result = cmd->result;
+	struct request *rq = cmd->request;
+	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
+	unsigned int zno = blk_rq_zone_no(rq);
+	enum req_opf op = req_op(rq);
+
+	/*
+	 * If we got an error for a command that needs updating the write
+	 * pointer offset cache, we must mark the zone wp offset entry as
+	 * invalid to force an update from disk the next time a zone append
+	 * command is issued.
+	 */
+	spin_lock_bh(&sdkp->zones_wp_ofst_lock);
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
+		if (sdkp->zones_wp_ofst[zno] != SD_ZBC_UPDATING_WP_OFST)
+			sdkp->zones_wp_ofst[zno] = SD_ZBC_INVALID_WP_OFST;
+		goto unlock_wp_ofst;
+	}
+
+	switch (op) {
+	case REQ_OP_ZONE_APPEND:
+		rq->__sector += sdkp->zones_wp_ofst[zno];
+		/* fallthrough */
+	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_WRITE_SAME:
+	case REQ_OP_WRITE:
+		if (sdkp->zones_wp_ofst[zno] < sd_zbc_zone_sectors(sdkp))
+			sdkp->zones_wp_ofst[zno] += good_bytes >> SECTOR_SHIFT;
+		break;
+	case REQ_OP_ZONE_RESET:
+		sdkp->zones_wp_ofst[zno] = 0;
+		break;
+	case REQ_OP_ZONE_FINISH:
+		sdkp->zones_wp_ofst[zno] = sd_zbc_zone_sectors(sdkp);
+		break;
+	case REQ_OP_ZONE_RESET_ALL:
+		memset(sdkp->zones_wp_ofst, 0,
+		       sdkp->nr_zones * sizeof(unsigned int));
+		break;
+	default:
+		break;
+	}
+
+unlock_wp_ofst:
+	spin_unlock_bh(&sdkp->zones_wp_ofst_lock);
+
+	return good_bytes;
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
@@ -294,7 +566,18 @@ void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
 		 * so be quiet about the error.
 		 */
 		rq->rq_flags |= RQF_QUIET;
+		goto unlock_zone;
 	}
+
+	if (sd_zbc_need_zone_wp_update(rq))
+		good_bytes = sd_zbc_zone_wp_update(cmd, good_bytes);
+
+
+unlock_zone:
+	if (sd_zbc_zone_needs_write_unlock(rq))
+		blk_req_zone_write_unlock(rq);
+
+	return good_bytes;
 }
 
 /**
@@ -396,11 +679,52 @@ static int sd_zbc_check_capacity(struct scsi_disk *sdkp, unsigned char *buf,
 	return 0;
 }
 
+struct sd_zbc_revalidate_zone_args {
+	struct scsi_disk	*sdkp;
+	u32			*zones_wp_ofst;
+};
+
+static void sd_zbc_revalidate_zones_cb(struct blk_zone *zone, unsigned int idx,
+				       void *data)
+{
+	struct sd_zbc_revalidate_zone_args *args = data;
+	struct scsi_disk *sdkp = args->sdkp;
+
+	if (zone) {
+		args->zones_wp_ofst[idx] = sd_zbc_get_zone_wp_ofst(zone);
+		return;
+	}
+
+	/* Final call: apply change */
+	swap(sdkp->zones_wp_ofst, args->zones_wp_ofst);
+}
+
+static int sd_zbc_revalidate_zones(struct scsi_disk *sdkp,
+				   unsigned int nr_zones)
+{
+	struct sd_zbc_revalidate_zone_args args = {
+		.sdkp = sdkp,
+	};
+	int ret;
+
+	args.zones_wp_ofst = kvcalloc(nr_zones, sizeof(u32), GFP_NOIO);
+	if (!args.zones_wp_ofst)
+		return -ENOMEM;
+
+	ret = __blk_revalidate_disk_zones(sdkp->disk,
+					  sd_zbc_revalidate_zones_cb, &args);
+	kvfree(args.zones_wp_ofst);
+
+	return ret;
+}
+
 int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 {
 	struct gendisk *disk = sdkp->disk;
+	struct request_queue *q = disk->queue;
 	unsigned int nr_zones;
 	u32 zone_blocks = 0;
+	u32 max_append;
 	int ret;
 
 	if (!sd_is_zoned(sdkp))
@@ -420,10 +744,14 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 	if (ret != 0)
 		goto err;
 
+	max_append = min_t(u32, logical_to_sectors(sdkp->device, zone_blocks),
+			   q->limits.max_segments << (PAGE_SHIFT - 9));
+	max_append = min_t(u32, max_append, queue_max_hw_sectors(q));
+
 	/* The drive satisfies the kernel restrictions: set it up */
-	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, sdkp->disk->queue);
-	blk_queue_required_elevator_features(sdkp->disk->queue,
-					     ELEVATOR_F_ZBD_SEQ_WRITE);
+	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
+	blk_queue_max_zone_append_sectors(q, max_append);
 	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
 
 	/* READ16/WRITE16 is mandatory for ZBC disks */
@@ -443,8 +771,8 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 
 	if (sdkp->zone_blocks != zone_blocks ||
 	    sdkp->nr_zones != nr_zones ||
-	    disk->queue->nr_zones != nr_zones) {
-		ret = blk_revalidate_disk_zones(disk);
+	    q->nr_zones != nr_zones) {
+		ret = sd_zbc_revalidate_zones(sdkp, nr_zones);
 		if (ret != 0)
 			goto err;
 		sdkp->zone_blocks = zone_blocks;
@@ -475,3 +803,26 @@ void sd_zbc_print_zones(struct scsi_disk *sdkp)
 			  sdkp->nr_zones,
 			  sdkp->zone_blocks);
 }
+
+int sd_zbc_init_disk(struct scsi_disk *sdkp)
+{
+	if (!sd_is_zoned(sdkp))
+		return 0;
+
+	sdkp->zones_wp_ofst = NULL;
+	spin_lock_init(&sdkp->zones_wp_ofst_lock);
+	INIT_WORK(&sdkp->zone_wp_ofst_work, sd_zbc_update_wp_ofst_workfn);
+	sdkp->zone_wp_update_buf = kzalloc(SD_BUF_SIZE, GFP_KERNEL);
+	if (!sdkp->zone_wp_update_buf)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void sd_zbc_release_disk(struct scsi_disk *sdkp)
+{
+	kvfree(sdkp->zones_wp_ofst);
+	sdkp->zones_wp_ofst = NULL;
+	kfree(sdkp->zone_wp_update_buf);
+	sdkp->zone_wp_update_buf = NULL;
+}
-- 
2.24.1

