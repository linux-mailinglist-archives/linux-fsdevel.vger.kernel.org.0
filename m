Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6344439D2BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 03:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFGBwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 21:52:24 -0400
Received: from m12-11.163.com ([220.181.12.11]:53177 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230105AbhFGBwX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 21:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KASRf
        sJZfB0R3HcXymPXFzkDkoz+t+ibdyfUWbvlin8=; b=PVbVqFFV0sJTm3MgUQlbF
        fq2uOpi3Ui1FtObHQK3POZDd+aImxVdHSMy/iulhhCRWO4knTVk6VJXDEFTd5mNr
        Tr5WG66EiSMZHGGXp1UMmBKVsJ6kZdR+lJhFBF/ClVVqy3Q3H4224lUKoVG6vDkK
        tAUYeFIW/GijxaaJaceHGc=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp7 (Coremail) with SMTP id C8CowADXwYlme71gwUmNgg--.202S2;
        Mon, 07 Jun 2021 09:50:31 +0800 (CST)
From:   lijian_8010a29@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] fs: namei: deleted the repeated word
Date:   Mon,  7 Jun 2021 09:49:33 +0800
Message-Id: <20210607014933.20329-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowADXwYlme71gwUmNgg--.202S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4kKw1rJrW3ury8uw4kZwb_yoWfXrgEya
        ykXF48WayrG3Wakay5Gw4fJrySqa1F9r1jkas5tF9rWa45JrW5JFsYgw10qrWUWFy5Xasr
        uFn7X3s29F4FgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5b_-JUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiSgeqUFPAOmNSWAAAs3
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: lijian <lijian@yulong.com>

deleted the repeated word 'to' in the comments

Signed-off-by: lijian <lijian@yulong.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 79b0ff9b151e..4062c00827fd 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -770,7 +770,7 @@ static bool try_to_unlazy(struct nameidata *nd)
  * @seq: seq number to check @dentry against
  * Returns: true on success, false on failure
  *
- * Similar to to try_to_unlazy(), but here we have the next dentry already
+ * Similar to try_to_unlazy(), but here we have the next dentry already
  * picked by rcu-walk and want to legitimize that in addition to the current
  * nd->path and nd->root for ref-walk mode.  Must be called from rcu-walk context.
  * Nothing should touch nameidata between try_to_unlazy_next() failure and
-- 
2.25.1

