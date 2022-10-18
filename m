Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCDC60254B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJRHPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 03:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJRHPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:15:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC8E1C114
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 00:15:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d24so12998667pls.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 00:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GWpp9H1EZop5nfcRDk8gH8fsXSS8/W/uxQB86i2A+io=;
        b=j28wJE/SlkqN0MjnlHNEnwUchiYmES1JAhp9HN8BuDU8EpRBzurMvOIs9LRp5sNeZf
         RftAfN/hdX/ko7MA6Biz+yBsd+AY5JU/+ShMBxe1d7lvQN2y4lPWbXReV5V4nqGAWHx9
         ot5LcqpDE7s6Lgyg7GIon+2kl38P5UpfMJVWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWpp9H1EZop5nfcRDk8gH8fsXSS8/W/uxQB86i2A+io=;
        b=r3k/uawadUYFGs9PDS4CinRGpyUTIc4IstHxIQm9JcbzYZt9hcFCNsFHuoRhXyIvP9
         nllPbrz9/6UbvJbIfrRTnTrsP7f/nPcEV4wH1aX94QFFsX5VIYflIP7FLLeUq/+zGc/F
         V2c3edY8JvYFZKwccLiwJo3coFjpKbYTInQA1HwcfAkqUTbSLlNCHCShuKJrbTcSOm+s
         HM9zEovLR3LnUUsAjbE2Bzd3/rUySD18EptZkpAG23Od3ztJGOgkBgWAImJ/PUeLNe7b
         6QBOR0+1fdlPrE1Uk11OCb4JTXn5odo7FdZub/qDYnm5UkB4eVVic4FqJp+VvQkIMUYs
         4sSw==
X-Gm-Message-State: ACrzQf0Wr4rknr+EEq/ovnJNbAvK5+4lqXNaou+poKu7N8u59+uPPOLj
        VX6WVabu3SezSvekOzNzMmyKnA==
X-Google-Smtp-Source: AMsMyM4eIF23D71VJssjlr620WzH9QKDOFN2h7T73Uvfdaj9OE3aQlt7wJsDmvK0Kf+7dlDWw6biQw==
X-Received: by 2002:a17:902:d504:b0:184:87ca:7856 with SMTP id b4-20020a170902d50400b0018487ca7856mr1676641plg.14.1666077266556;
        Tue, 18 Oct 2022 00:14:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r24-20020aa79638000000b00562eff85594sm8488909pfg.121.2022.10.18.00.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 00:14:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] binfmt: Fix whitespace issues
Date:   Tue, 18 Oct 2022 00:14:20 -0700
Message-Id: <20221018071350.never.230-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3571; h=from:subject:message-id; bh=cE+i46jrzxiQX8hRWgipHvknKIEvjBwuE256znMEhAA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTlJMQjP+BFOX9loYawD8HXVcEROtQbdET4WeOsOD cZ4e/PWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05STAAKCRCJcvTf3G3AJkrcD/ sFtj1A9f+SIqBDSukZmOj1y+sKcip8qY324JfvKAKVMUBhHgMNYycYLvFgN4PL9VaulC6Og9XQNrRT x8+/bYmLOFyVj6io0h++mn7RXZppKHA7bbHGbR65H75K+adr4MjigqXjr46wFpQ6TSQnbxaNvYVOwN RsGBKaC30dGgZ+RgY3ZMDGKR9bGvzy+Wsk8EZjOE7+CyY9CQkWXK6zmMztiy6xgzLKM/shDN7RETzn hAy8tau5WoDxetf/dD3H/4vDw814pQmvNAytqHdL2N21gvA+RKuP2EOPA7TtgokhurBIMqZL1tKpSk JZyHx9s3rrj6w4kQc2ZGs+bwIX8mFLCqRXzmptgVxPmTcLyl1joXLJaciRKwOo5ld0c7mF9AxaWAYr 9mWmrp9xvEpn5u+HqRvtqwoFgWPRgJ8aNXKmA9AzJt96h+1SSWINhnohcIuJPmaBj0tOgdvgRT50j/ eaCL8MmvU+ClJAfNB+vHT7jBhAaj7UYJErkAOGpuavNtQwb5OUAt0YfdRsvfhSK5ObH9H+4DuRtR3J 71aSWQTotYTtCKwXGkVLNTaHEIHbL44Wmb2ezbYPRaBbz3DUnZr3k+mFHfx+aP9hGn5nLynAJh3wyB A6TlSKrPXFR74vHV4K31OynzNpgIIa6dv1VjGIqMdNoR6if304OxtLjVAWXw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the annoying whitespace issues that have been following these files
around for years.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c          | 14 +++++++-------
 fs/binfmt_elf_fdpic.c    |  2 +-
 fs/exec.c                |  2 +-
 include/uapi/linux/elf.h |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 63c7ebb0da89..72f0672b4b74 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -248,7 +248,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	} while (0)
 
 #ifdef ARCH_DLINFO
-	/* 
+	/*
 	 * ARCH_DLINFO must come first so PPC can do its special alignment of
 	 * AUXV.
 	 * update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT() in
@@ -1020,7 +1020,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				 executable_stack);
 	if (retval < 0)
 		goto out_free_dentry;
-	
+
 	elf_bss = 0;
 	elf_brk = 0;
 
@@ -1043,7 +1043,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		if (unlikely (elf_brk > elf_bss)) {
 			unsigned long nbyte;
-	            
+
 			/* There was a PT_LOAD segment with p_memsz > p_filesz
 			   before this one. Map anonymous pages, if needed,
 			   and clear the area.  */
@@ -1520,7 +1520,7 @@ static void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, loff_t offset)
 	phdr->p_align = 0;
 }
 
-static void fill_note(struct memelfnote *note, const char *name, int type, 
+static void fill_note(struct memelfnote *note, const char *name, int type,
 		unsigned int sz, void *data)
 {
 	note->name = name;
@@ -2003,8 +2003,8 @@ static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
 	t->num_notes = 0;
 
 	fill_prstatus(&t->prstatus.common, p, signr);
-	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);	
-	
+	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
+
 	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
 		  &(t->prstatus));
 	t->num_notes++;
@@ -2294,7 +2294,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	if (!elf_core_write_extra_phdrs(cprm, offset))
 		goto end_coredump;
 
- 	/* write out the notes section */
+	/* write out the notes section */
 	if (!write_note_info(&info, cprm))
 		goto end_coredump;
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 08d0c8797828..e90c1192dec6 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1603,7 +1603,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	if (!elf_core_write_extra_phdrs(cprm, offset))
 		goto end_coredump;
 
- 	/* write out the notes section */
+	/* write out the notes section */
 	if (!writenote(thread_list->notes, cprm))
 		goto end_coredump;
 	if (!writenote(&psinfo_note, cprm))
diff --git a/fs/exec.c b/fs/exec.c
index 0284a5f3925e..902bce45b116 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -173,7 +173,7 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 exit:
 	fput(file);
 out:
-  	return error;
+	return error;
 }
 #endif /* #ifdef CONFIG_USELIB */
 
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 775a17b5b8ac..4c6a8fa5e7ed 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -91,7 +91,7 @@ typedef __s64	Elf64_Sxword;
 #define DT_INIT		12
 #define DT_FINI		13
 #define DT_SONAME	14
-#define DT_RPATH 	15
+#define DT_RPATH	15
 #define DT_SYMBOLIC	16
 #define DT_REL	        17
 #define DT_RELSZ	18
-- 
2.34.1

