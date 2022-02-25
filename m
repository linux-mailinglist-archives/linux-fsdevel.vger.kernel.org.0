Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED624C4E18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 19:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiBYSzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 13:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiBYSzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:55:22 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBBC1CABC7;
        Fri, 25 Feb 2022 10:54:49 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hw13so12574245ejc.9;
        Fri, 25 Feb 2022 10:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FR9eFid3X2JFCac30thoddSUcXVjWfM7VVCjlcAvVos=;
        b=UpUedE542p5XufpmCZXLrUgJaQoAeOV/LJuTynfFCVjDNp9wMd3x7oktyBaUsEw3q+
         1G30QXSto77jg7E1SvpM8n67KBjQH2GM37iAnUovzwiEYDu3Flj6TlOq4tjbSw9hpsZc
         aX6j10pd6ZsVS4j6XCGv09+xkkRBVvOlmjcoEKWFzE7X9P7ul51QIPxXzookZ+sPl0x1
         l4ZDdAf4U3U+QULIgzs7PxGZM8PLjEvP9eOl657MC7TIUMCvn7dogg/M0bN/YmhXlqnC
         5lCyMo0+Dm7bFf6NSyU04FQwfYM+LfsDk4EbNoMdWrEtt8IaPOLNSXTu956VfWcNIn1j
         0bUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FR9eFid3X2JFCac30thoddSUcXVjWfM7VVCjlcAvVos=;
        b=Ui3GgGH5KDjYIiU0cmHfK1/Vm9gHgQaeX3Q5kvDA9B7RtDkz2YsWc+EfrrqLISYG9c
         7nSaTLHIepA56MNYZ8T9l/vzJ/T6kGlkdoZyjtDqsPtPDpINa/j1X2w4rX0QzLZyKciN
         GSgkhvm5w4fiOHvgy17+TLDkTyzI3fNqn7Kg/fTLD1KP34UHTwRnImPziyXOKbiab3zI
         K9GYGk0cuCWcA5Dl91XYnDwsoHnFhSLc6ck7qq17iuA4vQzUOkUDw1csyfWNj+TbpAoc
         2QSaZiiREwE/xVgZzw3AI9KeTnmlwfODs3vh6hNGEY19fTxsii8CyI0oN2aIrDs+GenT
         t7SA==
X-Gm-Message-State: AOAM530ZYC4eedOVLo2jgMHUQXSKScBe2gQZqNHJMSX8bUTVJl5Xq7TY
        MRsOED6x3ixY7qmXGjHs0Dg=
X-Google-Smtp-Source: ABdhPJx2dFzBtkXGAJI/WDmBibn4QWH/IQMXnly8GvOa19/V+Cbp36yzpGrzizCJr6wAoai4egqIgQ==
X-Received: by 2002:a17:906:4987:b0:6c9:e16a:b5bf with SMTP id p7-20020a170906498700b006c9e16ab5bfmr6953533eju.247.1645815288284;
        Fri, 25 Feb 2022 10:54:48 -0800 (PST)
Received: from heron.intern.cm-ag (p200300dc6f1cbe000000000000000fd2.dip0.t-ipconnect.de. [2003:dc:6f1c:be00::fd2])
        by smtp.gmail.com with ESMTPSA id u19-20020a170906125300b006ceb043c8e1sm1328508eja.91.2022.02.25.10.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:54:47 -0800 (PST)
From:   Max Kellermann <max.kellermann@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Max Kellermann <max.kellermann@gmail.com>
Subject: [PATCH 1/4] include/pipe_fs_i.h: add missing #includes
Date:   Fri, 25 Feb 2022 19:54:28 +0100
Message-Id: <20220225185431.2617232-1-max.kellermann@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To verify that this header's #includes are correct, include it first
in fs/pipe.c.

To: Alexander Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@gmail.com>
---
 fs/pipe.c                 | 2 +-
 include/linux/pipe_fs_i.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index cc28623a67b6..da842d13029d 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 1991, 1992, 1999  Linus Torvalds
  */
 
+#include <linux/pipe_fs_i.h>
 #include <linux/mm.h>
 #include <linux/file.h>
 #include <linux/poll.h>
@@ -16,7 +17,6 @@
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 #include <linux/magic.h>
-#include <linux/pipe_fs_i.h>
 #include <linux/uio.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index c00c618ef290..0e36a58adf0e 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -2,6 +2,9 @@
 #ifndef _LINUX_PIPE_FS_I_H
 #define _LINUX_PIPE_FS_I_H
 
+#include <linux/mutex.h>
+#include <linux/wait.h>
+
 #define PIPE_DEF_BUFFERS	16
 
 #define PIPE_BUF_FLAG_LRU	0x01	/* page is on the LRU */
-- 
2.34.0

