Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520D076CE8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 15:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjHBN1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 09:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjHBN07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:26:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76626B5;
        Wed,  2 Aug 2023 06:26:53 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RGCP2665kzLnxQ;
        Wed,  2 Aug 2023 21:24:06 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 21:26:49 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH -next] dcache: Remove unused extern declaration d_instantiate_unique()
Date:   Wed, 2 Aug 2023 21:26:32 +0800
Message-ID: <20230802132632.22668-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Since commit 668d0cd56ef7 ("replace d_add_unique() with saner primitive")
this is not used anymore.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/dcache.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f59..612fb55623a0 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -220,7 +220,6 @@ extern seqlock_t rename_lock;
  */
 extern void d_instantiate(struct dentry *, struct inode *);
 extern void d_instantiate_new(struct dentry *, struct inode *);
-extern struct dentry * d_instantiate_unique(struct dentry *, struct inode *);
 extern struct dentry * d_instantiate_anon(struct dentry *, struct inode *);
 extern void __d_drop(struct dentry *dentry);
 extern void d_drop(struct dentry *dentry);
-- 
2.34.1

