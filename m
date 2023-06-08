Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E18727D92
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 13:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjFHLD3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 07:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjFHLDZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:03:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400F22129;
        Thu,  8 Jun 2023 04:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eGImU7RddjAi80e+tW424dPAVsMSpId5HtotbM4PBXg=; b=QKoakhTg4fLiP0bDEva9VVDSHF
        PoMBZ8+2TZOm6zqZZZbysdmTGb0yc9nnFw6clZtx37HM3Xse3adwly95AZxbBY1ySSJgA8HA67iRn
        eFV+iFsVsN2LDA9OYWGge7BK/aQOICH/cCGdQwmGwpXDtZ2C9goXDM/g0Anr3ib1UehMzci70pj/c
        1iUfv3NEM/9DSaVrFRoJ0WTbVxqrrIvihx4Na5Zz+kh4TjKYbgTjY+8ywcaQrPWxmiifoF5xz8Sji
        NfHF8ccPi5btIbYCZxAgOPoAfNOorZLKLMq1GGa7914qlDNbq0ngSD9scqJVd+NIwYP55iXOJWqBX
        sDrYuk7w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7DQ4-0091eW-27;
        Thu, 08 Jun 2023 11:03:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 03/30] cdrom: remove the unused mode argument to cdrom_ioctl
Date:   Thu,  8 Jun 2023 13:02:31 +0200
Message-Id: <20230608110258.189493-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 drivers/cdrom/cdrom.c | 2 +-
 drivers/cdrom/gdrom.c | 2 +-
 drivers/scsi/sr.c     | 2 +-
 include/linux/cdrom.h | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index e3eab319cb0474..245e5bbb05d41c 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3336,7 +3336,7 @@ static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
  * ATAPI / SCSI specific code now mainly resides in mmc_ioctl().
  */
 int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
-		fmode_t mode, unsigned int cmd, unsigned long arg)
+		unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 	int ret;
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index eaa2d5a90bc82f..14922403983e9e 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -505,7 +505,7 @@ static int gdrom_bdops_ioctl(struct block_device *bdev, fmode_t mode,
 	int ret;
 
 	mutex_lock(&gdrom_mutex);
-	ret = cdrom_ioctl(gd.cd_info, bdev, mode, cmd, arg);
+	ret = cdrom_ioctl(gd.cd_info, bdev, cmd, arg);
 	mutex_unlock(&gdrom_mutex);
 
 	return ret;
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 61b83880e395a4..444c7efc14cba7 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -539,7 +539,7 @@ static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	scsi_autopm_get_device(sdev);
 
 	if (cmd != CDROMCLOSETRAY && cmd != CDROMEJECT) {
-		ret = cdrom_ioctl(&cd->cdi, bdev, mode, cmd, arg);
+		ret = cdrom_ioctl(&cd->cdi, bdev, cmd, arg);
 		if (ret != -ENOSYS)
 			goto put;
 	}
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index cc5717cb0fa8a8..4aea8c82d16971 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -103,8 +103,8 @@ int cdrom_read_tocentry(struct cdrom_device_info *cdi,
 /* the general block_device operations structure: */
 int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode);
 extern void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode);
-extern int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
-		       fmode_t mode, unsigned int cmd, unsigned long arg);
+int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
+		unsigned int cmd, unsigned long arg);
 extern unsigned int cdrom_check_events(struct cdrom_device_info *cdi,
 				       unsigned int clearing);
 
-- 
2.39.2

