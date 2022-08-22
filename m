Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D8F59B976
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 08:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiHVGa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 02:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiHVGaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:30:55 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E83AA17AA5;
        Sun, 21 Aug 2022 23:30:54 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id A449C1E80D2C;
        Mon, 22 Aug 2022 14:27:15 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 17yKrVHvMQSe; Mon, 22 Aug 2022 14:27:13 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 11EE91E80CD1;
        Mon, 22 Aug 2022 14:27:13 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@nfschina.com, Dong Chuanjian <chuanjian@nfschina.com>
Subject: [PATCH] kernel/sysctl.c: remove unnecessary (void*) conversions
Date:   Mon, 22 Aug 2022 14:30:49 +0800
Message-Id: <20220822063049.5115-1-chuanjian@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

remove unnecessary void* type casting

Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 205d605cacc5..324e6bbbeb34 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1052,9 +1052,9 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table,
 		return 0;
 	}
 
-	i = (unsigned long *) data;
-	min = (unsigned long *) table->extra1;
-	max = (unsigned long *) table->extra2;
+	i = data;
+	min = table->extra1;
+	max = table->extra2;
 	vleft = table->maxlen / sizeof(unsigned long);
 	left = *lenp;
 
-- 
2.18.2

