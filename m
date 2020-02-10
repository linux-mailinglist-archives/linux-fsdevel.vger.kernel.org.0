Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665661582BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgBJSiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:38:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36639 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgBJSiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:38:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so4132606pfv.3;
        Mon, 10 Feb 2020 10:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OlRrcV4cV+SlhUD75IgA2vuU1RtHvP/9GZxrkhvxchc=;
        b=eyeATcJof+038p+BnoFo7o5+/Wg8N9L2sNXgOUL/t4JnoE5/w5swPUhhBxScTk/DHr
         WMNu7fXE7GqmMHBeupggQm1Z3ykj0g7eQw8WnUuK4U0pQiqSfHdhVwjCgPeuAac4sFlC
         9+hu32uaiFkSy7/WvvWuT7N49ThMt1lyd2U4N8lMQzN52NPseachthwFpS3tO9iocyLM
         EWiPKQzM6Ci56XgrmguS33VSlk5oKSIz0nJIgS3Ekmu8DEE9xopX+M3MwETvxQcPfkhG
         Ej5KC//6tToF6+drHLQNS07RK5XGeLd8fu37NPX3kAnreSm7FJ/mkwz6ydnCAgiKlB7V
         35YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OlRrcV4cV+SlhUD75IgA2vuU1RtHvP/9GZxrkhvxchc=;
        b=obe1WF4ObMZB+IVV471YaFe/dyClxlyJ8tuAw/CGjSWLWs4kwpae6cH6iljIWh0h/j
         hCrWuZFObOJTJuqNydSjqm8dgYmpl4unSuHGB8X1g5P92LB4EtgR71suhxsByzMWvljE
         TPibNKumqq+Iz2f/OobTmOuNkl5ZZabH0jyRdX1TOvIbz1ruEJzgeOlX79l9lVGoiCgu
         2J5a5hgFY6MeE9JTcTpXAUpPaw8O6gZtw9NxxuHQeuUwn4q+Za+3ZM3OCjLt43PlcylP
         uU6riNaKLj5HoVT9SidfP9R7WZCjINNta6jbrAoHVNqZnAOpJR7rtuxh0dvinvlUYBvc
         cdZQ==
X-Gm-Message-State: APjAAAV/uG5du1ofmstGYgEJ3q2urfTnr7sRJkmpuO/IBPkrBOZlAmxe
        P50Y2T8eYNp8dUtxEUZHn0Y=
X-Google-Smtp-Source: APXvYqwKlPqRa5EC0LwWDP1BusScl/tPVHSEFZRpU+UtUDBjpDgl/nxAobd28LS4kzzlkCdnyEMBAw==
X-Received: by 2002:a63:aa07:: with SMTP id e7mr3020882pgf.90.1581359885308;
        Mon, 10 Feb 2020 10:38:05 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:38:04 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 19/19] staging: exfat: Rename variable 'AccessTimestamp' to 'access_timestamp'
Date:   Tue, 11 Feb 2020 00:05:58 +0530
Message-Id: <20200210183558.11836-20-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "AccessTimestamp" to
"access_timestamp"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 2c911f1ea949..46cfac322821 100644
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
index 7388aa8fb344..9f47102e3f38 100644
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
@@ -1939,7 +1939,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->modify_timestamp.second = tm.sec;
 			dir_entry->modify_timestamp.millisecond = 0;
 
-			memset((char *)&dir_entry->AccessTimestamp, 0,
+			memset((char *)&dir_entry->access_timestamp, 0,
 			       sizeof(struct date_time_t));
 
 			*uni_name.name = 0x0;
@@ -3190,7 +3190,7 @@ static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 
 	exfat_time_fat2unix(&inode->i_mtime, &info.modify_timestamp);
 	exfat_time_fat2unix(&inode->i_ctime, &info.create_timestamp);
-	exfat_time_fat2unix(&inode->i_atime, &info.AccessTimestamp);
+	exfat_time_fat2unix(&inode->i_atime, &info.access_timestamp);
 
 	return 0;
 }
@@ -3261,7 +3261,7 @@ static int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 
 	exfat_time_unix2fat(&inode->i_mtime, &info.modify_timestamp);
 	exfat_time_unix2fat(&inode->i_ctime, &info.create_timestamp);
-	exfat_time_unix2fat(&inode->i_atime, &info.AccessTimestamp);
+	exfat_time_unix2fat(&inode->i_atime, &info.access_timestamp);
 
 	ffsWriteStat(inode, &info);
 
-- 
2.17.1

