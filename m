Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C7F648C7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 03:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLJCQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Dec 2022 21:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLJCQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Dec 2022 21:16:09 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A8DBC88;
        Fri,  9 Dec 2022 18:16:08 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NTWgh6LQkzmVdp;
        Sat, 10 Dec 2022 10:15:12 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 10 Dec
 2022 10:16:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <tytso@mit.edu>, <jack@suse.cz>,
        <axboe@kernel.dk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] writeback: remove obsolete macro EXPIRE_DIRTY_ATIME
Date:   Sat, 10 Dec 2022 18:10:42 +0800
Message-ID: <20221210101042.2012931-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

EXPIRE_DIRTY_ATIME is not used anymore. Remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/fs-writeback.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 9958d4020771..6bad645ac36f 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1345,8 +1345,6 @@ static bool inode_dirtied_after(struct inode *inode, unsigned long t)
 	return ret;
 }
 
-#define EXPIRE_DIRTY_ATIME 0x0001
-
 /*
  * Move expired (dirtied before dirtied_before) dirty inodes from
  * @delaying_queue to @dispatch_queue.
-- 
2.27.0

