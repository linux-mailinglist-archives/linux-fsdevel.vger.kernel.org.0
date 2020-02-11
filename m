Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6C9158EC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBKMli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:41:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45208 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgBKMlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:41:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so5432998pfg.12;
        Tue, 11 Feb 2020 04:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TdXzoooEIwf4ECqrrOyZqFRyKlMHXHMskvPfQQwPS7E=;
        b=IEvSzwwneqbrWvn0yZfOQ8OI5Gx2Xqj+HuJBwWaGc9IlERBIIVUTOIYLrzYBxSUQLe
         c6Koy9B/KXvnB7TNRK8ww8kRgz1j0RlADFiOnCRBZp0ID0pW48kbCCvncDs/HkmzT9P4
         sMc6wmN1JoHpUG7Nt50vzVGXyPYMUcWrBUp+tTsJUh0RhGM6oginC4bV0SZeEm/PlE1D
         ojQguIwFKb+yCcXvAWZQVI8fDFHlObqhomH7haIcTwKsZuTI3ObYeXpFkFTox6ZmDwJf
         9P4smkcakc4O5yxjZP0Z5dEg5vlOHSwIkokl66LVrK3PU7VJD3N9SuqhaH5sTEYa3lX0
         ea0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TdXzoooEIwf4ECqrrOyZqFRyKlMHXHMskvPfQQwPS7E=;
        b=MIGduIVYEi64EbBPCCCneAcyCK2bUghGgCt0DwsEbvAVlxsPVbLtdlNTWHt15gL5YX
         lK/zjndXTIG2LBJn7e+vggxcdJmS8usiiEoAnrjzuVBT4AVPtS+CYMK2VoeytwnFDX83
         l/fOwCZ7sEJk3YZ+vCmov3e6MTb7RB3167rl2DXaEeYt+t0Icl+Og/D4DNZo8YxSWtJ5
         jZkewL34DKXf3bIdylyrJBRJ5OX/SLExSdXCf6+IIIM9ObuF7cqtLLq4MTVAYsOlPYEo
         4Q0159IbJOT0SagMs78eoIBMIw7x4YA9lh9ReLw00dUZ0WnzTFSzUDG9zTwSDWZ3OGMo
         kBSA==
X-Gm-Message-State: APjAAAVssD6T2yNXdG+dh+G6+Z4tn/xM/ciOXtQw4CT7p3XZSUcyQyFj
        9lH3d0NlOZzCUVvWIHmP9N8TsbDMOEU=
X-Google-Smtp-Source: APXvYqwW3SeV5oqKeTuPUMR1CRE3AykgBtR8wfS55TL6bOFQFHYfM0bSw39qTBYoUArq3lqwkpolDw==
X-Received: by 2002:a63:8b44:: with SMTP id j65mr6569696pge.272.1581424896843;
        Tue, 11 Feb 2020 04:41:36 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:41:36 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 14/18] staging: exfat: Rename function "ffsWriteStat" to "ffs_write_stat"
Date:   Tue, 11 Feb 2020 18:08:55 +0530
Message-Id: <20200211123859.10429-15-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsWriteStat" to "ffs_write_stat" in
source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 6d21c0161419..5fb084941c3b 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1565,7 +1565,7 @@ static int ffs_read_stat(struct inode *inode, struct dir_entry_t *info)
 	return ret;
 }
 
-static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
+static int ffs_write_stat(struct inode *inode, struct dir_entry_t *info)
 {
 	int ret = 0;
 	struct timestamp_t tm;
@@ -3263,7 +3263,7 @@ static int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 	exfat_time_unix2fat(&inode->i_ctime, &info.CreateTimestamp);
 	exfat_time_unix2fat(&inode->i_atime, &info.AccessTimestamp);
 
-	ffsWriteStat(inode, &info);
+	ffs_write_stat(inode, &info);
 
 	return 0;
 }
-- 
2.17.1

