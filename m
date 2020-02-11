Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 657FC158EA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgBKMkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:40:25 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36788 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgBKMkY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:40:24 -0500
Received: by mail-pj1-f67.google.com with SMTP id gv17so1208378pjb.1;
        Tue, 11 Feb 2020 04:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9H40xTTNCEsSBuL3ApPQZ/FNZOtUwfhSHYivqLcrKf4=;
        b=KtZReSJpi3hWMVUhVmGnsinGiYUf0C3wrVLmHcj8YOnQN00ZBNeg7ueov/o9R5IvSL
         5/ok1SzC0S5syDcxJ+TV8EMfFeK2zaKTRhcbtTOFTSYRcB4am2GjP/b5929l3JhqpTiQ
         2QxrYKr07w8d3EREuK9+r9/a3anfq6R5fUOESSyXhb1+EkdDlQFpWEfxahRcGPIDs+0j
         hYw9leuV/VjttbV8rG3/GtVta76Z9FlCRhSa+at+u3YBpGYilCKWX2WyFQNrgEVSB5kV
         eaH7697f5/sKFqZ1f9z2VmQI1GKMHN2frUtieyDUgmHp6b/BO7r6F4CsjAumMY75U/Ip
         c9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9H40xTTNCEsSBuL3ApPQZ/FNZOtUwfhSHYivqLcrKf4=;
        b=fWsnSAgIdiOXM1P+HTvJvAW/C6NvI8azv70PViRVmrS2YRJeqeX5UyDYjHQS/JC2hl
         DIZWEvQgCCf4BkZGwFKACEMeHuPN4TSiWauB3aJFnuylkFPjFigYzbO63M1HCeyPAFze
         haZ1GFaNQGOc58RL0hvUUuTBjNbClzVJHmkcmeGHX6bCxttL9HgIsadoIej89eiFN4Az
         K8uMxbmUQo/5iQEtb9sVIiDdvzcCrydw+SZ1Cphd8M29o+2jlT6BCcW+fy7fRJDd2tum
         J7E0bb8dPG1mTb0qMCMr/+JQmP/ovKtx74g+tp0InzdMnzVU/f77DNCRCSNkfuSa0TJt
         Lpkg==
X-Gm-Message-State: APjAAAU/cr6h827D377wYK6Gv6ikUj3b9Ha0JVjzAVdW1xxbXvUckO7f
        VhaFwIigPjdQMbWL/MN6Ikc=
X-Google-Smtp-Source: APXvYqzkKkB8gpAgfQcowQA+Dx9hPXNvUSm0I0FKqxTW41hc3TNLAMLf938qjCxJbY6020GLeFrINQ==
X-Received: by 2002:a17:902:223:: with SMTP id 32mr3044488plc.167.1581424824262;
        Tue, 11 Feb 2020 04:40:24 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:40:23 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 01/18] staging: exfat: Rename function "ffsUmountVol" to "ffs_umount_vol"
Date:   Tue, 11 Feb 2020 18:08:42 +0530
Message-Id: <20200211123859.10429-2-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsUmountVol" to "ffs_umount_vol"
in the source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index b81d2a87b82e..1e47bfcebed5 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -439,7 +439,7 @@ static int ffsMountVol(struct super_block *sb)
 	return ret;
 }
 
-static int ffsUmountVol(struct super_block *sb)
+static int ffs_umount_vol(struct super_block *sb)
 {
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	int err = 0;
@@ -3301,7 +3301,7 @@ static void exfat_put_super(struct super_block *sb)
 	if (__is_sb_dirty(sb))
 		exfat_write_super(sb);
 
-	ffsUmountVol(sb);
+	ffs_umount_vol(sb);
 
 	sb->s_fs_info = NULL;
 	exfat_free_super(sbi);
@@ -3753,7 +3753,7 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 
 out_fail2:
-	ffsUmountVol(sb);
+	ffs_umount_vol(sb);
 out_fail:
 	if (root_inode)
 		iput(root_inode);
-- 
2.17.1

