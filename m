Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F319E3722
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 17:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503340AbfJXPyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 11:54:37 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42932 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409867AbfJXPyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:36 -0400
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsZJ3010316
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:35 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsUno004016
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:35 -0400
Received: by mail-qk1-f197.google.com with SMTP id x186so23866311qke.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yKYfNMQHtrbDF/G3Fi58sG8HBu5LDL0Q3jnUUhO0N9U=;
        b=JtH6gibDNs+q6Qs/GjifJU5Ao6oJ/4+A1YmTPfjJztMJW+GdyF4SNzSYOnz1lp4okN
         tcPjwmeDRb8rR+EwQ1uQcI1XLztJbOdMSpSjCkvvY79B4t1KlPyuOM3qHxAM+Y689nke
         GXHYkJDold0cL0uM320j+MWn/tGEFtRCxk9ZKxA+g4PogzhvOgcYoLlEr5HMtlpo/u9r
         ktxzZr3DGAowE+IHPou1c1X/FXx6/Iph1X7q92DlV3oT16yB5IXk2iNBpudYbhmh2cmt
         VBtugeMUUpCMg866WPd8kvmqV+SBEhCcB0x8BEIZZmctKIk6Vii3CH49yTFyU4B0VYO3
         LI7Q==
X-Gm-Message-State: APjAAAX8bzskI0xpODtR7+K60wRZhHqWMc4VKq5UGUN3MCkilVI1j6Uq
        Nf3n6wHrOWfnqIASsv8VpSYNRxei0eBBKzihlLLX/hSGW7QWv/3RDT818b8kl4qnQRriKuvgT1K
        54hJWek6u2y9dqpy5rAA1aMET2+9esjvvyjuc
X-Received: by 2002:ac8:2225:: with SMTP id o34mr4928566qto.68.1571932470303;
        Thu, 24 Oct 2019 08:54:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwBsKVtiz62Oia4u6IffqufPZzM7lHXCqrHFPfp50DFuDu8QE6bM/XoLuL+c9AKGg/jk/1cIQ==
X-Received: by 2002:ac8:2225:: with SMTP id o34mr4928544qto.68.1571932470041;
        Thu, 24 Oct 2019 08:54:30 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:28 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] staging: exfat: Clean up return code - FFS_MEMORYERR
Date:   Thu, 24 Oct 2019 11:53:19 -0400
Message-Id: <20191024155327.1095907-9-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert FFS_MEMORYERR to -ENOMEM

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h      |  1 -
 drivers/staging/exfat/exfat_core.c | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 00e5e37100ce..2588a6cbe552 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -218,7 +218,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
 #define FFS_EOF                 15
-#define FFS_MEMORYERR           17
 #define FFS_ERROR               19
 
 #define NUM_UPCASE              2918
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 23c369fb98e5..fa2bf18b4a14 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -177,7 +177,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 							       sizeof(struct buffer_head *),
 							       GFP_KERNEL);
 				if (!p_fs->vol_amap)
-					return FFS_MEMORYERR;
+					return -ENOMEM;
 
 				sector = START_SECTOR(p_fs->map_clu);
 
@@ -604,7 +604,7 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 	upcase_table = p_fs->vol_utbl = kmalloc(UTBL_COL_COUNT * sizeof(u16 *),
 						GFP_KERNEL);
 	if (!upcase_table)
-		return FFS_MEMORYERR;
+		return -ENOMEM;
 	memset(upcase_table, 0, UTBL_COL_COUNT * sizeof(u16 *));
 
 	while (sector < end_sector) {
@@ -644,7 +644,7 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 					upcase_table[col_index] = kmalloc_array(UTBL_ROW_COUNT,
 						sizeof(u16), GFP_KERNEL);
 					if (!upcase_table[col_index]) {
-						ret = FFS_MEMORYERR;
+						ret = -ENOMEM;
 						goto error;
 					}
 
@@ -684,7 +684,7 @@ static s32 __load_default_upcase_table(struct super_block *sb)
 	upcase_table = p_fs->vol_utbl = kmalloc(UTBL_COL_COUNT * sizeof(u16 *),
 						GFP_KERNEL);
 	if (!upcase_table)
-		return FFS_MEMORYERR;
+		return -ENOMEM;
 	memset(upcase_table, 0, UTBL_COL_COUNT * sizeof(u16 *));
 
 	for (i = 0; index <= 0xFFFF && i < NUM_UPCASE * 2; i += 2) {
@@ -707,7 +707,7 @@ static s32 __load_default_upcase_table(struct super_block *sb)
 									sizeof(u16),
 									GFP_KERNEL);
 				if (!upcase_table[col_index]) {
-					ret = FFS_MEMORYERR;
+					ret = -ENOMEM;
 					goto error;
 				}
 
-- 
2.23.0

