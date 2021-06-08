Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EEB39EC27
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 04:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFHChI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 22:37:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3091 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhFHChH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:37:07 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzZ332D1PzWtjf;
        Tue,  8 Jun 2021 10:30:23 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 10:35:12 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 10:35:12 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] fs/file: fix doc warnings in file.c
Date:   Tue, 8 Jun 2021 10:44:22 +0800
Message-ID: <20210608024422.2752247-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/file.c:655: warning: Function parameter or
  member 'fdt' not described in 'last_fd'
 fs/file.c:655: warning: Excess function
  parameter 'cur_fds' description in 'last_fd'
 fs/file.c:703: warning: Function parameter or
  member 'flags' not described in '__close_range'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index d8afa8266859..c6d99c875dea 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -645,7 +645,7 @@ EXPORT_SYMBOL(close_fd); /* for ksys_close() */
 
 /**
  * last_fd - return last valid index into fd table
- * @cur_fds: files struct
+ * @fdt: fdtable struct
  *
  * Context: Either rcu read lock or files_lock must be held.
  *
@@ -695,7 +695,7 @@ static inline void __range_close(struct files_struct *cur_fds, unsigned int fd,
  *
  * @fd:     starting file descriptor to close
  * @max_fd: last file descriptor to close
- *
+ * @flags:  flags of starting file
  * This closes a range of file descriptors. All file descriptors
  * from @fd up to and including @max_fd are closed.
  */
-- 
2.31.1

