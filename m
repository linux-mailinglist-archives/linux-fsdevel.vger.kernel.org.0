Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BDE6765AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 11:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjAUKXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 05:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjAUKXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 05:23:23 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C39126C6;
        Sat, 21 Jan 2023 02:23:22 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id fd15so6112903qtb.9;
        Sat, 21 Jan 2023 02:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t73OUm5Hu/QTQLymf1aW1FtTfvw+wRC90VtlrO5K74Q=;
        b=N2PwPl7aiBtLRfod/1/P10zXinkoVfpONWDKG314+LCXXre9Hi3O/jwhon7JMDhPmT
         Be2kdTw3IyV5fwVX+aKADrPGpzoirv8ZPSCLy36JbdzKLTUdAZ9GRA3TUJx8R5HcFwHz
         Rnmaats9Xsy2pDnKjp7KPjpRqZPW56jkaNZc4aQ4a4LL1hdPcWmCJow78aezGyZkJQiL
         N9DPXitk8uJv/lETkpSb0Fv251WaM3NG5A4JdIwLw3CThPyvyhgUCBiZsiRSBni4CwMU
         nvji5f3XnuiqKD4iswu7WDPhqsG68ea6fQKVQhI5mTeUnEXsA10WQ4KiTD9A7D1E+ALo
         3O1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t73OUm5Hu/QTQLymf1aW1FtTfvw+wRC90VtlrO5K74Q=;
        b=y720X9IRwwYLRgmFO66sub41nL97zb2ZquxiT3gg9OBEN3clMmWGiQm4HGndZLNhpN
         DmjgwbjBN15NlWM9hLALNySQFAPZF/Fy3MULlsV9G982Pbrx58hKg9qJ+4Y+I+EM96J4
         m3iWoNewvHh7ocz1RnOqSHQYVc+Ww6VGCgoWerfrOzrc6m/Axtcz9MSeujXkdVjGfXGb
         rqL53tMDYk5V2hE029GS5LsPM998bELlkhtV8yRUGDy+ila+LYjFqOetJicvg0D7H6tb
         YKt3K/cXkBUSAFCf2OJe+bJvbVLbd9hYXZqvcyzqAeJYY/NcrIQcidr4DLqd+de/ruRL
         6EBg==
X-Gm-Message-State: AFqh2kq3NA6QO/uZzUMMdGkANxLp5phulXHvNAGZw+7bgAU5RmpGhUku
        L+PoN9m+ufKfAZ9lj2seMqKNu2L2MrRs
X-Google-Smtp-Source: AMrXdXvoxvzx8N405bqrTZNfSFLLnWhxPYcHLo8caWW2pKaDjvgoiSvmxJGfqH7wvP1O7BUxdm8zrQ==
X-Received: by 2002:ac8:6e83:0:b0:3b6:3406:81cb with SMTP id c3-20020ac86e83000000b003b6340681cbmr25939497qtv.14.1674296601743;
        Sat, 21 Jan 2023 02:23:21 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id y2-20020a05620a44c200b006e42a8e9f9bsm14128630qkp.121.2023.01.21.02.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 02:23:21 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v4 1/3] ptrace,syscall_user_dispatch: Implement Syscall User Dispatch Suspension
Date:   Sat, 21 Jan 2023 05:23:14 -0500
Message-Id: <20230121102316.331935-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121102316.331935-1-gregory.price@memverge.com>
References: <20230121102316.331935-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
modify Syscall User Dispatch to suspend interception when enabled.

This is modeled after the SUSPEND_SECCOMP feature, which suspends
SECCOMP interposition.  Without doing this, software like CRIU will
inject system calls into a process and be intercepted by Syscall
User Dispatch, either causing a crash (due to blocked signals) or
the delivery of those signals to a ptracer (not the intended behavior).

Since Syscall User Dispatch is not a privileged feature, a check
for permissions is not required, however attempting to set this
option when CONFIG_CHECKPOINT_RESTORE it not supported should be
disallowed, as its intended use is checkpoint/resume.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/ptrace.h               | 2 ++
 include/uapi/linux/ptrace.h          | 6 +++++-
 kernel/entry/syscall_user_dispatch.c | 5 +++++
 kernel/ptrace.c                      | 4 ++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index eaaef3ffec22..461ae5c99d57 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -45,6 +45,8 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 
 #define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
 #define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
+#define PT_SUSPEND_SYSCALL_USER_DISPATCH \
+	(PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH << PT_OPT_FLAG_SHIFT)
 
 extern long arch_ptrace(struct task_struct *child, long request,
 			unsigned long addr, unsigned long data);
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 195ae64a8c87..ba9e3f19a22c 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -146,9 +146,13 @@ struct ptrace_rseq_configuration {
 /* eventless options */
 #define PTRACE_O_EXITKILL		(1 << 20)
 #define PTRACE_O_SUSPEND_SECCOMP	(1 << 21)
+#define PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH	(1 << 22)
 
 #define PTRACE_O_MASK		(\
-	0x000000ff | PTRACE_O_EXITKILL | PTRACE_O_SUSPEND_SECCOMP)
+	0x000000ff | \
+	PTRACE_O_EXITKILL | \
+	PTRACE_O_SUSPEND_SECCOMP | \
+	PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)
 
 #include <asm/ptrace.h>
 
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 0b6379adff6b..b5ec75164805 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -8,6 +8,7 @@
 #include <linux/uaccess.h>
 #include <linux/signal.h>
 #include <linux/elf.h>
+#include <linux/ptrace.h>
 
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
@@ -36,6 +37,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
 	char state;
 
+	if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
+	    unlikely(current->ptrace & PT_SUSPEND_SYSCALL_USER_DISPATCH))
+		return false;
+
 	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
 		return false;
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54482193e1ed..a348b68d07a2 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -370,6 +370,10 @@ static int check_ptrace_options(unsigned long data)
 	if (data & ~(unsigned long)PTRACE_O_MASK)
 		return -EINVAL;
 
+	if (unlikely(data & PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH) &&
+	    (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE)))
+			return -EINVAL;
+
 	if (unlikely(data & PTRACE_O_SUSPEND_SECCOMP)) {
 		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
 		    !IS_ENABLED(CONFIG_SECCOMP))
-- 
2.39.0

