Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 424BC14CEE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 18:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgA2Q7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 11:59:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33451 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgA2Q7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:59:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so85546pgk.0;
        Wed, 29 Jan 2020 08:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2KjaafwE2g+wJHMSZXmaiaKXLE2m0dx98a6SWPRLseM=;
        b=QnBQTRAdZ/x2siJeZQ+z/iHOGDk09zkSmwAZy3M5Hew3nw4tVVz8FDsM13lyCwkKpg
         GWKUddVJl5hdPQChCzVp7HAgclYvZwk/1KZGV5stS+abF+KLuLvCp/vORffkMN/QAgej
         CgGdjlar+W80UtxhhwkL92LrnQFdBvQghK22fcjHBV+6XYS+URqAcjz+mx5WKKq30+ro
         GdrTQ6fBT7RUM10o5kXLYmkXADDfwTsHjhFx8/mH46thOJ80AkHctZ/t8K6/4NNyDKYY
         gk9m2YbK1VjZMFq2twKCxjMrJqZJ1i7APYAEEv25+Kh6Y9aL8jo6UOtoqaCZS4uV+QJC
         QHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2KjaafwE2g+wJHMSZXmaiaKXLE2m0dx98a6SWPRLseM=;
        b=nJz4pOJitfuj3ggPwzLGgbrcL3Ft8qzRwnJffAl1auz12auhPZPFk4QujFOrPYqEvP
         jgcgOkf12pEAKUveQGwshodGuFcXimEFOTMP6OV9ac4MglqxVN6v2w5N6iTwK8ee/Ppn
         moNkPTWhkodjixp5niJquFvHjFQ8rsVitr3jgHdM5B6j6tyGTnHo89zYx2Y327rZCEWU
         q1TGgpf7irQ8TvGzWkwr/A+too15LhYRxmBCymLs2EVdEmm7WYbgHNVyRo9igpc6A/2J
         YOdr1a0Coo+7eeJrf37uoX2t5MJ4UiqRRH8M3Pa0+Co/5LS8qMoR7VOGe2zbMHVEOBAW
         k5hw==
X-Gm-Message-State: APjAAAUpPDLdvIb2cP+TuXu82qDIlfBKUrPlLni4ljogP9DqKtW/X1bF
        a0gR1UDWuVt1rE8aM+I97FM=
X-Google-Smtp-Source: APXvYqwNkY7ypwOk+TsF6h58m3fPoIAnGWMdlpqLD4CcSNyWYKt94jpOvrR5EgZbZ5e2eN9iL23/6A==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr504527pff.240.1580317193500;
        Wed, 29 Jan 2020 08:59:53 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.08.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:59:52 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 11/19] staging: exfat: Rename variable 'FreeClusters' to 'free_clusters'
Date:   Wed, 29 Jan 2020 22:28:24 +0530
Message-Id: <20200129165832.10574-12-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrences of identifier "FreeClusters" to "free_clusters"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 3fd234a323fb..2c42519d5eba 100644
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
index d8de39917bc0..335bf39aa171 100644
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

