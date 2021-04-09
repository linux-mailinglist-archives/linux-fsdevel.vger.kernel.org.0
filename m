Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DB935A332
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhDIQ0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 12:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhDIQ0K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:26:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 346E56105A;
        Fri,  9 Apr 2021 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985557;
        bh=WTQH0udz0NF8TztvnwMq88N10RCV7bqnuzOPfNws+Iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTlp1TSs29mHNs41k3ZC0N505SOsY11qPa3OJRwtW3BI67YF3RcCgkpqKFNgnTXwS
         YLLxH23aS5Pi8tMTTCDPtHjWMJY+VXskiTtooFqoSf+Gym/9mo3dW8G47Jca5yZ2uK
         mB4JNKp+prYvoZBPpGo13ETqZXfql9TIc7rX5P3AtwEXwASvWtEnurAnGDhDGdoOmd
         dJ6yQZh8nF6azGVITA40z+fDKFT4hGxnSeBbC89dOD36G8c8mX4502UGwLhHDSr2q1
         AyrEcjObvwndY0NcYMWH5dMu5SAnkIKaOcrhDQd+0hDwa4kWjJ6rOdo/68az+Iu5U7
         ajq7VMMpnC24g==
From:   Christian Brauner <brauner@kernel.org>
To:     Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/3] ecryptfs: remove unused helpers
Date:   Fri,  9 Apr 2021 18:24:20 +0200
Message-Id: <20210409162422.1326565-2-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210409162422.1326565-1-brauner@kernel.org>
References: <20210409162422.1326565-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=nzTvFnw3t4txDemcI17R/llUoqTSs+bJqW4FdAPoLKw=; m=J+qTInv0+c941FPP/DKnPR+q4fv+TijG5Mmocs7tYFA=; p=BwaSmLmuxC+Mnisblg4+PrmO+E3cXIi4r/5K2IN1AlY=; g=dbcf757b805a2d3101414e705db92ef74807805c
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYHB/qwAKCRCRxhvAZXjcoujCAQCL4Ot rt00cS9vtS4rQ/+DSZv/mAcTlquH6sSA1pV2ngAD8CFNsFjRJhZo7Uhs81C6mnv0OQryrd2RbDbKg +LElmAw=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Remove two helpers that are unused.

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
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
2.27.0

