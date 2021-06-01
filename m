Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880E2397840
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 18:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhFAQpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbhFAQpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:45:00 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CD2C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jun 2021 09:43:18 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h3-20020a1709026803b029010163ec78c5so3969001plk.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aTLuLVDR3lxcou2oBOuWuwpILE9+p4rbUTDh4A1ndUg=;
        b=cgjkARurXBSRrO3zA1rIuwqKH1hSgO+xKdOaemlYS/J7t4GR8aKmW37vIRssyT84e+
         D0QBFjgw7JZ7W2aE16mcr9xjkmCVufU++TxZpytMBMJEcPlwcJQ3Mv0/1r/C3/RAOlsO
         +QKvzP5we6zfaCnj0QM25edS3B6Rsgfxb/CM84uVVgfyOtkBnIp2fJ71NX0eu6rtund5
         BchPtn9k068U3QJaUBdHHT3t5pqZa8tfFtHP814l7KRV7HgUKSomKUj2u3DA9CeMZ6Rs
         EWE3/S81qRxQWUb65DICAssi9TKj6lm4fUSKrzRHfyGCS2DGwn874dgSe5PDMgVhu4Gr
         Kbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aTLuLVDR3lxcou2oBOuWuwpILE9+p4rbUTDh4A1ndUg=;
        b=akf8INeMShkr1NbM5+m+DG0NHXhXaYXCZtp4MqILLjdcHXRvRipTT/cxgQ8PPxrBF0
         hfydxxjddIMSmyV7Al1xQ08ce4RnkR9Qp2/bv1dXt3aVpXiYM3xeqa3EMOkWqYWUbf7b
         TBRQfkyZSaQWgHP0Iw1wkUSLXDfTdcRiwkfOjFcCGaBUwBYn8M3curpYOsBzeERDeMIO
         zaInAz6O96f0LJE7yELZQket7qbmRWhENlmXtGMQyxoYoLiX9zloo0hGFvZqVKPGtkQJ
         rVXWUffybwpdTTNY0YiEa2ljukaGtgRJX6cinsvD92BGDRK1FdDF6S22OOCln8Y5vOij
         3UgQ==
X-Gm-Message-State: AOAM530gccvfqw1KPqyC5jkhVoZvWYtNtsY4L/beObYqG5KKY19ZlXXb
        +S2f8MUagyGRB8Jeo+oUADboBD7dEFU+TA==
X-Google-Smtp-Source: ABdhPJwFeayMKFWCMU7/Jn60aBx4kngs6iBv6Aw8W/fGakCaE62W9z44EIv+sa0caIvWoz3jsRv0smxvW9OVvw==
X-Received: from dmatlack-heavy.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:19cd])
 (user=dmatlack job=sendgmr) by 2002:a17:902:6902:b029:106:50e3:b2db with SMTP
 id j2-20020a1709026902b029010650e3b2dbmr7955257plk.35.1622565798266; Tue, 01
 Jun 2021 09:43:18 -0700 (PDT)
Date:   Tue,  1 Jun 2021 16:43:05 +0000
Message-Id: <20210601164305.11776-1-dmatlack@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH] proc: Add .gitignore for proc-subset-pid selftest
From:   David Matlack <dmatlack@google.com>
To:     linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This new selftest needs an entry in the .gitignore file otherwise git
will try to track the binary.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/proc/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index bed4b5318a86..8f3e72e626fa 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -10,6 +10,7 @@
 /proc-self-map-files-002
 /proc-self-syscall
 /proc-self-wchan
+/proc-subset-pid
 /proc-uptime-001
 /proc-uptime-002
 /read
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

