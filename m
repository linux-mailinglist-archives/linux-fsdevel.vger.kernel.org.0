Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6785158EC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgBKMl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:41:26 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38228 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgBKMlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:41:25 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so1206234pjz.3;
        Tue, 11 Feb 2020 04:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2LN667GsaIU1PPznCvOIjpYDI6/NrfmfLtQqMg/2m28=;
        b=UwOH1rXDlAVGZ9jRO+T1mltnnyn449Ul/zuLqhaeWyxDB51mpOtRzhAU28xSaZ1hwV
         7v1ooNZ919hPSILlODsm0y3ahQWVZzsuQNGgWJZraEhizrzBY+sfAtGma3uhHChwO7ya
         O0q8qXIXPa/vNPBVyopeivMneqRIUzEd5gZzne9DgiX38JbljSgg9gHJRxJjdPB5y4RG
         WNtLQ3BBDTX9nkVX0PGuodmonZvndaSaNyWfqzmj3YsVJWL94NBG4bjQoALRcN2ANoQp
         +OqmwELQiwYc9UWD6UlCb7i2v0m41yS4MkLJ4GgMk3CnM9jovxs98rxu1WGwXcWpeD6A
         7PJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2LN667GsaIU1PPznCvOIjpYDI6/NrfmfLtQqMg/2m28=;
        b=L8nXUXS9qjQPlCfRWEsN6uLM64SGW3+8w9wxCVGKJtDMiQN9RBCwEqJv62/ZJEkxgP
         n5FjpwWyRNc2MFsxoSHQHmsBjUTC7tyND+mP/SfFuhPpwbPVSBMh3gnkugMnRYubMVCD
         3UaAHNMTXJamJ6RGP3kFvbJUbj2vnNwDQ3N6hEa2mNek8Wvc6ubi8oPAfc4kkMHN9HBe
         fPOfV6gQIV76mYkYPjT2nDRNPrcnnRnlJ6+rAkeuIRNPB2zLltKDGN+jtmQ9Eum9GZXD
         /9IKMMmMMjWaTcLQPFUWNvmI2PIw9+TCz428o/OK7mV5skv6+M5fdyrfjSRZeqmfpetX
         8N5A==
X-Gm-Message-State: APjAAAWOwLMofTKYxymCK04GVJHaM394jcMeUMaH8qfL1RiMSQ7h7GM7
        lNAxvNp09RZ6rCoCDKINiKY=
X-Google-Smtp-Source: APXvYqxNE7bFwonsXbH3VgCbcK+DHL6GqbObJmayZ5HGDVur+uv+s/v7quE/eYQv4c2S9bpQwJwJOA==
X-Received: by 2002:a17:90a:d205:: with SMTP id o5mr5009430pju.46.1581424885066;
        Tue, 11 Feb 2020 04:41:25 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:41:24 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 12/18] staging: exfat: Rename function "ffsMountVol" to "ffs_mount_vol"
Date:   Tue, 11 Feb 2020 18:08:53 +0530
Message-Id: <20200211123859.10429-13-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsMountVol" to "ffs_mount_vol" in
source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 05a4012c5c62..6fa005097a21 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -343,7 +343,7 @@ static inline void exfat_save_attr(struct inode *inode, u32 attr)
 		EXFAT_I(inode)->fid.attr = attr & (ATTR_RWMASK | ATTR_READONLY);
 }
 
-static int ffsMountVol(struct super_block *sb)
+static int ffs_mount_vol(struct super_block *sb)
 {
 	int i, ret;
 	struct pbr_sector_t *p_pbr;
@@ -3710,7 +3710,7 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 	sb_min_blocksize(sb, 512);
 	sb->s_maxbytes = 0x7fffffffffffffffLL;    /* maximum file size */
 
-	ret = ffsMountVol(sb);
+	ret = ffs_mount_vol(sb);
 	if (ret) {
 		if (!silent)
 			pr_err("[EXFAT] ffsMountVol failed\n");
-- 
2.17.1

