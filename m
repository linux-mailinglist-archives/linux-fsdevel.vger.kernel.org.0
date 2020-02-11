Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33680158EB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgBKMlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:41:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36624 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgBKMlD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:41:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so4239538plm.3;
        Tue, 11 Feb 2020 04:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RBXBZBbISoYp3llZnf8LsJEjZIERQv0jl9ZJUoR46tU=;
        b=gV7+CjZhfp1zQkIOJuLtKKPRqALr+omMQSZcjxi5WAn87q2OuZinkCT95+DSwIfBlt
         lFTkS8Mfv9L4+IqBuRuQGPFArOOrc/MexDZBchQl6onZuuuXv/Wk2NWeXY1paf7Z/dM/
         Idso5vOSJ+GAOF/98IEJWzfwiqNWJze7kgsz7uTrgZO1njWIK8UwXvBB4t/e0KCLBxkP
         pVe638yRl8hwzz1OWHNN7cYJB5/8g4NHH8R6Zyj2wvm4idUwQq3vBskVqxSGjRqrB51H
         SuTlQnsJlmbV8dV1HAmKLkQeJBruaWAmvqhTenscNPt/uTqoVAyu34bHxkh0X+fFBCAz
         ePsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RBXBZBbISoYp3llZnf8LsJEjZIERQv0jl9ZJUoR46tU=;
        b=Tl8vG9xooMJLHcyFqonYDdLbZpQJa0NtqW12lwU+eu4YCQIZ6O5by6/3eZhtjHplaP
         A5DdtL1hUgjIAom7bayZBAdcT56T+XtdJZP9/K10Z7NmRK2OZOK6w/rZ6Ot1KMZYZ/JK
         i9av6hTEyoe4hh198yA4r1icjo3XBzm1U4P0iK1AR9tDh79yD+kxsw/TvXrpUr7SAaKE
         blgBLGU0o60v6zFA/FJ/QpMXxsqRcpodOdvy0zgh2CjOPQLqSndAALWoeJH8+XAk8iA6
         ELlYwRwZV0sKGW+wJkcVC+tZO5Aiv7YDXWcAmvfAfWjavgOKAtgNcM1cyw9YCjlpbUGY
         S+Jg==
X-Gm-Message-State: APjAAAXpEb2tWzpbzmNewGnE6MS3gAhSz1SMwnPow0hXJ1/qr4PINHNw
        pnG2ibU1v+nH61Wyevl4+B0=
X-Google-Smtp-Source: APXvYqzGatr/xVY+vD0uibboZNO1fWmI1WU/x4CE3Kq9QYN7Wn3mi/8Vk4bP3pOCNon2RWGBHBWiaA==
X-Received: by 2002:a17:90a:3188:: with SMTP id j8mr3391492pjb.82.1581424863129;
        Tue, 11 Feb 2020 04:41:03 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:41:02 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 08/18] staging: exfat: Rename function "ffsWriteFile" to "ffs_write_file"
Date:   Tue, 11 Feb 2020 18:08:49 +0530
Message-Id: <20200211123859.10429-9-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsWriteFile" to "ffs_write_file" in
source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 3393c97bd9cb..d4e6f6a210e9 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -788,8 +788,8 @@ static int ffs_read_file(struct inode *inode, struct file_id_t *fid, void *buffe
 	return ret;
 }
 
-static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
-			void *buffer, u64 count, u64 *wcount)
+static int ffs_write_file(struct inode *inode, struct file_id_t *fid,
+			  void *buffer, u64 count, u64 *wcount)
 {
 	bool modified = false;
 	s32 offset, sec_offset, clu_offset;
@@ -2446,7 +2446,7 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 		goto out;
 
 
-	err = ffsWriteFile(dir, &fid, (char *)target, len, &ret);
+	err = ffs_write_file(dir, &fid, (char *)target, len, &ret);
 
 	if (err) {
 		ffsRemoveFile(dir, &fid);
-- 
2.17.1

