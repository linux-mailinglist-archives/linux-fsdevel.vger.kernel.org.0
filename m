Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68CE3458FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 08:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCWHmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 03:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhCWHmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:42:11 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB760C061574;
        Tue, 23 Mar 2021 00:42:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c17so6520492pfn.6;
        Tue, 23 Mar 2021 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZ8O9HW5IIQoJnCMuDYTUYenFaWgk4SuWyznvM7QwLA=;
        b=QXvvixWmQ5A4SI/WmqRAb3RBse5on6JPxiZz2bjr/L4KSNI4koe1B7kuXKATQ7p4KY
         8B/fJV9ZiGxjyxzvstZZioPoDcc554Upm8O89uVESfH93OzLoCgRmJx+tZvJJM9EhGkV
         lWr4+OwGO69eZUxESu5ILYCD0n5X8N6IqxBNQKcjSsvNM4XQXa5G9cw1Rml2JFmAJxja
         AgcZcSQbDmIgS99EFfGlek9gAudiorFSH4oUj48UgQjDluqaQxxPzity5yIFcg5KJdos
         ii13JZiaC6PYEGYo7GDoqMyj0QILHtCxrMYFQlvNGh5j/inWi3DNvX56D24mjPxmHh98
         zT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZ8O9HW5IIQoJnCMuDYTUYenFaWgk4SuWyznvM7QwLA=;
        b=tWIcfm3Uy900oyWAAEasWs43maYRlElgkb8gUsC6WOaytztEjuFjJijVfg9ipEDH0Q
         qXK1OWh1gbWzCFkHXDUwKp5lHGOGf4mCW1dTnJ5ptsawC9aplOFiqdo98i1SC9a7Meie
         T1xmFgQC7cSYG7a0+F1jh6t9GP4NXovlv5b4dMgzsCsU34aJFRKOIbrLieCBwMSRS/gF
         mtj0iBRbyri10ia58qlia+xfQOPeHQwFCjALuWp7QtUIj1kqNKA4wdbYPjXsDdkX0Qz2
         DE+lxaTZJn9P+jEuIpOySDilzPA7XMITcZroJ7ZUFeww5YcllTWGijyNqK8BvW5rraw+
         oouQ==
X-Gm-Message-State: AOAM530dhKdul0YRMv9r/PmIeBUDGB5b28Tgl/d+ihzWxeJpHs8LJbuM
        Qzehsd0CV9PW6i3QXMt4m7g=
X-Google-Smtp-Source: ABdhPJw+NbNwsGESiX/QpDRtMZSH6StqFPZjH10VUNEUdvb0QrndbAxIWP/el+4qOx94cGr7bTlQaw==
X-Received: by 2002:a62:fc06:0:b029:21d:17f7:31c4 with SMTP id e6-20020a62fc060000b029021d17f731c4mr743118pfh.61.1616485330523;
        Tue, 23 Mar 2021 00:42:10 -0700 (PDT)
Received: from DESKTOP-4V60UBS.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id g3sm8985067pfi.31.2021.03.23.00.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 00:42:10 -0700 (PDT)
From:   Xiaofeng Cao <cxfcosmos@gmail.com>
X-Google-Original-From: Xiaofeng Cao <caoxiaofeng@yulong.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: [PATCH v2] fs/exec: fix typos and sentence disorder
Date:   Tue, 23 Mar 2021 15:42:12 +0800
Message-Id: <20210323074212.15444-1-caoxiaofeng@yulong.com>
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
v2: resume the right boundary
 fs/exec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 18594f11c31f..5e23101f9259 100644
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
+		 * the address space in [new_end, old_start). Some architectures
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

