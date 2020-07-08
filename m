Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B60F218B00
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 17:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgGHPST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 11:18:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729206AbgGHPST (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:18:19 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 16E1CF926B60FB54B837;
        Wed,  8 Jul 2020 23:18:16 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Jul 2020 23:18:08 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Daniel Colascione <dancol@google.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH -next] vfs: Make _anon_inode_getfile() static
Date:   Wed, 8 Jul 2020 23:28:17 +0800
Message-ID: <20200708152817.13534-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sparse tool complains as follows:

fs/anon_inodes.c:80:13: warning:
 symbol '_anon_inode_getfile' was not declared. Should it be static?

_anon_inode_getfile() is not used outside of anon_inodes.c,
so marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 fs/anon_inodes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 25d92c64411e..90b022960027 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -77,11 +77,11 @@ static struct inode *anon_inode_make_secure_inode(
 	return inode;
 }
 
-struct file *_anon_inode_getfile(const char *name,
-				 const struct file_operations *fops,
-				 void *priv, int flags,
-				 const struct inode *context_inode,
-				 bool secure)
+static struct file *_anon_inode_getfile(const char *name,
+					const struct file_operations *fops,
+					void *priv, int flags,
+					const struct inode *context_inode,
+					bool secure)
 {
 	struct inode *inode;
 	struct file *file;

