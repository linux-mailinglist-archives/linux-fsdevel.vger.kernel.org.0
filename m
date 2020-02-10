Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26AB91582B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBJShl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:37:41 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:42661 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgBJShl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:37:41 -0500
Received: by mail-pf1-f173.google.com with SMTP id 4so4113974pfz.9;
        Mon, 10 Feb 2020 10:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=alT9tv0N8tW7XzRa/7TFhdEC9a9+4WLpwTT20uC/sHY=;
        b=dUiBY7fccUmCaRQSS0VKmJDI6Cj1HbJBJEY8u2ST8lYQkezXHc7NTK9z05m33JtuGX
         sOVH/A+aO3CbqztxP0QuTNy/EOsP80mZ5lbd4JUrRIfQsVFVBKz1hHCGrz8+ebHsUfQi
         0rNAvnokwkD1ovZH7S035Tw9GrnnBZdb+C/YESWMcvCCakW7LFmXMp/EzDrpTtZyVF6g
         Nuzmyps4SaTIvNFEY2sQ3xdWKfjtrt/SiyabfUD0Ic0h/ypUKqmgQZniGgYqUhlvZ4I3
         EX1pWst4PT/f/TWJiDABKnEV2ETPO8RUAi/kaKyKmIKBbnmjX0B9Jb59XTafCIhIH8Tu
         Q/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=alT9tv0N8tW7XzRa/7TFhdEC9a9+4WLpwTT20uC/sHY=;
        b=m+0AKPMt3oAOazDn7T9Nh2CQ7nOYQFdi3UPm5i0WJMtRPIbnwF+a2yBeTg85BV9AM9
         qWrKaNVWPVENTmYp3/mL/Qyax4J2TPPQjUwH1suoCJoNS8Ho5iwO2FWga8hyBo/eOZq0
         YnaBk4WYnGMxGopfRLU1UqDFhQyQwwXpwbQCRdkOfNApe+C8vghRM/QXg1SmHQ8qd3Pm
         vbVU1/ma3etkpFh1INLxrpDhjv2+a0zWXInflDYXGiIM1lxC8IyEfqwD1zErJrxWF4jP
         FV3NgYLj1maB/vOQQw1+E9nJwX9QbJ8CokV7UXGh20UHq1HB1O4UzgYtxQOxcSHP0/xs
         BRaA==
X-Gm-Message-State: APjAAAVc5Z5/+LC6PgHp/jJb9xVQI105kiFBeHOh4IA8zn+jnELJLrJc
        RTImgqSzC0FaglRUAN1pPDA=
X-Google-Smtp-Source: APXvYqwE+uIqcS2A8NsNO7wZu5xFeeqilLEtryP9JckD6QfgVRKmGLL+PDThQTlRNPNI5BSHVHFtnw==
X-Received: by 2002:a63:78c7:: with SMTP id t190mr3120192pgc.416.1581359860366;
        Mon, 10 Feb 2020 10:37:40 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:37:39 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 14/19] staging: exfat: Rename variable 'ShortName' to 'short_name'
Date:   Tue, 11 Feb 2020 00:05:53 +0530
Message-Id: <20200210183558.11836-15-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "ShortName" to "short_name"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 3acb4701a30b..319c53fb62dc 100644
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
index 566a6f62ed67..d32759d5ba68 100644
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
@@ -2129,9 +2129,9 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
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

