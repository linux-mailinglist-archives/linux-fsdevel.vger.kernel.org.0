Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5439358CB36
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 17:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbiHHPWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 11:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243586AbiHHPWD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:22:03 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD9613FBB;
        Mon,  8 Aug 2022 08:22:01 -0700 (PDT)
X-QQ-mid: bizesmtp76t1659972117tavk4rgh
Received: from harry-jrlc.. ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 23:21:44 +0800 (CST)
X-QQ-SSF: 0100000000200030C000B00A0000020
X-QQ-FEAT: C2zsvWT0ctUyrMisP7qGC1f+IV5HhMNclhUQ/lnMIGQOqvoyOtZw7q1ZlKDgO
        HF8EZQ7FN9Suj7j5BUw5ZLyQa4gVl564IZr0QJiijJq9e9CoffbUs6A3xLfP5uCTMv/YBcn
        nT93GdtYQnuJMvg375nrJxG6KCHfL7JxvAlNwxCPn2YsIEaKaZzw5HHkrG2a5sNF8X3qA14
        62EcHiu1lsXro9IWIeMoVmmQeAB1Hq5Vd374soOn8L/yBu7b+D4a0rZywMDvMxEHv7yzx01
        1KH2KgjehbHVGD+QUTzsSf6xtKgHICG2mEtzfk7Kb9U0pZvL18OKpJsZlOPi/WP7X/uG0r3
        o7PuSF3lbTZxV8ayNwL8qikE35j6SQIzmnTZqOxxfU7Jq7oaLbbYws8Gp4fqQ==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] radix tree test suite: Parameter type completion
Date:   Mon,  8 Aug 2022 23:21:42 +0800
Message-Id: <20220808152142.59327-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

'unsigned int' is better than 'unsigned', which has several changes.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 tools/testing/radix-tree/iteration_check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/radix-tree/iteration_check.c b/tools/testing/radix-tree/iteration_check.c
index e9908bcb06dd..c53d5dd9d6de 100644
--- a/tools/testing/radix-tree/iteration_check.c
+++ b/tools/testing/radix-tree/iteration_check.c
@@ -162,7 +162,7 @@ static void *tag_entries_fn(void *arg)
 }
 
 /* This is a unit test for a bug found by the syzkaller tester */
-void iteration_test(unsigned order, unsigned test_duration)
+void iteration_test(unsigned int order, unsigned int test_duration)
 {
 	int i;
 
-- 
2.30.2

