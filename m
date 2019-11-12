Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4E9F86AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 03:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfKLCKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 21:10:44 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:47998 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727004AbfKLCKk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:10:40 -0500
Received: from mr4.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2AdUt011482
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:39 -0500
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2AY5B015667
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:39 -0500
Received: by mail-qv1-f71.google.com with SMTP id y24so7543733qvh.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 18:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=b5jr6tXP5LAFzWoaAbKdx7aZISn6y4Z0nVj5Y80ntww=;
        b=F631TbYRy1iFFtel1ffmkbsX5UvKLW7fTUPXKaa4RxhaMKv75gTKTYoAL+NGWJ0VA/
         iJSlcjKGrnFCQSX9V2I0YTEQ7jY/cqNWo7dGAnyObzpJRGA/W/3qdN1QTqWRYY416c1e
         LgZb4/dAui9T9y0i1z2jrjH6OCC6ERu16cMsJyh5WeaOdl+r2lnmH+i6TlOBWMwVWTAm
         Fxy5dDM2Knhwr01qr8w0a7YpepeQ4kP9qt/LgZuC/L9egopdcQxPFHBBItlpbMmnVU9I
         emKKeOqP9K9H6ILQaxLijmxbcE7fe7ht4976H7J3iqyK64jhyxk5VHv1fz9sbRfDef+F
         d/xA==
X-Gm-Message-State: APjAAAU+/DVF6Y10tKDhUEyz5zzFmaXnyM4EgEWOF+dDyrqddIQHifJd
        NpXD3Xi+Ehbi/VolImJXEb3JkkaV4+tey6xPm8g7XWkUsyfhNtQyLjPEt17q3sCdXRJEr/SEFLY
        z58kDZNXfrYfcfCaNiOBguX/fEcMD8YQGYJn1
X-Received: by 2002:ad4:53ab:: with SMTP id j11mr1438036qvv.47.1573524633942;
        Mon, 11 Nov 2019 18:10:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEK6sXuvh08AvDwU3ReArUAHvfT2mPDPFXvQoqYAE1rCCmAavdthWCRAuyx6Wr0FR7AXxORg==
X-Received: by 2002:ad4:53ab:: with SMTP id j11mr1438023qvv.47.1573524633631;
        Mon, 11 Nov 2019 18:10:33 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o195sm8004767qke.35.2019.11.11.18.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:10:32 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] staging: exfat: Clean up return codes - FFS_INVALIDFID
Date:   Mon, 11 Nov 2019 21:09:52 -0500
Message-Id: <20191112021000.42091-5-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
References: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Covert FFS_INVALIDFID to -EINVAL

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 292af85e3cd2..7a817405c624 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -214,7 +214,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_NOTMOUNTED          4
 #define FFS_ALIGNMENTERR        5
 #define FFS_SEMAPHOREERR        6
-#define FFS_INVALIDFID          8
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
 #define FFS_ERROR               19
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 7c99d1f8cba8..dd6530aef63a 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -699,7 +699,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* check the validity of pointer parameters */
 	if (!buffer)
@@ -831,7 +831,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* check the validity of pointer parameters */
 	if (!buffer)
@@ -1237,7 +1237,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* check the validity of pointer parameters */
 	if (!new_path || (*new_path == '\0'))
@@ -1358,7 +1358,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	mutex_lock(&p_fs->v_mutex);
@@ -2145,7 +2145,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	dir.dir = fid->dir.dir;
 	dir.size = fid->dir.size;
-- 
2.24.0

