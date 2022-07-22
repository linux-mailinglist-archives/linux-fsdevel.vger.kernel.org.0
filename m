Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295FD57E79F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 21:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiGVTrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 15:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiGVTrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:47:10 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D30121E3E;
        Fri, 22 Jul 2022 12:47:05 -0700 (PDT)
X-QQ-mid: bizesmtp80t1658519213tfhl2rzf
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 03:46:40 +0800 (CST)
X-QQ-SSF: 0100000000200030C000B00A0000020
X-QQ-FEAT: lO87fmWkX3HCErG+gOK8vO8LaZDVgUXcpbAHnB2mjNmhqHTah2biSvUA5ZYOf
        gMqA6fP56plzoaJVzSoifa3NrxBXpYQcexZP3YoiKTzemJdkE/63tp0Jl7oK7DhKdrOwmPj
        QS4luxYerZLyLcQsRbb4AUlnO4n6+7/yIMOkwEbQmVdf9AuPquyW1LyOD37a4AMmpBJhIu/
        IBrpltBFhXKFrLCgif16lIvkM9hyo1jkT61ztWVyib0wjQuswI66+5B8z8hc8fAG+HRICgK
        5WUYBIKHQiwFxX0UgtmXYVsYlAo0dfEj1WxNXgYtWKK4yx02Bf6p6p74Fe9Cs/dvEKF4q9C
        tFt0O5UsdkMPnr+3+2ucYdk3bOVApqjEGF+J66Y2xpyn6FzAecnhUW47n9Dsg==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     jack@suse.cz
Cc:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] fsnotify: Fix comment typo
Date:   Sat, 23 Jul 2022 03:46:39 +0800
Message-Id: <20220722194639.18545-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The double `if' is duplicated in line 104, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 fs/notify/fsnotify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 6eee19d15e8c..a9773167d695 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -100,7 +100,7 @@ void fsnotify_sb_delete(struct super_block *sb)
  * Given an inode, first check if we care what happens to our children.  Inotify
  * and dnotify both tell their parents about events.  If we care about any event
  * on a child we run all of our children and set a dentry flag saying that the
- * parent cares.  Thus when an event happens on a child it can quickly tell if
+ * parent cares.  Thus when an event happens on a child it can quickly tell
  * if there is a need to find a parent and send the event to the parent.
  */
 void __fsnotify_update_child_dentry_flags(struct inode *inode)
-- 
2.30.2

