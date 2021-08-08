Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FE13E3904
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 07:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhHHFZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 01:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHHFZF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 01:25:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0916BC061760
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Aug 2021 22:24:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k2so12833308plk.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Aug 2021 22:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iD5xug5gH+aE1/eKaizPOLC3q8YITPs84DAF43cLMV4=;
        b=u/RUD8L09VoKtMJcWjNc/OaICz/+ih/DkygHbZXUgs2xkaFKIhJ81WUXgv2c2kmQbU
         XBJb8RrGaCbCOAzqCESczjlkgwn/Cm30eww+WhAYDOx3eWwxPVVJPVC46bchwiUiGc9T
         gtWTr1yybvzm/3Pz55XTnANPH4dKHUv0QmOG9EL5uIZgf3zAhkMGnbJbsgn7lwnLepr5
         ymdfkSrFu93UZ3IugRaFWHr0CZHPzj9U2VI+Zmsq0VSbJA6q3Vm8meGq02BO+X0XH0DO
         5fsuFCckLR99bJTxJ++Zzb7AvAOfrBvVrpCPsnO1G87Q5n64A+bJHE3ooQhbZ2Dm3SRD
         r9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iD5xug5gH+aE1/eKaizPOLC3q8YITPs84DAF43cLMV4=;
        b=mfghWiKB3cHwk/9PpavpMYp3ffOdiTHo/VFJyw+9l9Z4S2MLppyt3UmEQvJ9baSJ9k
         cBokL5CX5EPJVXyIa7UPOsqVR64DZv08fvOVrpcc6w+uWVo+jfwEUeW8u0BHNq5MXkpl
         YeFH6LlMd5ddB8TMGjazxbLOiaJta0TdgjvcMaW02KWcs8caoHVMG92ORzNqF8Brene6
         491Ebcx48T8RvNjT24oieE6jbVmcq+nkGKmnweQi2L2hdtxTsqWjqLF1DHcE0af4eiih
         VZusB9NhtHTTMWdf/9Ja9wV6LjM3+8Ky4BfPmHKrLP5RV8k+vstHeVlw/scJKEcvdugC
         jwiQ==
X-Gm-Message-State: AOAM533oaWaLcRCWbxqMyWZHEg+n2hanLRGNqY17uWXBAV0Gx5MG+kkY
        Hby/LnRxByBG3Hl/wdQfjBtYrvXBe2YL7g==
X-Google-Smtp-Source: ABdhPJyO1oq2yAC/vmkZ+DVpdJPcLf9tt0Bm0dEmWk9+1v/185UdBzCcAvSGBUOSbuxQ/freBux11Q==
X-Received: by 2002:a17:903:22c6:b029:12c:8da8:fd49 with SMTP id y6-20020a17090322c6b029012c8da8fd49mr15092798plg.79.1628400285339;
        Sat, 07 Aug 2021 22:24:45 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c29e:146d:490d:33cc])
        by smtp.gmail.com with ESMTPSA id b26sm15899214pfo.47.2021.08.07.22.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 22:24:44 -0700 (PDT)
Date:   Sun, 8 Aug 2021 15:24:33 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 1/5] kernel/pid.c: remove static qualifier from
 pidfd_create()
Message-ID: <0c68653ec32f1b7143301f0231f7ed14062fd82b.1628398044.git.repnop@google.com>
References: <cover.1628398044.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628398044.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the idea of returning pidfds from the fanotify API, we need to
expose a mechanism for creating pidfds. We drop the static qualifier
from pidfd_create() and add its declaration to linux/pid.h so that the
pidfd_create() helper can be called from other kernel subsystems
i.e. fanotify.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/pid.h | 1 +
 kernel/pid.c        | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index fa10acb8d6a4..af308e15f174 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -78,6 +78,7 @@ struct file;
 
 extern struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
+int pidfd_create(struct pid *pid, unsigned int flags);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index ebdf9c60cd0b..d3cd95b8b080 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -550,10 +550,12 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
  * Note, that this function can only be called after the fd table has
  * been unshared to avoid leaking the pidfd to the new process.
  *
+ * This symbol should not be explicitly exported to loadable modules.
+ *
  * Return: On success, a cloexec pidfd is returned.
  *         On error, a negative errno number will be returned.
  */
-static int pidfd_create(struct pid *pid, unsigned int flags)
+int pidfd_create(struct pid *pid, unsigned int flags)
 {
 	int fd;
 
-- 
2.32.0.605.g8dce9f2422-goog

/M
