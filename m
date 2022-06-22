Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9885540B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 04:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356293AbiFVC65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 22:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356000AbiFVC64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:58:56 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69C6AA3;
        Tue, 21 Jun 2022 19:58:55 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 91A0C1E80CD2;
        Wed, 22 Jun 2022 10:58:45 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5cRq9H8Da_xB; Wed, 22 Jun 2022 10:58:42 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.97])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 63C8B1E80C7D;
        Wed, 22 Jun 2022 10:58:42 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] coredump: Fix typo
Date:   Wed, 22 Jun 2022 10:58:47 +0800
Message-Id: <20220622025847.13335-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change 'postion' to 'position'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ebc43f960b64..9efbe3d0cbc8 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -756,7 +756,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		core_dumped = binfmt->core_dump(&cprm);
 		/*
 		 * Ensures that file size is big enough to contain the current
-		 * file postion. This prevents gdb from complaining about
+		 * file position. This prevents gdb from complaining about
 		 * a truncated file if the last "write" to the file was
 		 * dump_skip.
 		 */
-- 
2.25.1

