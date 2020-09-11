Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1691265F0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 13:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgIKLrc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 07:47:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725803AbgIKLrP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:47:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9FDFB7BABC0350C4F33;
        Fri, 11 Sep 2020 19:46:24 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 19:46:22 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <hdegoede@redhat.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] fs: vboxsf: Fix a kernel-doc warning in vboxsf_wrappers.c
Date:   Fri, 11 Sep 2020 19:43:39 +0800
Message-ID: <20200911114339.62308-1-wanghai38@huawei.com>
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

fs/vboxsf/vboxsf_wrappers.c:132: warning: Excess function parameter 'param' description in 'vboxsf_create'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/vboxsf/vboxsf_wrappers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/vboxsf/vboxsf_wrappers.c b/fs/vboxsf/vboxsf_wrappers.c
index bfc78a097dae..3b6630e2847d 100644
--- a/fs/vboxsf/vboxsf_wrappers.c
+++ b/fs/vboxsf/vboxsf_wrappers.c
@@ -114,7 +114,7 @@ int vboxsf_unmap_folder(u32 root)
  * vboxsf_create - Create a new file or folder
  * @root:         Root of the shared folder in which to create the file
  * @parsed_path:  The path of the file or folder relative to the shared folder
- * @param:        create_parms Parameters for file/folder creation.
+ * @create_parms: create_parms Parameters for file/folder creation.
  *
  * Create a new file or folder or open an existing one in a shared folder.
  * Note this function always returns 0 / success unless an exceptional condition
-- 
2.17.1

