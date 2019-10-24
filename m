Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1AEE3735
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 17:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503397AbfJXPy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 11:54:57 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54690 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503368AbfJXPy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:56 -0400
Received: from mr2.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFstbF027217
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:55 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsoBW024712
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:55 -0400
Received: by mail-qt1-f200.google.com with SMTP id y10so25492871qti.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ebz41ETy8wsrwzEhWbgXC3OcDhlPcRnHFiZwy0DcYE8=;
        b=q1j/F2mCq7fZyAGl6iTNLka/Mmj0zB4/VbcgtGwmn3U+4BBe58NtgkzsQuINQffXYT
         q+7hMSqhhaGJvtbiKw1WX9nK5vSOVW8JAzA1DCctXX/PCCVNQ+mB/GhGiAlTxyPML/Ir
         Hdvsxyx+JBpfO9ZGgzkJ+p4WG8ydGO5MUJ70JkIf7ZN8l52+z+Z3jsQ/mkUi1juF/lqV
         aPIATd3Lvy/H3KcLiXaHvSuc2cvIRTww4M8SsK9sj0hwuw57y1LWwXqjvUB4kBDyJuYf
         A+hFyB0vhZxgJEFqjqm2xsmnxeeyFH0xJIAI24cF45F13QJLNkeGdYBtCQosZk+cECQm
         530Q==
X-Gm-Message-State: APjAAAXWjTLRW8ar70W36lSEyVdeoG7mGeFN+3qwTEstIQUInZdNl6Qx
        /06LOFWQYbYii/Jg8xhhml43MBsoTEGyehw2deWvMziXhI8cbGF+U/2w4NYQawI6etCb0KZI3/b
        N7yWSDQ2s+nk7HYAg/bK8FtitKHDVxQn+4goz
X-Received: by 2002:ac8:720e:: with SMTP id a14mr4772381qtp.316.1571932489844;
        Thu, 24 Oct 2019 08:54:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxBNlthD7w6u5EwcLS/za3GIA5LDaEJPQnUeoaZMC5ekgSm+p+/++RGitjUZCBI1o2LpNtSJw==
X-Received: by 2002:ac8:720e:: with SMTP id a14mr4772353qtp.316.1571932489482;
        Thu, 24 Oct 2019 08:54:49 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:48 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] staging: exfat: Clean up return codes - FFS_INVALIDFID
Date:   Thu, 24 Oct 2019 11:53:23 -0400
Message-Id: <20191024155327.1095907-13-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
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
index 3ff7293fedd2..505751bf1817 100644
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
index a0c28fd8824b..485297974ae7 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -693,7 +693,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* check the validity of pointer parameters */
 	if (!buffer)
@@ -823,7 +823,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* check the validity of pointer parameters */
 	if (!buffer)
@@ -1228,7 +1228,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* check the validity of pointer parameters */
 	if (!new_path || (*new_path == '\0'))
@@ -1349,7 +1349,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
@@ -2136,7 +2136,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	dir.dir = fid->dir.dir;
 	dir.size = fid->dir.size;
-- 
2.23.0

