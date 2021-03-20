Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFB2342FBD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 22:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhCTVyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 17:54:54 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:35558 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhCTVyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 17:54:24 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNjVz-007jYF-Kp; Sat, 20 Mar 2021 21:52:11 +0000
Date:   Sat, 20 Mar 2021 21:52:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] ecryptfs: get rid of unused accessors
Message-ID: <YFZuiwhD7gKlu9Qs@zeniv-ca.linux.org.uk>
References: <YFZuSSpfWPrkJNVY@zeniv-ca.linux.org.uk>
 <YFZubuMq1akR1YDx@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFZubuMq1akR1YDx@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ecryptfs/ecryptfs_kernel.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index e6ac78c62ca4..463b2d99b554 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -496,12 +496,6 @@ ecryptfs_set_superblock_lower(struct super_block *sb,
 	((struct ecryptfs_sb_info *)sb->s_fs_info)->wsi_sb = lower_sb;
 }
 
-static inline struct ecryptfs_dentry_info *
-ecryptfs_dentry_to_private(struct dentry *dentry)
-{
-	return (struct ecryptfs_dentry_info *)dentry->d_fsdata;
-}
-
 static inline void
 ecryptfs_set_dentry_private(struct dentry *dentry,
 			    struct ecryptfs_dentry_info *dentry_info)
@@ -515,12 +509,6 @@ ecryptfs_dentry_to_lower(struct dentry *dentry)
 	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.dentry;
 }
 
-static inline struct vfsmount *
-ecryptfs_dentry_to_lower_mnt(struct dentry *dentry)
-{
-	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.mnt;
-}
-
 static inline struct path *
 ecryptfs_dentry_to_lower_path(struct dentry *dentry)
 {
-- 
2.11.0

