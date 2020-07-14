Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15D821F011
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 14:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgGNMIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 08:08:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7305 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727867AbgGNMIo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:08:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 399CF715D9F40D7FCA3B;
        Tue, 14 Jul 2020 20:08:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Jul 2020
 20:08:35 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
CC:     <yebin10@huawei.com>
Subject: [PATCH] fs: Remove unused variable pid_struct and child_reaper in ns_ioctl function
Date:   Tue, 14 Jul 2020 20:09:12 +0800
Message-ID: <20200714120912.1000621-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs/nsfs.c: In function ‘ns_ioctl’:
fs/nsfs.c:195:14: warning: unused variable ‘pid_struct’ [-Wunused-variable]
  195 |  struct pid *pid_struct;
      |              ^~~~~~~~~~
fs/nsfs.c:194:22: warning: unused variable ‘child_reaper’ [-Wunused-variable]
  194 |  struct task_struct *child_reaper;
      |                      ^~~~~~~~~~~~

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/nsfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 5a7de1ee6df0..543672426fd3 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -191,8 +191,6 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 {
 	struct user_namespace *user_ns;
 	struct pid_namespace *pid_ns;
-	struct task_struct *child_reaper;
-	struct pid *pid_struct;
 	pid_t pid;
 	struct ns_common *ns = get_proc_ns(file_inode(filp));
 	uid_t __user *argp;
-- 
2.25.4

