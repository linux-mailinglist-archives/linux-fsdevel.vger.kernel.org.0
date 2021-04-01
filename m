Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A3E350BBB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhDABKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233076AbhDABK2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:10:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ED4D61057;
        Thu,  1 Apr 2021 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239428;
        bh=S/olNvP8K/9M1KNfFw7wdzo57JHH3/l8MtygPCKgQrQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PK7sgXT//kyXSuf4DLUGJXvJV2s4XdvhiQg4cfrt+ptUdaga0BCgU51yyTZvj0+zT
         RBSSXa3jUv/8T/5QKAMWpGanC9TE1xzlAS67jV7e0zrDRVNT8DH5VHxJHt8i7hICEk
         6QzeP3Lt/l5vwKS9Ar0coVFykxBzT//UMvxo5GVd2EAPk2elIYfVGGQqVVxSoK1Vt1
         783a71HlzQeI2VhnEM8emx6tAv1D8SP1whIZprsUEhipcCFiTsmBsXYeZWRCzhpgl2
         Vc7ajNX9dATSRj2kAN9TbfQvQaxJKVitY0K28cUfsYI5/MD25dunQS9PPrZ/bUjXol
         1jtweeUXlRAwg==
Subject: [PATCH 18/18] xfs: enable atomic swapext feature
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:10:27 -0700
Message-ID: <161723942746.3149451.5617213251020259501.stgit@magnolia>
In-Reply-To: <161723932606.3149451.12366114306150243052.stgit@magnolia>
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add the atomic swapext feature to the set of features that we will
permit.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 15d967414500..c6e3316dd861 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -486,7 +486,8 @@ xfs_sb_has_incompat_feature(
 }
 
 #define XFS_SB_FEAT_INCOMPAT_LOG_ATOMIC_SWAP (1 << 0)
-#define XFS_SB_FEAT_INCOMPAT_LOG_ALL 0
+#define XFS_SB_FEAT_INCOMPAT_LOG_ALL \
+		(XFS_SB_FEAT_INCOMPAT_LOG_ATOMIC_SWAP)
 #define XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN	~XFS_SB_FEAT_INCOMPAT_LOG_ALL
 static inline bool
 xfs_sb_has_incompat_log_feature(

