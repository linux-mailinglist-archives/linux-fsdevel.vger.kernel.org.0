Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2632635118A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 11:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhDAJKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 05:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhDAJJw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:09:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF56C0613E6
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 02:09:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so703968pjb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+IsVjISMkpZP5tT2zT9xXS3PV75jGVHq8NuXz4FV7zU=;
        b=Tcop26gJmkd/1TqpULLeDQ2otNmc6j+/VT4iMfeBNgjEfZGjZLKKY1ePPRrQIP3viG
         Esvxv2FAIs51D5A/9yYudr9r1G81x0btHrw8kyZ99swJEdFy/+ABh7aE6ecvN3vRhOvv
         7MvjzbztD7AU/8KGWNLBmKKRQpzfQTVyEelQwkJfB8O/1nqvRkIGHQBI7rN8xgI7pNb2
         GduPhZ3AeBM5D7ClCe70GmFCitB8rR7szjOOuVl1AlLoToz0FbP7n/NAhunhM4nu8X3I
         dnGXfOsxHa5nL7iMivXJJIuny92B72ytUP1lCBRLB5bv0EwmDE/euDet7RVGVBKcRaeR
         /3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+IsVjISMkpZP5tT2zT9xXS3PV75jGVHq8NuXz4FV7zU=;
        b=c9r/wqHl6KoJ5CtrgRZaRELjZQg1vJnqONYmIfYyhbqsvnVxxkKODoXAhXsGyIJ6nl
         /gko43GgeBZ8i9h+cXRelhmD0UVbbRXsn1DGxx8TVlD9pmtVHt0FxKS+P7yLYKH4B95n
         oy7GiiEe8wsJzBUaZTUsNGdBDmya+qa1B42Ty+McRTdisJ06EIIuJbjwHYims1QsE0bz
         fADNw7A2oMFuXcuZmD8slP36X12+jweX0Qy0OlfCgAAtFMuhS2ziGOTkpP1E/G6s9w1E
         sl0PoKCtK0S8GX2BAALSlfFEGwX80rDKStutsHX5QHcPSqJu5KMnOlurnRlWr1y4VaFO
         Dtsg==
X-Gm-Message-State: AOAM533nHgyskED/g500M3ikdcdlCnYOVIwabpltad0KNjIJbGoP2s5V
        iGKXCN9OOSLlp1rSwAKfaYLx
X-Google-Smtp-Source: ABdhPJzD1ZPSRBjIXRewRBPdRngJTQcG7U1Ly+YzsKw0o4Hb/fRlfsUZ6aEHLdqdggJrzuxMD5kH5A==
X-Received: by 2002:a17:902:c945:b029:e7:1ec4:4315 with SMTP id i5-20020a170902c945b02900e71ec44315mr6937613pla.51.1617268192395;
        Thu, 01 Apr 2021 02:09:52 -0700 (PDT)
Received: from localhost ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id f21sm4303758pfe.6.2021.04.01.02.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:09:52 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     christian.brauner@ubuntu.com, hch@infradead.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, hridya@google.com,
        surenb@google.com, viro@zeniv.linux.org.uk, sargun@sargun.me,
        keescook@chromium.org, jasowang@redhat.com
Cc:     devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] binder: Use receive_fd() to receive file from another process
Date:   Thu,  1 Apr 2021 17:09:32 +0800
Message-Id: <20210401090932.121-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401090932.121-1-xieyongji@bytedance.com>
References: <20210401090932.121-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use receive_fd() to receive file from another process instead of
combination of get_unused_fd_flags() and fd_install(). This simplifies
the logic and also makes sure we don't miss any security stuff.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/android/binder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c119736ca56a..080bcab7d632 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3728,7 +3728,7 @@ static int binder_apply_fd_fixups(struct binder_proc *proc,
 	int ret = 0;
 
 	list_for_each_entry(fixup, &t->fd_fixups, fixup_entry) {
-		int fd = get_unused_fd_flags(O_CLOEXEC);
+		int fd  = receive_fd(fixup->file, O_CLOEXEC);
 
 		if (fd < 0) {
 			binder_debug(BINDER_DEBUG_TRANSACTION,
@@ -3741,7 +3741,7 @@ static int binder_apply_fd_fixups(struct binder_proc *proc,
 			     "fd fixup txn %d fd %d\n",
 			     t->debug_id, fd);
 		trace_binder_transaction_fd_recv(t, fd, fixup->offset);
-		fd_install(fd, fixup->file);
+		fput(fixup->file);
 		fixup->file = NULL;
 		if (binder_alloc_copy_to_buffer(&proc->alloc, t->buffer,
 						fixup->offset, &fd,
-- 
2.11.0

