Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD526293985
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 13:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392414AbgJTLBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 07:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392406AbgJTLBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 07:01:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CD3C0613CE
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 04:01:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n16so689512pgv.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 04:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxAYr2sFB3M55J3MySzPgg9HcO1IPfrCWJA+c9nDhwg=;
        b=wXgX62b0D8vcdXwNsi47cgqrQ4OAEHe/LTs7wKNjiZVx3vGvqt1Q7JeOnUNzqDOQ2+
         Npobpnm7EUIkvc6nfu0DKvdCM+YoY74j/htMAltCDKYn/EwGxqorKBTFgFo6lqQRQsIo
         bNr1j0Vndr4tvxM5W9BW6EzqpkEwUULM6L4+ohoIToW3Nd2Cg1JsFUUL8eTpRa9x3VQU
         L4J9A0RqEGmHDLLMHvfUfjJz0nr4oOSRz94N+DEMfe5DC2zonxevhesgPjxUszmwYaHu
         8Zqp6kz9I3k7+58I41yYFVi3FQqIt2609vBB2kKQVKSvX9vJsQeQ34RIAIjh9oe2+pHN
         1MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxAYr2sFB3M55J3MySzPgg9HcO1IPfrCWJA+c9nDhwg=;
        b=UUrUbPBiGjOTVCO04GSCSXqpDltC8BsTKRM/6pQKeNJiOkDGg7eMXZ398nZwxlx5lV
         2ZWU4DCkO/cypjs0oKPAHVyw2TJNmW42HbIfty3Q3AECUyptOIACh3a+g8KKDoaE7NL7
         SEq8IdGw0/7L2nSfRjlE8ALYlQPD+AWNhGxbMbNzzMhTH4uEYuBrrM5nQQ9wmYO0YcaX
         KtAA6DXI6vAfYyTQZUyFCFlsCmdqn402FC+bGzcB4YWCrTjsgh2a0Qfshw2l4Zz7TeN0
         GE6ugYAnJ6rMTWKgOAf+ACiMkMc0KbHmpIDLhFNqhVKA19d0AfFcsePl0ONu/o61N7zx
         7lQw==
X-Gm-Message-State: AOAM533F/m6MHnCRCmjdFAvbR6LqUb6X9Jk/IBgGm8ZTJCzZs0R7sCOv
        Mz5YQYs0GMEhxJ/hcIfLM9J+jA==
X-Google-Smtp-Source: ABdhPJyXjZjZR3KxkQQdtD1qmYQ+1KSWxfWiXSvRuxxGUrBX8s5yprlvLHfXrHVyvAxG806mF+TZnw==
X-Received: by 2002:a63:165b:: with SMTP id 27mr2106910pgw.197.1603191694421;
        Tue, 20 Oct 2020 04:01:34 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id b15sm1668976pju.16.2020.10.20.04.01.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2020 04:01:33 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        anmar.oueja@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dcookies: Make dcookies depend on CONFIG_OPROFILE
Date:   Tue, 20 Oct 2020 16:31:27 +0530
Message-Id: <51a9a594a38ae6e0982e78976cf046fb55b63a8e.1603191669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The dcookies stuff is used only with OPROFILE and there is no need to
build it if CONFIG_OPROFILE isn't enabled. Build it depending on
CONFIG_OPROFILE instead of CONFIG_PROFILING.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ Viresh: Update the name in #endif part ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 fs/Makefile              | 2 +-
 include/linux/dcookies.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index 7bb2a05fda1f..a7b3d9ff8db5 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -64,7 +64,7 @@ obj-$(CONFIG_SYSFS)		+= sysfs/
 obj-$(CONFIG_CONFIGFS_FS)	+= configfs/
 obj-y				+= devpts/
 
-obj-$(CONFIG_PROFILING)		+= dcookies.o
+obj-$(CONFIG_OPROFILE)		+= dcookies.o
 obj-$(CONFIG_DLM)		+= dlm/
  
 # Do not add any filesystems before this line
diff --git a/include/linux/dcookies.h b/include/linux/dcookies.h
index ddfdac20cad0..8617c1871398 100644
--- a/include/linux/dcookies.h
+++ b/include/linux/dcookies.h
@@ -11,7 +11,7 @@
 #define DCOOKIES_H
  
 
-#ifdef CONFIG_PROFILING
+#ifdef CONFIG_OPROFILE
  
 #include <linux/dcache.h>
 #include <linux/types.h>
@@ -64,6 +64,6 @@ static inline int get_dcookie(const struct path *path, unsigned long *cookie)
 	return -ENOSYS;
 }
 
-#endif /* CONFIG_PROFILING */
+#endif /* CONFIG_OPROFILE */
 
 #endif /* DCOOKIES_H */
-- 
2.25.0.rc1.19.g042ed3e048af

