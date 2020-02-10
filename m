Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185601582AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBJSh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:37:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37027 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJSh0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:37:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so3166107plz.4;
        Mon, 10 Feb 2020 10:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HfStNmJze4gtu3p+ndhiR96JnMn6mxUwQjjELtrDbgw=;
        b=nbgcE4S82HyLS8e82SBCtKIJg82H9pfKpp6uxHmNuLCbHLUpc/vT6MXxfZEbEif+ki
         q1COMmUn+EwQwUoHNEweenRBvWQTF+0QI11jmZ0EKcSXKmFMYSe8vxU4Es1mTw4ZhCKM
         jG00Y6R7FI7UIFYGPHpn8rVJH5cxkqw34hcHh+ljQgHxm9ZyYH5SmFYMMq6amKjrQUoD
         kwn3SsD/y8qPOTrLj5eiO04vUyZue+3kMRUHWCX0MpKZLZPN3kqfhq2uFFLK0DF5sCUO
         Y41RxtsvkV/1bl90njlJesWxnq8UEdy8ga8l1b8gdqw0VF94T8YFYJzs4RktPwIzZdZP
         7ktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HfStNmJze4gtu3p+ndhiR96JnMn6mxUwQjjELtrDbgw=;
        b=Jjj49WF/Cm4jQ17oaR1el22z85XBWhYW7f+CynbDBDjS0EpMXifFGPi3Ss1eDZXamY
         3UHiF2TrilcCPDxUBb/eVKRh4a45wuS6iXd87Iy1Ug3OcXaZu3iKQ51qGCha35xyW49+
         rufqC/4O+g56jqi+u749kndB1Rc4NDAgdstEGn1Tbn2g5Szjc8qsJRvga1wZgeFLO6ta
         YgfLL9PzLNtaTqjgvYUVkE8Bo5QqjLwK9I0OqZx/BdKTQGeyjqn1u7lIFGnrVhx7zAXE
         YtZSKJETp6dlKN9Yrj8oti+3VDomiEyUyne6hIQ5hKvZ4mPtMZgK5d82KPvlBpgAtV/X
         1oGg==
X-Gm-Message-State: APjAAAVyoxP2UTaABig8/Z5m+v3wfu+HPQ3NS9geLTzF72OOx66K/2DS
        Zdga8e8cc5yHJu6Tur61JOk=
X-Google-Smtp-Source: APXvYqyfBTYIZhMkueWHP73fRu6clkAmebFrfnGeR5nEwSvXvDu41+vPTgK9KG4bgb8HNxd5QMKuDg==
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr14045799plp.110.1581359845297;
        Mon, 10 Feb 2020 10:37:25 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:37:24 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 11/19] staging: exfat: Rename variable 'FreeClusters' to 'free_clusters'
Date:   Tue, 11 Feb 2020 00:05:50 +0530
Message-Id: <20200210183558.11836-12-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "FreeClusters" to "free_clusters"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index df84a729d5d5..aa6c46628fdd 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -245,7 +245,7 @@ struct vol_info_t {
 	u32      fat_type;
 	u32      cluster_size;
 	u32      num_clusters;
-	u32      FreeClusters;
+	u32      free_clusters;
 	u32      UsedClusters;
 };
 
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 59e18b37dd7d..dcccf4170afe 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -498,7 +498,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	info->cluster_size = p_fs->cluster_size;
 	info->num_clusters = p_fs->num_clusters - 2; /* clu 0 & 1 */
 	info->UsedClusters = p_fs->used_clusters;
-	info->FreeClusters = info->num_clusters - info->UsedClusters;
+	info->free_clusters = info->num_clusters - info->UsedClusters;
 
 	if (p_fs->dev_ejected)
 		err = -EIO;
@@ -3349,7 +3349,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 		info.cluster_size = p_fs->cluster_size;
 		info.num_clusters = p_fs->num_clusters - 2;
 		info.UsedClusters = p_fs->used_clusters;
-		info.FreeClusters = info.num_clusters - info.UsedClusters;
+		info.free_clusters = info.num_clusters - info.UsedClusters;
 
 		if (p_fs->dev_ejected)
 			pr_info("[EXFAT] statfs on device that is ejected\n");
@@ -3358,8 +3358,8 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = info.cluster_size;
 	buf->f_blocks = info.num_clusters;
-	buf->f_bfree = info.FreeClusters;
-	buf->f_bavail = info.FreeClusters;
+	buf->f_bfree = info.free_clusters;
+	buf->f_bavail = info.free_clusters;
 	buf->f_fsid.val[0] = (u32)id;
 	buf->f_fsid.val[1] = (u32)(id >> 32);
 	buf->f_namelen = 260;
-- 
2.17.1

