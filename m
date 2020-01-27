Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E45614A1D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgA0KQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:16:11 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33128 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgA0KQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:16:10 -0500
Received: by mail-pj1-f67.google.com with SMTP id m7so1924340pjs.0;
        Mon, 27 Jan 2020 02:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uqJouIHf679d7RfMVdsTQABFE3LSL2nEkmeERrDaZwA=;
        b=D9LzKd2Rt7AIs9CPAOlMQkST4b9wVAL5Wwt/a/aq7VbsnJHUAlpLcr7tTizWeBbLtZ
         gLMFSj4OR0Q8cb15gBX2FeS1jinyAggXeIR9CHk3cedgZliKk2V25TfMpZWaSpEAP+ZP
         XYUDL/gdge1LWZswzFM3f18lv22ujR2UMiBMSHp6YAEHUGoaTKPBx0Qu4AVpVKvsHM/h
         vjRHPOL/6Wq7mXj5M1G5YRnI8iFcRVOje3hBoAuWC4rl5rKyT0IhiLJeXBj7+5LEkWPs
         TpJbfikkQ4RTFVc0Ppal5pB5+v002OKf8Yyg2jpu9CZ5I9xVMxLZv/56U+VzfkfaDSzd
         rVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uqJouIHf679d7RfMVdsTQABFE3LSL2nEkmeERrDaZwA=;
        b=LAk2FSMMFe+CL/7arpk7X18v4HANEbAC+2yA7Ern683rR6QScv6AVfyL00/xxx14z/
         Te2j37xEsSKKgrh19wHjBeEBkCqVPYl8VYk5107+o6IZeLsTloXupk+sQkAT2likVskG
         lL9z5jOACssZggxtfSUygKu31ybpuByQEN1acZC6qOZ1Ej66DaoI9SsYoVx7yP/nwceU
         DFAn+xcyVCrFx/32TsVc+aZulxh0VWEK7vRHsDpDEHGalyYN3MQ07gBpTInamj2HyHQV
         ox/aOf+K/1637rJDQDAotorMQH+E4XfjsLMRirIDiAHfENjSMtrrNXYAyVj8jTnUt9wm
         tL/w==
X-Gm-Message-State: APjAAAUXNmWAIUbabC3lS+JFqH2ozl4Xnovgmu6cLVOTmSvrtTKtbB+L
        Rn38HSNsNWk7c002fH8ZbPc=
X-Google-Smtp-Source: APXvYqz3MdSETRa8Qhn3mjnM9xEyOqh43vFhRnyKw5NfUyKYd4uegbwy+0aEPWu+Sc3gUKuitxZUSg==
X-Received: by 2002:a17:90a:ff02:: with SMTP id ce2mr1167302pjb.98.1580120170312;
        Mon, 27 Jan 2020 02:16:10 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c902:a5e9:3956:8df2:aee5:9cf6])
        by smtp.gmail.com with ESMTPSA id s15sm15504138pgq.4.2020.01.27.02.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:16:09 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 22/22] staging: exfat: Rename variable  "AccessTimestamp" to "access_timestamp"
Date:   Mon, 27 Jan 2020 15:43:43 +0530
Message-Id: <20200127101343.20415-23-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200127101343.20415-1-pragat.pandya@gmail.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the occurrences of "AccessTimestamp" to "access_timestamp" in
exfat.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 92f36fcc4591..7424a27ca23f 100644
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
index 3fb7977ef27f..3364bc2140f5 100644
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
 	info->modify_timestamp.milli_second = 0;
 
-	memset((char *)&info->AccessTimestamp, 0, sizeof(struct date_time_t));
+	memset((char *)&info->access_timestamp, 0, sizeof(struct date_time_t));
 
 	*uni_name.name = 0x0;
 	/* XXX this is very bad for exfat cuz name is already included in es.
@@ -1942,7 +1942,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			dir_entry->modify_timestamp.second = tm.sec;
 			dir_entry->modify_timestamp.milli_second = 0;
 
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

