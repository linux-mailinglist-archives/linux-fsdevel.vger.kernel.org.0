Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD68216B29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGGLNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 07:13:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbgGGLNZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:13:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 29157A3A780DA937EC46;
        Tue,  7 Jul 2020 19:13:23 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Jul 2020 19:13:13 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH -next] fs_parse: make function fs_param_bad_value() static
Date:   Tue, 7 Jul 2020 19:23:23 +0800
Message-ID: <20200707112323.9117-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sparse tool complains as follows:

fs/fs_parser.c:192:5: warning:
 symbol 'fs_param_bad_value' was not declared. Should it be static?

Function fs_param_bad_value() is not used outside of fs_parser.c,
so marks it static.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 fs/fs_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index ab53e42a874a..68b0148f4bb8 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -189,7 +189,7 @@ int fs_lookup_param(struct fs_context *fc,
 }
 EXPORT_SYMBOL(fs_lookup_param);
 
-int fs_param_bad_value(struct p_log *log, struct fs_parameter *param)
+static int fs_param_bad_value(struct p_log *log, struct fs_parameter *param)
 {
 	return inval_plog(log, "Bad value for '%s'", param->key);
 }

