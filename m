Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE936BF832
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 07:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjCRGC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 02:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCRGC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 02:02:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B564D60F;
        Fri, 17 Mar 2023 23:02:57 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c18so7431716ple.11;
        Fri, 17 Mar 2023 23:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679119377; x=1681711377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HX2Vj0FqJHvCREMyAVXC+Ew/k8upKYV2kIV0kMLwhNg=;
        b=WrfB2bwZf2cF8EjGCGotHY0Iqb2M32vFcWnZYy51MNfEiG+xiMWsfRbev323QqIHKt
         /8BdovrzaxckOgWhYGSAnyeNyjZBSUcvDhnAdQz0uRdd1jsT8vJHESzO5MogcW//0DBc
         EPYEa/i6uuzoNQCL78HMqeQ4tBPR4o1U4xbdOtOVzBxyzgGq6TXRV2Ed+jJ08fQV8LEM
         HzPAClTyzoWJ/Jl3XUit8q90bkPLX3g12c/XNv9wY4mFXvYkIyT+IVNawlybHZ2EyhRb
         EbU26IHhL5CPUh+Ef+CJed3KrLK/EDTtKqwHNAVD9sfFEw2cHob78L5blGQjBIfbKFQX
         qZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679119377; x=1681711377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX2Vj0FqJHvCREMyAVXC+Ew/k8upKYV2kIV0kMLwhNg=;
        b=glZIYw4gGsW65p4/nc2LL7HeSc4i9Hqj6oKsXoMFoQmNIHOnQE05qzOB6iElasNOa+
         lB7fSiJh58Gb9oQTNcsrHfxquhCdbMaAQPx/Lyokn9u5GapBX60YBF2XuVFZph2vFez4
         xxl5ZpSHt9m+/bebHewrWhLOBiwfBu53j9j1jFTDsxGS38n8LBk/kk1hZoU+/GfctbNK
         22Tz6I0wuuChkULGK90X6Yjz7kmhzYDrHaFuxadsEiI24qfvvC1lYqUmJ8MI5jqZKzJO
         L5rlBbAlZwaUKcmouGr7zUKmX6RadJhsLhdkK0q8+ynEz1YO2GAuR9XPWb5LZf4tUQgs
         EUsw==
X-Gm-Message-State: AO0yUKWN3Lb39EdpiilJVK8lDIyLFq5VoVUJduK43Ig+HMrSCBvrzjkj
        5BVVzOdWKeHWya8V9E5Q820=
X-Google-Smtp-Source: AK7set+K7UlmFtEWwKIuL52V+E4VXXdLcdzr3Fwir+XXzHSLgkk5cdkYUtRWPlf8aM9oh3Z72NtZ/w==
X-Received: by 2002:a17:90b:3548:b0:23b:4bce:97de with SMTP id lt8-20020a17090b354800b0023b4bce97demr8523345pjb.4.1679119377133;
        Fri, 17 Mar 2023 23:02:57 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id w23-20020a17090a15d700b00233b5d6b4b5sm5775920pjd.16.2023.03.17.23.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 23:02:56 -0700 (PDT)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, David.Laight@ACULAB.COM,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org,
        aloktiagi <aloktiagi@gmail.com>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [RFC v2 1/3] file: Introduce iterate_fd_locked
Date:   Sat, 18 Mar 2023 06:02:46 +0000
Message-Id: <20230318060248.848099-1-aloktiagi@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Callers holding the files->file_lock lock can call iterate_fd_locked instead of
iterate_fd

Signed-off-by: aloktiagi <aloktiagi@gmail.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
---
 fs/file.c               | 21 +++++++++++++++------
 include/linux/fdtable.h |  3 +++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index c942c89ca4cd..4b2346b8a5ee 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1295,15 +1295,12 @@ int f_dupfd(unsigned int from, struct file *file, unsigned flags)
 	return err;
 }
 
-int iterate_fd(struct files_struct *files, unsigned n,
-		int (*f)(const void *, struct file *, unsigned),
-		const void *p)
+int iterate_fd_locked(struct files_struct *files, unsigned n,
+                int (*f)(const void *, struct file *, unsigned),
+                const void *p)
 {
 	struct fdtable *fdt;
 	int res = 0;
-	if (!files)
-		return 0;
-	spin_lock(&files->file_lock);
 	for (fdt = files_fdtable(files); n < fdt->max_fds; n++) {
 		struct file *file;
 		file = rcu_dereference_check_fdtable(files, fdt->fd[n]);
@@ -1313,6 +1310,18 @@ int iterate_fd(struct files_struct *files, unsigned n,
 		if (res)
 			break;
 	}
+	return res;
+}
+
+int iterate_fd(struct files_struct *files, unsigned n,
+		int (*f)(const void *, struct file *, unsigned),
+		const void *p)
+{
+	int res = 0;
+	if (!files)
+		return 0;
+	spin_lock(&files->file_lock);
+	res = iterate_fd_locked(files, n, f, p);
 	spin_unlock(&files->file_lock);
 	return res;
 }
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index e066816f3519..14882520d1fe 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -122,6 +122,9 @@ void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
+int iterate_fd_locked(struct files_struct *, unsigned,
+			int (*)(const void *, struct file *, unsigned),
+			const void *);
 
 extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
-- 
2.34.1

