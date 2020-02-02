Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2E514FD44
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 14:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgBBNVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Feb 2020 08:21:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbgBBNVe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Feb 2020 08:21:34 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1CD0019DDCFA158EFFD1;
        Sun,  2 Feb 2020 21:21:30 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Sun, 2 Feb 2020 21:21:21 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yaohongbo@huawei.com>, <chenzhou10@huawei.com>
Subject: [PATCH -next] fs_parse: make fs_param_bad_value() static
Date:   Sun, 2 Feb 2020 21:15:46 +0800
Message-ID: <20200202131546.30174-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix sparse warning:

fs/fs_parser.c:192:5: warning:
	symbol 'fs_param_bad_value' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 fs/fs_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index fdc047b..904e91f 100644
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
-- 
2.7.4

