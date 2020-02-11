Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0C1158ECB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgBKMly (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:41:54 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52444 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgBKMly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:41:54 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep11so1272101pjb.2;
        Tue, 11 Feb 2020 04:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CIfSyxk8m5KdaRw+eqZDYzeqYcBL0deHQR3VHGn90v4=;
        b=ej8gJHzUU83hNwVW5kBvIGeS1YVDTmnNQYfkx15u3grPC56UMQ5VST2GQ1JrK13rb+
         Xh+RPF1kNym7AENJjmiBM3kOPX3lX5WStNnxEztxXA1LmbhKaWBNwlPWtjGuOTfiDT2g
         iFYYURmNmY2J032balplXwfLBPCwP06eobN3gqcWhlpdZwnkg+AVvg5A7l+zD4s70WRc
         2EUjefuvq9iSM3sOvlg6JMD+NQ/STkiyhE7NBOBD5oU7JIaAc8wykgrHlL19s2fNwzyy
         erspp3FJXgLZDq8MmGdmU6r4oyCJpT0+UIliqlxuqoiD3y7bMBgZKfnc4Hp3v82GW1yW
         q2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CIfSyxk8m5KdaRw+eqZDYzeqYcBL0deHQR3VHGn90v4=;
        b=pFt5w11lnjD+x7XHXplLc7EPMBm65d7Yp4ohEnJ5SWOyDeTYdqYJ51GLriU1GDNZPp
         9Zt6DXtLMZaTIJnZ5PanMfAlKjTcoJHUK5toWf7trpSVicWTVeuoEiYqq+DHBCLVrTwy
         DFHvAvLkktwt1EGj0fmDMRaIrdsr31a8Xw/D/fPpkJ0fQaDOZIKY+8Z1TYFmFs74IJz+
         FCp4Q/m3T8EESOHKdWAw7GSKDi+xtdDXp0/RdvkLU0ktg4rm7qzi1Rm8Rq2e69LfX6UJ
         kD8Udf6+CCPbZGC8qPx1Dv09FEOC4rG07daR6Puqxw1uxm2ABDAb8fD5IjX5HzhjYU6R
         1HBA==
X-Gm-Message-State: APjAAAUBPQWxzi3JDrgJQzwJN/dQPMqZEcR/pjwuAIMF8iWljdTB6393
        VS41yho+salmV3UUHCDKmj5B3z1jeic=
X-Google-Smtp-Source: APXvYqy8spf+MreM/IpAWINLH7taan10tKj7B/NVCR51nFh89nzqEh/qABKbj7mQEimKcbBihbbt9A==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr17038138plf.50.1581424913115;
        Tue, 11 Feb 2020 04:41:53 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:41:52 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 17/18] staging: exfat: Rename function "ffsReadDir" to "ffs_read_dir"
Date:   Tue, 11 Feb 2020 18:08:58 +0530
Message-Id: <20200211123859.10429-18-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsReadDir" to "ffs_read_dir" in
source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index d8265dabe37d..46aeff4fb3d3 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1816,7 +1816,7 @@ static int ffs_create_dir(struct inode *inode, char *path, struct file_id_t *fid
 	return ret;
 }
 
-static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
+static int ffs_read_dir(struct inode *inode, struct dir_entry_t *dir_entry)
 {
 	int i, dentry, clu_offset;
 	int ret = 0;
@@ -2111,7 +2111,7 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 	EXFAT_I(inode)->fid.rwoffset = cpos >> DENTRY_SIZE_BITS;
 
-	err = ffsReadDir(inode, &de);
+	err = ffs_read_dir(inode, &de);
 	if (err) {
 		/* at least we tried to read a sector
 		 * move cpos to next sector position (should be aligned)
-- 
2.17.1

