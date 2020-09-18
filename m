Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6441C26FD7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 14:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIRMsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 08:48:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726656AbgIRMsH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:48:07 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 861B49ADAD090815AEBD;
        Fri, 18 Sep 2020 20:48:03 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 20:48:01 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] open: Fix some kernel-doc warnings in open.c
Date:   Fri, 18 Sep 2020 20:45:09 +0800
Message-ID: <20200918124509.3261-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

fs/open.c:887: warning: Excess function parameter 'opened' description in 'finish_open'
fs/open.c:929: warning: Excess function parameter 'cred' description in 'vfs_open'

@opened and @cred are not in used, remove them.

Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/open.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 9af548fb841b..3f6df10f07f7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -869,7 +869,6 @@ static int do_dentry_open(struct file *f,
  * @file: file pointer
  * @dentry: pointer to dentry
  * @open: open callback
- * @opened: state of open
  *
  * This can be used to finish opening a file passed to i_op->atomic_open().
  *
@@ -923,7 +922,6 @@ EXPORT_SYMBOL(file_path);
  * vfs_open - open the file at the given path
  * @path: path to open
  * @file: newly allocated file with f_flag initialized
- * @cred: credentials to use
  */
 int vfs_open(const struct path *path, struct file *file)
 {
-- 
2.17.1

