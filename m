Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D774714A1C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgA0KPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:15:47 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37463 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgA0KPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:15:46 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so2918996pjb.2;
        Mon, 27 Jan 2020 02:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I9pkyhc+eRMc75D37+Ijz8Li4nOzz5kNkid/81a27nw=;
        b=L9j3oibDgnrRL03YsdZBscU5YT8Rv5RVywL/GWNRVCybUYM3dj6iKCW81+uqkYsIdA
         bw53Hh2vqL196hh+keBnqu1qAOu+Fv8X1f58wkVjmJMb6OyFPsoBHbGOxJudnrqfhsED
         sj3txTD0JALBhaJuwmJ2yyIU5f7EPA/5pgIUy0v2LoaLloZ0zWw2uHq2dL+UV/8EPfoU
         DMnP18FyxdexnjLrD06SXoIQfCthKykQ0c0L/y2zGhcl2y0NftH6i8w+9B8fvdvXi/XK
         nQzLK2RwYgVWZkBDXKuuN8DI4gS4EXvaWjJv5yQG/0bQ0sNv8YvGPGX2raR9it67EWNV
         56FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I9pkyhc+eRMc75D37+Ijz8Li4nOzz5kNkid/81a27nw=;
        b=UmeF4LOtgziNQS9leSW/K31uR+924t5sDTJHXNXlUptmXKVH9Tcq2vcwYCOwDYLdLC
         0bT/cbVrdD3cHAOEU1ImZWROHVZEg8yImdagsWkikRF3t2qTr6RajmWdpUEaOazmMNvx
         mBL/MdQnUJL096bhZhhb5WB+JyRsS9ZqijBZNOUM6ujrtJ9eosgWBxdvrf9w8a1BxY9n
         CkaH7CYrH4hSxVi/+zqKMwvEjLneDEA9ToucCD99CWr+N7/ACe2CFFMy1Qb5HlXBIVm8
         uqUfmwqQCABVseSDIoe4JQEfZya0BzryldBYRdWzdlX2Lm4yvOA23PfoULdOhcpENPxG
         2Weg==
X-Gm-Message-State: APjAAAXbs8u76H2lwirtwK0i6K0PNsuN3+VcrjtoLshaergZC+ev51Gk
        qJFK2dFTkSNUGPIqcTZVOts=
X-Google-Smtp-Source: APXvYqyN0c3kUL7zYMEV8gTBqJZRquANVf/BMwwevYJCRJD2T+WVZZJZetgB1ahLfrOQp7P/jEHh3g==
X-Received: by 2002:a17:902:654d:: with SMTP id d13mr16244156pln.187.1580120145953;
        Mon, 27 Jan 2020 02:15:45 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:15:45 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 17/22] staging: exfat: Rename variable "ShortName" to "short_name"
Date:   Mon, 27 Jan 2020 15:43:38 +0530
Message-Id: <20200127101343.20415-18-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "ShortName" to "short_name" in exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index bc917b241bab..c334467d6c94 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -273,7 +273,7 @@ struct dir_entry_t {
 	char name[MAX_NAME_LENGTH * MAX_CHARSET_SIZE];
 
 	/* used only for FAT12/16/32, not used for exFAT */
-	char ShortName[DOS_NAME_LENGTH + 2];
+	char short_name[DOS_NAME_LENGTH + 2];
 
 	u32 Attr;
 	u64 Size;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 8a4915aa3849..73ebe5a5dde9 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1464,7 +1464,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 			       sizeof(struct date_time_t));
 			memset((char *)&info->AccessTimestamp, 0,
 			       sizeof(struct date_time_t));
-			strcpy(info->ShortName, ".");
+			strcpy(info->short_name, ".");
 			strcpy(info->name, ".");
 
 			dir.dir = p_fs->root_dir;
@@ -2132,9 +2132,9 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 	if (!de.name[0])
 		goto end_of_dir;
 
-	if (!memcmp(de.ShortName, DOS_CUR_DIR_NAME, DOS_NAME_LENGTH)) {
+	if (!memcmp(de.short_name, DOS_CUR_DIR_NAME, DOS_NAME_LENGTH)) {
 		inum = inode->i_ino;
-	} else if (!memcmp(de.ShortName, DOS_PAR_DIR_NAME, DOS_NAME_LENGTH)) {
+	} else if (!memcmp(de.short_name, DOS_PAR_DIR_NAME, DOS_NAME_LENGTH)) {
 		inum = parent_ino(filp->f_path.dentry);
 	} else {
 		loff_t i_pos = ((loff_t)EXFAT_I(inode)->fid.start_clu << 32) |
-- 
2.17.1

