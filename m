Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF58672914
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 21:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjARUL2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 15:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjARULU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:11:20 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59EA5DC26;
        Wed, 18 Jan 2023 12:11:13 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id m7so94659ilh.7;
        Wed, 18 Jan 2023 12:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIxZYj7eSsuia8WbIjlSg4jlVWCI9wmpVpaDv9bWJuY=;
        b=b/AJv+Yz0q1aHUoMexookxY52jz6rwrer8JQEwBvKM1OA3S8B1iAt/vGbraek60Efa
         4bN+I1rpbmNvvFi4xek9qblY+FR8M7LVJGAu5UU0mJA+blgMSkr9P9oSzaXOWEvlPRNR
         SJwWaWuU6S971nI/1hrRhp0UhDpHN66C3wleauxdWY54REHxx9dC67Adihyeo3hzxmRR
         jbcVfYulxn7lou8AD8k/pL/DgklVSsLK7yGdUUvjvzhlPHZeZfiiEhENL4K0dTadp3/5
         6F0dVURwDmnIGZzhJR1wpeeZ2ZeJYanVT23L6jefBkdLHea0/Y7xC+LdtGIqR/QCb0Yp
         lOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIxZYj7eSsuia8WbIjlSg4jlVWCI9wmpVpaDv9bWJuY=;
        b=8RZrDZcdRf+aJG8bpSoj3dAzSM5YttHvzEKVLLAj/GXklIY4PGZL2ZFaGKs8247rRt
         3b8YWU+PGCOh+azdD2/DK5OqRfxv1hWRY6OP6xJ/Djz75NwLE56ZiCjoZW3kishEb27/
         DZ/TKK2tc71NQ+SH3KdqIxBZAoAMP41cr44E1KOOoJD8qei9B8Z90kL6eoVtWLin/P4N
         X8HvM4z47R1IqKuXlUDCRif6Pa5BFyz3OeMS6kY56tPxWnvxX4R0R3uiaUnqZhBis3ZC
         iAA2HYYdEJQ3IwtS9b/AAJzZMfpxRJj3hVMtqSj+MQJbQ8aJgIBLYamTmZ7qzfWZ8qgb
         npug==
X-Gm-Message-State: AFqh2koo/s49ViH/LjfRTlQdSnFwhN0tliP9+1eRvMqENQWj9t7ibTBM
        TlY1TBLKVMcvXOJpDr5WcI+d2i49cNvg
X-Google-Smtp-Source: AMrXdXtwjaApDMB3XWr6gQZuBYEYUyZxG/xCEfNGBICQm7WT6cfXjB6YYAnLEpX8nXAPEcRN1aSQiQ==
X-Received: by 2002:a92:7a0c:0:b0:30e:ecd7:d3fa with SMTP id v12-20020a927a0c000000b0030eecd7d3famr7499313ilc.12.1674072672995;
        Wed, 18 Jan 2023 12:11:12 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id i5-20020a92c945000000b0030bfbc121a1sm10299998ilq.79.2023.01.18.12.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:11:12 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter for sud configuration
Date:   Wed, 18 Jan 2023 15:10:55 -0500
Message-Id: <20230118201055.147228-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118201055.147228-1-gregory.price@memverge.com>
References: <20230118201055.147228-1-gregory.price@memverge.com>
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

This patch implements ptrace getter and setter interface for syscall
syscall user dispatch configuration info.

Presently, these settings are write-only via prctl, making it impossible
to implement transparent checkpoint.

This is modeled after a similar interface for SECCOMP, which can have
its configuration dumped by ptrace for software like CRIU.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 .../admin-guide/syscall-user-dispatch.rst     |  5 +-
 include/linux/syscall_user_dispatch.h         | 19 +++++++
 include/uapi/linux/ptrace.h                   | 10 ++++
 kernel/entry/syscall_user_dispatch.c          | 49 +++++++++++++++++++
 kernel/ptrace.c                               |  9 ++++
 5 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
