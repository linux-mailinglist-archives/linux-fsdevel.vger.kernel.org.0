Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A5B14CEEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 18:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgA2RAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 12:00:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39357 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgA2RAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:00:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so168576plp.6;
        Wed, 29 Jan 2020 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9aeiVANobTtX2du6RvB/Di8UDcO1ImcJlTwuVWcf+30=;
        b=k1WtaHw0ZIub3Ihonid26f1Rdn8lq9AHxeZY2KVIXqoGqq6qMefdsu0jtCKpO17guf
         pbSxGpJrXZavkKIQsRGWgL92za9fhwDmW2Rtv2b8QVB9+8fbiekFaOZFUUvf+YhrjZ/U
         /8ZNYxooQmHSguKjS+1QxfNLOGZkIIXpGGQw23vYu2bqGPoftUoNWT+zV6r/rThs4R1S
         aTeGpJnxOvQrtG1clWSIK27TorFeLeB4ubK7acsmtEsIZOiMUgr6WWymSChy2T+eHgkM
         1zcBbOq3yD0nrB1C2d2I706iK4ZirE1dOyBRzzpi9SFIDcsCb1cCPmZKhPYe9utvJVUP
         kH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9aeiVANobTtX2du6RvB/Di8UDcO1ImcJlTwuVWcf+30=;
        b=QiR88/XVP6BHnKCfn7ohQhVod65X0EX2Msnh/3175ZIm1bU152JVWZs0HpUSYSbqfH
         joo6M3xGS8hFSuWpKk5Hvtw53LlRFs0evxRFh86+Fjd8qjRbjIWm5SuHzZMYFjIkNNnl
         gIPTWW0X9McZQ2CCSGqSWE3zLyFeOuwCxn5lugz7ML9+Re+jNC+3MGrbJaNBpoNonZYy
         9dEm90HF+1p9HhEHfswb9V+a6+v0Nf2WvuClkAkqFTqR06JDdd44GEVZKBHEfaCHm6o8
         GAH4/rBah2UZgcOj3OLxrjeFfhy5KoH4XyjnbXDOaxzhposHxKWE4hSWSGnYPRNIQIb3
         smaw==
X-Gm-Message-State: APjAAAUXjubkDAcLbLfXOjHZqtApTrqXyYmTZSY75Rq9/TnNe+8peGPE
        uUaH+vByxwFixddvC94pROg=
X-Google-Smtp-Source: APXvYqwoxr62sLiUXS6Pzcz1MyevOZgjh8DyFmryp8Fk9RTl5zR6fobYKH+H/3go+qJ405se8eX+5Q==
X-Received: by 2002:a17:90a:26ab:: with SMTP id m40mr641511pje.42.1580317209743;
        Wed, 29 Jan 2020 09:00:09 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.09.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 09:00:09 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 14/19] staging: exfat: Rename variable 'ShortName' to 'short_name'
Date:   Wed, 29 Jan 2020 22:28:27 +0530
Message-Id: <20200129165832.10574-15-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrences of identifier "ShortName" to "short_name"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index e74e4d5fecd4..099730e5b9f1 100644
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
index 8e9684808cba..e155079722c8 100644
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

