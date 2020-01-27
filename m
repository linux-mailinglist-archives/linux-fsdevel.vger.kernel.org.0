Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE3414A1BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgA0KPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:15:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42016 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbgA0KPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:15:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so4686041pfz.9;
        Mon, 27 Jan 2020 02:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2ffH0K8BFmkOC/vLFRY737ndfJQRlqPy+w9ONVEocJo=;
        b=tpiOhf+569/miNYtRdQIQc0t5PkG61c9/QOKwLgZLiok6RPr5VJQq/nHvYYeJBJa/3
         PQhgiqwJaR7JM9sIKZozopyZCuvLqCrivfOHKszGF80AR1CQjywguqt4IRcEbnUnLaf/
         q5YncfI/H2rwGi1DnaIRVCjm8BAQu1OHKCg4HIhwFFVpdhfrDootcccKHqhYoL9mudmX
         fPKAFRUZpfCd2567jSaSgbNLD7+yFVleJFdzmjPEqsD3YG8796uvaFDmjlRIuB5nFSPt
         gKe6Zqy/Zt7UJp0d7e3Br7kXhJh6VQ3eCkf24Y9IGpyTyeqwB4foMFfSPoj/0NC7cODB
         HHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2ffH0K8BFmkOC/vLFRY737ndfJQRlqPy+w9ONVEocJo=;
        b=n8te42vFqimW1EPtm3zt4+oIVLF/kx0B7JOcbCT8pEyAEccUgBOWwD8dYCxUsFQ7m7
         5YTx+ZljFwn5B8ln2/jDPMVU2DxIKyrzRT4XIpRoINX6TjcIoCkmwODNMTDxuun0eriT
         GwM+IjWjgmN3icT7fotRwWqYT8Qv3k9euXW+ASNPLuM2QnnZ5hrlf3wY70y9IGqFW7hi
         n+UBChb3M5/1oe4In7stC5EjvOZaPJqtZQgY1R6zmCceGLxdWAg2izLKWzMIODEzsKFV
         I1AkbPF8P/CCOlN+wR39EriUd1+KhWQa9CSWE377tabsyFCP9SCivap503zSpCkAtchb
         YDZQ==
X-Gm-Message-State: APjAAAXIEyJ2rILRPWn2HqWgYamtbcNe9nTs0cnPV2JpaJIqqwBKigs7
        MKjDqvEOfxuhb1v1aK0Hf2Q=
X-Google-Smtp-Source: APXvYqyeU4HI+w6Zs4rhoa0d+PXReVp8dIkqtpHlKYuVreJmGlb4KefHZiLlPCdD8iv/YWTXQSPw1Q==
X-Received: by 2002:a63:1d1a:: with SMTP id d26mr17685427pgd.98.1580120131638;
        Mon, 27 Jan 2020 02:15:31 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:15:31 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 14/22] staging: exfat: Rename variable "FreeClusters" to "free_clusters"
Date:   Mon, 27 Jan 2020 15:43:35 +0530
Message-Id: <20200127101343.20415-15-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "FreeClusters" to "free_clusters" in
exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 36baa4c9a98a..4cc5c1914864 100644
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
index c5edf09f1123..7a8b876414bd 100644
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
@@ -3352,7 +3352,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 		info.cluster_size = p_fs->cluster_size;
 		info.num_clusters = p_fs->num_clusters - 2;
 		info.UsedClusters = p_fs->used_clusters;
-		info.FreeClusters = info.num_clusters - info.UsedClusters;
+		info.free_clusters = info.num_clusters - info.UsedClusters;
 
 		if (p_fs->dev_ejected)
 			pr_info("[EXFAT] statfs on device that is ejected\n");
@@ -3361,8 +3361,8 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
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

