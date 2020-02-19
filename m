Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 950011649C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 17:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgBSQRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 11:17:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35552 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgBSQRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:17:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so301980pfa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 08:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Uy6UkLvPHbCZFb2G0DtVigJYqThbQGxt+hlDRaLD/UQ=;
        b=w9VPh/OOAHC9E9VFvJmLCc/TOWjFbMLZG1/5InWeEHD12l9q868DkpMO5zp7aoG3Ha
         rszRtkBZZ5YvkgDWq3I9I+TKWpkOBkJbH2dyzleehHPl+tXyCnhmcAQ8GdDYPCsX0nSO
         ZdlC3OWMAKxUDr7JqoZTIiAK9fJYvsTuJZgDIRnQW8+IahJPxoZ9aIDV9X2GtgVj8CBa
         0FYDDKTDVdMjznxuYVbmNFha/uLnvYZOJNjezDkmBc2FqnR00jfaiuHWH/6gr5teT1Ne
         JWW1G7ryfir6R68jKsNaYllh/u/FfKaevs/5VdkjFX9P0ajKwxdINyWCHjDXmhJkx32v
         zk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Uy6UkLvPHbCZFb2G0DtVigJYqThbQGxt+hlDRaLD/UQ=;
        b=PWNon9JZZaZdTibyxfeQO0slMe7tAQ0t5yw10Qf4XsulFATX7b6M67g/RoizJNMpQi
         mq75f+AunW90tWwUzbob2hHSk+zuVgtx9utePKL1gI3dlaQVZ7q2J+uXuo+g/j7I/jvl
         OT63XVXbV1qF5vJznCyAVWA9sD+L5DW5nYarxk3z9HLksoUmi6Twh6Pp6g2rlyTsCzFW
         qFL4L88d1OLPyi9hq8gZ97vmNLtRBTRY6efwLSPSWDkccFaLa4D76AJlkvzE7SNafvjk
         +0rhUZm4UqcxoJrrO7qrpjiZS7Y/ToukVf0iGcHkqZN6ZM2zg6JCvM+89JWVVSBcq+WI
         zWaw==
X-Gm-Message-State: APjAAAUC7wgKLSYZ89OuS5aKrywA8IB0nIi/Mur912t4O59TB+jip4dY
        brxEi4kE9gZNsWDss093rkJEqQ==
X-Google-Smtp-Source: APXvYqy9Eoe+mM9PUgWeyNvkRF6huxYBxkkZz6VqXZpZ/IPHOjItmusPH6NY1cjPY/WVTZmf/9xFLQ==
X-Received: by 2002:a63:ce4b:: with SMTP id r11mr29739694pgi.419.1582129069058;
        Wed, 19 Feb 2020 08:17:49 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id b42sm298534pjc.27.2020.02.19.08.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 08:17:48 -0800 (PST)
Date:   Wed, 19 Feb 2020 21:47:38 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: remove exfat_fat_sync()
Message-ID: <20200219161738.GA22282@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

exfat_fat_sync() is not called anywhere, hence remove it from
exfat_cache.c and exfat.h

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_cache.c | 19 -------------------
 2 files changed, 20 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index c4ef6c2de329..e36d01b6fdc9 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -647,7 +647,6 @@ s32 exfat_fat_write(struct super_block *sb, u32 loc, u32 content);
 u8 *exfat_fat_getblk(struct super_block *sb, sector_t sec);
 void exfat_fat_modify(struct super_block *sb, sector_t sec);
 void exfat_fat_release_all(struct super_block *sb);
-void exfat_fat_sync(struct super_block *sb);
 u8 *exfat_buf_getblk(struct super_block *sb, sector_t sec);
 void exfat_buf_modify(struct super_block *sb, sector_t sec);
 void exfat_buf_lock(struct super_block *sb, sector_t sec);
diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
index 3fd5604058a9..790ea4df9c00 100644
--- a/drivers/staging/exfat/exfat_cache.c
+++ b/drivers/staging/exfat/exfat_cache.c
@@ -341,25 +341,6 @@ void exfat_fat_release_all(struct super_block *sb)
 	mutex_unlock(&f_mutex);
 }
 
-void exfat_fat_sync(struct super_block *sb)
-{
-	struct buf_cache_t *bp;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	mutex_lock(&f_mutex);
-
-	bp = p_fs->FAT_cache_lru_list.next;
-	while (bp != &p_fs->FAT_cache_lru_list) {
-		if ((bp->drv == p_fs->drv) && (bp->flag & DIRTYBIT)) {
-			sync_dirty_buffer(bp->buf_bh);
-			bp->flag &= ~(DIRTYBIT);
-		}
-		bp = bp->next;
-	}
-
-	mutex_unlock(&f_mutex);
-}
-
 static struct buf_cache_t *buf_cache_find(struct super_block *sb, sector_t sec)
 {
 	s32 off;
-- 
2.17.1

