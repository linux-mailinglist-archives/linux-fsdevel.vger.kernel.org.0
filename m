Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACB514A1B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgA0KPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:15:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35811 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbgA0KPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:15:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id i23so4703093pfo.2;
        Mon, 27 Jan 2020 02:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=srlge2UyLaMLQMOBuVNCorvu2hILs9zTEX6ffyYx364=;
        b=U4n4tTx9CiDzqkS0IdtHnP7N1ZHpLKh96OZLl+ZrMLImNebgom7M96D+0WF3xRUXYi
         z6iawH0aejcJDS3JkyFw3n1Zccive5w88Ab0N/TA8wp119GxrJlNosIIshJZvZdyhl6o
         H05eACtTp6dADrYdAkKMcMY6TZSw1wFh9c7x2fTEnmoS7b/PWykcoCQNOWed9OMbQKdF
         3zVWPrSKuWWjM+P4RBdJuUileIp1Z/NGGKtqzgGobJviWPZgp1ehsJqirRCe+YaeeZ2D
         30mynq82LB80knhA4yLn4Bfq1kjYttKZ8JxCb79F+BrENO03bl8hsGsX3cvD4q/0JQ97
         OJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=srlge2UyLaMLQMOBuVNCorvu2hILs9zTEX6ffyYx364=;
        b=I9vUpAN/OhvbWSI0AEetdRhLyxLLwI+UCu6ZfZNnvWfC36bZvV0hagYl5+DFOPafKM
         VKHv2rsAZSv2gR//5bZF6UvKsPq/05kPOp2bM9ItR9EB6G7FNnzE7CyJ4He9c7GljSwI
         LKY3w9g6CG05V63m49WwoLTHIyAEGCSvSYSkdl+BjUtKGW+EO+tjOOgN8sJ3Pv1i5dRZ
         KKVzVlbdIQc5jNAOTIMI4no7DnMS8F+SW6byYOorOEm5hzSMCGjLN1Xh5bwSstyga6zj
         RkY7fH5J3YJhxXoIa/5PI7nBZi1WUtBE0pJHrN6XVHtoPDDF/Hkp6zzXw9wsnjt76bQO
         OTAQ==
X-Gm-Message-State: APjAAAUvImG+KwCtC0vyptEpHk9B1WOjeSS1xrvojjnoRfRj2fNLh03H
        /9/Y77dV5k9PhdcHifXbMhw=
X-Google-Smtp-Source: APXvYqysbjV2ji5EYJHV5PyvyPXacfZu6qeM1cE0RQF4rGdVXXJfVcjO/TIlowqCy56Zw1aaUiQF0A==
X-Received: by 2002:a65:420d:: with SMTP id c13mr19176232pgq.101.1580120117036;
        Mon, 27 Jan 2020 02:15:17 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:15:16 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 11/22] staging: exfat: Rename variable "FatType" to "fat_type"
Date:   Mon, 27 Jan 2020 15:43:32 +0530
Message-Id: <20200127101343.20415-12-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "FatType" to "fat_type" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 58292495bb57..8a4668d301fc 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -242,7 +242,7 @@ struct dev_info_t {
 };
 
 struct vol_info_t {
-	u32      FatType;
+	u32      fat_type;
 	u32      ClusterSize;
 	u32      NumClusters;
 	u32      FreeClusters;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 6cc21d795589..695c8793fe5f 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -494,7 +494,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	if (p_fs->used_clusters == UINT_MAX)
 		p_fs->used_clusters = p_fs->fs_func->count_used_clusters(sb);
 
-	info->FatType = p_fs->vol_type;
+	info->fat_type = p_fs->vol_type;
 	info->ClusterSize = p_fs->cluster_size;
 	info->NumClusters = p_fs->num_clusters - 2; /* clu 0 & 1 */
 	info->UsedClusters = p_fs->used_clusters;
@@ -3348,7 +3348,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 			return -EIO;
 
 	} else {
-		info.FatType = p_fs->vol_type;
+		info.fat_type = p_fs->vol_type;
 		info.ClusterSize = p_fs->cluster_size;
 		info.NumClusters = p_fs->num_clusters - 2;
 		info.UsedClusters = p_fs->used_clusters;
-- 
2.17.1

