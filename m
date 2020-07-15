Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41160220E6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 15:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgGONuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 09:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgGONuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:50:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18DDC061755;
        Wed, 15 Jul 2020 06:50:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cm21so3103668pjb.3;
        Wed, 15 Jul 2020 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hRkHds1NU1aAj2mUyg9AefWENY97EFcwEhOvlQBvAKI=;
        b=pWaJrQSldw39pjxlOdwaKTkIxxaKzDd4ZxG0tqbp1GB3mRAkMTmBA0jtlp6bAGgTSU
         GgVzohKuKo/TfEfX2Ei6K2SXDRpbmwRYuzFCxY7rcIjA1+li0MF8JPTKUoZ7IxMBljDL
         JvaqQ1fpJHcR5gmIujuUgVUxcwwc4sCalhmzTUs5j+tUUQBP7qFE6PpCcHhiwA8VCu04
         wcDW6kz6yQAGqqJqZZBULuWAvge1DKFp+Cv9IohNu+/idyG32HxhLK1tRc2HROEnwjSP
         L/VwxQMXznSL0PvfGv3fe3uqWg40CmOXEgSp5FKpdqVDia+mxNwxhqtski5ooBLP4mBM
         x6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hRkHds1NU1aAj2mUyg9AefWENY97EFcwEhOvlQBvAKI=;
        b=NSBsZFugBAf6KzxDtswnO65KF1+P6kmz0GznfQivy+rkHsKqdwOUpjzpUcNjXH0QCJ
         3XaAvHEe3fvNEVmKJ0H1SQQujNsTI7Y84jRRpjTBg4CxPu79KMIV7bslTr3IvnAOzIht
         baUlbvtSXPIu3SRF9GccZCge42vBSS8CG6QPUlvDkvqQifoLWaAY/nIcW2nEjkH6y4I7
         8r8A9FjXfI3vZ3H311wUAsBXouWVs0XrBdqNeUxOKE0vIjKktBJc5ubFSv1ML4m0qyl2
         AOZeIGKZDOtkKpQP39VqVxmKULPzUwcOlSjh9qdTL2fSE3is8MU9pperH3qF4tljWqEV
         MQ9Q==
X-Gm-Message-State: AOAM5325ZlQpyp+Uq4L+ZmJMpdTTw0CKawztwvNpU8VklC6ItNJaEGeF
        xc5PTRlgYeXX6Co9Jj9hpqyevwp8
X-Google-Smtp-Source: ABdhPJxwp+fXlmVhFcSGVSrfWttv0T9qrX7cyZMRH9nprZKuy53DxC55Zw0pQl3hlh4gr1o4To4C1w==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr8654284plo.57.1594821011393;
        Wed, 15 Jul 2020 06:50:11 -0700 (PDT)
Received: from ubuntu.localdomain ([220.116.27.194])
        by smtp.gmail.com with ESMTPSA id y9sm2205998pju.37.2020.07.15.06.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 06:50:10 -0700 (PDT)
From:   youngjun <her0gyugyu@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        youngjun <her0gyugyu@gmail.com>
Subject: [PATCH] exfat: change exfat_set_vol_flags() return type void.
Date:   Wed, 15 Jul 2020 06:50:00 -0700
Message-Id: <20200715135000.86155-1-her0gyugyu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

exfat_set_vol_flags() always return 0.
So, change function return type as void.

Signed-off-by: youngjun <her0gyugyu@gmail.com>
---
 fs/exfat/exfat_fs.h |  2 +-
 fs/exfat/super.c    | 15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 7579cd3bbadb..2130f62bf518 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -383,7 +383,7 @@ static inline int exfat_sector_to_cluster(struct exfat_sb_info *sbi,
 }
 
 /* super.c */
-int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag);
+void exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag);
 
 /* fatent.c */
 #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu)
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 253a92460d52..dc05935cb88f 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -58,17 +58,16 @@ static void exfat_put_super(struct super_block *sb)
 static int exfat_sync_fs(struct super_block *sb, int wait)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	int err = 0;
 
 	/* If there are some dirty buffers in the bdev inode */
 	mutex_lock(&sbi->s_lock);
 	if (test_and_clear_bit(EXFAT_SB_DIRTY, &sbi->s_state)) {
 		sync_blockdev(sb->s_bdev);
-		if (exfat_set_vol_flags(sb, VOL_CLEAN))
-			err = -EIO;
+		exfat_set_vol_flags(sb, VOL_CLEAN);
+
 	}
 	mutex_unlock(&sbi->s_lock);
-	return err;
+	return 0;
 }
 
 static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
@@ -98,7 +97,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
+void exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct boot_sector *p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
@@ -106,7 +105,7 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 
 	/* flags are not changed */
 	if (sbi->vol_flag == new_flag)
-		return 0;
+		return;
 
 	sbi->vol_flag = new_flag;
 
@@ -114,7 +113,7 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 	 * if this volume has been mounted with read-only
 	 */
 	if (sb_rdonly(sb))
-		return 0;
+		return;
 
 	p_boot->vol_flags = cpu_to_le16(new_flag);
 
@@ -128,7 +127,7 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 
 	if (sync)
 		sync_dirty_buffer(sbi->boot_bh);
-	return 0;
+	return;
 }
 
 static int exfat_show_options(struct seq_file *m, struct dentry *root)
-- 
2.17.1

