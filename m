Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA92B46E892
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 13:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhLIMl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 07:41:29 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:38359 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230094AbhLIMl3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:41:29 -0500
X-QQ-mid: bizesmtp51t1639053437tl6mn1bb
Received: from wangx.lan (unknown [218.88.126.113])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 09 Dec 2021 20:37:05 +0800 (CST)
X-QQ-SSF: 0100000000200050C000B00A0000000
X-QQ-FEAT: JP31pyibfXmZXPT3zN6WE00+qJKEgJpaJKbO49b/K+vySw0QdjA4TRAZ6id+0
        NgaE/j5yIfqk+Tq5sJL6KuuxLmxJIaB8K/jkGblsPgfmFFsU/sGP8e7FwfYP3c8V0YUxpAF
        HvJiGM6ynBNxV4UFkBDb4o09cMYdIuqB/yADYiexWoBpbrxEBDk+f65NRoEmi/LDgpjL09d
        3JtZqYrVl+tNF//F7ixYHxEEj9Q+DA7w8wpM30oQog1v/JsfkdBQGWbD51WTLB1Adm1cg/9
        hniFf4TRkc23wilKrwEmpL39kS3zflXNCZ6gPOblDAcAjJsxsJVIo/zypz8vkUAFlksQ==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     viro@zeniv.linux.org.uk
Cc:     ebiederm@xmission.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] fs/exec:Fix syntax errors in comments
Date:   Thu,  9 Dec 2021 20:37:03 +0800
Message-Id: <20211209123703.18494-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Delete the redundant word 'from'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index cc5ec43df028..d90added76f9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -118,7 +118,7 @@ bool path_noexec(const struct path *path)
  * Note that a shared library must be both readable and executable due to
  * security reasons.
  *
- * Also note that we take the address to load from from the file itself.
+ * Also note that we take the address to load from the file itself.
  */
 SYSCALL_DEFINE1(uselib, const char __user *, library)
 {
-- 
2.20.1

