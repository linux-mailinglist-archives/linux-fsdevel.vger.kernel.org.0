Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B83342FC0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 22:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCTVyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 17:54:54 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:35562 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhCTVyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 17:54:53 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNjWU-007jYa-0A; Sat, 20 Mar 2021 21:52:42 +0000
Date:   Sat, 20 Mar 2021 21:52:41 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] ecryptfs: ecryptfs_dentry_info->crypt_stat is never used
Message-ID: <YFZuqS7OheVDgObg@zeniv-ca.linux.org.uk>
References: <YFZuSSpfWPrkJNVY@zeniv-ca.linux.org.uk>
 <YFZubuMq1akR1YDx@zeniv-ca.linux.org.uk>
 <YFZuiwhD7gKlu9Qs@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFZuiwhD7gKlu9Qs@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

... and never had anything non-NULL stored into it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ecryptfs/ecryptfs_kernel.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 463b2d99b554..495fb4514d09 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -262,10 +262,7 @@ struct ecryptfs_inode_info {
  * vfsmount too. */
 struct ecryptfs_dentry_info {
 	struct path lower_path;
-	union {
-		struct ecryptfs_crypt_stat *crypt_stat;
-		struct rcu_head rcu;
-	};
+	struct rcu_head rcu;
 };
 
 /**
-- 
2.11.0

