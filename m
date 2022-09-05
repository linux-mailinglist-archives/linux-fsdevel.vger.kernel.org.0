Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091D65ACFF5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 12:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiIEKR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 06:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbiIEKQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:16:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F05A550B5;
        Mon,  5 Sep 2022 03:15:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MLkqc400qzrS41;
        Mon,  5 Sep 2022 18:13:16 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 5 Sep
 2022 18:15:08 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] writeback: remove obsolete macro EXPIRE_DIRTY_ATIME
Date:   Mon, 5 Sep 2022 18:14:36 +0800
Message-ID: <20220905101436.19792-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's not used now. Remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/fs-writeback.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 08a1993ab7fd..b91284cc39c5 100644
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
2.23.0

