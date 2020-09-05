Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FD725E544
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Sep 2020 05:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIEDib (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 23:38:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10817 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgIEDia (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 23:38:30 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A62FE94E9224D464644F;
        Sat,  5 Sep 2020 11:38:27 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Sat, 5 Sep 2020 11:38:19 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH] fs: get rid of warnings when built with W=1
Date:   Sat, 5 Sep 2020 11:37:08 +0800
Message-ID: <1599277028-12723-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are two warnings when built with W=1:

fs/open.c:887: warning: Excess function parameter 'opened' description in 'finish_open'
fs/open.c:929: warning: Excess function parameter 'cred' description in 'vfs_open'

As there are two comments for deleted parameters, remove them.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 fs/open.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 9af548f..3f6df10 100644
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
2.8.1

