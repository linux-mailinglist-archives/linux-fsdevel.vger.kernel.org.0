Return-Path: <linux-fsdevel+bounces-49509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6E2ABDA47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 15:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FFA8A3910
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F765242D94;
	Tue, 20 May 2025 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gxkw8zcp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D3242D9A;
	Tue, 20 May 2025 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749330; cv=none; b=Er6+XNyWAvKcXeFMchvkD7KeeKLSpgPeSb1Rv0YpRmaPO/pmBBI3umxBfJEi64eXSmnhfWoSjYAyhBEHzXwv+KkeZ4YLPmXJvNNhtiu7pAg8powi3RrfwEOBBToTi83tlXv8bA5EOhjRG5ekEJMuHzplsiTWPkxMTZWqYTHare4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749330; c=relaxed/simple;
	bh=708s2A/GAiTFxCJ5ww+8glg7QM9WzXzBaNesx7c/BLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7P+WKy8iMJyzGjFCSAAUNvDdh+0E9aOOh4cHlrCdQ6Ej+cly7hAgPRFe3UjzT1wVDSyRvm4IlVfphcxgxtRW7Dgu3V/a48xtIi0lHGLCGuQY5fkNZ5JxrWOqgNYnqLNvbmWFJswZ9P4q4p2tnFs/CE/F22HR7ej5TkiiG9ElxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gxkw8zcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED53DC4CEE9;
	Tue, 20 May 2025 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749328;
	bh=708s2A/GAiTFxCJ5ww+8glg7QM9WzXzBaNesx7c/BLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gxkw8zcpTAJcAwEUl31acxSbHZBsnCKxwaCXL043+XRxuaPy2eWsgsvui+A8LhwVe
	 r5qpchfHodgyxspiecGDnQcygoB117sz2MUwQqp1pZ4NUXf/E283vPQ1yVgToUED4x
	 oR8Hwv3SBxm0Th0rpVlMZ0lntaft5/GlMBF8ySW4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	"Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 01/97] binfmt: Fix whitespace issues
Date: Tue, 20 May 2025 15:49:26 +0200
Message-ID: <20250520125800.721573657@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125800.653047540@linuxfoundation.org>
References: <20250520125800.653047540@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 8f6e3f9e5a0f58e458a348b7e36af11d0e9702af ]

Fix the annoying whitespace issues that have been following these files
around for years.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Link: https://lore.kernel.org/r/20221018071350.never.230-kees@kernel.org
Stable-dep-of: 11854fe263eb ("binfmt_elf: Move brk for static PIE even if ASLR disabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_elf.c          | 14 +++++++-------
 fs/binfmt_elf_fdpic.c    |  2 +-
 fs/exec.c                |  2 +-
 include/uapi/linux/elf.h |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 89e7e4826efce..d1cf3d25da4b6 100644
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
@@ -1021,7 +1021,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				 executable_stack);
 	if (retval < 0)
 		goto out_free_dentry;
-	
+
 	elf_bss = 0;
 	elf_brk = 0;
 
@@ -1044,7 +1044,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		if (unlikely (elf_brk > elf_bss)) {
 			unsigned long nbyte;
-	            
+
 			/* There was a PT_LOAD segment with p_memsz > p_filesz
 			   before this one. Map anonymous pages, if needed,
 			   and clear the area.  */
@@ -1522,7 +1522,7 @@ static void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, loff_t offset)
 	phdr->p_align = 0;
 }
 
-static void fill_note(struct memelfnote *note, const char *name, int type, 
+static void fill_note(struct memelfnote *note, const char *name, int type,
 		unsigned int sz, void *data)
 {
 	note->name = name;
@@ -2005,8 +2005,8 @@ static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
 	t->num_notes = 0;
 
 	fill_prstatus(&t->prstatus.common, p, signr);
-	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);	
-	
+	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
+
 	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
 		  &(t->prstatus));
 	t->num_notes++;
@@ -2296,7 +2296,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	if (!elf_core_write_extra_phdrs(cprm, offset))
 		goto end_coredump;
 
- 	/* write out the notes section */
+	/* write out the notes section */
 	if (!write_note_info(&info, cprm))
 		goto end_coredump;
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index c71a409273150..b2d3b6e43bb56 100644
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
index 2039414cc6621..b65af8f9a4f9b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -169,7 +169,7 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 exit:
 	fput(file);
 out:
-  	return error;
+	return error;
 }
 #endif /* #ifdef CONFIG_USELIB */
 
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index c7b056af9ef0a..3e5f07be26fc8 100644
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
2.39.5




