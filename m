Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95381169991
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 20:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgBWTQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 14:16:38 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54785 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWTQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:16:37 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so3143837pjb.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 11:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xhCwhGQIZ68RTJVI13/7fmg0HCbgaGCnJpEMnTMshms=;
        b=ZxC8300Cu9zoGh3oDdVXtzCtCHURfQr9JHTCzwL86vXe0HQ0SrYHWEnyfEfZ0csUX9
         fK4VhEEr1igymLgFdajezB9DBrxi41pEWBms/Ujf7YNkVBpc0v09l94+L+4UjKX0A+Sg
         mlBNqyEziOTQ+j4/aHyXmwrCElNNnTWtF33U8wEYyT4y1CXVkr7BnbpHAtUGaPBGkhpE
         twEh1ASjXZjhHDdLBUs7B8jsOecVBpv7hUg1svtBu+oKQ6grCHCjefOeNHV/bplT4olQ
         PAwQDURWyJA9B1P7SfZOXghU8SaL2/4/o1LZW57qrw0NuTN2jfMZvGmWJVpp5VXoPIGG
         nstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xhCwhGQIZ68RTJVI13/7fmg0HCbgaGCnJpEMnTMshms=;
        b=eTK7DAS94A6RYonVISaOkBp6h6gxGNW1DfRgQCA5K2T72Dy/1XyVc0ag2ZeRsUo7NR
         S/mY1AYGwj5V98GiBl7/YWeJhuGAyTfNHu/dQpA0yyC9W+2bPxtsHhEX/xESW8LDbJ1O
         h5nePWLBdm5ZOAF50xwSINJlwSWDTt1X6+QPdsv1tK3Z1VXuy58btfapvCwQDNrP41Ma
         iRuNukb79V9BE/FHewt8XgCc6pul1eiwcXi1VYouCCSgngSrtNsTPiakP8KrG7x1vgoA
         5wjfQ9iw4AvDXY0qC/0a/mj2JAKBF7MSDBz5mbVVtuIiLwBh82f6V7HUA74stRb8AuJU
         Es1Q==
X-Gm-Message-State: APjAAAU8mVANYtSXliQLlEjYTUEOv1tvd/OhioYhEr4jzsHKIXj65KVg
        7/WTaQit9zoltS6mlP5u0Jg99w==
X-Google-Smtp-Source: APXvYqy1jlwQX9XeUc0yGutt90sXGehx0w/DGEuJ7JFIjQsAUqrnzBlCvvj6X/ZdLjfganCz7rbWRQ==
X-Received: by 2002:a17:90a:200d:: with SMTP id n13mr16601022pjc.16.1582485392234;
        Sun, 23 Feb 2020 11:16:32 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id w128sm8199209pgb.55.2020.02.23.11.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 11:16:31 -0800 (PST)
Date:   Mon, 24 Feb 2020 00:46:23 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: remove exfat_buf_sync()
Message-ID: <20200223191623.GA20122@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

exfat_buf_sync() is not called anywhere, hence remove it from
exfat_cache.c and exfat.h

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_cache.c | 19 -------------------
 2 files changed, 20 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index e36d01b6fdc9..1867d47d2394 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -653,7 +653,6 @@ void exfat_buf_lock(struct super_block *sb, sector_t sec);
 void exfat_buf_unlock(struct super_block *sb, sector_t sec);
 void exfat_buf_release(struct super_block *sb, sector_t sec);
 void exfat_buf_release_all(struct super_block *sb);
-void exfat_buf_sync(struct super_block *sb);
 
 /* fs management functions */
 void fs_set_vol_flags(struct super_block *sb, u32 new_flag);
diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
index 790ea4df9c00..87d019972050 100644
--- a/drivers/staging/exfat/exfat_cache.c
+++ b/drivers/staging/exfat/exfat_cache.c
@@ -515,22 +515,3 @@ void exfat_buf_release_all(struct super_block *sb)
 
 	mutex_unlock(&b_mutex);
 }
-
-void exfat_buf_sync(struct super_block *sb)
-{
-	struct buf_cache_t *bp;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	mutex_lock(&b_mutex);
-
-	bp = p_fs->buf_cache_lru_list.next;
-	while (bp != &p_fs->buf_cache_lru_list) {
-		if ((bp->drv == p_fs->drv) && (bp->flag & DIRTYBIT)) {
-			sync_dirty_buffer(bp->buf_bh);
-			bp->flag &= ~(DIRTYBIT);
-		}
-		bp = bp->next;
-	}
-
-	mutex_unlock(&b_mutex);
-}
-- 
2.17.1

