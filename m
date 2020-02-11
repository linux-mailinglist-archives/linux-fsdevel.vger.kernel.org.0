Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B3158EC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgBKMlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:41:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45320 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgBKMlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:41:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so4222551pls.12;
        Tue, 11 Feb 2020 04:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPEXRrqVk1GdXx8VX7m7B/Egm4j+wVyV7Wz6lHZEIqA=;
        b=Gm6lza3tFHot7xPi/MjRiouQwnLsnUKLXQNTDLkx14LfKRI3gMaVYQeLEY1z5PDYiI
         HIl9vg5kooSwAsfJZTKE/GSGZfskHerWpl7iFlkjnXd4VIsutWzA5o/F27m/vxYF3jMH
         mW/JVqre/IRZ9ktVoYQ0yysxu+vhgW9ul7dKpZy0wwt8+FsJWiCDejWWI4m2sMjy2707
         oa7X7N3lx+GMhL5b9O8U/fTkaRyXsFvkyyAE3pCZ8iadEti6h77EcZ1qGZ55L5sn6vcf
         lGQBi5l5bEMevV8ZCCrJgb+aDVqL2l4E+tfgbuM81ksCCAYwZq2cO5m3uqum26btFsuv
         b9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JPEXRrqVk1GdXx8VX7m7B/Egm4j+wVyV7Wz6lHZEIqA=;
        b=Qa3wEcL5y/TWfaCCXjRf6krNVf0RBgfviZKr8yErVFBdyy21ePgddGXiaRvnKhYrp5
         Jw05Ga80QYwkfVkQfoIM47IC//9jb+Jl64cXDljATLPT0B0RYeH42Qz/dQk70UMj5MTM
         nQV8BH6VAojlWffrn1tsapxGqASA5FJrPB8dVOpGhfg3m0q5Xoa7BXp9ktmSp2HfGaxl
         nX4EKuLcyWpG+KKxOLtqPx1i8CAbPHKOePXeRR8Sj0KssLDHzAYLdUY+bLVfJoD+dpKM
         MyUK/dLdQp8IkMwf3swCtFxhqcn/hLIsm+AD72nJ1Ze3KOcz5imVe3fPCozqKO9sVdjM
         RGWA==
X-Gm-Message-State: APjAAAVR3WeXMNUbX/xfTkia2qKiE71Q7PjTwgfwhpWYxVZAMmG9QVP7
        9XJ8rYj05WP9UB/V4q5js74=
X-Google-Smtp-Source: APXvYqxkVBM62/1fq/HV58DaT6xc2LUugIaqeNiuuJ/lOSHnGAfQ1FYU0rd5RnPwmSiPXZn33T6ueA==
X-Received: by 2002:a17:90a:21c7:: with SMTP id q65mr3542449pjc.8.1581424891284;
        Tue, 11 Feb 2020 04:41:31 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:41:30 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 13/18] staging: exfat: Rename function "ffsReadStat" to "ffs_read_stat"
Date:   Tue, 11 Feb 2020 18:08:54 +0530
Message-Id: <20200211123859.10429-14-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsReadStat" to "ffs_read_stat" in
source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 6fa005097a21..6d21c0161419 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1435,7 +1435,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 }
 #endif
 
-static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
+static int ffs_read_stat(struct inode *inode, struct dir_entry_t *info)
 {
 	s32 count;
 	int ret = 0;
@@ -3147,7 +3147,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 
 	memcpy(&(EXFAT_I(inode)->fid), fid, sizeof(struct file_id_t));
 
-	ffsReadStat(inode, &info);
+	ffs_read_stat(inode, &info);
 
 	EXFAT_I(inode)->i_pos = 0;
 	EXFAT_I(inode)->target = NULL;
@@ -3643,7 +3643,7 @@ static int exfat_read_root(struct inode *inode)
 
 	EXFAT_I(inode)->target = NULL;
 
-	ffsReadStat(inode, &info);
+	ffs_read_stat(inode, &info);
 
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
-- 
2.17.1

