Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBB614A1BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgA0KPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:15:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44639 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbgA0KPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:15:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so4904710pgl.11;
        Mon, 27 Jan 2020 02:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eMr4psfWgJ9fb4qbP9kKyPdJt7Lo5XGdcJP/eVazIso=;
        b=IOom2ukhWfgNkJRLBcke9EKnz6KTi0/vaHrfCaz/g1+TL2io1DE6doYYcxrp0yqNZo
         sx6tkg4oMaDQTPvZi5GuP7HK49stci4jd81bFLke3W+YnBhRXjdCf9O+XLoKiypdU/LM
         cm3POzg0I/hlcR/gh7A8QyZBa08ghlp+zTxOk8ZNwV1UNYHy7J9X8yzG21PW9Jqq3v1U
         /fYyvg+SCetcffMmD0VGsmQ195sHdXsAl/4CQD5T/APaamNigBdHWgWO1GGPHjYAMhU3
         RngrieQSpnWlCHNkZmgzlRs/sV7rpya6GPiFtu01YGeHxEoJnbxv4Zi81spH1UgHtLCs
         GQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eMr4psfWgJ9fb4qbP9kKyPdJt7Lo5XGdcJP/eVazIso=;
        b=c7riKtOPUO8vn7PKP5D2x/KEA5GGA/mLqRHQMNNxG0Jw7ZEm5VgJkz5MqOhgwVuzRF
         bEQSCXMA6/UWf24HwYSj+suCJp5JS4Agk9KznMDtPvxqN7IrYbibCLiK3EUibGXG2Rel
         RZvDvnFqW3cq0f6rmNG2VNlsYFeitINzph12WLBhFUn+3i7i+BlC2y67TVYZvtoesIeG
         qtNw+77BLUmKv5QDfwhzikjwfWhAIzYDx2eKUqSHOvo9IxJJpwLVODgORq6SsKSowZjx
         U9/5dMzwO2ZDz+dy54HOzSCRBDVddryAvMaQb8o3KCcxdr4UlAa1/6AMU56kRCGAAFJB
         ijsg==
X-Gm-Message-State: APjAAAV4nMZxV+XcfaWJ6EMZVGg0IWjTIGFcb7kDR+jQiKOMW7hi3bvI
        lwpuPqRHgPo0dYmhlokRvns=
X-Google-Smtp-Source: APXvYqwV371FrvlzQir9WoQFP5YSMgFPDn0zPWiHdeQGOBE1SFHUqH2is1uMBFsvhXjS+T64ceo7ew==
X-Received: by 2002:a62:2ccd:: with SMTP id s196mr7280282pfs.227.1580120136290;
        Mon, 27 Jan 2020 02:15:36 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:15:35 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 15/22] staging: exfat: Rename variable "UsedClusters" to "used_clusters"
Date:   Mon, 27 Jan 2020 15:43:36 +0530
Message-Id: <20200127101343.20415-16-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "UsedClusters" to "used_clusters" in
exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 4cc5c1914864..abed7fed3823 100644
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
index 7a8b876414bd..223699a21079 100644
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
@@ -3351,8 +3351,8 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
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

