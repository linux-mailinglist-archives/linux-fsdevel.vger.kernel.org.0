Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E657123983
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfLQWTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:19:01 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:42327 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfLQWRn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:43 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MPGNn-1iJtNk0HCn-00PeZf; Tue, 17 Dec 2019 23:17:29 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-doc@vger.kernel.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 13/27] compat_ioctl: cdrom: handle CDROM_LAST_WRITTEN
Date:   Tue, 17 Dec 2019 23:16:54 +0100
Message-Id: <20191217221708.3730997-14-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wpOzJeFufAHUVew0tCAOYce8zMXOPidyJEDHZ6pQ5GaUKg8+CDX
 h7MBzbcLPVMio9kfQoSfOTfY3vxyKEJ51kkTL2W9m6KoiixxPeES/rPHhLYMS3HLccXegsv
 k2H3sqymCqH2WEdNBVYO+Pa/7nVD5p4xIpTPyQbpKaEF5BnOtpu5V76Hk5QKEhX0c57O6+9
 iqqUYAqmFhuT18BCsoAUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CIB+4OQSR64=:WBhyckcX/5l7eAeTjvEoM/
 w4upkT4JvAY0/CRT9+NICNrKfxWQgzFpdAAXj+N/219xyoUp3i3ArASxNj5M5wRYKgkvQZQxH
 CxE3wmmlICtVcCt38Iyj0fCz219veSow7XvDStghM7YdHK3Dyc6tvlWWXjGrbbVRnSjwPfDRg
 eVtYANDyKpGQXAf9W7W90lMaNv5QMnxNMgyq39t/ISQtLXqABgziP8W2h45E7twP5VBot7roC
 GL1ML1O03UlrCwfpOAkcgAdPWAHJZqUm3sBBK5njNHfVE35o5IBtcTuXdtKRnOvtk0yQoGDSJ
 VvyZRKQAB0hgxPqN29PkxvMSJi7nxkkeU4eEQ5e5E0s4OkSUgjPjtxtDSBpGBgdgb26I7jH2L
 WThg17UcmwvgV1keBdbZ4b/FITTwdodVlLprRQoVJYBHU+DHryNHvKqiVjmu2hjYvq+APMZRQ
 8CqFFoQLK9j+/z4XOJvkjTBW3oFG5EyvDNVM6yeAWb/gJ/Q/cK4dMzs8/h2w38PPOyVOH+8CJ
 GIOD1toGYO9NJ1N9oFYeeglO/lAFX7OvezRPohzgPi2aoCJB6ApyXKb4gonN+8Fv4HMFm0YAn
 arCC0GtPppbxPq3gxhB8lsLrZSS2AFE+ix/mk7W8HSVu6ItzoancGQHxY/wKZjbbETFZm5fPJ
 /14Hk/KHBiHbbD+jpVUF0Y+Gf1ti/u7yMF0lQGlVccJE3OH+qD4WefTxzFl5aPUrsX15aFR1w
 Cc0R5lYy8WI3de9J8he5JIBk4eYo4gSYrrHC7sS4ng7SAXuIfuf+vpYVaZYyqumJzv7yGEiiG
 i+9Lx5d/5ai3pOwDpQnQJJ3YqYcqWsPmuRATJOiCUiObGVXUhY5YSaDw3y0R2ptIuC1ixKtTh
 QEy6XnI1qqp/ZZw4o4iQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the only ioctl command that does not have a proper
compat handler. Making the normal implementation do the
right thing is actually very simply, so just do that by
using an in_compat_syscall() check to avoid the special
case in the pkcdvd driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/pktcdvd.c | 24 +-----------------------
 drivers/cdrom/cdrom.c   |  7 ++++---
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index ab4d3be4b646..5f970a7d32c0 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2663,26 +2663,6 @@ static int pkt_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-static int pkt_compat_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	/* compatible */
-	case CDROMEJECT:
-	case CDROMMULTISESSION:
-	case CDROMREADTOCENTRY:
-	case CDROM_SEND_PACKET: /* compat mode handled in scsi_cmd_ioctl */
-	case SCSI_IOCTL_SEND_COMMAND:
-		return pkt_ioctl(bdev, mode, cmd, (unsigned long)compat_ptr(arg));
-
-	/* FIXME: no handler so far */
-	default:
-	case CDROM_LAST_WRITTEN:
-		return -ENOIOCTLCMD;
-	}
-}
-#endif
-
 static unsigned int pkt_check_events(struct gendisk *disk,
 				     unsigned int clearing)
 {
@@ -2704,9 +2684,7 @@ static const struct block_device_operations pktcdvd_ops = {
 	.open =			pkt_open,
 	.release =		pkt_close,
 	.ioctl =		pkt_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl =		pkt_compat_ioctl,
-#endif
+	.compat_ioctl =		blkdev_compat_ptr_ioctl,
 	.check_events =		pkt_check_events,
 };
 
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 48095025e588..faca0f346fff 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3293,9 +3293,10 @@ static noinline int mmc_ioctl_cdrom_last_written(struct cdrom_device_info *cdi,
 	ret = cdrom_get_last_written(cdi, &last);
 	if (ret)
 		return ret;
-	if (copy_to_user((long __user *)arg, &last, sizeof(last)))
-		return -EFAULT;
-	return 0;
+	if (in_compat_syscall())
+		return put_user(last, (__s32 __user *)arg);
+
+	return put_user(last, (long __user *)arg);
 }
 
 static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
-- 
2.20.0

