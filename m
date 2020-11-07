Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9D22AA640
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 16:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgKGPaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Nov 2020 10:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgKGPaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Nov 2020 10:30:19 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EF9C0613CF;
        Sat,  7 Nov 2020 07:30:18 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id x23so2369470plr.6;
        Sat, 07 Nov 2020 07:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9NXH+Ms7XkWHFZBe4Cvg39ykSyyKv7UXBKIHhl19iEo=;
        b=FRmLSBi0+GDidM3ZaJpQ6FPDJhqM5IibBL6livR2q8y9+Z93auYFYRTnKx/QhHPfon
         qHV6T3V7FEnXf8oWwYAbMWSa7NWdA1yyhfVKSQm6oL9CaUSy6NMgBcYV0JLs0P86ZqAi
         7Gr29uUJ5+bgs1ze8gDKv9iiIcQqRXWPf3lmloWObxrA7BeOhC/vz7cOqxuTZlORcdZh
         d3QTUgmC7GUsL6oe+W7ki1PkIk6RxJdSWObwx5bEK93U7IZHWxErN4FretyTbyvsGfQh
         AzD6kv5cEGbXvbdda1k/wbNGAyOHgPjje3EW9a8MaiUQGpuiSmsGXGmQmhoclnb0siRv
         kCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9NXH+Ms7XkWHFZBe4Cvg39ykSyyKv7UXBKIHhl19iEo=;
        b=CRRb4bZmPRPdt6qVa99RB4LF6EsuV6IXN+U2KKPqKE8+oqH4TKxal4wMAOQi7yXQbv
         Boo0vJ28Rdg0CKQTh4ZIzdK3g6YYNPEsNXOojp7KMNSWZOWZn2gWwFzf+fwQp6NdIkyV
         jPzEamMoseo/2Ntc0s27v4vtLqMOS8tWHQSV47IEJa8jAGknJxPHt32JZTVq/+OH2a5x
         4kGpRWWIid82/qgBSGSf/jS/2uh+DIFxi/ygKG4WTHsyfiMxK5XQNFj2EZ44JJPcbQYp
         LCc7IO8dYClKoPfn52YP2ku0L+h+qxWH38PkL9ouE9D5c7N+o89yBqj1+4qzojxUgJIW
         ISmg==
X-Gm-Message-State: AOAM530+7fLws6EXSfVkFaFmF659dv+qvQiUEKWSu2SlAjRTpwrgoKOQ
        wYJE/7Sk72z+ECyoN65bRmo5AIv5KeRA
X-Google-Smtp-Source: ABdhPJwq37eTVs9NlA7M/eF5J2yHMnTVyNXkWu4QuZzoIdgh08llFivFr7vyvR7F8xQqcMDHCHU5ng==
X-Received: by 2002:a17:902:56e:b029:d5:d861:6b17 with SMTP id 101-20020a170902056eb02900d5d8616b17mr5810449plf.17.1604763018332;
        Sat, 07 Nov 2020 07:30:18 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id w70sm4816913pfc.11.2020.11.07.07.30.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 07:30:17 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     adobriyan@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] proc: fix comparison to bool warning
Date:   Sat,  7 Nov 2020 23:30:11 +0800
Message-Id: <1604763011-7972-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Fix the following coccicheck warning:

./fs/proc/generic.c:370:5-31: WARNING: Comparison to bool

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 fs/proc/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 2f9fa179194d..4533eb826af7 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -367,7 +367,7 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 
 	write_lock(&proc_subdir_lock);
 	dp->parent = dir;
-	if (pde_subdir_insert(dir, dp) == false) {
+	if (!pde_subdir_insert(dir, dp)) {
 		WARN(1, "proc_dir_entry '%s/%s' already registered\n",
 		     dir->name, dp->name);
 		write_unlock(&proc_subdir_lock);
-- 
2.20.0

