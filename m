Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED7476FC3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 10:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjHDIpj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 04:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjHDIpg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:45:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC95430EA
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 01:45:33 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHK2m0RplztRVh;
        Fri,  4 Aug 2023 16:42:08 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:45:31 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <krisman@collabora.com>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: [PATCH -next] unicode: Make failed_tests and total_tests static
Date:   Fri, 4 Aug 2023 16:45:03 +0800
Message-ID: <20230804084503.29876-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

failed_tests nad total_tests is not referred outside
fs/unicode/utf8-selftest.c, so make them static.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 fs/unicode/utf8-selftest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index eb2bbdd688d7..c928e6007356 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -14,8 +14,8 @@
 
 #include "utf8n.h"
 
-unsigned int failed_tests;
-unsigned int total_tests;
+static unsigned int failed_tests;
+static unsigned int total_tests;
 
 /* Tests will be based on this version. */
 #define UTF8_LATEST	UNICODE_AGE(12, 1, 0)
-- 
2.17.1

