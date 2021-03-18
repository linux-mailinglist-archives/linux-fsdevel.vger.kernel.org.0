Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12853408F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 16:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhCRPcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 11:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhCRPbp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:31:45 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC77C06174A;
        Thu, 18 Mar 2021 08:31:45 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id u19so1673049pgh.10;
        Thu, 18 Mar 2021 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WISvoiSHb3sZxBE43r1Wvg3VojGivOC9kZX8qyoQBHc=;
        b=fOoT8iun3I1HTQZ89M/n/qvb0DgbdxCSWp5ZNqn27JVOdBEvAZwdYa6Y+5POwN8jFX
         s6loFMNpY2tWMGAr+oO1hu3uagX9Vsf66Kesr0JHH8+Jycb4+167bjG66CsDfPNAO1Pj
         PnG2auWueW/qCj9Y2Os1WWw/TfqIv2nrh8NzF/1aIrGd6KY1qZNG/1baf/6UcgTm1ykW
         txY0SOjNbEUz9GMtp1tRHN2BC0jYe0Q9m3fvVHdKA8V22godKAhUn5NE9jBD0CYuqPk8
         JUBYcMYEf4ZZG3WpN8OQTNSKVImeqtUyJsDFmKtrE8oT0VBk81M2MSq6s6Fw4icD103C
         wyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WISvoiSHb3sZxBE43r1Wvg3VojGivOC9kZX8qyoQBHc=;
        b=DKJroE3kW9DyF2i6OiH3pl+DXiGfBw+ppUO31zVypq9nClo483/qUicypo/E+yr3GJ
         qiMkRZc4jNg/JoK9fazT2aymMwM6pWGEe44nJinnvFmOiEBrnRE1SyYyu15avyM2EyP0
         xTwhC5aAG4GVmuI2PsAASlqkQPOv2Ubod9dDB7hiPA0ZtBdXr4/AbxIF7UOiQ3f1crFo
         2sZpPScMzVlIlzFDEwFEhhplzTmwBCqSAZl+LK/DlVPBv4xS+hlhj+RI47k8pp3w206o
         9fZTNSYRl0lXe1BEblDGWnmyu7LXlYSES0lWv2RnwWUsgDXC/lQJuyo5isMfHukPg00b
         DVIw==
X-Gm-Message-State: AOAM5301+kJYvAQbC3lg3K2EWv2g+7TdwXRV6njpEcAYcO/sxuIz088S
        N9BLE1vA8B881sGh/Aaw93uwW+OG9A7G7w==
X-Google-Smtp-Source: ABdhPJwPvjBKnOMFOwvyqlgsZmAgL5HzEChQJ6WltLifDNfwwAEesgil/yAktMU6SJ5qKMH02Hc0gw==
X-Received: by 2002:a62:1997:0:b029:1ed:5de5:5f1c with SMTP id 145-20020a6219970000b02901ed5de55f1cmr4539040pfz.14.1616081504869;
        Thu, 18 Mar 2021 08:31:44 -0700 (PDT)
Received: from DESKTOP-4V60UBS.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id f2sm2965341pfq.129.2021.03.18.08.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:31:44 -0700 (PDT)
From:   Xiaofeng Cao <cxfcosmos@gmail.com>
X-Google-Original-From: Xiaofeng Cao <caoxiaofeng@yulong.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: [PATCH] fs/exec: fix typos and sentence disorder
Date:   Thu, 18 Mar 2021 23:31:45 +0800
Message-Id: <20210318153145.13718-1-caoxiaofeng@yulong.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

change 'backwords' to 'backwards'
change 'and argument' to 'an argument'
change 'visibile' to 'visible'
change 'wont't' to 'won't'
reorganize sentence

Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
---
 fs/exec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 18594f11c31f..5a66f8d71bbd 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -536,7 +536,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 		if (!valid_arg_len(bprm, len))
 			goto out;
 
-		/* We're going to work our way backwords. */
+		/* We're going to work our way backwards. */
 		pos = bprm->p;
 		str += len;
 		bprm->p -= len;
@@ -603,7 +603,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 }
 
 /*
- * Copy and argument/environment string from the kernel to the processes stack.
+ * Copy an argument/environment string from the kernel to the processes stack.
  */
 int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
 {
@@ -718,9 +718,9 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
-		 * the address space in [new_end, old_start) some architectures
+		 * the address space in [new_end, old_start]. Some architectures
 		 * have constraints on va-space that make this illegal (IA64) -
-		 * for the others its just a little faster.
+		 * for the others it's just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
 			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
@@ -1120,7 +1120,7 @@ static int de_thread(struct task_struct *tsk)
 		 */
 
 		/* Become a process group leader with the old leader's pid.
-		 * The old leader becomes a thread of the this thread group.
+		 * The old leader becomes a thread of this thread group.
 		 */
 		exchange_tids(tsk, leader);
 		transfer_pid(leader, tsk, PIDTYPE_TGID);
@@ -1142,7 +1142,7 @@ static int de_thread(struct task_struct *tsk)
 		/*
 		 * We are going to release_task()->ptrace_unlink() silently,
 		 * the tracer can sleep in do_wait(). EXIT_DEAD guarantees
-		 * the tracer wont't block again waiting for this thread.
+		 * the tracer won't block again waiting for this thread.
 		 */
 		if (unlikely(leader->ptrace))
 			__wake_up_parent(leader, leader->parent);
@@ -1270,7 +1270,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
-	 * not visibile until then. This also enables the update
+	 * not visible until then. This also enables the update
 	 * to be lockless.
 	 */
 	set_mm_exe_file(bprm->mm, bprm->file);
-- 
2.25.1

