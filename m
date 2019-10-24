Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD88E371D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 17:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409860AbfJXPyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 11:54:33 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42904 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409853AbfJXPyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:32 -0400
Received: from mr1.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsWqv010277
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:32 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsQve023405
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:32 -0400
Received: by mail-qt1-f200.google.com with SMTP id n34so12547637qta.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CFX2Xv2E2XFYpCFGhPq9au3w9hrjHGnjTLte4Rd/YmA=;
        b=RXmE6+/w5cqawfz4zyxapMotaFwA4DCoqjWZXi9e0UPunZfw5WADD06Dc2JdvZYRzG
         C+exztBx5eAp3p4MV3LSsekJuXuEjjnwnyfQjepMMb4Y2Ub2v53GnFfLKUM2EvE62vDx
         uBlBzvW8tH925ufCAYSf0asSnST7+XuxxyDULDOiuS3xWLdawRdoQzAYh32UzkJSP+py
         IGACHPQ7K3k3eanbAZmcr1eSGyJCke6o0tQuK5fhI3RaUEDbiCvzdPPIqGhaLscNofYP
         9pGnURQUXY3hb6Z1UiLWmFVTaW7xtucFnVEGvrRBFgt1KCpn2StQ/h75srDMwLRCu9uN
         U/rQ==
X-Gm-Message-State: APjAAAWGYev82sEt/CZr11MLR6rGdKM4C+yWf7/6laBy7YC5L3WPVJfA
        8fHdcFI6Q//EeWRBOerfL4hPSIBP+mdAY/OZ8cq1dYAFTq5Ic5znMBMeD4wEW9b6pFdfW7COsnQ
        8Js2f0kco8NfPdo4Px4rsjfW3RQdMjyluP2J8
X-Received: by 2002:ac8:741a:: with SMTP id p26mr4892055qtq.143.1571932466664;
        Thu, 24 Oct 2019 08:54:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwdcgzw8DZoEnTBhImp4GLM2YUeJK+MhsCB366bACFRrmA0VURtroFgd+2o8FGC37yHNwzjPg==
X-Received: by 2002:ac8:741a:: with SMTP id p26mr4892026qtq.143.1571932466279;
        Thu, 24 Oct 2019 08:54:26 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:25 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] staging: exfat: Clean up return codes - FFS_INVALIDPATH
Date:   Thu, 24 Oct 2019 11:53:18 -0400
Message-Id: <20191024155327.1095907-8-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert FFS_INVALIDPATH to -EINVAL

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_core.c  | 10 +++++-----
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index c56363652c5d..00e5e37100ce 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -214,7 +214,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_NOTMOUNTED          4
 #define FFS_ALIGNMENTERR        5
 #define FFS_SEMAPHOREERR        6
-#define FFS_INVALIDPATH         7
 #define FFS_INVALIDFID          8
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index ba5680123b0f..23c369fb98e5 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2124,7 +2124,7 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 
 	num_entries = p_fs->fs_func->calc_num_entries(p_uniname);
 	if (num_entries == 0)
-		return FFS_INVALIDPATH;
+		return -EINVAL;
 
 	if (p_fs->vol_type != EXFAT) {
 		nls_uniname_to_dosname(sb, p_dosname, p_uniname, &lossy);
@@ -2136,7 +2136,7 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 		} else {
 			for (r = reserved_names; *r; r++) {
 				if (!strncmp((void *)p_dosname->name, *r, 8))
-					return FFS_INVALIDPATH;
+					return -EINVAL;
 			}
 
 			if (p_dosname->name_case != 0xFF)
@@ -2257,11 +2257,11 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 	struct file_id_t *fid = &(EXFAT_I(inode)->fid);
 
 	if (strscpy(name_buf, path, sizeof(name_buf)) < 0)
-		return FFS_INVALIDPATH;
+		return -EINVAL;
 
 	nls_cstring_to_uniname(sb, p_uniname, name_buf, &lossy);
 	if (lossy)
-		return FFS_INVALIDPATH;
+		return -EINVAL;
 
 	fid->size = i_size_read(inode);
 
@@ -2659,7 +2659,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 	/* check if the source and target directory is the same */
 	if (fs_func->get_entry_type(epmov) == TYPE_DIR &&
 	    fs_func->get_entry_clu0(epmov) == p_newdir->dir)
-		return FFS_INVALIDPATH;
+		return -EINVAL;
 
 	buf_lock(sb, sector_mov);
 
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 2c294e238d7b..5b35e3683605 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -2356,7 +2356,7 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_REGULAR, &fid);
 	if (err) {
-		if (err == FFS_INVALIDPATH)
+		if (err == -EINVAL)
 			err = -EINVAL;
 		else if (err == -EEXIST)
 			err = -EEXIST;
@@ -2567,7 +2567,7 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 
 	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_SYMLINK, &fid);
 	if (err) {
-		if (err == FFS_INVALIDPATH)
+		if (err == -EINVAL)
 			err = -EINVAL;
 		else if (err == -EEXIST)
 			err = -EEXIST;
@@ -2637,7 +2637,7 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	err = ffsCreateDir(dir, (u8 *)dentry->d_name.name, &fid);
 	if (err) {
-		if (err == FFS_INVALIDPATH)
+		if (err == -EINVAL)
 			err = -EINVAL;
 		else if (err == -EEXIST)
 			err = -EEXIST;
@@ -2691,7 +2691,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 
 	err = ffsRemoveDir(dir, &(EXFAT_I(inode)->fid));
 	if (err) {
-		if (err == FFS_INVALIDPATH)
+		if (err == -EINVAL)
 			err = -EINVAL;
 		else if (err == -EEXIST)
 			err = -ENOTEMPTY;
@@ -2748,7 +2748,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (err) {
 		if (err == -EPERM)
 			err = -EPERM;
-		else if (err == FFS_INVALIDPATH)
+		else if (err == -EINVAL)
 			err = -EINVAL;
 		else if (err == -EEXIST)
 			err = -EEXIST;
-- 
2.23.0

