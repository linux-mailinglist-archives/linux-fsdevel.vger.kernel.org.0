Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E18B265F4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 14:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgIKMIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 08:08:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:32768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbgIKMID (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:08:03 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 34660C9AB0915342A1BE;
        Fri, 11 Sep 2020 20:07:45 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 20:07:40 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] fs_parser: Fix 'name' kernel-doc warning in validate_constant_table()
Date:   Fri, 11 Sep 2020 20:04:54 +0800
Message-ID: <20200911120454.70466-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

fs/fs_parser.c:322: warning: Excess function parameter 'name' description in 'validate_constant_table'

This parameter is not in use. Remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/fs_parser.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index ab53e42a874..a5bd6ea5a03 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -310,7 +310,6 @@ EXPORT_SYMBOL(fs_param_is_path);
 #ifdef CONFIG_VALIDATE_FS_PARSER
 /**
  * validate_constant_table - Validate a constant table
- * @name: Name to use in reporting
  * @tbl: The constant table to validate.
  * @tbl_size: The size of the table.
  * @low: The lowest permissible value.
-- 
2.17.1

