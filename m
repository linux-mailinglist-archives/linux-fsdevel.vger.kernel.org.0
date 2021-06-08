Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4830039EC3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 04:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhFHCjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 22:39:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8070 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhFHCjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:39:35 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzZ8F35jqzYsT4;
        Tue,  8 Jun 2021 10:34:53 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 10:37:42 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 10:37:41 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] fs: fix doc warnings in read_write.c
Date:   Tue, 8 Jun 2021 10:46:51 +0800
Message-ID: <20210608024651.2754777-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/read_write.c:88: warning: Function parameter or
  member 'maxsize' not described in 'generic_file_llseek_size'
 fs/read_write.c:88: warning: Excess function parameter
  'size' description in 'generic_file_llseek_size'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 9db7adf160d2..1c0c23c83c7f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -71,7 +71,7 @@ EXPORT_SYMBOL(vfs_setpos);
  * @file:	file structure to seek on
  * @offset:	file offset to seek to
  * @whence:	type of seek
- * @size:	max size of this file in file system
+ * @maxsize:	max size of this file in file system
  * @eof:	offset used for SEEK_END position
  *
  * This is a variant of generic_file_llseek that allows passing in a custom
-- 
2.31.1

