Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60CE4819F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 07:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhL3Gg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 01:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhL3Gg3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:36:29 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFD5C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Dec 2021 22:36:29 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id m2so20243729qkd.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Dec 2021 22:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2dEt9Nd0ARWBNMmu3W1dftD70iBiIrB3iXHWVof0Nmo=;
        b=V5tdf4M9/hX/BD/RMNvwyoburA8oTG46C9H4UkrNrfLUJi4aqWmUwajEyDyomTP7Xb
         rVYGiFdQAU0dUQ1dDjS2W27QjCnbiZ04nDR3iio8DDBF4A4fRFu38fTkniZ9GHTYb6+3
         WW/nv2zsjff5hAznkVuVdxW+O3KN91pKV+e4msMw43MBjiWHwTR/nCtCmHIkAhEmEmPg
         l1wgf5PB3+wBi+yZszJ4cdXo5r4UY+FnpkSzlyp8+47T/1YeW42xBxRCdj4j6ivNO0YN
         TFc5wDf6eBtXKobkaa9j5KHa3LR9xS7huw081Zwusz/nLXNBBkpVmnLfu1ZfSHLn0nhH
         t9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2dEt9Nd0ARWBNMmu3W1dftD70iBiIrB3iXHWVof0Nmo=;
        b=fJTS4t3jKpPtDct4dgDSYwaU3hGH+aI0U1qVlVmZtmwyRb5ommwwcKbaKwNeQNd6Fx
         GIA2ALCH26YyXNpEP9oIpJUu8s6CEk3LeAyPXJg9KXiTQtBehgPrCwerZBKaNz8f0w4N
         7D26JYILbFVpxN6wJkRdNNavmAnP7a4Ttz3+g03mKlGbkgnaMksL/rO6k7d8+bF7A64x
         pKxqw7Ckl24BMLXVJBtdNH3u6eFaDdeMiZgZH5NJehW6aM4H2F42OywrKNRagPtwulIO
         D2Ygjb5RKXYDfjcvVLjqpeqdW3iKt5gqzOyvj4F2z6b7Xw0k1FGbr+xz3FVH7shYXWvI
         qhOw==
X-Gm-Message-State: AOAM530xXaZ7j8+wzPomUsni113gFAFj/15u7S7UMWYbdZd8FP0GNgsB
        IlbtK7zlfi6Mo11V1q6Y4Ug=
X-Google-Smtp-Source: ABdhPJzGELzMg9iJZNNj8zwwxVxHMNxrgiLtkkJUI1fl2oXvr38fSVAyLGpR/Jy7lTEshCtBgtFnBg==
X-Received: by 2002:a05:620a:24c3:: with SMTP id m3mr20712178qkn.301.1640846188407;
        Wed, 29 Dec 2021 22:36:28 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e20sm20349469qty.14.2021.12.29.22.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 22:36:28 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux] sysctl: Remove redundant ret assignment
Date:   Thu, 30 Dec 2021 06:36:22 +0000
Message-Id: <20211230063622.586360-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

Subsequent if judgments will assign new values to ret, so the
statement here should be deleted

The clang_analyzer complains as follows:

fs/proc/proc_sysctl.c:

Value stored to 'ret' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 fs/proc/proc_sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 5d66fae..30d74b8 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1053,7 +1053,6 @@ static int sysctl_follow_link(struct ctl_table_header **phead,
 	struct ctl_dir *dir;
 	int ret;
 
-	ret = 0;
 	spin_lock(&sysctl_lock);
 	root = (*pentry)->data;
 	set = lookup_header_set(root);
-- 
2.15.2


