Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093E267745A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 04:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjAWD3w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Jan 2023 22:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjAWD3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Jan 2023 22:29:51 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD691448C;
        Sun, 22 Jan 2023 19:29:49 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id q15so8855101qtn.0;
        Sun, 22 Jan 2023 19:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgFqur+BidWWWQr7r2LPXldx8oTQot1Qp1tXD/WiXfY=;
        b=aXerHjM3OC9ndo5Q3C5+pmGodhG7mKJqaptfNyYdWWWNcNr4xq/0TBLKrBw5ESXsgZ
         jg84s/XqTxsrimKQi0dUWE78pQbysFgKHvIkoQkwwff/xN76aFA2SM7zUsEt97NLRGvf
         hhnz3cghJZJQvr+AksoDwjCC2lOLQLSSGAf/7uRXI4l2WUslQtp5QsTVBvvV52iug8TU
         ryvrH8sHHbxl0zCVCIqaouo/8L35n4O/DeTswGU1OwQInxypnrt1x4or34qZioeLfc3i
         NJXBo2Oux6Mz2B1Ccn1Qw642J2aj/HxdBjwc0Hau6IAKbl7BM31NqCs8yztb65Nkpok6
         jQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgFqur+BidWWWQr7r2LPXldx8oTQot1Qp1tXD/WiXfY=;
        b=1N1AmouTS2P/Ul2ZF52QjOZRqXnCa1rpvbc7zinl5djgdnEXIGOjFk/zD5z//G+jJd
         KjhpF5Absle7w5IroNsCqkUdbdYwxf0v3m9ZN6y2s8WzPBjpNXYsy0tYye2PQGLfdj4D
         1xi13/UHArm28QASeC1U2mLlkBwZBNUSm6AuQOF2Vmk5rUtwkRcbR0Fid+eI7LEj2nGU
         K6LH4sAti6x5A+D27YkBdmMglkjAxmbkkUQi2rCxGXsDUjmxL5It04OlN8lb82+OHFvI
         49r+XLeVgFuJEd2+YzsuriM9QPuQKwGI+FMOoxVY3ZJV0e8Cwvs1xCg8yxrAQDJSxSAd
         zEOQ==
X-Gm-Message-State: AFqh2krUsPNcHkEYj+oTer4u7yUxirbfsTI9paN74JUaat8FucR/Uj/b
        WYGfprHtk+P0fgSaLa2D0QvMzlP5eM1I
X-Google-Smtp-Source: AMrXdXsv+aWdy/Yy/TfkjcpMJTXw3AoOi9BYBga3ld1DyGO8OiG2pQKxViozE8ZYQgu/PcnPGfj7lQ==
X-Received: by 2002:ac8:668d:0:b0:3b6:32ef:2dda with SMTP id d13-20020ac8668d000000b003b632ef2ddamr31948335qtp.34.1674444588905;
        Sun, 22 Jan 2023 19:29:48 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id u3-20020ae9c003000000b0070928ee3933sm4875492qkk.75.2023.01.22.19.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 19:29:48 -0800 (PST)
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
Date:   Sun, 22 Jan 2023 22:29:42 -0500
Message-Id: <20230123032942.18263-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123032942.18263-1-gregory.price@memverge.com>
References: <20230123032942.18263-1-gregory.price@memverge.com>
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

Implement ptrace getter/setter interface for syscall user dispatch.

Presently, these settings are write-only via prctl, making it impossible
to implement transparent checkpoint (coordination with the software is
required).

This is modeled after a similar interface for SECCOMP, which can have
its configuration dumped by ptrace for software like CRIU.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 .../admin-guide/syscall-user-dispatch.rst     |  5 +-
 include/linux/syscall_user_dispatch.h         | 19 ++++++++
 include/uapi/linux/ptrace.h                   | 10 ++++
 kernel/entry/syscall_user_dispatch.c          | 46 +++++++++++++++++++
 kernel/ptrace.c                               |  9 ++++
 5 files changed, 88 insertions(+), 1 deletion(-)

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
index a0ae443fb7df..9e1bd0d87c1e 100644
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
 
+static inline int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+	void __user *data)
+{
+	return -EINVAL;
+}
+
+static inline int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
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
index b5ec75164805..a303c8de59af 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -111,3 +111,49 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 
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
+	if (test_syscall_work(SYSCALL_USER_DISPATCH))
+		config.mode = PR_SYS_DISPATCH_ON;
+	else
+		config.mode = PR_SYS_DISPATCH_OFF;
+
+	config.offset = sd->offset;
+	config.len = sd->len;
+	config.selector = sd->selector;
+	config.on_dispatch = sd->on_dispatch;
+
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
index a348b68d07a2..76de46e080e2 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -32,6 +32,7 @@
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
 #include <linux/minmax.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -1263,6 +1264,14 @@ int ptrace_request(struct task_struct *child, long request,
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

