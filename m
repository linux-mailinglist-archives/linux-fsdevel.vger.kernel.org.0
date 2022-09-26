Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739DE5E97E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 04:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiIZCaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 22:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIZCaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 22:30:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B3B2496E
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Sep 2022 19:30:21 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MbRVQ0s14zpVMk
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 10:27:26 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 10:30:19 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <jack@suse.cz>, <amir73il@gmail.com>, <repnop@google.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] fs/notify: ftrace: Remove obsoleted fanotify_event_has_path()
Date:   Mon, 26 Sep 2022 10:30:18 +0800
Message-ID: <20220926023018.1505270-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All uses of fanotify_event_has_path() have
been removed since commit 9c61f3b560f5 ("fanotify: break up
fanotify_alloc_event()"), now it is useless, so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 fs/notify/fanotify/fanotify.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index bf6d4d38afa0..57f51a9a3015 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -452,12 +452,6 @@ static inline bool fanotify_is_error_event(u32 mask)
 	return mask & FAN_FS_ERROR;
 }
 
-static inline bool fanotify_event_has_path(struct fanotify_event *event)
-{
-	return event->type == FANOTIFY_EVENT_TYPE_PATH ||
-		event->type == FANOTIFY_EVENT_TYPE_PATH_PERM;
-}
-
 static inline const struct path *fanotify_event_path(struct fanotify_event *event)
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
-- 
2.25.1

