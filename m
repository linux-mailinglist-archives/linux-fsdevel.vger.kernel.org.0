Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 349A514CEF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 18:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgA2RAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 12:00:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42429 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgA2RAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:00:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id p9so162600plk.9;
        Wed, 29 Jan 2020 09:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Re+GjI9C7izuf8NURe9OZ9XSS0jaSob1qfaa/PaU3r8=;
        b=JuzyK2icLE4/NHojG1P9zT5/IOWVLZUapAZYMcTzvLDYauV96IgNVJaZfNNULspY2I
         9DzuC+QuXU7WP9GEQRDg+QwP0eexmVDnIslSvcGgb+7k1+Kv77cUsM+Vo61ox30ZmkZY
         bmlWvJ1XXuMcFcOsOvb7bjGxx+XiqMFc4jA/7Mg8yMkD9VldTnPtskIeL36T8i8uekRF
         3hGvjZzUlE86B88lW+moaIbTMagdUg0/DU8PFvVk/L++a83u/4WzY+BbBogn4MQ5h2Ld
         dczMJI90kIvzfVYsaZl+YpwBLoeUTq47H97fcffj9E0Lmnc8bGgXPY4oamZGOh5xWmcN
         3p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Re+GjI9C7izuf8NURe9OZ9XSS0jaSob1qfaa/PaU3r8=;
        b=tcnicQ38hgMbMPU6zopIwYE8odEEqP/o5UP5ztLR9wKTIRnXvxtBgXKG7xtkXe+X5/
         oES1P4JcWGS7nvw5vyYj79W3I2pRr/0+WbscxZhAh6ZTAfuEdZ6gmBldVwM/LVs7n4Lf
         KNX4bF/0rkdJqNkBi899Ubpyk4hXu4uSogBVdoxB9kdOElQYkaTHoYCONSRSrcoXQHmO
         Zk89HUnJtUC/+3oCSmBjkbs7STfkHV2u7bTaZSUs0aJNB4dOq9a0/PpwbCQaCraa+ecL
         /8lzFTXymRJ7T4GtV2N6ImiiXtqWgqjUlAM+ikVd94Hd69sQRB/vRqdVP0A5iahDK166
         EVoQ==
X-Gm-Message-State: APjAAAU5GW/banwqVO8ck+VWD41R3jd77nmeDfbnOTn+tcXiWGJ00MDq
        EcoDlzyX0Xm8dPxbvLZ6TAT2RlroMpM=
X-Google-Smtp-Source: APXvYqym2Cve/sWrde69rBx6Ve7uO608Kf0kw0RBG/Kvk5NBwuUvQ8DccUSFXZwYG4rOqU7+3YKYvw==
X-Received: by 2002:a17:902:528:: with SMTP id 37mr306157plf.322.1580317220820;
        Wed, 29 Jan 2020 09:00:20 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.09.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 09:00:20 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 16/19] staging: exfat: Rename variable 'NumSubdirs' to 'num_subdirs'
Date:   Wed, 29 Jan 2020 22:28:29 +0530
Message-Id: <20200129165832.10574-17-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrences of identifier "NumSubdirs" to "num_subdirs"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index f1fa4d19a2e2..0b5ec053bb26 100644
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
index 73d116b8d769..14a10f6f8653 100644
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

