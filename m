Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A1D158EBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgBKMlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:41:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36639 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgBKMlP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:41:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id d9so5681315pgu.3;
        Tue, 11 Feb 2020 04:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YnXotBwOZaJ8idgdzUqyvmMqWBBs0bfAHQ43fZW4Xj4=;
        b=XkUYkuDbtptOrXHwl9Ijv80vF/Q3qZ8y+Wfw3Bffj7bzvvHbdAX8gNl0z6d1w9YPbQ
         Uhqr0DQlES8fWSxQesJX+xWI1LClnbNHKcHIYvFU1AgM1NxyLZKBY4ClkL6+OLGUS2Kp
         YZ0WwQd2VrTGyah7FVT16zgf0l5WVoXCBARZ/HqmgG9SBQbZkkZvjffd08a7kBpZCCS5
         HTn5sBRrJBdPcnMfN3kZ/q/4hbFJaQ8xIKh6l1UcrC0B7istiKexg3q63c7f7eHfy02e
         Ywh+8samAAxCRmhZiWwFVFEzpfqXvVHNzICcgnltT/Ve2d0E5wu+TGZY5Dx9JnyvrLTE
         jP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YnXotBwOZaJ8idgdzUqyvmMqWBBs0bfAHQ43fZW4Xj4=;
        b=TzRillLSYyw4s5Wx2S1tTUgWZDOy0nxkx0k7Mtcjj9B2279PlgN2RVcyQcT5Qlmrxi
         6ozUrLuxtaZsKlqPYCgXvSFJ42zIM99VbbJapq2OxS2rKTKjtCQjXB21GcUDJWVSZAkH
         ZyNDXqtnMa11gjcEGJ7seReAO8J5o/Kmk4fkgWkNJq/Jnvl+hv+AF4+VC2lFvLIctTQ6
         QlhLyXkzi784L8kh2lHMmD+gDicoXsAhEfEYPeohpcclJo2z+X2yYhkaFn2q+I8lQltT
         lDl9No8GG3Wj55GKZmWHzNVueuGa/iF3SNFm4/ly/Dzx2gzRhya1KxtHt9dPdLU/zk/U
         Eb+w==
X-Gm-Message-State: APjAAAVxaDrKUrI4BAqWz9BGnWHsUTKVwVAH8uNEpts3ScutiwO8aavA
        Jj1tHHn5lko4Z6sA2JiPLtwSaWB60SE=
X-Google-Smtp-Source: APXvYqyYPE3ywUExVAnAvw8ZK3U1Cvtmqs0951I97W3Yol8d2oLNTpV8scMkF7Bq7s/gidb0+WwjkA==
X-Received: by 2002:aa7:9aa7:: with SMTP id x7mr2984079pfi.78.1581424873956;
        Tue, 11 Feb 2020 04:41:13 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:41:13 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 10/18] staging: exfat: Rename function "ffsMoveFile" to "ffs_move_file"
Date:   Tue, 11 Feb 2020 18:08:51 +0530
Message-Id: <20200211123859.10429-11-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsMoveFile" to "ffs_move_file" in
source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5bbd31e6ba3c..51893f8c3e92 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1167,8 +1167,8 @@ static void update_parent_info(struct file_id_t *fid,
 	}
 }
 
-static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
-		       struct inode *new_parent_inode, struct dentry *new_dentry)
+static int ffs_move_file(struct inode *old_parent_inode, struct file_id_t *fid,
+			 struct inode *new_parent_inode, struct dentry *new_dentry)
 {
 	s32 ret;
 	s32 dentry;
@@ -2605,8 +2605,8 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	EXFAT_I(old_inode)->fid.size = i_size_read(old_inode);
 
-	err = ffsMoveFile(old_dir, &(EXFAT_I(old_inode)->fid), new_dir,
-			  new_dentry);
+	err = ffs_move_file(old_dir, &(EXFAT_I(old_inode)->fid), new_dir,
+			    new_dentry);
 	if (err)
 		goto out;
 
-- 
2.17.1

