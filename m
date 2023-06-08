Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE949727D8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 13:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjFHLDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 07:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjFHLD1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:03:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8D32134;
        Thu,  8 Jun 2023 04:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WVOLYCYgNhurfOY8cVan3fvTgQgKmYPWrYutrJ2vXRM=; b=qyT0M/2tVDs9AVGQPIMNQZxI0I
        kiiW95vvxeGfq+g9SDYSNtmxtI7R5kN06IlrPOZjCsSqXD6prbwiCBvOGKO8BBzGEYtpRSaJ00EjB
        VP/xEP1E8kt9e+kdcf35ZXVVRdeOf1aRWAdGR9l6LnsbsVZx+AeSsw7kJk3ucn/6igTTr2yJDKZ00
        HYgE5ezEwHu3KAjgE+gA7dllqOQsrc7Tex+y5Clbmc1W77I4ns6o9ZaVoq1wlYi9x2ClAizYTUR8K
        4dex9WW67jAaG7Zm2BMK7cfiH9PQSHgYf8G6zKNHARoCpZ93w/BrMPW+ZUpKe5VlwRiMRWtGIG6x4
        TcjI7f8w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7DQ2-0091dM-18;
        Thu, 08 Jun 2023 11:03:06 +0000
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
Subject: [PATCH 02/30] cdrom: remove the unused bdev argument to cdrom_open
Date:   Thu,  8 Jun 2023 13:02:30 +0200
Message-Id: <20230608110258.189493-3-hch@lst.de>
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
 drivers/cdrom/cdrom.c | 3 +--
 drivers/cdrom/gdrom.c | 2 +-
 drivers/scsi/sr.c     | 2 +-
 include/linux/cdrom.h | 3 +--
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 416f723a2dbb33..e3eab319cb0474 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1155,8 +1155,7 @@ int open_for_data(struct cdrom_device_info *cdi)
  * is in their own interest: device control becomes a lot easier
  * this way.
  */
-int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
-	       fmode_t mode)
+int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode)
 {
 	int ret;
 
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index ceded5772aac6d..eaa2d5a90bc82f 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -481,7 +481,7 @@ static int gdrom_bdops_open(struct block_device *bdev, fmode_t mode)
 	bdev_check_media_change(bdev);
 
 	mutex_lock(&gdrom_mutex);
-	ret = cdrom_open(gd.cd_info, bdev, mode);
+	ret = cdrom_open(gd.cd_info, mode);
 	mutex_unlock(&gdrom_mutex);
 	return ret;
 }
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 12869e6d4ebda8..61b83880e395a4 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -498,7 +498,7 @@ static int sr_block_open(struct block_device *bdev, fmode_t mode)
 		sr_revalidate_disk(cd);
 
 	mutex_lock(&cd->lock);
-	ret = cdrom_open(&cd->cdi, bdev, mode);
+	ret = cdrom_open(&cd->cdi, mode);
 	mutex_unlock(&cd->lock);
 
 	scsi_autopm_put_device(sdev);
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 67caa909e3e615..cc5717cb0fa8a8 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -101,8 +101,7 @@ int cdrom_read_tocentry(struct cdrom_device_info *cdi,
 		struct cdrom_tocentry *entry);
 
 /* the general block_device operations structure: */
-extern int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
-			fmode_t mode);
+int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode);
 extern void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode);
 extern int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 		       fmode_t mode, unsigned int cmd, unsigned long arg);
-- 
2.39.2

