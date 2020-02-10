Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1765E15829B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBJShL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:37:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35107 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJShK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:37:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so4361055pgk.2;
        Mon, 10 Feb 2020 10:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27GS09eY1gZMvn8ykuFSTchiyR/0xlUbhClAe0LrabY=;
        b=ttfeDu8Zq4PNzrvi+BAn5afh1cmsVKs6haYWiAPBxQZNCe/zQSIihKZG0Pa/WzK1Er
         i9CqtMcAbBu5nv/440DEgGKrTiaAeRqy5hEkCWyeCCRwTMXEl1Apl6/dZcEtEHPiUqdh
         mNUh5JghIJSUW2+hQgc3HBAzutxUazNUYCu+drSFqfpG6jmmmANGYbwRTh3uSgAVrEN6
         SJS234pDg8Ukh2FuAondiOkH/7Oc1/D66HxZCOIdNg6IL98Sds/XPgd2uU43dfROpse2
         ICcyeUKr/M+xLzNtA8IAd4x0M4b0gwNTSTKWdE8tViSs/JKXfnNsARyrRyEd4a52L8nh
         i/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27GS09eY1gZMvn8ykuFSTchiyR/0xlUbhClAe0LrabY=;
        b=gnCLL67ECF6oAsBcs/JSSXaaXWzUHtvFKrlK7o41inJXCoyRJybsy9fwUTkBVye+Ri
         Da4AUgo/0XNtpaQxd4dGAmCfCGDauSWRx5uox1mGqpMkBmeJxMWwsazJmwUIER7K2wVP
         WGkc5iA/7sAXuQ1i5VgJDD3t1N7EzLyvDTE+jee4quc8LmjYDWP9mqKEe4fPR/doYf4B
         qECZN8Z2v9HOTv8oH+ZpTUPDor0Ln5fbPaqEJxgj/ttaiFPJgYaSJINBIYhpMCQ3Zeo0
         SmSAmQKIj8OJCl2MSfHp9sUFRXB7Jh1j8vqKEM8/4jVzun+xfUhA8FE101bcP1y5iDGE
         QWyQ==
X-Gm-Message-State: APjAAAW6XGy2DaEHAQzw/+W+3foGt/+pT8X2b2lpNL/ZnLJt2W18jh1h
        bhhq298HxTwDix537GLsRSU=
X-Google-Smtp-Source: APXvYqwtTrWXOaXFI4zLrvcX0Q/Ed+c2CsDmDrBwmpAQ640g+GzKUygWUNrHGvfT/Xmqx5u440L/Kg==
X-Received: by 2002:a63:5f10:: with SMTP id t16mr3111488pgb.222.1581359829628;
        Mon, 10 Feb 2020 10:37:09 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:37:09 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 08/19] staging: exfat: Rename variable 'FatType' to 'fat_type'
Date:   Tue, 11 Feb 2020 00:05:47 +0530
Message-Id: <20200210183558.11836-9-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "FatType" to "fat_type"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 96e1e1553e56..43c40addf5a5 100644
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
index 472a6c8efcbb..7b5be94a0bb7 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -494,7 +494,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	if (p_fs->used_clusters == UINT_MAX)
 		p_fs->used_clusters = exfat_count_used_clusters(sb);
 
-	info->FatType = p_fs->vol_type;
+	info->fat_type = p_fs->vol_type;
 	info->ClusterSize = p_fs->cluster_size;
 	info->NumClusters = p_fs->num_clusters - 2; /* clu 0 & 1 */
 	info->UsedClusters = p_fs->used_clusters;
@@ -3345,7 +3345,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 			return -EIO;
 
 	} else {
-		info.FatType = p_fs->vol_type;
+		info.fat_type = p_fs->vol_type;
 		info.ClusterSize = p_fs->cluster_size;
 		info.NumClusters = p_fs->num_clusters - 2;
 		info.UsedClusters = p_fs->used_clusters;
-- 
2.17.1

