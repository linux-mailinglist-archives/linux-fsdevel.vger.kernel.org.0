Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE320E119D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 07:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbfJWF2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 01:28:39 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:60946 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389463AbfJWF2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:28:38 -0400
Received: from mr4.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9N5Sbcv003456
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:37 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9N5SWFa021458
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:37 -0400
Received: by mail-qt1-f197.google.com with SMTP id j18so12576868qtp.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2019 22:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3R3TYJQENxlxM/7hiSPDOzoGGvmVuWM26HSA4gktLsc=;
        b=XB/Lip33jqr6WjAOZlobP1ufHfklIC4VRwX3S3gmPn2qpUwos8mfhhi0ZtbENIuXQ5
         JpCcHA2um0x1rJukxLy8HmSRCkCOY62AWToUOXbc3+VK2XAddvTuifdLtP7BtHHz9ERx
         +ZMkkD8AZ2mTKofGk3cftore7nILr6S2swoYySXyFO2JuOpsL6/9isfdUy3CXV3f4yEk
         7qoWFdqu7Oxwmr+P+OU/R8vin2zT2153htqlVYEGRGWoJS3VSgwiRNXvwKvKAR53OVHQ
         /gWLv6PlfuJIavVybwDWkX+lRAejHliEGGvckb4QQQRh3d9pCRzyhlQDGIgJIdHv9M9Z
         mjZQ==
X-Gm-Message-State: APjAAAU3mtfGFbgmsh8soMJvyHvlMe8RfT0Qw9PJ1vfFtki2F/j6nXNl
        wwbLdlCASXAb5ZUukaFZV39xVqA3CBSEV7hHjYWbZQ+ba2/juQZZKb7tEjbUdCzncHdWD7aI/ID
        KqUbzlQfWzGGFVG9G9NKSDmtJ6jIixucT0AyS
X-Received: by 2002:ac8:70c3:: with SMTP id g3mr7202614qtp.391.1571808512063;
        Tue, 22 Oct 2019 22:28:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzy4r7y16DC8h4ydIFPzLdAGCvDsekngAhlepEpIYK5p7QCs9OYpm9liB0aPVEfxDo6Cc6ONA==
X-Received: by 2002:ac8:70c3:: with SMTP id g3mr7202598qtp.391.1571808511686;
        Tue, 22 Oct 2019 22:28:31 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 14sm10397445qtb.54.2019.10.22.22.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 22:28:30 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valdis.Kletnieks@vt.edu
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: exfat: Clean up static definitions in exfat_cache.c
Date:   Wed, 23 Oct 2019 01:27:48 -0400
Message-Id: <20191023052752.693689-6-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
References: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move static function bodies before first use, remove the definition in exfat.h

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |  4 --
 drivers/staging/exfat/exfat_cache.c | 94 +++++++++++++++--------------
 2 files changed, 48 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index dbd86a6cdc95..654a0c46c1a0 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -768,17 +768,13 @@ void buf_init(struct super_block *sb);
 void buf_shutdown(struct super_block *sb);
 int FAT_read(struct super_block *sb, u32 loc, u32 *content);
 s32 FAT_write(struct super_block *sb, u32 loc, u32 content);
-static u8 *FAT_getblk(struct super_block *sb, sector_t sec);
-static void FAT_modify(struct super_block *sb, sector_t sec);
 void FAT_release_all(struct super_block *sb);
-static void FAT_sync(struct super_block *sb);
 u8 *buf_getblk(struct super_block *sb, sector_t sec);
 void buf_modify(struct super_block *sb, sector_t sec);
 void buf_lock(struct super_block *sb, sector_t sec);
 void buf_unlock(struct super_block *sb, sector_t sec);
 void buf_release(struct super_block *sb, sector_t sec);
 void buf_release_all(struct super_block *sb);
-static void buf_sync(struct super_block *sb);
 
 /* fs management functions */
 void fs_set_vol_flags(struct super_block *sb, u32 new_flag);
diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
index e1b001718709..e9ad0353b4e5 100644
--- a/drivers/staging/exfat/exfat_cache.c
+++ b/drivers/staging/exfat/exfat_cache.c
@@ -193,6 +193,50 @@ void buf_shutdown(struct super_block *sb)
 {
 }
 
+static u8 *FAT_getblk(struct super_block *sb, sector_t sec)
+{
+	struct buf_cache_t *bp;
+	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
+
+	bp = FAT_cache_find(sb, sec);
+	if (bp) {
+		move_to_mru(bp, &p_fs->FAT_cache_lru_list);
+		return bp->buf_bh->b_data;
+	}
+
+	bp = FAT_cache_get(sb, sec);
+
+	FAT_cache_remove_hash(bp);
+
+	bp->drv = p_fs->drv;
+	bp->sec = sec;
+	bp->flag = 0;
+
+	FAT_cache_insert_hash(sb, bp);
+
+	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
+		FAT_cache_remove_hash(bp);
+		bp->drv = -1;
+		bp->sec = ~0;
+		bp->flag = 0;
+		bp->buf_bh = NULL;
+
+		move_to_lru(bp, &p_fs->FAT_cache_lru_list);
+		return NULL;
+	}
+
+	return bp->buf_bh->b_data;
+}
+
+static void FAT_modify(struct super_block *sb, sector_t sec)
+{
+	struct buf_cache_t *bp;
+
+	bp = FAT_cache_find(sb, sec);
+	if (bp)
+		sector_write(sb, sec, bp->buf_bh, 0);
+}
+
 static int __FAT_read(struct super_block *sb, u32 loc, u32 *content)
 {
 	s32 off;
@@ -441,50 +485,6 @@ int FAT_write(struct super_block *sb, u32 loc, u32 content)
 	return ret;
 }
 
-u8 *FAT_getblk(struct super_block *sb, sector_t sec)
-{
-	struct buf_cache_t *bp;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	bp = FAT_cache_find(sb, sec);
-	if (bp) {
-		move_to_mru(bp, &p_fs->FAT_cache_lru_list);
-		return bp->buf_bh->b_data;
-	}
-
-	bp = FAT_cache_get(sb, sec);
-
-	FAT_cache_remove_hash(bp);
-
-	bp->drv = p_fs->drv;
-	bp->sec = sec;
-	bp->flag = 0;
-
-	FAT_cache_insert_hash(sb, bp);
-
-	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
-		FAT_cache_remove_hash(bp);
-		bp->drv = -1;
-		bp->sec = ~0;
-		bp->flag = 0;
-		bp->buf_bh = NULL;
-
-		move_to_lru(bp, &p_fs->FAT_cache_lru_list);
-		return NULL;
-	}
-
-	return bp->buf_bh->b_data;
-}
-
-void FAT_modify(struct super_block *sb, sector_t sec)
-{
-	struct buf_cache_t *bp;
-
-	bp = FAT_cache_find(sb, sec);
-	if (bp)
-		sector_write(sb, sec, bp->buf_bh, 0);
-}
-
 void FAT_release_all(struct super_block *sb)
 {
 	struct buf_cache_t *bp;
@@ -510,7 +510,8 @@ void FAT_release_all(struct super_block *sb)
 	up(&f_sem);
 }
 
-void FAT_sync(struct super_block *sb)
+/* FIXME - this function is not used anyplace. See TODO */
+static void FAT_sync(struct super_block *sb)
 {
 	struct buf_cache_t *bp;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -704,7 +705,8 @@ void buf_release_all(struct super_block *sb)
 	up(&b_sem);
 }
 
-void buf_sync(struct super_block *sb)
+/* FIXME - this function is not used anyplace. See TODO */
+static void buf_sync(struct super_block *sb)
 {
 	struct buf_cache_t *bp;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-- 
2.23.0

