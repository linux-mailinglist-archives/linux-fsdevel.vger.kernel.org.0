Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8724BFD0CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 23:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfKNWPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 17:15:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52872 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKNWPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:15:13 -0500
Received: from [82.43.126.140] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iVNOQ-0006CO-DR; Thu, 14 Nov 2019 22:15:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: exfat: fix spelling mistake "maont" -> "mount"
Date:   Thu, 14 Nov 2019 22:15:09 +0000
Message-Id: <20191114221509.10728-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a kernel info message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/exfat/exfat_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 23002aefc964..b0fcdbbe4579 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -364,7 +364,7 @@ static int ffsMountVol(struct super_block *sb)
 	exfat_bdev_open(sb);
 
 	if (p_bd->sector_size < sb->s_blocksize) {
-		printk(KERN_INFO "EXFAT: maont failed - sector size %d less than blocksize %ld\n",
+		printk(KERN_INFO "EXFAT: mount failed - sector size %d less than blocksize %ld\n",
 			p_bd->sector_size,  sb->s_blocksize);
 		ret = -EINVAL;
 		goto out;
-- 
2.20.1

