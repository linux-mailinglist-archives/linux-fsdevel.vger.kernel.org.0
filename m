Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DAE6FF7BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 18:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbjEKQql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 12:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbjEKQqj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 12:46:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57297DAA;
        Thu, 11 May 2023 09:46:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6439d505274so5291001b3a.0;
        Thu, 11 May 2023 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683823595; x=1686415595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9388nZtLPPzUDQlg0DAtAaZCpuETG5OG9TUNhd45Zc=;
        b=o8mfOQOBnUYRjyYKXL1F9bF/wJ8/7Vw5CuoNAlhjl/2ybkg8xXnvcNY4Qo0drl+RVm
         Kef3sRnIbmrQjObiHMfDD+hHSDcSrXWGlwzYRG/1ehNMH0vCp8mDbMUnDfcusq31f3Pb
         nNk7zPCnUmn7OD1qpkXTj3cZ9fF2d0GmEIqLDRwmnqiYdLb7/QLK+2bonp2O+aXtIs7b
         SvkNVug6SKVSqhj4naBOFjurQQkjasWvHJFu9Y/iLA5eYNJeIggV6m/SWccre7dDab/f
         miE+wjqJVpSs/1+A8SDn+cW2YM2pNu2TZ4oRsvu6C84DOefnfbcuNCbaSEzieMGcAje8
         ti7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683823595; x=1686415595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9388nZtLPPzUDQlg0DAtAaZCpuETG5OG9TUNhd45Zc=;
        b=DdAeO8ZcZlnqOSwdIQs9H5TGAASns3E1c+JnNyh95bPk7aCKAvd9yd3WdPu0gE/hvY
         wbMeG+F3rhs6ReSgmnaJTn7UIuXfNU9oxHi9+fpu/zmHB4TE8iDhe4qd3LhelG5QXga2
         j/5RNa+vOdHsgxbpoYJYeAfxSEuLRwjRYFDXPsO/s1PbMgjDQWTlGyYNJKeXF+guI7dC
         E5ygkbwcooc6bzkITiNqt2b9b5kPBDs6r4G9UZBbjk/4hDPbGm/7uGi8GHuYtTK1QgtY
         dZFMf9ABMozAapZ7qCOyjc+DY3XncGtsAQdpzYqLG7ckwaicOMrhb+p1fqkZGWJHJQFe
         2rGQ==
X-Gm-Message-State: AC+VfDxGvtqnKX0SkU5sWG46rJCzSgkXzOsyP+2ReKd9uMN9ky1rNxd7
        7ZKYfqErn5abxqq9+Ol+4zHaKYHnRYQ=
X-Google-Smtp-Source: ACHHUZ7G9ZRvycVsBi/WmG82k2DguB02qxYM3ikX3BU6ekoKCrnu7JNrTkitB4RC2a2FYtfBHXjtqg==
X-Received: by 2002:a05:6a00:1a89:b0:63f:1037:cc24 with SMTP id e9-20020a056a001a8900b0063f1037cc24mr26171428pfv.32.1683823594933;
        Thu, 11 May 2023 09:46:34 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-94-72.dynamic-ip.hinet.net. [36.228.94.72])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b005a8bf239f5csm5502761pfi.193.2023.05.11.09.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:46:34 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: use correct __poll_t type
Date:   Fri, 12 May 2023 00:46:25 +0800
Message-Id: <20230511164628.336586-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fix the following sparse warnings by using __poll_t instead
of unsigned type.

fs/eventpoll.c:541:9: sparse: warning: restricted __poll_t degrades to integer
fs/eventfd.c:67:17: sparse: warning: restricted __poll_t degrades to integer

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 fs/eventfd.c            | 2 +-
 fs/eventpoll.c          | 2 +-
 include/linux/eventfd.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 95850a13ce8d..6c06a527747f 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -43,7 +43,7 @@ struct eventfd_ctx {
 	int id;
 };
 
-__u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, unsigned mask)
+__u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask)
 {
 	unsigned long flags;
 
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 980483455cc0..e0eabaae7402 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -536,7 +536,7 @@ static void ep_poll_safewake(struct eventpoll *ep, struct epitem *epi,
 #else
 
 static void ep_poll_safewake(struct eventpoll *ep, struct epitem *epi,
-			     unsigned pollflags)
+			     __poll_t pollflags)
 {
 	wake_up_poll(&ep->poll_wait, EPOLLIN | pollflags);
 }
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index 36a486505b08..98d31cdaca40 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -40,7 +40,7 @@ struct file *eventfd_fget(int fd);
 struct eventfd_ctx *eventfd_ctx_fdget(int fd);
 struct eventfd_ctx *eventfd_ctx_fileget(struct file *file);
 __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
-__u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, unsigned mask);
+__u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask);
 int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
 				  __u64 *cnt);
 void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
-- 
2.34.1

