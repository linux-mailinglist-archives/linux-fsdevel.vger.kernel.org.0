Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2FA39D4A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 08:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFGGJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 02:09:57 -0400
Received: from m12-12.163.com ([220.181.12.12]:42034 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhFGGJ5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=e3HVO
        33jWIQeAYjTiaJgSFTUeqx8JRvBeqjse2s1de8=; b=DmxaclLUdaVMkprQ5kReh
        4+G4MYuaj94L20EOXzCJLr0o8j/e/aQQerVs8CvAKY+hF17ClGqfOKj9r0kiHhUL
        MUQofZjsao/uB96wu6h6weNGjFxCwEeoGiGa7KppL50wE239fLlxOq/titKUd5XC
        MM9p4qJBXS/zSqeNRkdSYk=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowABHECHAt71g2aYbIg--.2774S2;
        Mon, 07 Jun 2021 14:08:01 +0800 (CST)
From:   lijian_8010a29@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] fs: read_write: Fix a typo
Date:   Mon,  7 Jun 2021 14:07:03 +0800
Message-Id: <20210607060703.174599-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowABHECHAt71g2aYbIg--.2774S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur4xWryUtry8Kr4rZw1kZrb_yoW3JwcEkr
        WIkr4vvr4qvr1xAa48uayYqw1jg3yFkFsYqanxtr98t347t34vka9Iqwn5Kr1UJr47WFyY
        kFs2qw1rWr12vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnunQUUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbi3wGqUGB0GdN6SwAAsL
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'implemenation' to 'implementation'.

Signed-off-by: lijian <lijian@yulong.com>
---
 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 9db7adf160d2..ba9bf77d93f8 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -137,7 +137,7 @@ EXPORT_SYMBOL(generic_file_llseek_size);
  * @offset:	file offset to seek to
  * @whence:	type of seek
  *
- * This is a generic implemenation of ->llseek useable for all normal local
+ * This is a generic implementation of ->llseek useable for all normal local
  * filesystems.  It just updates the file offset to the value specified by
  * @offset and @whence.
  */
-- 
2.25.1


