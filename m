Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20504158EB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgBKMk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:40:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39549 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgBKMk6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:40:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id j15so5669884pgm.6;
        Tue, 11 Feb 2020 04:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vB8/tlMIfHHY6/JMMNWkwheJDn7F+wyT1YK9e+905A8=;
        b=AI1Jahnp3mJx/q/qFF/nSI7JcaXi73sppfYvfhyqY6oGhAHBFdp42+HO9HXbK9Rzkt
         rt1eIfjwxX/8Swwq+X9sExmQakKyBolj88QFbn1bzxnXd1Hg0kajAHudgOfcyJwggVYQ
         8Yebe9WTnQGPeN1hkonkhHY6DE4he5bDBAoBPuHk7exQ/1l2f7w5Id+QtRcRT60PnI2I
         ji3NFN69DpMSXx9G+eKC9MAFpLdkQLqfl/H+pAlP3UpmQn+vXw3YQPuEqFz2KuRQHoPd
         dgtE7QDBMOr6Yz9g9q/1V5A5NTIQCAvwW/E9gGgAAJPMze5r6BWI6oG9MSfGVPKOGUgw
         cKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vB8/tlMIfHHY6/JMMNWkwheJDn7F+wyT1YK9e+905A8=;
        b=hriFA7nvMkO/IOcyyYVBFLuomAyBQZxXlySjbrSf6ORYJrG1+Ia0GLWIFNN7BBd5Kt
         x9wY6I9+UaG5UHxACTW8SVE8SVL5Tn8poLMTOYwo2lbMcEKh5xh1nmQoHDJjujEemsBr
         02m0skECglJcJ8f9T71uLE954TDctNY54a47l5hyZ8Ct63g9MffnuzIAuiDNvehGCqw+
         Yuv6Bbw3wfVb4jclsP1PpRTkqtH81zStmWbm688LAumVx1anLlzwQELgZmlvhDGVh+o3
         qZKC2ZW1T5swX+Bzp4LGunt8rYGqxcg9ykibr8SjEf7qpaVcKimfjniKlKTUw8NhwXya
         l63w==
X-Gm-Message-State: APjAAAXE2v7xhR9A6JBloPiljwcgpBMsevj25JKzZwUrzE+BzWw+abEt
        GDtttgWWy0isg9800Ycwf28=
X-Google-Smtp-Source: APXvYqwqBWKNVboD3wYTD1qQefYmtJ7eRYkmgdT5tnRsuEVF/qV/efF4GI9OJ5A8v0V4OetM5tJXDA==
X-Received: by 2002:a63:6387:: with SMTP id x129mr2871091pgb.285.1581424857431;
        Tue, 11 Feb 2020 04:40:57 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:40:56 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 07/18] staging: exfat: Rename variable "LogSector" to "log_sector"
Date:   Tue, 11 Feb 2020 18:08:48 +0530
Message-Id: <20200211123859.10429-8-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "LogSector" to "log_sector" in
source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index c7f56f77e4bb..3393c97bd9cb 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -668,7 +668,7 @@ static int ffs_read_file(struct inode *inode, struct file_id_t *fid, void *buffe
 	s32 offset, sec_offset, clu_offset;
 	u32 clu;
 	int ret = 0;
-	sector_t LogSector;
+	sector_t log_sector;
 	u64 oneblkread, read_bytes;
 	struct buffer_head *tmp_bh = NULL;
 	struct super_block *sb = inode->i_sb;
@@ -746,20 +746,20 @@ static int ffs_read_file(struct inode *inode, struct file_id_t *fid, void *buffe
 		/* byte offset in sector */
 		offset &= p_bd->sector_size_mask;
 
-		LogSector = START_SECTOR(clu) + sec_offset;
+		log_sector = START_SECTOR(clu) + sec_offset;
 
 		oneblkread = (u64)(p_bd->sector_size - offset);
 		if (oneblkread > count)
 			oneblkread = count;
 
 		if ((offset == 0) && (oneblkread == p_bd->sector_size)) {
-			if (sector_read(sb, LogSector, &tmp_bh, 1) !=
+			if (sector_read(sb, log_sector, &tmp_bh, 1) !=
 			    0)
 				goto err_out;
 			memcpy((char *)buffer + read_bytes,
 			       (char *)tmp_bh->b_data, (s32)oneblkread);
 		} else {
-			if (sector_read(sb, LogSector, &tmp_bh, 1) !=
+			if (sector_read(sb, log_sector, &tmp_bh, 1) !=
 			    0)
 				goto err_out;
 			memcpy((char *)buffer + read_bytes,
@@ -796,7 +796,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 	s32 num_clusters, num_alloc, num_alloced = (s32)~0;
 	int ret = 0;
 	u32 clu, last_clu;
-	sector_t LogSector;
+	sector_t log_sector;
 	u64 oneblkwrite, write_bytes;
 	struct chain_t new_clu;
 	struct timestamp_t tm;
@@ -932,19 +932,19 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 		/* byte offset in sector    */
 		offset &= p_bd->sector_size_mask;
 
-		LogSector = START_SECTOR(clu) + sec_offset;
+		log_sector = START_SECTOR(clu) + sec_offset;
 
 		oneblkwrite = (u64)(p_bd->sector_size - offset);
 		if (oneblkwrite > count)
 			oneblkwrite = count;
 
 		if ((offset == 0) && (oneblkwrite == p_bd->sector_size)) {
-			if (sector_read(sb, LogSector, &tmp_bh, 0) !=
+			if (sector_read(sb, log_sector, &tmp_bh, 0) !=
 			    0)
 				goto err_out;
 			memcpy((char *)tmp_bh->b_data,
 			       (char *)buffer + write_bytes, (s32)oneblkwrite);
-			if (sector_write(sb, LogSector, tmp_bh, 0) !=
+			if (sector_write(sb, log_sector, tmp_bh, 0) !=
 			    0) {
 				brelse(tmp_bh);
 				goto err_out;
@@ -952,18 +952,18 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 		} else {
 			if ((offset > 0) ||
 			    ((fid->rwoffset + oneblkwrite) < fid->size)) {
-				if (sector_read(sb, LogSector, &tmp_bh, 1) !=
+				if (sector_read(sb, log_sector, &tmp_bh, 1) !=
 				    0)
 					goto err_out;
 			} else {
-				if (sector_read(sb, LogSector, &tmp_bh, 0) !=
+				if (sector_read(sb, log_sector, &tmp_bh, 0) !=
 				    0)
 					goto err_out;
 			}
 
 			memcpy((char *)tmp_bh->b_data + offset,
 			       (char *)buffer + write_bytes, (s32)oneblkwrite);
-			if (sector_write(sb, LogSector, tmp_bh, 0) !=
+			if (sector_write(sb, log_sector, tmp_bh, 0) !=
 			    0) {
 				brelse(tmp_bh);
 				goto err_out;
-- 
2.17.1

