Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC4D39D2C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 03:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhFGCAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 22:00:00 -0400
Received: from m12-17.163.com ([220.181.12.17]:35099 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhFGCAA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 22:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VV7oX
        bnHCAfOg77rhAZOko34pxwPYPpLx3vndGyuS3w=; b=P1RSKNHNjMzTPxNb8ITlH
        87Cbgk7ZGT1+CJe8Tuhk8FKQeojRYD0HnI74ZG0rhFTPQyS/ankWWJzLwaV/MIge
        LZVnloUMJl0+rwB1l3ovwV6lbHBFDhEbeiQsOrC1cM93L1G4Cq6AjjJnR88ocdfj
        SUY00+SlVK/8WFEUWzwkuQ=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp13 (Coremail) with SMTP id EcCowADXqGAufb1gnMpy5w--.42944S2;
        Mon, 07 Jun 2021 09:58:07 +0800 (CST)
From:   lijian_8010a29@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] fs: exec: deleted the repeated word
Date:   Mon,  7 Jun 2021 09:57:08 +0800
Message-Id: <20210607015708.35584-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowADXqGAufb1gnMpy5w--.42944S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFW7uFyDJr1kGr4xuF15urg_yoWxZrXEyw
        4UAFy0grZ8trWIyFy5K3ZaqryIqa18Ar98XF1rKF93X34YqF43CrZ5Jr1IkryDXrWDZa43
        Xan5WayDuay8WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5jZX7UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiEQ+qUF7+3nHfgwAAs3
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: lijian <lijian@yulong.com>

deleted the repeated word 'from' in the comments.

Signed-off-by: lijian <lijian@yulong.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 18594f11c31f..b6cad5ea78d0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -120,7 +120,7 @@ bool path_noexec(const struct path *path)
  * Note that a shared library must be both readable and executable due to
  * security reasons.
  *
- * Also note that we take the address to load from from the file itself.
+ * Also note that we take the address to load from the file itself.
  */
 SYSCALL_DEFINE1(uselib, const char __user *, library)
 {
-- 
2.25.1


