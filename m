Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8711A6E89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 23:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbgDMVnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 17:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388914AbgDMVnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:43:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E84C0A3BDC;
        Mon, 13 Apr 2020 14:43:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so4646888wrx.4;
        Mon, 13 Apr 2020 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afpWVAYpzZoZj0cDvbL8nrVqxs7nYxlOztCZvs4WtUQ=;
        b=n4GgF6ZvxeiMQzKcLPJYat0oTylnX+JU8HeEovMVSF3wH7koxJ/qhOk8Rx8OsZv2ZU
         M/ouFWf+mujWlix45liM6rESmfaaySYkc4WbrHKEzprG80Tw6oCUi6AK2qopMck8TNLX
         vCvCiNaPj5g/etB57fWlQx59B4vGjQh/IH95iiXlz1YWQAal1oWT20c38lnRF1kR1pcy
         fMvDilMbH/oi9r8YRgjLOHrcwfx2OWxRIdqv4Tjw5zY+A7rRDZmY2sl6S6nw+FdmixRh
         WO0cviCLsO5h3p5ZyVJBB6rDenpX6C4U8l7wP3qL+Vz3cNO8zQN1DbiH7SnGkBpmgpqB
         8fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=afpWVAYpzZoZj0cDvbL8nrVqxs7nYxlOztCZvs4WtUQ=;
        b=WHeTLrKLR8AYA8U0rcJv4+a/WMy961JV5jr0bXbMtrdLns9okS2CWZqgDZecbWcpiZ
         AEhXFGcqbFRhi79fPp+e1X466kj2VQwzLSFeWB/qZaUWktqdun9TSVEJNnXkvPWNZ9y4
         CZ1BgEnmugOK7/QV1D00lBSwmCccsMT2t6COAA096daQ2beYRWWB2rNU2HAGotz70XSB
         +ihj33UZOkQr09kgwdZBRcoBUOVB3GfzNaovD0RLvH6gw7NrNPDVndJNpBR7DDK8AzjZ
         WVvNXiR9baUQrw7hcOb9YNo//E+usd6l5kbUQCWfeF72Fp81a23YQtTz4arLxjPs00GJ
         SMhw==
X-Gm-Message-State: AGi0PuYwszpaPiYBRenu0iMAN2jO8x+HEOBVpr+XQPyDQ7xZaT3fJ1Fi
        nvbVUvXCrH8MOzB+PfIjGABzpc3D3Q==
X-Google-Smtp-Source: APiQypKoWcnPd09pTJoHtRS5w95RqrkCG3ThrVdtiu2tqlaUdLoXeUKrjEYD25oz7RWRfHnpVPwR1Q==
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr22341815wru.371.1586814183920;
        Mon, 13 Apr 2020 14:43:03 -0700 (PDT)
Received: from ninjahost.lan (79-73-33-244.dynamic.dsl.as9105.com. [79.73.33.244])
        by smtp.gmail.com with ESMTPSA id 1sm15597703wmi.0.2020.04.13.14.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:43:03 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org (open list:FSNOTIFY: FILESYSTEM
        NOTIFICATION INFRASTRUCTURE)
Subject: [PATCH v2] fsnotify: Add missing annotation for fsnotify_finish_user_wait() and for fsnotify_prepare_user_wait()
Date:   Mon, 13 Apr 2020 22:42:40 +0100
Message-Id: <20200413214240.15245-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sparse reports warnings at fsnotify_prepare_user_wait()
	and at fsnotify_finish_user_wait()

warning: context imbalance in fsnotify_finish_user_wait()
	- wrong count at exit
warning: context imbalance in fsnotify_prepare_user_wait()
	- unexpected unlock

The root cause is the missing annotation at fsnotify_finish_user_wait()
	and at fsnotify_prepare_user_wait()
fsnotify_prepare_user_wait() has an extra annotation __release()
 that only tell Sparse and not GCC to shutdown the warning

Add the missing  __acquires(&fsnotify_mark_srcu) annotation
Add the missing __releases(&fsnotify_mark_srcu) annotation
Add the __release(&fsnotify_mark_srcu) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
changes since v2
-include annotations for fsnotify_prepare_user_wait()

 fs/notify/mark.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 1d96216dffd1..8387937b9d01 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -325,13 +325,16 @@ static void fsnotify_put_mark_wake(struct fsnotify_mark *mark)
 }
 
 bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
+	__releases(&fsnotify_mark_srcu)
 {
 	int type;
 
 	fsnotify_foreach_obj_type(type) {
 		/* This can fail if mark is being removed */
-		if (!fsnotify_get_mark_safe(iter_info->marks[type]))
+		if (!fsnotify_get_mark_safe(iter_info->marks[type])) {
+			__release(&fsnotify_mark_srcu);
 			goto fail;
+		}
 	}
 
 	/*
@@ -350,6 +353,7 @@ bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
 }
 
 void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info)
+	__acquires(&fsnotify_mark_srcu)
 {
 	int type;
 
-- 
2.24.1

