Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF06158EC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgBKMls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:41:48 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51983 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgBKMls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:41:48 -0500
Received: by mail-pj1-f67.google.com with SMTP id fa20so1275895pjb.1;
        Tue, 11 Feb 2020 04:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AlXfI3TYENDO6EIV6539YfBeSyGhAhgJFR6rgHScXF4=;
        b=S90OjPJkBgFMPll4NjkZiIQ2jRaq6iUsPwIjaYg4s565ns4MsPdSe1HsgjxTuiGnLP
         2Xw5lWRCNMFFEpBPgSpEua/GqybPc4PtlbL1QShJ3Dkd1lp8vhoDLecwhEpW0O9LDBp/
         EN/60+LLrwQnlmv11ezHpOQ+hvF7JktRNT1hGDu73lq5y5idhJhEdxLH6rlZzSstQK1q
         aK9QY6A5WmplN52F30uePV90Y5JQJCs+ZHLrkuepMf6hAtsbfFU8QbZTTbx829vwzrOh
         kLQ5ZpvjOLm++swwRG2EoX/HPUZPB9wvP0qx3h6FKbnHnkPAJoE4Bm1buMsE3FLINj0p
         R+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AlXfI3TYENDO6EIV6539YfBeSyGhAhgJFR6rgHScXF4=;
        b=Hp07wrT/180HUl1aXB9nwXstv4ta36S2u3M4S0h+lgO3i7U/+qxNsroerilnoIgXwT
         BRTzxGJiyHsKwRgjuQie5yjxtFh3oajenMl9cBAwfv5AJsMaKjXX3xgufjIUeFFAlejN
         vKs2B7vucPH2XAB+RlHCTgMhhdNj3kiGNiLIDny0ys8dRq6B77tbh+6i2XG3FoTJXwSE
         n6xqtBAQjcSdM0gUxLJT9nP1KrCfn+aZP4XxTPNehKDqWpl1vkS2N88+dyaDyR2H1RBG
         0kt+DMmmmSiJatNXgJRfMrJ633F+iZqu7CdjWoencGWO6RK/3EZGvhdmhes75wvjZZiT
         Ft8Q==
X-Gm-Message-State: APjAAAXS417jUCM2tRTYi7yIb4KXz/JD/SGdgcXvxHHVjl1CKQOnNOvo
        eXwO99sPHs2wiy7Q1eGU6wY=
X-Google-Smtp-Source: APXvYqz5gZKbIttVFpeyZfSqvDhLaMLAzotEcOmqptNaUCR7PV4pjEavYaL2/BUlCXNGvIxhf8oM7Q==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr17552526plk.141.1581424907655;
        Tue, 11 Feb 2020 04:41:47 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:41:47 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 16/18] staging: exfat: Rename function "ffsCreateDir" to "ffs_create_dir"
Date:   Tue, 11 Feb 2020 18:08:57 +0530
Message-Id: <20200211123859.10429-17-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsCreateDir" to "ffs_create_dir" in
source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 87a7bcba4921..d8265dabe37d 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1776,7 +1776,7 @@ static int ffs_map_cluster(struct inode *inode, s32 clu_offset, u32 *clu)
 /*  Directory Operation Functions                                       */
 /*----------------------------------------------------------------------*/
 
-static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
+static int ffs_create_dir(struct inode *inode, char *path, struct file_id_t *fid)
 {
 	int ret = 0;
 	struct chain_t dir;
@@ -2505,7 +2505,7 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	pr_debug("%s entered\n", __func__);
 
-	err = ffsCreateDir(dir, (u8 *)dentry->d_name.name, &fid);
+	err = ffs_create_dir(dir, (u8 *)dentry->d_name.name, &fid);
 	if (err)
 		goto out;
 
-- 
2.17.1

