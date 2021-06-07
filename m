Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DFA39D4AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 08:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFGGN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 02:13:59 -0400
Received: from m12-15.163.com ([220.181.12.15]:48642 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhFGGN7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ucIsH
        6s5UZSTSd8u+dhiLzuICj1ex/HPmgmtvqBoX0E=; b=pqkQ5t3QBj0t4B828o/jB
        tMCwNz+hS3ydWGhIx2uAQCaLt2w/KsO5TWqXE18IyPdufRFsxrGUHAZx/8Gg01nD
        ZK+xcj3AbshUcAQlxDfm5q4W+FvDCa25Dqr1v5hOEBeMsKaBXu1oHa2Y6TRauFP4
        u8wY5oBJd7vp8WyLftucuM=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp11 (Coremail) with SMTP id D8CowACnrqbvtL1glWEjAA--.48S2;
        Mon, 07 Jun 2021 13:56:08 +0800 (CST)
From:   lijian_8010a29@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] fs: fs-writeback: Fix a typo
Date:   Mon,  7 Jun 2021 13:55:00 +0800
Message-Id: <20210607055500.159160-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowACnrqbvtL1glWEjAA--.48S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrW8GrW5KrWxXw15Zry7Jrb_yoW3trc_Wr
        4Iqr48CF4DXFW5Xr4xAFs3tryvqw1rCFyxJa1DKF4DG345Zws8Zrs8Gryqvr12qFy7Za93
        u3ZFgrW7Zay29jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnWGQDUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiLxiqUFUMY1-DoQAAsK
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'paramters' to 'parameters'.

Signed-off-by: lijian <lijian@yulong.com>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 7c46d1588a19..f827490a41aa 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -215,7 +215,7 @@ void wb_wait_for_completion(struct wb_completion *done)
  * Parameters for foreign inode detection, see wbc_detach_inode() to see
  * how they're used.
  *
- * These paramters are inherently heuristical as the detection target
+ * These parameters are inherently heuristical as the detection target
  * itself is fuzzy.  All we want to do is detaching an inode from the
  * current owner if it's being written to by some other cgroups too much.
  *
-- 
2.25.1

