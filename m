Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709B85AC881
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 03:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiIEBZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Sep 2022 21:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIEBZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:25:49 -0400
X-Greylist: delayed 260 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 04 Sep 2022 18:25:48 PDT
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 769652BB0D
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Sep 2022 18:25:48 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 0B85E1E80D74;
        Mon,  5 Sep 2022 09:20:34 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VlII1Ahj_rUB; Mon,  5 Sep 2022 09:20:31 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 680311E80D59;
        Mon,  5 Sep 2022 09:20:31 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] proc/proc_sysctl: Remove unnecessary 'NULL' values from Pointer
Date:   Mon,  5 Sep 2022 09:21:10 +0800
Message-Id: <20220905012110.2946-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pointer variables allocate memory first, and then judge. There is no
need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/proc/proc_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 021e83fe831f..50ba9e4fb284 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1246,7 +1246,7 @@ static bool get_links(struct ctl_dir *dir,
 static int insert_links(struct ctl_table_header *head)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
-	struct ctl_dir *core_parent = NULL;
+	struct ctl_dir *core_parent;
 	struct ctl_table_header *links;
 	int err;
 
-- 
2.18.2

