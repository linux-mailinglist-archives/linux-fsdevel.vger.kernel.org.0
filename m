Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE76A39D37F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 05:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhFGDdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 23:33:43 -0400
Received: from m12-14.163.com ([220.181.12.14]:50830 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhFGDdi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 23:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aQezI
        gDZ4Dkufbw8cfjUKRsYnvqFjm0kePbth+hDqBM=; b=ASexVYuwUAgVvRf4EY6Su
        6scAHDcPZ60VfxI3n1pyEg+FAIZoWygiJZAPBgHYP7rk/y3OsoWGOg8gZEffLjT1
        doLjDQJuRxrHJKaa6gbIppTqsZ9kR3BmuOBvnc9m34de9YeTlWnqJlRF4Zla4HOh
        YuQY2lQsWOUc8lXTxIqmY0=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp10 (Coremail) with SMTP id DsCowAB3wWUYk71gu8pbNQ--.43515S2;
        Mon, 07 Jun 2021 11:31:37 +0800 (CST)
From:   lijian_8010a29@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] fs: file_table: Fix a typo
Date:   Mon,  7 Jun 2021 11:30:39 +0800
Message-Id: <20210607033039.112297-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAB3wWUYk71gu8pbNQ--.43515S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryDXr1fJw45Aw1UCFyxuFg_yoW3Xrc_Ka
        ykt3yDua95JryIvryxGwsIqrWkX3W5AF1rJr43tF93Jw45J3yfCrsF9r1xWw42gF4UJFyk
        GF1kur43CF4jkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnQAw7UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbi3xmqUGB0GdIEJwAAsA
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'happend' to 'happen'.

Signed-off-by: lijian <lijian@yulong.com>
---
 fs/file_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 45437f8e1003..4891f267b69a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -121,7 +121,7 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
 }
 
 /* Find an unused file structure and return a pointer to it.
- * Returns an error pointer if some error happend e.g. we over file
+ * Returns an error pointer if some error happen e.g. we over file
  * structures limit, run out of memory or operation is not permitted.
  *
  * Be very careful using this.  You are responsible for
-- 
2.25.1

