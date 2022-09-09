Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057475B2CFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 05:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiIIDie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 23:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIIDib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:38:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1915E100400;
        Thu,  8 Sep 2022 20:38:31 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MP1p35CJgzmVL6;
        Fri,  9 Sep 2022 11:34:51 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 11:38:28 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <jack@suse.cz>, <amir73il@gmail.com>, <cuigaosheng1@huawei.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fsnotify: remove unused declaration
Date:   Fri, 9 Sep 2022 11:38:28 +0800
Message-ID: <20220909033828.993889-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fsnotify_alloc_event_holder() and fsnotify_destroy_event_holder()
has been removed since commit 7053aee26a35 ("fsnotify: do not share
events between notification groups"), so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 fs/notify/fsnotify.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 87d8a50ee803..fde74eb333cc 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -76,10 +76,6 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
  */
 extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
 
-/* allocate and destroy and event holder to attach events to notification/access queues */
-extern struct fsnotify_event_holder *fsnotify_alloc_event_holder(void);
-extern void fsnotify_destroy_event_holder(struct fsnotify_event_holder *holder);
-
 extern struct kmem_cache *fsnotify_mark_connector_cachep;
 
 #endif	/* __FS_NOTIFY_FSNOTIFY_H_ */
-- 
2.25.1

