Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6CBE158EB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgBKMkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:40:47 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39648 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgBKMkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:40:46 -0500
Received: by mail-pj1-f68.google.com with SMTP id e9so1202465pjr.4;
        Tue, 11 Feb 2020 04:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2K+trdnQQOzkzm76zvow5EbebT3tW2J3I9Fu0OdgGmg=;
        b=jQXUq6D+kVuQyeMFk8YoWMTP4vd/bZuZKq1mAjF3G6AvDKTMCGLetBTLVtYEN02hrb
         iqjt/c9NsFHF7aPMmjxJt5zxaRKpq+zfEoy60kma/PY4W51cJe3ffSFUGZNmEeac7gCM
         5kgJ1yYmdo3aiq2r1hXjr//vBGJH8783QvfkAzU6uFdppqaITTO8stvZb9xfRwHNpU7B
         /6xwWpA61Hv7mdMxLrGUM3klom3hSmPimT1Zjiuy6OWp8cQeAdkcpZx2W9ebUbhqsWrt
         b1iAvh8gS7cxYaHPzF4pM/CGySTBbCmBgsD9K07FCoZTo+10ZPTc3GjGvbIQk8Y48Xat
         IuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2K+trdnQQOzkzm76zvow5EbebT3tW2J3I9Fu0OdgGmg=;
        b=ZFK2EffxhjhjU5eoBMyZhtyZEOD7Q4rf3EUOBaaUlSNmRZi8LxLvKe9e4NiAqasXHf
         FEIZ67q5JbgysiPoRl3F5lPGO+r3kMtDKlXMIH7f3eyThM+nB/PwPtyMsg0e3dqO1ltK
         Mzt7TvOhU1yMcRQbwoXkVSJ4i58g3xo+FWnH+SvB+KKooiURA2UpOLfG5rzdmT8AUkiB
         EzSkBCsNV5IcDVlEwcD8tWTOA9ux8wj3CG4fUuzcyf7WUN+BcsemnOFHv0JRXguZ+QeW
         hOPpocclGGlO4rvEmj8lroC28UIhwGmwv8pQQ30eA7xDK935pIh52CJM9M2ADbUp4mWi
         33dA==
X-Gm-Message-State: APjAAAXsmyQh0skJiXp/oe7aiPFvUNeFZ4416GkqRM9dcVbTQNMHpB1Y
        5lh79SDKqQerswqSV6E5j0lT+hvkVxY=
X-Google-Smtp-Source: APXvYqw9/y449WJFgZlfmTbcletSIQEX1AfhZGjOyPgAVgPvFIVywtBEJEGT+6aC2rVeWlI2rgw5Mw==
X-Received: by 2002:a17:90a:6c26:: with SMTP id x35mr3282984pjj.84.1581424846226;
        Tue, 11 Feb 2020 04:40:46 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:40:45 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 05/18] staging: exfat: Rename function "ffsCreateFile" to "ffs_create_file"
Date:   Tue, 11 Feb 2020 18:08:46 +0530
Message-Id: <20200211123859.10429-6-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsCreateFile" to "ffs_create_file"
in source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 6082c6e75468..5080de9b289a 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -621,8 +621,8 @@ static int ffs_lookup_file(struct inode *inode, char *path, struct file_id_t *fi
 	return ret;
 }
 
-static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
-			 struct file_id_t *fid)
+static int ffs_create_file(struct inode *inode, char *path, u8 mode,
+			   struct file_id_t *fid)
 {
 	struct chain_t dir;
 	struct uni_name_t uni_name;
@@ -2232,7 +2232,7 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	pr_debug("%s entered\n", __func__);
 
-	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_REGULAR, &fid);
+	err = ffs_create_file(dir, (u8 *)dentry->d_name.name, FM_REGULAR, &fid);
 	if (err)
 		goto out;
 
@@ -2441,7 +2441,7 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 
 	pr_debug("%s entered\n", __func__);
 
-	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_SYMLINK, &fid);
+	err = ffs_create_file(dir, (u8 *)dentry->d_name.name, FM_SYMLINK, &fid);
 	if (err)
 		goto out;
 
-- 
2.17.1