index 60314953c728..a23ae21a1d5b 100644
--- a/Documentation/admin-guide/syscall-user-dispatch.rst
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -43,7 +43,10 @@ doesn't rely on any of the syscall ABI to make the filtering.  It uses
 only the syscall dispatcher address and the userspace key.
 
 As the ABI of these intercepted syscalls is unknown to Linux, these
-syscalls are not instrumentable via ptrace or the syscall tracepoints.
+syscalls are not instrumentable via ptrace or the syscall tracepoints,
+however an interfaces to suspend, checkpoint, and restore syscall user
+dispatch configuration has been added to ptrace to assist userland
+checkpoint/restart software.
 
 Interface
 ---------
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
index a0ae443fb7df..dbf384b7a26e 100644
--- a/include/linux/syscall_user_dispatch.h
+++ b/include/linux/syscall_user_dispatch.h
@@ -22,6 +22,13 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 #define clear_syscall_work_syscall_user_dispatch(tsk) \
 	clear_task_syscall_work(tsk, SYSCALL_USER_DISPATCH)
 
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+	void __user *data);
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+	void __user *data);
+
+
 #else
 struct syscall_user_dispatch {};
 
@@ -35,6 +42,18 @@ static inline void clear_syscall_work_syscall_user_dispatch(struct task_struct *
 {
 }
 
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+	void __user *data)
+{
+	return -EINVAL;
+}
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+	void __user *data)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_GENERIC_ENTRY */
 
 #endif /* _SYSCALL_USER_DISPATCH_H */
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index ba9e3f19a22c..8b93c78189b5 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -112,6 +112,16 @@ struct ptrace_rseq_configuration {
 	__u32 pad;
 };
 
+#define PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG 0x4210
+#define PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG 0x4211
+struct syscall_user_dispatch_config {
+	__u64 mode;
+	__s8 *selector;
+	__u64 offset;
+	__u64 len;
+	__u8 on_dispatch;
+};
+
 /*
  * These values are stored in task->ptrace_message
  * by ptrace_stop to describe the current syscall-stop.
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 7607f4598dd8..ae4f9a4b96ac 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -111,3 +111,52 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 
 	return 0;
 }
+
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+		void __user *data)
+{
+	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
+	struct syscall_user_dispatch_config config;
+
+	if (size != sizeof(struct syscall_user_dispatch_config))
+		return -EINVAL;
+
+	if (sd->selector) {
+		config.mode = PR_SYS_DISPATCH_ON;
+		config.offset = sd->offset;
+		config.len = sd->len;
+		config.selector = sd->selector;
+		config.on_dispatch = sd->on_dispatch;
+	} else {
+		config.mode = PR_SYS_DISPATCH_OFF;
+		config.offset = 0;
+		config.len = 0;
+		config.selector = NULL;
+		config.on_dispatch = false;
+	}
+	if (copy_to_user(data, &config, sizeof(config)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+		void __user *data)
+{
+	struct syscall_user_dispatch_config config;
+	int ret;
+
+	if (size != sizeof(struct syscall_user_dispatch_config))
+		return -EINVAL;
+
+	if (copy_from_user(&config, data, sizeof(config)))
+		return -EFAULT;
+
+	ret = set_syscall_user_dispatch(config.mode, config.offset, config.len,
+			config.selector);
+	if (ret)
+		return ret;
+
+	task->syscall_dispatch.on_dispatch = config.on_dispatch;
+	return 0;
+}
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index a6ad815bd4be..0b210a1450e7 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -32,6 +32,7 @@
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
 #include <linux/minmax.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -1264,6 +1265,14 @@ int ptrace_request(struct task_struct *child, long request,
 		break;
 #endif
 
+	case PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG:
+		ret = syscall_user_dispatch_set_config(child, addr, datavp);
+		break;
+
+	case PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG:
+		ret = syscall_user_dispatch_get_config(child, addr, datavp);
+		break;
+
 	default:
 		break;
 	}
-- 
2.39.0

