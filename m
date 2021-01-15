Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E032F768B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 11:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbhAOKWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 05:22:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10973 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAOKWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:22:16 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DHHJC23Bqzj6tv;
        Fri, 15 Jan 2021 18:20:43 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 15 Jan 2021
 18:21:29 +0800
From:   Chengyang Fan <cy.fan@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] fs: Remove unneeded semicolon
Date:   Fri, 15 Jan 2021 18:48:54 +0800
Message-ID: <20210115104854.2351448-1-cy.fan@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove a superfluous semicolon after function definition.

Signed-off-by: Chengyang Fan <cy.fan@huawei.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c17..3072a587a823 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2906,7 +2906,7 @@ extern int insert_inode_locked(struct inode *);
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void lockdep_annotate_inode_mutex_key(struct inode *inode);
 #else
-static inline void lockdep_annotate_inode_mutex_key(struct inode *inode) { };
+static inline void lockdep_annotate_inode_mutex_key(struct inode *inode) { }
 #endif
 extern void unlock_new_inode(struct inode *);
 extern void discard_new_inode(struct inode *);
-- 
2.25.1

