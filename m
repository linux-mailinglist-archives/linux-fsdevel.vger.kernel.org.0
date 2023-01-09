Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3CD662A31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 16:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjAIPiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 10:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjAIPhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:37:31 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AE8564D6;
        Mon,  9 Jan 2023 07:34:10 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id x11so7956693qtv.13;
        Mon, 09 Jan 2023 07:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpjXMcZ/7RudLTNZ8yQIMhedP7zu8/TzwLoOBtws8VI=;
        b=PGgvb/o0mxa8qkP79RyhSNxzFBfMJkOqp2Yvbm/7U1WdFwFL77akyQnl11h4SMpCij
         KARGsIgRzOk0uY3NMirowb5WiQc6mpr21mOf/gpFLZ/fP/JUmYDtbmLXSooFJoamXpsC
         I8asgY8T02al9dovbSYDcGMb6WzfpUplgETs9onhDL1bqfAtq75TnzjwspwjGuSVGc3M
         ZXpM3ACWJUHDKDA+yMzb8NGduIIRRscYEybRH0R2psgTiD/SpEH7fsQPN4vNYRbxMPNK
         1vW6VsUE/Rf+tw+LKbB7UODQVHPb3i0MH6h6MoLX1BfaPfUoed8wFUki/gIPVvXmXBHN
         n/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpjXMcZ/7RudLTNZ8yQIMhedP7zu8/TzwLoOBtws8VI=;
        b=NkZMAf8QqvdflKglc32NDHyNaCaqv0rlc3jNk6nejkAwKqWb/FnTZsEBus2dddsXQr
         q2ObwoYQRgo0ls5MO2EAxHZZgrX1tzPLc6ONLrmDT/2IMeNQcRmKk6oX0LVcDpkrOAMO
         kZvMp2bKZ/iQ6603Lf7bfn7OF8AI3TxlSpcsEURbcHg+3aH55VudwT8+HIbPWfCQ1Y4G
         MPqQa3srYPMRSijzqM7CNGvE/nKzdkQgx3JEfjZRTJOXWZp+qWnpqi28htXz735lMKsf
         bJAXHi2NZH3RCqka2FBu5saesVlq50HjCaC3WA5w9r7VqlDc/HvlbCsN5tl1/wfylTkr
         iDlQ==
X-Gm-Message-State: AFqh2kooNELeg9hfWoZeHizOvif/zDbTQBNHX+jMmWqBUovFyd56ieyn
        tyg+jzLdt6Eftim9UrFbsNLGkcURUQ==
X-Google-Smtp-Source: AMrXdXs02xojdZxQRNkUuff7oVgOR4Qth2e7eCNrl+Qy+s6+Ap4vnsTd7ye02979zfve3yRaAyZ7NQ==
X-Received: by 2002:ac8:4403:0:b0:3a8:20fd:7111 with SMTP id j3-20020ac84403000000b003a820fd7111mr91263754qtn.39.1673278446359;
        Mon, 09 Jan 2023 07:34:06 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id f1-20020ac81341000000b003a6a19ee4f0sm4687236qtj.33.2023.01.09.07.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 07:34:04 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 1/3] ptrace,syscall_user_dispatch: Implement Syscall User Dispatch Suspension
Date:   Mon,  9 Jan 2023 10:33:46 -0500
Message-Id: <20230109153348.5625-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230109153348.5625-1-gregory.price@memverge.com>
References: <20230109153348.5625-1-gregory.price@memverge.com>
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
---
 include/linux/ptrace.h               | 2 ++
 include/uapi/linux/ptrace.h          | 6 +++++-
 kernel/entry/syscall_user_dispatch.c | 5 +++++
 kernel/ptrace.c                      | 5 +++++
 4 files changed, 17 insertions(+), 1 deletion(-)

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
index 0b6379adff6b..f097c06224c9 100644
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
+			unlikely(current->ptrace & PT_SUSPEND_SYSCALL_USER_DISPATCH))
+		return false;
+
 	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
 		return false;
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54482193e1ed..a6ad815bd4be 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -370,6 +370,11 @@ static int check_ptrace_options(unsigned long data)
 	if (data & ~(unsigned long)PTRACE_O_MASK)
 		return -EINVAL;
 
+	if (unlikely(data & PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)) {
+		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTART))
+			return -EINVAL;
+	}
+
 	if (unlikely(data & PTRACE_O_SUSPEND_SECCOMP)) {
 		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
 		    !IS_ENABLED(CONFIG_SECCOMP))
-- 
2.37.3

