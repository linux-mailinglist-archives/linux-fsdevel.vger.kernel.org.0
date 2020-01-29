Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B691814CEDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 17:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgA2Q7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 11:59:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42409 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgA2Q7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:59:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so56699pgb.9;
        Wed, 29 Jan 2020 08:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PJt29fpMlf5QIWbEwlo7IH62d5FhRNTDbUVvQF2baUI=;
        b=gh2RK85B8NOwK3idUEi4OtRe0/WcrHmWcPvrHandlHXU9jkb9hTyq93hIQL+DMaSbs
         NFtEUNTffx/ZEXUWaXUXKvV75dVqzYGuQ/zx8f2ZY93GdTFCiZexoQKAHL31Ggl5SalD
         MisaJ7HRj+uPBftcOeHPW0AFcAxUrOl3A/KFUtRionIqhUcljBJtp48LAHhWjzD9Ix3I
         jEGRf0m1/yTvgKvpMBcdZD6fFTJmhnCTA6EG0DeiuqBVNWI5s/b+YNei+Fsq6A61MkaN
         DDV45wbfRkBDUTek0Jx50NTARF5RaByLEOs647eAD8ViFGSZNq0KRvce+tXoz+YSBIy5
         3Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PJt29fpMlf5QIWbEwlo7IH62d5FhRNTDbUVvQF2baUI=;
        b=ErBWUakIrESFwRGo79LgSgW8mNulxnF8iwnzTEX/AlYl4yeHwSwIjtyPiUv90bUEaS
         zFIo0PT9PXD3tYPF2FsaSzmzYwroGyNz66C8OG1mVFc1z7ksi+zsqXYCy7E/F6l7YTXu
         qPTEHs8O4Gt1yoy4tYNTeUUSI3j3kzDDwZNfneOQ3VKIn7bMKObSYXXvYKVBApBeSKqo
         NtCszFc6dW/nUbyIkY/ovpnVb1MKfDYNoQ+zffpiGrTTNQzxEKoypUl1Psz8xlvWItUY
         PtpOab9FX48oF2R4+yzqnjf2n1GPbXNWKuCz9Vx61Lf9o3OpKZpO4thdUFwopNtomIwk
         JzSA==
X-Gm-Message-State: APjAAAUc2sYE0uLu0K84z1nDu7N29tTqrsq1BPVhJIVJMlO7usGUKLEn
        H4sNqdK590lm0PHcmzigRsc=
X-Google-Smtp-Source: APXvYqzdQ7nUMbDaA3I6UMgsFCb/dQporMjaJNcyYVfVE/rPc5JH6NfgVyi0Rk/m+wfum951itB5Sw==
X-Received: by 2002:a63:b305:: with SMTP id i5mr24306579pgf.25.1580317182608;
        Wed, 29 Jan 2020 08:59:42 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.08.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:59:42 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 09/19] staging: exfat: Rename variable 'ClusterSize' to 'cluster_size'
Date:   Wed, 29 Jan 2020 22:28:22 +0530
Message-Id: <20200129165832.10574-10-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrences of identifier "ClusterSize" to "cluster_size"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 8e01f011ef27..c9d9791312f0 100644
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
index 6278fc3eac19..ac6f38508d2b 100644
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

