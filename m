Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E3A14A1B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgA0KPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:15:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44620 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbgA0KPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:15:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so4904403pgl.11;
        Mon, 27 Jan 2020 02:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JcRIPbkub/tWCLWv2xyN/6N5F607AAwY0FQRtWmXUeA=;
        b=I2BMAGxj91JaWVFHnYf9So8bsD1dfH8idbbGesPL0ij3BPjgFCvpvLWjduaA5C8qkg
         8Qa2UOd3foVbMQcndVTWVnlpHv/PNu9eGY+jlTMlbamIIvBw196VKKknWRvCeGjqnGII
         fSQhGwKhVMDj4ynx6uiUTHYjo7it5NW7KImy6H4XpdoHZW28L6ZDnSGNHdOGOhxCkQs5
         9t1ebEbrxNhPlpwApa/W8pVeqbRL3ovJXuWiFKAXF5LM+LJbbGheNJL2AQYnsxQJocku
         BfMyoYnDgZXkYoUcRo1KAkkDppttvlREYu5vumOWZvCWvGurNJzFRHQPh66Feu0z/OYr
         9AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JcRIPbkub/tWCLWv2xyN/6N5F607AAwY0FQRtWmXUeA=;
        b=WKm2qZg1hL1mihBkvgwKc77aCEli2XtNTRin3EAU97wXRswpdmlHRIkebP+MkJdXIC
         hOvgkc5rjNXAOhCMif47khoCiliNNTvWTTVDVYykfmI21kpbr35/LzYZ+xRowxoUsIIr
         6YWDFqENq7B+9DxnYnBv5a1YfT4iHmyxZZMRSba2KgELoZjP8mhZ7EqgfHQKfehUUExF
         6WFMR2mrm9HHAt88R/o/21XtF+EFC1OIOxBRKEDyBmNPcUywjONii8ej7VfhWlsadD6D
         8rQhLTPUwMEeR0bJ+l1iGpmaxRJ3t740a6AKNopSKmXpQnocO5vUD6gYYq7LOPEdVeFZ
         G3Ow==
X-Gm-Message-State: APjAAAXHQVyyEshGlMx5+KPVjWJfiflyVprrFm3nu+onHql5KJ1N/dp+
        XUEdHoLneFnV6hPTK4qOlvLqVjbnR/Y=
X-Google-Smtp-Source: APXvYqz4cpaQhSrx7z63SDuOGFvrj5XzI/Ry023qsgX7Z6Wknq4LZXkbYdBRvnz+HNjoGYRxXi+zWg==
X-Received: by 2002:a63:7c55:: with SMTP id l21mr18809439pgn.57.1580120122163;
        Mon, 27 Jan 2020 02:15:22 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:15:21 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 12/22] staging: exfat: Rename variable "ClusterSize" to "cluster_size"
Date:   Mon, 27 Jan 2020 15:43:33 +0530
Message-Id: <20200127101343.20415-13-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "ClusterSize" to "cluster_size" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 8a4668d301fc..8787cb3203ba 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -243,7 +243,7 @@ struct dev_info_t {
 
 struct vol_info_t {
 	u32      fat_type;
-	u32      ClusterSize;
+	u32      cluster_size;
 	u32      NumClusters;
 	u32      FreeClusters;
 	u32      UsedClusters;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 695c8793fe5f..b9445bef0e6d 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -495,7 +495,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 		p_fs->used_clusters = p_fs->fs_func->count_used_clusters(sb);
 
 	info->fat_type = p_fs->vol_type;
-	info->ClusterSize = p_fs->cluster_size;
+	info->cluster_size = p_fs->cluster_size;
 	info->NumClusters = p_fs->num_clusters - 2; /* clu 0 & 1 */
 	info->UsedClusters = p_fs->used_clusters;
 	info->FreeClusters = info->NumClusters - info->UsedClusters;
@@ -3349,7 +3349,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	} else {
 		info.fat_type = p_fs->vol_type;
-		info.ClusterSize = p_fs->cluster_size;
+		info.cluster_size = p_fs->cluster_size;
 		info.NumClusters = p_fs->num_clusters - 2;
 		info.UsedClusters = p_fs->used_clusters;
 		info.FreeClusters = info.NumClusters - info.UsedClusters;
@@ -3359,7 +3359,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	}
 
 	buf->f_type = sb->s_magic;
-	buf->f_bsize = info.ClusterSize;
+	buf->f_bsize = info.cluster_size;
 	buf->f_blocks = info.NumClusters;
 	buf->f_bfree = info.FreeClusters;
 	buf->f_bavail = info.FreeClusters;
-- 
2.17.1

