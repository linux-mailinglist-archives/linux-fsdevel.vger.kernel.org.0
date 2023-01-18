Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC7F672910
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 21:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjARULU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 15:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjARULM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:11:12 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F865DC15;
        Wed, 18 Jan 2023 12:11:10 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id o15so81895ill.11;
        Wed, 18 Jan 2023 12:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqgqlvxl2/AjHmd8bF7KdCJg7y96KUb9pTAZ52R5/2g=;
        b=bdrvtx5ZNhgIk9MmhFukQ/LPkMhBhfAROXqqep7fDgGl3OA8JifOfMctbfukQx85JG
         07Jfp9smBT8tMrHecHqxzm1W5SqERHQekZm6Am19mR/lb7pai0hkqsQXkL8cPjfqnPD6
         j2gR6LVkL89vjpWKYGGjfDt7cSemJgE5/vORS9PEpLXQJCkwqemjGVAHRyzPVEtapADa
         5MSRaZ28BuVhOZIGctLicIlYVz0oBmZlsctPpKfFYVIJGvqETPofsTc4yNaPl3isfpYo
         puDeV9j19qqVYnoRT9o7Ezhq1ucG1hDr6Ngn56nPtTLzaFk7MlsERx37m/1TdFuJhC/2
         NGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqgqlvxl2/AjHmd8bF7KdCJg7y96KUb9pTAZ52R5/2g=;
        b=2FI4EOuiZhMN+nhw8i9X62jC7qFKGb0K4Utz5SVhIVvkSLwxbnZz2kvjGWeoOMZgkU
         Tj8fkRj9PfBXxJjileOrSOTSrSQOWRgFuYMqNttkdV3Db6fw/bVqjyzORQelWwZHmR/B
         kkfuHIy4boOob83Dn+Gw/bVaxUHL4uXYqg4cTMKXEJI2/2w4X3JU5q+fr6BzZwCevgGw
         Mpu8TJVdk27MY8i12fE1nl9wdlbdhNp1kKvqTVPa7rdw51MAdRUMa6AS7W2s7fn4Lmd0
         vHRcaG136o/FJGlhwF9W06gh+sDAO9LbohHLMHwRWIQ0FUUj78ihyBOrLlqA7f8ctUBa
         y9/A==
X-Gm-Message-State: AFqh2koXDOImSWx8dJZs2l61WyXyHiisFyagA5VD+skAgVylB4cJ/SCG
        fCvY6TPbja3uK2B49ntgCX4BdPYR7+kq
X-Google-Smtp-Source: AMrXdXs65z3mHMdccDSgpcyzyox+lwVkGOM8Ivj9ALWa7rq82jvgbCrnDGVjJrWFMLOuPbugow67oA==
X-Received: by 2002:a05:6e02:2186:b0:30f:3704:3e18 with SMTP id j6-20020a056e02218600b0030f37043e18mr2022430ila.25.1674072669393;
        Wed, 18 Jan 2023 12:11:09 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id i5-20020a92c945000000b0030bfbc121a1sm10299998ilq.79.2023.01.18.12.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:11:09 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 2/3] fs/proc/array: Add Syscall User Dispatch to proc status
Date:   Wed, 18 Jan 2023 15:10:54 -0500
Message-Id: <20230118201055.147228-3-gregory.price@memverge.com>
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

If a dispatch selector has been configured for Syscall User Dispatch,
report Syscall User Dispath as configured in proc/status.

This provides an indicator to userland checkpoint/restart software that
it much manage special signal conditions (similar to SECCOMP)

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 fs/proc/array.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49283b8103c7..c85cdb4c137c 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -428,6 +428,13 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
 	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
 }
 
+static inline void task_syscall_user_dispatch(struct seq_file *m,
+						struct task_struct *p)
+{
+	seq_put_decimal_ull(m, "\nSyscall_user_dispatch:\t",
+			    (p->syscall_dispatch.selector != NULL));
+}
+
 int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task)
 {
@@ -451,6 +458,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_cpus_allowed(m, task);
 	cpuset_task_status_allowed(m, task);
 	task_context_switch_counts(m, task);
+	task_syscall_user_dispatch(m, task);
 	return 0;
 }
 
-- 
2.39.0

