Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A4514A1B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgA0KP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:15:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36246 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbgA0KP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:15:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so4912219pgc.3;
        Mon, 27 Jan 2020 02:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B8GDmRl8TepNTcDzJT5ICA0rDYFD1xF6+jSjLMlbtuc=;
        b=afqek/uATyxIPblcJJgh6QUg8ByugTFUNdXyKY2aQ2ZL4ojwVOJ3UR/aFu5eU+majb
         v3S12LTErNzYcH9cAjcXMOqWhCGsP55ru6dd2ze4aWibktiyojGAlKH04UdRsYYSY5Io
         cfN++8wDqXREN09r7ipWJiYR0Ev+9xSYu518rWSSaHBkgbYlYStHVpDqR/a+MJEtW9LY
         eflmVm019i8UFA7E1cvi/iPJQJbO0gy/pnUWBUco7vKfO02ncwYfuXYh7bstItSJdR3z
         +UnlvP3MHtEAguNOy3fIb+EIweWYPsRq4v/3jr47KXfaRpHg4yZ/HjD+L8XSfUbzRMmu
         fSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B8GDmRl8TepNTcDzJT5ICA0rDYFD1xF6+jSjLMlbtuc=;
        b=AZt3WzYVivNi0ouqi9TSW0UC/0Iini5L7TxMbRoUZOFk13Q+Vpphe3+HHChcMENCOP
         LMSt8UdQorUa+7bhHC6rBRZJfKWM41Y01VaoiUFJgd9Z3xLr6I68sTTzBXHz6eWJ/KRY
         N5P1fLLOe0NlBB1J4pnp1gJGT6kxATDR7hUTs24I8Ggft7PwD7igSQb9wyYfTTNa0n3F
         H9sUHaJHgOCZq3y6LOXotJfdIRrzNiV2DYE1iMNg6hqfyRX71FTotjERzA/dS3PNT3KY
         cm7PgGwkkTOmFRxzDgoHPEo9klLP82ESBkMeh+5eZ4xNpKV01WeEB+ohI/h2bXKiXi5y
         9XLA==
X-Gm-Message-State: APjAAAWjEvzpdTn9cyDdKBkhkHkNfqLuijF4SncIstB0mozpsovUGJNR
        jji51Xy2zNViuW0THYM5SjA=
X-Google-Smtp-Source: APXvYqy3v+pKWVgDjy9WH7ZrBlVym3xhNyVbZysFPRgp0oPfzBUtsPSjwIwNYCvtCug6+OaUrOqqvA==
X-Received: by 2002:a63:5818:: with SMTP id m24mr18839235pgb.358.1580120126661;
        Mon, 27 Jan 2020 02:15:26 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:15:26 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 13/22] staging: exfat: Rename variable "NumClusters" to "num_clusters"
Date:   Mon, 27 Jan 2020 15:43:34 +0530
Message-Id: <20200127101343.20415-14-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurreces of "NumClusters" to "num_clusters" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 8787cb3203ba..36baa4c9a98a 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -244,7 +244,7 @@ struct dev_info_t {
 struct vol_info_t {
 	u32      fat_type;
 	u32      cluster_size;
-	u32      NumClusters;
+	u32      num_clusters;
 	u32      FreeClusters;
 	u32      UsedClusters;
 };
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index b9445bef0e6d..c5edf09f1123 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -496,9 +496,9 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 
 	info->fat_type = p_fs->vol_type;
 	info->cluster_size = p_fs->cluster_size;
-	info->NumClusters = p_fs->num_clusters - 2; /* clu 0 & 1 */
+	info->num_clusters = p_fs->num_clusters - 2; /* clu 0 & 1 */
 	info->UsedClusters = p_fs->used_clusters;
-	info->FreeClusters = info->NumClusters - info->UsedClusters;
+	info->FreeClusters = info->num_clusters - info->UsedClusters;
 
 	if (p_fs->dev_ejected)
 		err = -EIO;
@@ -3350,9 +3350,9 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	} else {
 		info.fat_type = p_fs->vol_type;
 		info.cluster_size = p_fs->cluster_size;
-		info.NumClusters = p_fs->num_clusters - 2;
+		info.num_clusters = p_fs->num_clusters - 2;
 		info.UsedClusters = p_fs->used_clusters;
-		info.FreeClusters = info.NumClusters - info.UsedClusters;
+		info.FreeClusters = info.num_clusters - info.UsedClusters;
 
 		if (p_fs->dev_ejected)
 			pr_info("[EXFAT] statfs on device that is ejected\n");
@@ -3360,7 +3360,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = info.cluster_size;
-	buf->f_blocks = info.NumClusters;
+	buf->f_blocks = info.num_clusters;
 	buf->f_bfree = info.FreeClusters;
 	buf->f_bavail = info.FreeClusters;
 	buf->f_fsid.val[0] = (u32)id;
-- 
2.17.1

