Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CCE38C24C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 10:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhEUIyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 04:54:35 -0400
Received: from m12-16.163.com ([220.181.12.16]:41650 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231997AbhEUIyR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 04:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZTzuX
        fJn3QgTmYp1EYsez1K1U40m36RHdwnIyXbDqH4=; b=U0rZv6HCAKO3fYjxH/ey2
        /7uHJMVDMRSIv/a4kJh3XmGtClVph3vcKf0gViksyZ+TG+WC6SxrK+PKRVn1SRQN
        RtGiYyWtbaUZHF4HfiwyPnefnAMyQShEq7Yp7UTla4cfDW+1Jz2C5NIN4yYvlH4l
        he7SwMfjJ80UPv0xOswg9E=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp12 (Coremail) with SMTP id EMCowABndDXgdKdgAX7JsQ--.16448S2;
        Fri, 21 May 2021 16:52:52 +0800 (CST)
From:   zuoqilin1@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] fs: Fix typo
Date:   Fri, 21 May 2021 16:52:58 +0800
Message-Id: <20210521085258.30-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowABndDXgdKdgAX7JsQ--.16448S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7FApUUUUU
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiZQSZiV8ZOoXrewAAsY
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Change 'backwords' to 'backwards'.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 18594f1..17c067a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -536,7 +536,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 		if (!valid_arg_len(bprm, len))
 			goto out;
 
-		/* We're going to work our way backwords. */
+		/* We're going to work our way backwards. */
 		pos = bprm->p;
 		str += len;
 		bprm->p -= len;
-- 
1.9.1


