Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4311614CEDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 17:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgA2Q7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 11:59:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34089 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgA2Q7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:59:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so176726plt.1;
        Wed, 29 Jan 2020 08:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ZbBhIi0riG/FffoHPYCh51NnFjjYqXGbFi/rzBY4g8=;
        b=PanbDHou8mhsrOBc69UOZyTngiEm8iDn5oseDnSAz+rMw8vbwMrDAaSir43qohiOYf
         IBpLw/I1Jiu27c99X6Qhlx2ZoFkAH4WE95oQ3SChbL9B7DAZaNIS6mV18Iu/5zlZeoOp
         iJeX427lwXFFiLFVYHcPwMqZwZAbRpPoAhROajvJWv9sLleTzOqqeRslPFU5fmRYjH4E
         9XzeDtWLlOgBmf0V51vYMfQ3k//tJJhG4UNRcArRq/H2O1dokzfUbKRRg2cE8Ut5i+CI
         Z92auWIftgpF7l8k78ygxTe2ZfYi+tYCOrwPlWSRSR+V3r+6GZNI7UQ4xbhcSQ8kE7Sy
         eDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ZbBhIi0riG/FffoHPYCh51NnFjjYqXGbFi/rzBY4g8=;
        b=Wvmj1fnKqArNTQjPaCbtregFmyS4bP3QiSd3kJ469IahSRWH9tvJD4e+ZuQ8uziFN5
         g0/0xCxXatnv8Ald22XaaLQ3/KMJ7oaxWtO5qLTxVk2eWFQO+639mtjAni6etdHmzz29
         Fo+LbkquGO0z0nQGzzBHeM5G3fMUlvQYS8VFTD+83cIdOJQi3+LoWXB283MwK+F6Cdlb
         3aZ2co69t/JyIj7iPFv7IPoCClnoomNpzx8ZsGpiRlwDuEvUfg6D9v9jLJ6zlsRASqCe
         kayNdGwJ5dU4LDkjHj35nFhqQYEO6z5zo2E/tMSv3Ii8PvQFbZfg6G7nlhw6nUi3PvH6
         Ovow==
X-Gm-Message-State: APjAAAWt53tOnE2tUaiI+cfiBr6jvkxyu6JNjVPv2xdWWwVhwFj9lZ/u
        zfQiXQH0qoNyail7BQNKXXg=
X-Google-Smtp-Source: APXvYqwCjJDPtZFFe4m2zkyLFY91/aQnmcgFPFrJlbSY60+TzUbowjEIKyEw9282hQtPDF5v5/eHGw==
X-Received: by 2002:a17:902:6b82:: with SMTP id p2mr279070plk.259.1580317188504;
        Wed, 29 Jan 2020 08:59:48 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.08.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:59:47 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 10/19] staging: exfat: Rename variable 'NumClusters' to 'num_cluster'
Date:   Wed, 29 Jan 2020 22:28:23 +0530
Message-Id: <20200129165832.10574-11-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrences of identifier "NumClusters" to "num_clusters"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index c9d9791312f0..3fd234a323fb 100644
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
index ac6f38508d2b..d8de39917bc0 100644
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

