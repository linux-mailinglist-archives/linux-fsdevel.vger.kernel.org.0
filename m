Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30D2158ECD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgBKMl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:41:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46132 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgBKMl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:41:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id b35so5647963pgm.13;
        Tue, 11 Feb 2020 04:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FtRlENVNolnCiaO2hVKdFhSA/GHmlMc2pvSths4iqzY=;
        b=Uavs+HnVyKTdY1ZFZTB22+XvtS9tKDAn6f8iWVaXOvYf403Mcrayl9+w0wX2cDe7cW
         gWbUgUwnOA6BC30fPn6TqmXvSerPqBQjz4+bhrb0ws7yvVwBe2UtDyYBCtVXtta32mQS
         IGpckD3IreGc6l5KHgPGf/C4pPIw3VV05oxauE6rv9/pI8eKZTASot/At9mxOh/j5zyU
         QPdukbeibIwC9g5SbLjzguAmYIioiYxfZVukV1+WRVukIq6MOcAFQyQ5bL5HamXuhpLI
         FGah4iPIJUW5PsLHT/68yRyq89nx02kpw/Efi7OXV1G45AB462VgsV3axj3FmqOd2Zrk
         Pe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FtRlENVNolnCiaO2hVKdFhSA/GHmlMc2pvSths4iqzY=;
        b=Svr3w2uspoRH6mTxTVkSG5MtFn1eJ1Im2uIxbCX8LUkYQaVqy+q/hROWRD/HvGyu0i
         Zs8NzIPVnsaD+o233BpWPBsts0eBJqlW4Rmtobyg3amjISM5HiCqJZteY6QdGK0pCmCe
         TxcsGv7i+YIakqYtl76PXRZZwlD0G9+drRpO8j5zU2Q/qwMVNmZYQwpzQuzagcC1Le5F
         6qjBscFnUH+utud+jzGLeGkMN5dfJD9iyugO0cJhmsuW4rnmKz1IUCBW4PzWNZh6XGdL
         OBD5A0zVgJ13Lj4BRPaV/Wl4d321I37q/8c/eKR1xyBwGH4RoNlMfUoeb0dpjyyPgVGi
         n/sg==
X-Gm-Message-State: APjAAAU3r/3HMI19dzcUlNL7alZ+gXeqlABfK4Nm7Rmw5tJ6KrKbknuZ
        C3nx5WxHIdi0jCfdfDcOzAY=
X-Google-Smtp-Source: APXvYqyPnjOb6fwoAwKu5+dJXEwN7cwq0Mum+cwVeUBHeNbyU8M6oqPanxPNg7MmHO1ekvXp++oMxw==
X-Received: by 2002:a63:d94d:: with SMTP id e13mr6593266pgj.240.1581424917917;
        Tue, 11 Feb 2020 04:41:57 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:41:57 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 18/18] staging: exfat: Rename function "ffsRemoveDir" to "ffs_remove_dir"
Date:   Tue, 11 Feb 2020 18:08:59 +0530
Message-Id: <20200211123859.10429-19-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsRemoveDir" to "ffs_remove_dir" in
source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 46aeff4fb3d3..3e022eb3ada3 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -2002,7 +2002,7 @@ static int ffs_read_dir(struct inode *inode, struct dir_entry_t *dir_entry)
 	return ret;
 }
 
-static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
+static int ffs_remove_dir(struct inode *inode, struct file_id_t *fid)
 {
 	s32 dentry;
 	int ret = 0;
@@ -2556,7 +2556,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 
-	err = ffsRemoveDir(dir, &(EXFAT_I(inode)->fid));
+	err = ffs_remove_dir(dir, &(EXFAT_I(inode)->fid));
 	if (err)
 		goto out;
 
-- 
2.17.1

