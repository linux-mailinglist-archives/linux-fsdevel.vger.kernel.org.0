Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754364453B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 14:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhKDNUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 09:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhKDNUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:20:43 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787DAC061714;
        Thu,  4 Nov 2021 06:18:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b13so7192951plg.2;
        Thu, 04 Nov 2021 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cvtb8CIKfADiOEN9IcO0E0T6dQ8q9jRw5HskuILEYD0=;
        b=aFEqFuXpTTt0IMg1V94YaeIA0+Klh8Qkwwi+c2rVzdRsRe1aRZQ4mzPXYV4vqsnypI
         3dfAgLdty4lDsE7ioEesG1zM/Ff8kpKMewbQolW9w3EpfM1qm2940wOIKHTymLVdnZ8w
         b5bYccb5HVv/T5J8q/yXUkj/naw4GscAcuY1dMMDg024f6OcTKMb912Cp/+Njjg41gYd
         F4rKiQBPNub7UiLFCthvYc9nsYyCZ4D3ooOUW8XHlQEHZHdOwiEtU6lFP/M3fj3vyzCG
         w3C50UKYMttdUppfYb0VMBSR+pK8mHScKwSkeDJZ3E0o7R1InDWBqgQr2uF2Es6tovH1
         d7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cvtb8CIKfADiOEN9IcO0E0T6dQ8q9jRw5HskuILEYD0=;
        b=Lxmk5v+HtEfdGcjwW3gOUNkorPZuMDUXd7SmIKHy0xjNS6c0H+Xd2NErHI+gTlg5HP
         94Jd74Pggp4y25T+u2VxhhsZ0WXKxXGzLZQJIhql3WAiADfPN4S53Klg87gDp+NJ/NfK
         YoeeZf9EMD3gy3ruT9yErEtgEMPB+/WjBbY15T/gonOLgGUE3xbuOyDRrUcY8slohYYf
         +qNdTaBsCyX9iUAYIcDUXVFWnH1/ZeNA0P1zl42Ndz6XIlksfN9bHYwFrZw27GtSGOSE
         0ArTNGo/l02VFDAxQ1/sX424Lk5ESjfi0NJwwSnO/QPX3dPiPmu44CESTpY/4wxhg4+w
         0Ftw==
X-Gm-Message-State: AOAM531fMXPOOwrWsoC4fbtZxxu3U0mgLyT9It7VqN5cpuFmJfAO5SRY
        jg3nIncMqcWBzYFQij500CZOldqKbGo7JPjsIcWDAQ==
X-Google-Smtp-Source: ABdhPJzjKypJFDumtnVy3cT1bSgVpnHx5XhUrSeuST8L3fll0GsXhod8inLVTjEHLILIVHm2UoszFg==
X-Received: by 2002:a17:902:d643:b0:141:d7a8:3c07 with SMTP id y3-20020a170902d64300b00141d7a83c07mr28539634plh.82.1636031885060;
        Thu, 04 Nov 2021 06:18:05 -0700 (PDT)
Received: from ubuntu.localdomain ([106.39.42.116])
        by smtp.gmail.com with ESMTPSA id z18sm2044878pfe.113.2021.11.04.06.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 06:18:04 -0700 (PDT)
From:   Quanfa Fu <fuqf0919@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quanfa Fu <fuqf0919@gmail.com>
Subject: [PATCH] fs: Fix misspelling of "visible"
Date:   Thu,  4 Nov 2021 21:17:55 +0800
Message-Id: <20211104131755.558272-1-fuqf0919@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Quanfa Fu <fuqf0919@gmail.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index b6079f1a098e..dae032c2198a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1267,7 +1267,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
-	 * not visibile until then. This also enables the update
+	 * not visible until then. This also enables the update
 	 * to be lockless.
 	 */
 	retval = set_mm_exe_file(bprm->mm, bprm->file);
-- 
2.25.1

