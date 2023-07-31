Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689AB7694BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 13:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGaL1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 07:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGaL1C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:27:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52301C9
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 04:27:01 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RDwpt3MGdzNmSx
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 19:23:34 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 19:26:59 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next] fs/hfsplus: Remove kernel-doc warnings
Date:   Mon, 31 Jul 2023 19:26:28 +0800
Message-ID: <20230731112628.214421-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove kernel-doc warning:

fs/hfsplus/wrapper.c:49: warning: Function parameter or member 'opf' not
described in 'hfsplus_submit_bio'
fs/hfsplus/wrapper.c:49: warning: Excess function parameter 'op'
description in 'hfsplus_submit_bio'
fs/hfsplus/wrapper.c:49: warning: Excess function parameter 'op_flags'
description in 'hfsplus_submit_bio'

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 fs/hfsplus/wrapper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 0b791adf02e5..690f6dbb7bec 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -30,8 +30,7 @@ struct hfsplus_wd {
  * @sector: block to read or write, for blocks of HFSPLUS_SECTOR_SIZE bytes
  * @buf: buffer for I/O
  * @data: output pointer for location of requested data
- * @op: direction of I/O
- * @op_flags: request op flags
+ * @opf: request op flags
  *
  * The unit of I/O is hfsplus_min_io_size(sb), which may be bigger than
  * HFSPLUS_SECTOR_SIZE, and @buf must be sized accordingly. On reads
-- 
2.17.1

