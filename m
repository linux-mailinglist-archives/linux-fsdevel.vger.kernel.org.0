Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83A53F80E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 05:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhHZDQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 23:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhHZDQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 23:16:04 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FEBC061757
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Aug 2021 20:15:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s11so1817117pgr.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Aug 2021 20:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/FRDpU19jEX72ioiIcPwAkcRKAZ3d8wedehja87eDdM=;
        b=FHs51ZfySnCFDVsdi9x4YQLdIl+TeyWGHms6ZaOXVMYnz3/R1nmtdFJHK05ScbpS86
         u9HPPkW2zZ4HWKhZrqBvVltKDQ1k3jeFEi87NI+GA47rvEqdo6pUTtHGG4ld3C3IxUQq
         SoiTFn8FRUviZwqcx6+9nPHeCltqHS4fRNYAlZRIS5V1c6+zoXZsZUyCyJSKg96Kc6Py
         VvwLo1OQgjiEfaQdpvtRkGRg30JWn/LJghEsNn9ayNb2SVUIBSXgh0Ud6KSYd0qFRapy
         c8NL28JWgPsL9q6VIt1BAJwKF2ZAKHLFW8BvcYJsyzmZ2nYrGtv4/JBwlzLkPp20HaCm
         4OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/FRDpU19jEX72ioiIcPwAkcRKAZ3d8wedehja87eDdM=;
        b=AY2huSXjKTPs3AelqwYnt/qHLFFGtlWOzgf7qq5y21vLMKLglfTkN9Nh1VBAcDKeYY
         3lezH+kwBZzhXC3kz3BHuMuaxYcUK3b2y6F+jfZ45Tf9UW4V6SgGALdX50f2hCc/4ONM
         5zkXKLLMn5pLm16OVv6xVwOlxB1SBQpw7j6Nsqo4R/uxFFLduK3z0qsIrOJOi248FGg+
         dl0uZK3SCgHqfP+2TuxT7LeHUKvY/ZlVUA1gWJoavOkjdPrhPoDnpaiXv0OqTFkOWJdz
         g8z1cazSQYeeWS924U3eTI1upU7uv+GURrHTwAt3kNANWuzwxbZK1PGjuMQ/1MuHcqZM
         DQFA==
X-Gm-Message-State: AOAM531Qz2k4RsHfAqbvmWB6xFh3D4gWi6uueeBUJdBrfo3yYX7Re83E
        u50RQqxe6ax34bVuBqxOKJq3mxYd3vaY8Q==
X-Google-Smtp-Source: ABdhPJyjn7w6nZvzYmoz33Fwe4wBTn9Hu+9UP0mdgZlnhFYJ7Jy0RFjv1QFV8scBpavN89miV9AVJA==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr1396205pgq.206.1629947717477;
        Wed, 25 Aug 2021 20:15:17 -0700 (PDT)
Received: from AHUANG12-1LT7M0.lenovo.com (1-174-61-115.dynamic-ip.hinet.net. [1.174.61.115])
        by smtp.gmail.com with ESMTPSA id y27sm953358pfa.29.2021.08.25.20.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 20:15:17 -0700 (PDT)
From:   Adrian Huang <adrianhuang0701@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] exec: fix typo and grammar mistake in comment
Date:   Thu, 26 Aug 2021 11:14:51 +0800
Message-Id: <20210826031451.611-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

1. backwords -> backwards
2. Remove 'and'

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 fs/exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 38f63451b928..7178aee0d781 100644
--- a/fs/exec.c
+++ b/fs/exec.c
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
+ * Copy argument/environment strings from the kernel to the processe's stack.
  */
 int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
 {
-- 
2.27.0

