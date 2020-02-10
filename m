Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3001582AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgBJShb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:37:31 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55082 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJSha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:37:30 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so128356pjb.4;
        Mon, 10 Feb 2020 10:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6lwk7miD+ae4jYYUu6bZ8+EVLNhjmBds1tK8zZYoDaY=;
        b=AYHYMyiVBRhvvhLK2Df31om+O/xI0JupMjAhijHFJeHmLBOMZaWGpChcBRc8j34moa
         c9K9hFTlP6fEFDI4kCY77reTrKUghuTWoxDnahIcliazM3xnzmkfkshbdQKBq5x0pPlk
         U8XwKvDQqUGgGYhrrP45KXuGA0CSdc/DKaHy2anZASMikSEeKmtaJrfFkD9/WgAulcSo
         gwdVRMHtoIkEG06e7RKXQ4r3IDRZ72n/Fl7TZfeOnTj971VvN1QU60wG8cNMPmx+hNFJ
         FGmTZwowFK/IcHtLOkZFAFL7uBflq/c03u75SdU/4xZnxTRJgf5Dlx+A6ChwYIXqOzlk
         XCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6lwk7miD+ae4jYYUu6bZ8+EVLNhjmBds1tK8zZYoDaY=;
        b=Q4a8gwmoscLteKKNS4Jda7F/NjhqwDxEV8hv5eSlSItW1I2S0kmxPbfNLbEu5+Ptrt
         7vxT6ZicpSuiQvnseOtIWtYyzFdC0C9RUrkSVeVqLaloQAqN0odiPRauYD5lWFFND++C
         yFEO1Fm+gz8XChVB0EEJzzWatdRar/BUe4uUTuqfd/FrZ9IJgrTmgHWwl1zQNXH2Xpg6
         W/i6mP7hKaqOSBNbnJXjRZw5kdHAe8GGqQzkLeb19Bkj2bcQYqRYGPXBfpF3T2CA+fHB
         4diha9Dov/XYiEuk+Z1Dg+v4VCMcbG0G32VsuZfoGYzWwHYUQU5oC47vR8PMhIu6CQ/D
         NfcA==
X-Gm-Message-State: APjAAAVdOnS5lG+9g1SIpH10/y1ORHJGJCR3xrjtpajp/r7aoVo8f1cG
        VEkQpEHSDb0E8q3l1XgAZ1U=
X-Google-Smtp-Source: APXvYqy9BhBfDaOAN2mGbOwrysU4PzmHuWlw6ufGWELxO5+2Bk5SILjeWy2pZchgdlgTrLTs80YRJw==
X-Received: by 2002:a17:90a:af81:: with SMTP id w1mr505149pjq.14.1581359849734;
        Mon, 10 Feb 2020 10:37:29 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:37:29 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 12/19] staging: exfat: Rename variable 'UsedClusters' to 'used_clusters'
Date:   Tue, 11 Feb 2020 00:05:51 +0530
Message-Id: <20200210183558.11836-13-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "UsedClusters" to "used_clusters"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index aa6c46628fdd..01d79dcc1c94 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -246,7 +246,7 @@ struct vol_info_t {
 	u32      cluster_size;
 	u32      num_clusters;
 	u32      free_clusters;
-	u32      UsedClusters;
+	u32      used_clusters;
 };
 
 /* directory structure */
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index dcccf4170afe..7d70206eb5f8 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -497,8 +497,8 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	info->fat_type = p_fs->vol_type;
 	info->cluster_size = p_fs->cluster_size;
 	info->num_clusters = p_fs->num_clusters - 2; /* clu 0 & 1 */
-	info->UsedClusters = p_fs->used_clusters;
-	info->free_clusters = info->num_clusters - info->UsedClusters;
+	info->used_clusters = p_fs->used_clusters;
+	info->free_clusters = info->num_clusters - info->used_clusters;
 
 	if (p_fs->dev_ejected)
 		err = -EIO;
@@ -3348,8 +3348,8 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 		info.fat_type = p_fs->vol_type;
 		info.cluster_size = p_fs->cluster_size;
 		info.num_clusters = p_fs->num_clusters - 2;
-		info.UsedClusters = p_fs->used_clusters;
-		info.free_clusters = info.num_clusters - info.UsedClusters;
+		info.used_clusters = p_fs->used_clusters;
+		info.free_clusters = info.num_clusters - info.used_clusters;
 
 		if (p_fs->dev_ejected)
 			pr_info("[EXFAT] statfs on device that is ejected\n");
-- 
2.17.1

