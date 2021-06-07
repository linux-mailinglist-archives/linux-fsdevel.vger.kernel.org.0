Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C96239D9B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 12:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFGKdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 06:33:55 -0400
Received: from m12-15.163.com ([220.181.12.15]:39447 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhFGKdz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=o81iM
        2yaKW4GFjiu9Xno55x0ouWw1HIlF2M5RhpAFis=; b=IswmJiD5b+p3VqqBHxqEy
        6+EGM7dHhQvlJ1ng4d3hLxXotkJGDveSldRoaxBNvxIvhii60iPMuXZXgrh/Cnpj
        1AjoHzXpyEnvSyO2bj7oY3g5Csyv+76/juycyWfpqZtpe0hWZETdLNC3fy5fdnwT
        KQNOFsIaoT3LEXUwNTVKd0=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp11 (Coremail) with SMTP id D8CowADnnNFDmb1g2xQYAA--.11S2;
        Mon, 07 Jun 2021 11:58:04 +0800 (CST)
From:   lijian_8010a29@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH v2] fs: file_table: Fix a typo
Date:   Mon,  7 Jun 2021 11:56:58 +0800
Message-Id: <20210607035658.143153-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowADnnNFDmb1g2xQYAA--.11S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWUJr1kAr15JF1UWFW3Wrg_yoW3CrX_tF
        Wkt3yDurZ8JryIvryxCanxZrykJ3W5CF1rtw43Kr9xtw45J397ursrur1xWw42qF4UtFyk
        GF1kur15Cr1IkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnDKsUUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiSg2qUFPAOmUm5gAAsx
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'happend' to 'happen'.

Signed-off-by: lijian <lijian@yulong.com>
---
v2: change 'happend' to 'happened'.
 fs/file_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 4891f267b69a..f40df305dd3b 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -121,7 +121,7 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
 }
 
 /* Find an unused file structure and return a pointer to it.
- * Returns an error pointer if some error happen e.g. we over file
+ * Returns an error pointer if some error happened e.g. we over file
  * structures limit, run out of memory or operation is not permitted.
  *
  * Be very careful using this.  You are responsible for
-- 
2.25.1

