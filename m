Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708E463CEC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 06:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiK3Fhr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 00:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiK3Fhn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:37:43 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860491C431;
        Tue, 29 Nov 2022 21:37:41 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id z17so11511316qki.11;
        Tue, 29 Nov 2022 21:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKPR57ek3ooMmQ0+P1pqWsdpJjQbw5NulQVkSVNRu1E=;
        b=EV9IW20OrVRhM9suJigdFA5+18vgpaTzBQ4q+EXeow1qz2b+V1im7z7Z6un2WNmsTw
         mCjzcFHsC0O2l8XqSsqY6cXPq8fOO6TEHI00P3BZpTGlAzkOc3ZOiVwpuRiAZabZOYvl
         Lukmglq1AqQDcNY3fJjSBiw7OaJBjC4/xvxGajobULDjHKs+appLj7gV1Zi3/oBpivIB
         qzwz/UI2wntk8bkfbUiwElEYaV7OMR7MBUYSvkbbvDuKcSwFNkdHKKaWP9QDGFvnN4dQ
         SzPfMvpWUWg8Yu+b8+x1KJpSWgl8bmqyrtEqG4SbbwOKX8dqKY5e7JecV8COzAh7CMGS
         JpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKPR57ek3ooMmQ0+P1pqWsdpJjQbw5NulQVkSVNRu1E=;
        b=KXw+iYTz2YiGPc7mn8xYEbvsvQeLmcMNSRTs+3ay6ymf22zBtMbDF9H2EhYOKTMd6l
         smYQDEQjpmd0ImwgvKsd5oOviJsl+lYqEpfTy1E6JHUVJ/HXXFG3P5yCyI1lB3k+CGIW
         zrx9SRKdF03h8wUuUFEoCcIj2BLJdgZOPqCE/+B31NvLHlw7tksh8FyIr4oD1qAcu5OP
         +hBoUtYhp7SF6pefCeAoOj6aldrZ9mBaZS5PBJ8ABes1KmD/LByJ9n4QxH8zu0LB8xdw
         DYEQ6hsB7r9473cKdJaJk7PRoYRvYZpey5WosLNSqRWdmzxk2SmkjR+nzbk9P0S6/l3p
         FryA==
X-Gm-Message-State: ANoB5pm4ki/H82HGAyIrr4GMbxQKnb7v4g6HT8+kNnzSqq8rTdc1kKdN
        EfG7t0H6h7Nvh9kwzYJHLg==
X-Google-Smtp-Source: AA0mqf4oXB/zkTlgTxjuRLQfqUfakOmEWU22ocH6K0bhvbU2hXohDbj2ZXGfjq+i/zU0MPFGBLmkkw==
X-Received: by 2002:ae9:e115:0:b0:6fc:2903:1dd1 with SMTP id g21-20020ae9e115000000b006fc29031dd1mr31838425qkm.232.1669786660561;
        Tue, 29 Nov 2022 21:37:40 -0800 (PST)
Received: from bytedance.attlocal.net ([130.44.212.155])
        by smtp.gmail.com with ESMTPSA id i11-20020ac8764b000000b003a611cb2a95sm321010qtr.9.2022.11.29.21.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 21:37:40 -0800 (PST)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v3] coredump: Use vmsplice_to_pipe() for pipes in dump_emit_page()
Date:   Tue, 29 Nov 2022 21:37:34 -0800
Message-Id: <20221130053734.2811-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031210349.3346-1-yepeilin.cs@gmail.com>
References: <20221031210349.3346-1-yepeilin.cs@gmail.com>
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

From: Peilin Ye <peilin.ye@bytedance.com>

Currently, there is a copy for each page when dumping VMAs to pipe
handlers using dump_emit_page().  For example:

  fs/binfmt_elf.c:elf_core_dump()
      fs/coredump.c:dump_user_range()
                     :dump_emit_page()
        fs/read_write.c:__kernel_write_iter()
                fs/pipe.c:pipe_write()
             lib/iov_iter.c:copy_page_from_iter()

Use vmsplice_to_pipe() instead of __kernel_write_iter() to avoid this
copy for pipe handlers.

Tested by dumping a 32-GByte core into a simple handler that splice()s
from stdin to disk in a loop, PIPE_DEF_BUFFERS (16) pages at a time.

                              Before           After   Improved by
  Time to Completion   40.77 seconds   35.49 seconds        12.95%
  CPU Usage                   92.27%          86.40%         6.36%

Suggested-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
---
change in v3:
  - do not rely on error checking in vmsplice_to_pipe() (Al Viro)
  - rebase onto linux-next

change in v2:
  - fix warning in net/tls/tls_sw.c (kernel test robot)

 fs/coredump.c            | 10 +++++++++-
 fs/splice.c              |  4 ++--
 include/linux/coredump.h |  3 +++
 include/linux/splice.h   |  3 +++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index de78bde2991b..7f0981d71881 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -42,6 +42,7 @@
 #include <linux/timekeeping.h>
 #include <linux/sysctl.h>
 #include <linux/elf.h>
+#include <linux/splice.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -586,6 +587,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			goto fail_unlock;
 		}
 
+		set_bit(COREDUMP_USE_PIPE, &cprm.flags);
+
 		if (cprm.limit == 1) {
 			/* See umh_pipe_setup() which sets RLIMIT_CORE = 1.
 			 *
@@ -861,7 +864,12 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 		return 0;
 	pos = file->f_pos;
 	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
-	n = __kernel_write_iter(cprm->file, &iter, &pos);
+
+	if (test_bit(COREDUMP_USE_PIPE, &cprm->flags))
+		n = vmsplice_to_pipe(file, &iter, 0);
+	else
+		n = __kernel_write_iter(cprm->file, &iter, &pos);
+
 	if (n != PAGE_SIZE)
 		return 0;
 	file->f_pos = pos;
diff --git a/fs/splice.c b/fs/splice.c
index 5969b7a1d353..c9be20f4115e 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1234,8 +1234,8 @@ static long vmsplice_to_user(struct file *file, struct iov_iter *iter,
  * as splice-from-memory, where the regular splice is splice-from-file (or
  * to file). In both cases the output is a pipe, naturally.
  */
-static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
-			     unsigned int flags)
+long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
+		      unsigned int flags)
 {
 	struct pipe_inode_info *pipe;
 	long ret = 0;
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index d3eba4360150..3e34009487bf 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -28,8 +28,11 @@ struct coredump_params {
 	int vma_count;
 	size_t vma_data_size;
 	struct core_vma_metadata *vma_meta;
+	unsigned long flags;
 };
 
+#define COREDUMP_USE_PIPE	0
+
 /*
  * These are the only things you should do on a core-file: use only these
  * functions to write out all the necessary info.
diff --git a/include/linux/splice.h b/include/linux/splice.h
index a55179fd60fc..38b3560a318b 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -10,6 +10,7 @@
 #define SPLICE_H
 
 #include <linux/pipe_fs_i.h>
+#include <linux/uio.h>
 
 /*
  * Flags passed in from splice/tee/vmsplice
@@ -81,6 +82,8 @@ extern ssize_t splice_direct_to_actor(struct file *, struct splice_desc *,
 extern long do_splice(struct file *in, loff_t *off_in,
 		      struct file *out, loff_t *off_out,
 		      size_t len, unsigned int flags);
+extern long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
+			     unsigned int flags);
 
 extern long do_tee(struct file *in, struct file *out, size_t len,
 		   unsigned int flags);
-- 
2.20.1

