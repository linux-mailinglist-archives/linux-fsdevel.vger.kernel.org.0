Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA24214A1C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgA0KP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:15:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42928 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgA0KP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:15:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so3576495plk.9;
        Mon, 27 Jan 2020 02:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RHsNhx6vrUoikkv5dv3p0L1TT7e/AEExxslakumc+Z8=;
        b=iBpuWHqw7W6e+WbIyYgNgXxWwgmpnsB7liFQRvfA3QK48xe3nWZHLChZvGnbxIzxBB
         Vf7hi52LNJwPany5bVJDVCZSb5kPTnuKlCiacHhlRP+nALLpKroVVEbGbps9hvtqbKI8
         PyvH/lsBSb3L3Ry2cs4cCAokstq6GF2h+ovNPmnbkCqbQTTGdhUUjvZI2rgVkE/HS/gL
         apJT1xHzBnT+4UsbWYyaKlYTBPEKggrjLZQFWO/4N9r8e8WtWdT+156pxBWfzfaw6hEk
         qkY4OKDerbln7baxTgKdvfvTONjpwtwvBjJR3M561BMh/0dNTN0goNcVhGIwMAOK6USd
         IRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RHsNhx6vrUoikkv5dv3p0L1TT7e/AEExxslakumc+Z8=;
        b=n2+4ZYgY6wP4FM/8Vz2y0YAL7HZv7jMKY8xXQlEXGjaWmGgwob0RrZMgxuRp1hCtl8
         TOtyTsfsBPO5aTwVWoaZGDpfr1Hjg7x14VT8LjVzoMbYGwvtUT/DMn1G8DMTe6nqIjMq
         di+9C2DXqjmm5n8aH/SkGz6TuVpqkXgRiQVFuDgQ+NUBmtj/FGSp6aNqV4DoAXPpVZYc
         n1r9suHhZjEsLZIdCwblciwkE9X8BWhdqMRGMWYvv3ICyjg6EDygNrtBgHBX0JlmaowS
         aL9jv+Sg4ZFWONhPDWnJzTRTY8n5wSC8qyFxGfhf264rF5Uccc4lBlB51PVxYzy09zB6
         N2/Q==
X-Gm-Message-State: APjAAAWH+bwenXjZ+EWDSJrzTvKA4VgEVRKPAc0eU1xSlLrBWdE3XONE
        emNnzE/dbCfpis2xwXI4sBc=
X-Google-Smtp-Source: APXvYqyaOwAWnULMWgndBrQQTf+HvNALhpFu4sooB+T8IRuZDVtr82njMNXTS0VWzsWPt9IweH2vZg==
X-Received: by 2002:a17:90a:f84:: with SMTP id 4mr8268094pjz.74.1580120155754;
        Mon, 27 Jan 2020 02:15:55 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:15:55 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 19/22] staging: exfat: Rename variabel "NumSubdirs" to "num_subdirs"
Date:   Mon, 27 Jan 2020 15:43:40 +0530
Message-Id: <20200127101343.20415-20-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurreces of "NumSubdirs" to "num_subdirs" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index ab48bbd083e5..2e07cb6b694a 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -277,7 +277,7 @@ struct dir_entry_t {
 
 	u32 attr;
 	u64 Size;
-	u32 NumSubdirs;
+	u32 num_subdirs;
 	struct date_time_t CreateTimestamp;
 	struct date_time_t ModifyTimestamp;
 	struct date_time_t AccessTimestamp;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 27d6362f2102..2fe59bdabb56 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1484,7 +1484,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 				ret = count; /* propogate error upward */
 				goto out;
 			}
-			info->NumSubdirs = count;
+			info->num_subdirs = count;
 
 			if (p_fs->dev_ejected)
 				ret = -EIO;
@@ -1532,7 +1532,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 						   uni_name.name);
 	nls_uniname_to_cstring(sb, info->name, &uni_name);
 
-	info->NumSubdirs = 2;
+	info->num_subdirs = 2;
 
 	info->Size = p_fs->fs_func->get_entry_size(ep2);
 
@@ -1551,7 +1551,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 			ret = count; /* propogate error upward */
 			goto out;
 		}
-		info->NumSubdirs += count;
+		info->num_subdirs += count;
 	}
 
 	if (p_fs->dev_ejected)
@@ -3167,7 +3167,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 
 		i_size_write(inode, info.Size);
 		EXFAT_I(inode)->mmu_private = i_size_read(inode);
-		set_nlink(inode, info.NumSubdirs);
+		set_nlink(inode, info.num_subdirs);
 	} else if (info.attr & ATTR_SYMLINK) { /* symbolic link */
 		inode->i_generation |= 1;
 		inode->i_mode = exfat_make_mode(sbi, info.attr, 0777);
@@ -3667,7 +3667,7 @@ static int exfat_read_root(struct inode *inode)
 	inode->i_mtime = curtime;
 	inode->i_atime = curtime;
 	inode->i_ctime = curtime;
-	set_nlink(inode, info.NumSubdirs + 2);
+	set_nlink(inode, info.num_subdirs + 2);
 
 	return 0;
 }
-- 
2.17.1

