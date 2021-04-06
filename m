Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61535511A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 12:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbhDFKph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 06:45:37 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:15636 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhDFKph (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:45:37 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 9BA0998044F;
        Tue,  6 Apr 2021 18:45:27 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] hfsplus/hfsplus_fs.h: Remove unnecessary struct declaration
Date:   Tue,  6 Apr 2021 18:44:55 +0800
Message-Id: <20210406104500.675141-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTUpNGkhJGkoYTUIYVkpNSkxMS05CSUxCSk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCo6Pyo*HD8KFi0cFC45LxAX
        DxQKCRVVSlVKTUpMTEtOQklDSk5JVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKT0xDNwY+
X-HM-Tid: 0a78a6c9848ad992kuws9ba0998044f
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

struct hfs_btree is defined at 73rd line.
The declaration here is unnecessary. Remove it.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 fs/hfsplus/hfsplus_fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 12b20479ed2b..4da395c25f4a 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -139,7 +139,6 @@ struct hfs_bnode {
  */
 
 struct hfsplus_vh;
-struct hfs_btree;
 
 struct hfsplus_sb_info {
 	void *s_vhdr_buf;
-- 
2.25.1

