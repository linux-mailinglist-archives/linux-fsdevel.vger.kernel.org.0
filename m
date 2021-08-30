Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3509F3FB20A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 09:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhH3HpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 03:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbhH3HpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:45:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DEBC061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 00:44:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g184so12589974pgc.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=n3s+aWgMpeDFSdHAYKGGE6ShOJD+E15iEl3av0MxhAE=;
        b=o9xDf91U+BdUEavL2dR+tCuO84V/Qjduab0fY178+9ZUf9lB0N40NlKv/hLGXf3bU+
         RaQA4N8sjMw1gfLzepa6LIZMVjMKd26HoXa+142wSEmLXrWlPIhKuF6tkoEJHEkZ9/4Z
         fdzhNMlvwevUlZswjGuMUTSzAwXBGScxeC1NVnXQMLbL7DpVEEfx9g6jZC3wU8xnHKzH
         04tQEpyO1uv6g9GXKMOxYKhviWtwDfbtVenVCGKu4aPkyR+eVAH3Dq5NxNYwlDyKxW96
         DP9ZWflncY3wNpu9vaXCfcij4NJvS63sOSRObash8I/vcp3DD5WrWhBNWe3mD7i34vSt
         SHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n3s+aWgMpeDFSdHAYKGGE6ShOJD+E15iEl3av0MxhAE=;
        b=cAkDLg4+R3qDQVnk+Vjk+NhhDnktfr3Yx+KxTk1LN4HmT38DfMQG2FU5H3qgg6l/5k
         INlmRmPx9ZPzbhMoXxLuN2IHRf4jj9s/H+W6ro1MqgfeGb65IL4GMqFY2qOT3eQbam6q
         8XI3M7vNMXwyNnl8SGK33csgRGnruiy9EB/Bcme+i77b3Jr5cQ2tQUQEJ0DjTvqAePFf
         m6ScQYSi4lutlJRAtygfC/nvb3bCuoHz35nU3lEPbHOKBx/SjvqvYNVYcIBIekHWed8L
         a0UDCLWToGXB+HTQQC00hxFwxxDTi0lHY6hxB5W6OimfAKKPUNugKuoasa9Yx8R9uEu7
         M3oQ==
X-Gm-Message-State: AOAM531vSvXo1Do+P+3Sdwtw0Lk1k2fyYwmK6htlChd8R3yi1ZxEDf6z
        rlSzJELmuStMig1XTvy9an3iv6Bqk5ag1Q==
X-Google-Smtp-Source: ABdhPJyNKN4983JW1NBaM++8m/SWjEp3LC9Qw/8YcASV9RegPvG3cNnOQLJ8vx49/BGyILTloADZwA==
X-Received: by 2002:a05:6a00:1ac7:b0:3e2:2d05:3b31 with SMTP id f7-20020a056a001ac700b003e22d053b31mr22187868pfv.2.1630309465996;
        Mon, 30 Aug 2021 00:44:25 -0700 (PDT)
Received: from AHUANG12-1LT7M0.lenovo.com (1-174-51-2.dynamic-ip.hinet.net. [1.174.51.2])
        by smtp.gmail.com with ESMTPSA id a23sm8842873pfo.120.2021.08.30.00.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 00:44:25 -0700 (PDT)
From:   Adrian Huang <adrianhuang0701@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH v2 1/1] exec: fix typo and grammar mistake in comment
Date:   Mon, 30 Aug 2021 15:44:06 +0800
Message-Id: <20210830074406.789-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

1. backwords -> backwards
2. Remove 'and' and whitespace
3. Correct the possessive form of "process"

Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
Changes since v2:
 * Correct possessive form of "process" and fix the grammar, per Randy 

 fs/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 38f63451b928..d0e20fedde21 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -504,7 +504,7 @@ static int bprm_stack_limits(struct linux_binprm *bprm)
 
 /*
  * 'copy_strings()' copies argument/environment strings from the old
- * processes's memory to the new process's stack.  The call to get_user_pages()
+ * process's memory to the new process's stack. The call to get_user_pages()
  * ensures the destination page is created and not swapped out.
  */
 static int copy_strings(int argc, struct user_arg_ptr argv,
@@ -533,7 +533,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 		if (!valid_arg_len(bprm, len))
 			goto out;
 
-		/* We're going to work our way backwords. */
+		/* We're going to work our way backwards. */
 		pos = bprm->p;
 		str += len;
 		bprm->p -= len;
@@ -600,7 +600,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 }
 
 /*
- * Copy and argument/environment string from the kernel to the processes stack.
+ * Copy an argument/environment string from the kernel to the process's stack.
  */
 int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
 {
-- 
2.27.0

