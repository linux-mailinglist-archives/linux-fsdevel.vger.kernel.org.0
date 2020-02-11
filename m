Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9239C158EA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgBKMkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:40:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46155 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgBKMkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:40:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so4216218pll.13;
        Tue, 11 Feb 2020 04:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SOR+aKlva87N2LUyxGO5pVucYWF1MeR0uphILcdbOm8=;
        b=GBIPPwdsCRN3EQUw+tg1pYinlqmFaQ2LCe+yWdIr9kLe8wyTCahjNIwYJDDbkSQdYx
         xoQofGXwIiEWhQ6pAMgYpev0EtK86hOw9lKrJe3o/aVZjVeZIiTuK+egEegvivvrK6iq
         bPBKoc1e/tyQDsWGH7R/RF0g3p5fJKAXW57719D2/b/ZOWSsE3PvNMohO1aTdG85GGcq
         8cXAN6WD4dgmJMmUWDEilGwjjf1Ud2kzBJB50TblDPyaOnuTs9GkbwIjvgiJiPxK36iP
         tnwoc+0GHn4e65yo/9jHX2eGSeg/esPzl8v4Gk1SiXUSyUKel47MUOJdljU/muN/K50l
         +lfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SOR+aKlva87N2LUyxGO5pVucYWF1MeR0uphILcdbOm8=;
        b=WMguW7PD412r7LCT4XFySI17W+WdP4K6lmX9T+jbh8RV6oUPZsoc6481wjqjIhM+Su
         MNc6cGU+hL0DCp0Zveo4VfSEUANYOpRM1m1IyAlLMCrryw05r/zQ0EnmWTbqqnObMWnS
         88bYz84unsbmGdUVUOa+37XcEQBS2lKrPwawKE0TUC60KJjPo7B2VEfHef3xk4Y1DhR0
         moUx+D5om7OzneL9w9Ti+0QAtD1StnvfFCk8dGL9wh12IiCmL5EGOdu0DnCCwGRdBO/g
         mGAGb1It38GDFsFPZnJUt+x+QS08UqOMI9ofANFHb+XAA5FN48Qsru5PSgIP5XW81gWa
         9/pg==
X-Gm-Message-State: APjAAAUjf88vHMlAhmz7REV/gX3MoNoxoQ3zgBos36iPk87kJlUnSY7I
        tj6PASEkV6u7DfUewecWJQw=
X-Google-Smtp-Source: APXvYqweTIzwmY3XCYmc6xk2SBo4/l4bIJllHhaBfOQNJbtfyOCIyKaohxgUpKHYvwZiddGNpoFnvw==
X-Received: by 2002:a17:90a:d986:: with SMTP id d6mr3487035pjv.78.1581424829845;
        Tue, 11 Feb 2020 04:40:29 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:40:29 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 02/18] staging: exfat: Rename function "ffsGetVolInfo" to "ffs_get_vol_info"
Date:   Tue, 11 Feb 2020 18:08:43 +0530
Message-Id: <20200211123859.10429-3-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsGetVolInfo" to "ffs_get_vol_info"
in the source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 1e47bfcebed5..06d8e3d60e9e 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -479,7 +479,7 @@ static int ffs_umount_vol(struct super_block *sb)
 	return err;
 }
 
-static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
+static int ffs_get_vol_info(struct super_block *sb, struct vol_info_t *info)
 {
 	int err = 0;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -3341,7 +3341,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct vol_info_t info;
 
 	if (p_fs->used_clusters == UINT_MAX) {
-		if (ffsGetVolInfo(sb, &info) == -EIO)
+		if (ffs_get_vol_info(sb, &info) == -EIO)
 			return -EIO;
 
 	} else {
-- 
2.17.1

