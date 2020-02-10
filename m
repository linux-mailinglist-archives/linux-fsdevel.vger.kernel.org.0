Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDA61582A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBJShV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:37:21 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40491 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJShU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:37:20 -0500
Received: by mail-pj1-f67.google.com with SMTP id 12so111910pjb.5;
        Mon, 10 Feb 2020 10:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HS62S5V7Qa07ZQUMT3Q93j8iWGJHMLo+fJYA8CxCock=;
        b=sANQpXsyHmm/d/GWSP7Owb/st6xVfVjs+LDYcZsCf5Bkxukflb2YMvRx6mUTeC/iXk
         BR7doZv8Zfc6hmqMpBpZzA0VKtvFlHqCAsGZjvzA87LL2mhZTcQYRY83egGiB+AvRN++
         pLK90VCEqf2K02OjeE1L6WMTZPVMtQ/WiIvcUIgIhayK+pLjwt51nT7fpPo2WNHqwquH
         uk1DklkNW+P8/MT5qAGxVa8jYNDcMI0fHWavTGmvcWbjRBREDoawRUnI7QVM3N2axFV9
         aHJDRqpDOmFb0yHeIGoayFMwieTr+Mdjr4jJFlMaC88iqT11YB33/x5dF6z9oDR3kWdc
         S+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HS62S5V7Qa07ZQUMT3Q93j8iWGJHMLo+fJYA8CxCock=;
        b=nM5MbplM2PJwsASM9r8MiTFo7GNjUCtO68bA5sgiH2bURSpZOb7F6LaJH/OpvBkaqe
         Tnfg2BpY/2k16tRIDc0WsbKdLkKAEyFq5LElEmiAPJ/UecmLhV0mX0bFWCiSEE0HlvZ2
         hgrAszNynF1JxuAB2Buug86rgzEyGR4j0aqt9kNV2wJhP/aaaicZAgbHvbuef29QmI1z
         Mc+GrVRsT6PW0Um9XpIPU0aihRzSkMZ3tTYKy4UBoba34WdWgosmVmlgPRgc+HjF+Env
         ievc3GXp8YPQxxh0kZyoJHeH/iuYinnMldqFCKwgS3jD5Q8A5sMkuM0ImNdnW+277M4s
         Oh2g==
X-Gm-Message-State: APjAAAXjG/H4RVm9oktOW8ROd1UICkGhC6ByWW63/dsKG/nQ5N+vlqiW
        /JpG5Cr5yWryQDFGYteseRw=
X-Google-Smtp-Source: APXvYqzSTCVLpw41wYXgoo9QWkGLg6yuI6kZG3p2+few/NSO+vSp2E5FIKRYxdj+96eNyvrCSRA09A==
X-Received: by 2002:a17:902:b210:: with SMTP id t16mr13861164plr.65.1581359839948;
        Mon, 10 Feb 2020 10:37:19 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:37:19 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 10/19] staging: exfat: Rename variable 'NumClusters' to 'num_clusters'
Date:   Tue, 11 Feb 2020 00:05:49 +0530
Message-Id: <20200210183558.11836-11-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences identifier "NumClusters" to "num_clusters"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index c6e3981cc370..df84a729d5d5 100644
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
index cac5631d0f11..59e18b37dd7d 100644
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
@@ -3347,9 +3347,9 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
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
@@ -3357,7 +3357,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = info.cluster_size;
-	buf->f_blocks = info.NumClusters;
+	buf->f_blocks = info.num_clusters;
 	buf->f_bfree = info.FreeClusters;
 	buf->f_bavail = info.FreeClusters;
 	buf->f_fsid.val[0] = (u32)id;
-- 
2.17.1

