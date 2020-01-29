Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85A9714CEFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 18:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgA2RAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 12:00:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38986 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgA2RAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:00:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id 4so67373pgd.6;
        Wed, 29 Jan 2020 09:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XKusosktXdhQypNmQUgC29Bmq7GAyRxVBNaveBtgBKw=;
        b=B/FP/kbijLoUXdz1aENvwUNjJW/rtL7lcbRg/yjefqqPxANOQz8ACh2s25+Fc83Khy
         RfB+JV1ZHq58qv/E4m4JOIeVSK2gfD1p9As6/oeqXbKdpAxRwH/jk/xvTrQ7pFd9SUyz
         P0ndYQWQ/XFh+Azkch7NvEwnibiVyYJVUUULr6yfGlsdnBE1D6I+Jbuvg7AwUqkwry13
         TN3uUfxWWnjmRb+F8rmC0GoAPADrJqzxVaERsTVFBNOZ4TyeIJReyVzq7qyOU5iQw+dy
         qq41ysbt7H0DnpWmT2S4Og7EuI6uFtahrAsoPZajdg9LjG8u7adxwUlzuDmk19jz9XZ9
         9yDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XKusosktXdhQypNmQUgC29Bmq7GAyRxVBNaveBtgBKw=;
        b=MstIA45rTYi++Z6Hw20IZSfKUZcaw1rCeHtRhGMpP4BBkhNqqNAblPqA5yj8APIz2M
         m5nzKmhvatvbxQWXxY4iZq+rb0vyh0+X2/esXDZp8cbvqvuswdNvBpZ3ztnGOZMmKU3T
         JGRbwgtUZJ5KaqLUQVkfYhw68m31RFSBeZKgMp7V1WdlhSrdC6eF8SJGE0EMuI5Ybrp/
         PUNyfAUZf4VuCo3Tj+c2hpEJyGzd5gjq+BYirhM5he/pDTO4LUVRrpWgP7XXqg8OLJ1u
         cVzbYslTlcmFVDcxgwrDekUqBzq462FFKvWTLgtaIizmS6w4zBj6M55VJ9Ans392ETHn
         Cc8Q==
X-Gm-Message-State: APjAAAX8uwC+yTR7FWkLzj40ZBN8DtGq/7hpxVP1+E/QO9E0BLOGCMhM
        CsZZ/OoRRD9cjkvWmYJt6Rc=
X-Google-Smtp-Source: APXvYqxzAIaEtu+asWCf6V9L0A5X+2P6HuI3uZGFl0xHR4Q5cxutZSQJhBgVkKY3B4g2xbCsK3vmzw==
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr476644pfn.245.1580317238848;
        Wed, 29 Jan 2020 09:00:38 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.09.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 09:00:38 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 19/19] staging: exfat: Rename variable 'AccessTimestamp' to 'access_timestamp'
Date:   Wed, 29 Jan 2020 22:28:32 +0530
Message-Id: <20200129165832.10574-20-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrences of identifier "AccessTimestamp" to
"access_timestamp"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 323048cd1903..29762946e773 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -280,7 +280,7 @@ struct dir_entry_t {
 	u32 num_subdirs;
 	struct date_time_t create_timestamp;
 	struct date_time_t modify_timestamp;
-	struct date_time_t AccessTimestamp;
+	struct date_time_t access_timestamp;
 };
 
 struct timestamp_t {
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 92670913971f..d78172d3f6b7 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1462,7 +1462,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 			       sizeof(struct date_time_t));
 			memset((char *)&info->modify_timestamp, 0,
 			       sizeof(struct date_time_t));
-			memset((char *)&info->AccessTimestamp, 0,
+			memset((char *)&info->access_timestamp, 0,
 			       sizeof(struct date_time_t));
 			strcpy(info->short_name, ".");
 			strcpy(info->name, ".");
@@ -1522,7 +1522,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	info->modify_timestamp.second = tm.sec;
 	info->modify_timestamp.millisecond = 0;
 
-	memset((char *)&info->AccessTimestamp, 0, sizeof(struct date_time_t));
+	memset((char *)&info->access_timestamp, 0, sizeof(struct date_time_t));
 
 	*uni_name.name = 0x0;
 	/* XXX this is very bad for exfat cuz name is already included in es.
@@ -1942,7 +1942,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->modify_timestamp.second = tm.sec;
 			dir_entry->modify_timestamp.millisecond = 0;
 
-			memset((char *)&dir_entry->AccessTimestamp, 0,
+			memset((char *)&dir_entry->access_timestamp, 0,
 			       sizeof(struct date_time_t));
 
 			*uni_name.name = 0x0;
@@ -3193,7 +3193,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 
 	exfat_time_fat2unix(&inode->i_mtime, &info.modify_timestamp);
 	exfat_time_fat2unix(&inode->i_ctime, &info.create_timestamp);
-	exfat_time_fat2unix(&inode->i_atime, &info.AccessTimestamp);
+	exfat_time_fat2unix(&inode->i_atime, &info.access_timestamp);
 
 	return 0;
 }
@@ -3264,7 +3264,7 @@ static int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 
 	exfat_time_unix2fat(&inode->i_mtime, &info.modify_timestamp);
 	exfat_time_unix2fat(&inode->i_ctime, &info.create_timestamp);
-	exfat_time_unix2fat(&inode->i_atime, &info.AccessTimestamp);
+	exfat_time_unix2fat(&inode->i_atime, &info.access_timestamp);
 
 	ffsWriteStat(inode, &info);
 
-- 
2.17.1

