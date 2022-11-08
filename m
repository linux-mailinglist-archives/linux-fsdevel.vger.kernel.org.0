Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124166205B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 02:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiKHBSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 20:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiKHBSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:18:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1339313F69
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Nov 2022 17:18:39 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5qx10rhBzRp6j;
        Tue,  8 Nov 2022 09:18:29 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 09:18:23 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 09:18:23 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <sforshee@kernel.org>,
        <akpm@linux-foundation.org>, <christian.brauner@ubuntu.com>
CC:     <linux-fsdevel@vger.kernel.org>, <wangxiongfeng2@huawei.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH] open: fix finish_open() and vfs_open() kernel-doc comment
Date:   Tue, 8 Nov 2022 09:37:08 +0800
Message-ID: <20221108013708.65767-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit be12af3ef5e6 ("getting rid of 'opened' argument of
->atomic_open() - part 1") remove the last parameter 'opened' but forgot
update the kernel-doc. So is the commit ae2bb293a3e8 ("get rid of cred
argument of vfs_open() and do_dentry_open()"). Let's remove the
redundant parameter description.

Fixes: be12af3ef5e6 ("getting rid of 'opened' argument of ->atomic_open() - part 1")
Fixes: ae2bb293a3e8 ("get rid of cred argument of vfs_open() and do_dentry_open()")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 fs/open.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index a81319b6177f..d35965434f70 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -951,7 +951,6 @@ static int do_dentry_open(struct file *f,
  * @file: file pointer
  * @dentry: pointer to dentry
  * @open: open callback
- * @opened: state of open
  *
  * This can be used to finish opening a file passed to i_op->atomic_open().
  *
@@ -1005,7 +1004,6 @@ EXPORT_SYMBOL(file_path);
  * vfs_open - open the file at the given path
  * @path: path to open
  * @file: newly allocated file with f_flag initialized
- * @cred: credentials to use
  */
 int vfs_open(const struct path *path, struct file *file)
 {
-- 
2.20.1

