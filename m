Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C09158EAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgBKMkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:40:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35644 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgBKMkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:40:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id y73so5462462pfg.2;
        Tue, 11 Feb 2020 04:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vNB8GaKg9O+94+m+JhhyWqrlwA28PBFjXIy3V7eDens=;
        b=L2wK2FU299w7KfCcc083qXSVft0zlc6j373IdYsP+mvhUqBf/w/r4V3BP9F1QGYFgP
         3ZVsvOK5jn012+WlILfEfHn5BCnmV6+ZHYHDMqqKIHwen/1JyCDzVI+3YXmbl6xjlQvX
         oN26eAAWuXcRs7gHEEc0oq55MddUp/XEfSEsZVV/QiqcB3jWyKhhwnHE2nGTbVOdPrks
         vNcRiIR8w3lBfF2bamPhR9BQN5oaZNsk8uROEpJCJsnsB7ZFTGuxyfSaYg1wIejfWklW
         G0M0eWs3cJ6lK71N1mOtHWHzDzJKOIYqBvgX2mbxPo3UfdI2peE6Aqe0/PL2iTLjWpyU
         xjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vNB8GaKg9O+94+m+JhhyWqrlwA28PBFjXIy3V7eDens=;
        b=Z1msMYSqYe0cp/8sJztZGre7MKDL3KLkY4JXa/b9t3ziBGV+QOtrdmEHFrCNooTXXn
         LRv5gHpZYDsz89J/I1fOYCoDI58vbrzlyU0dRbPGqBZmhrvbRmZ9W8uXbEcas/1kXrAS
         7wuomWNQI+DF1xtWtqkRW+0R8vhj9P9TC1yywbF5LrBVXc2T9E26ePaHt0FlyD9VFQ/8
         E+wRUHP0JMO+c1E36ailGKIjPsJUvN/UwNu0GppCOiOnjFuXatnRPkO3Rzf/M5oPHWJf
         cYcBzuGeJrR0jdKcmKxS372pTgSzHP0pTlXtxgREpK9VsnA3U9ZuMfxy5DR14J6GOZdy
         Sd5Q==
X-Gm-Message-State: APjAAAVSSn0A4AAmiWjeJLbWq2hD3EMNMlkAIJwXtMlXkeqNRc9Ws+MG
        J+GVLZ1eilQLS8vq2Ek12+k=
X-Google-Smtp-Source: APXvYqzcSqNMjz3nfB8nCri6G1335AxVHlRIBYjnheU+zhYu6CGK6skN+HVh4/my0CPHaqzKio5NTw==
X-Received: by 2002:aa7:85d9:: with SMTP id z25mr3115945pfn.223.1581424835462;
        Tue, 11 Feb 2020 04:40:35 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:40:34 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 03/18] staging: exfat: Rename function "ffsSyncVol" to "ffs_sync_vol"
Date:   Tue, 11 Feb 2020 18:08:44 +0530
Message-Id: <20200211123859.10429-4-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsSyncVol" to "ffs_sync_vol" in
source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 06d8e3d60e9e..ba86ca572f32 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -509,7 +509,7 @@ static int ffs_get_vol_info(struct super_block *sb, struct vol_info_t *info)
 	return err;
 }
 
-static int ffsSyncVol(struct super_block *sb, bool do_sync)
+static int ffs_sync_vol(struct super_block *sb, bool do_sync)
 {
 	int err = 0;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -2899,7 +2899,7 @@ static int exfat_file_release(struct inode *inode, struct file *filp)
 	struct super_block *sb = inode->i_sb;
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
-	ffsSyncVol(sb, false);
+	ffs_sync_vol(sb, false);
 	return 0;
 }
 
@@ -3314,7 +3314,7 @@ static void exfat_write_super(struct super_block *sb)
 	__set_sb_clean(sb);
 
 	if (!sb_rdonly(sb))
-		ffsSyncVol(sb, true);
+		ffs_sync_vol(sb, true);
 
 	__unlock_super(sb);
 }
@@ -3326,7 +3326,7 @@ static int exfat_sync_fs(struct super_block *sb, int wait)
 	if (__is_sb_dirty(sb)) {
 		__lock_super(sb);
 		__set_sb_clean(sb);
-		err = ffsSyncVol(sb, true);
+		err = ffs_sync_vol(sb, true);
 		__unlock_super(sb);
 	}
 
-- 
2.17.1

