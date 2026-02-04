Return-Path: <linux-fsdevel+bounces-76238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NZbNPCugmn/YAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 03:29:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F6AE0D99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 03:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCEF230CA66B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 02:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BF62C0263;
	Wed,  4 Feb 2026 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPev4Nj6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D329221577
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 02:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770172101; cv=none; b=fTP02c1fpmQPC2r9eFRUrpOqzqd2LiraFJVu98EmDz0Cq4oCBQhcbradgMQlPQFMeOwCsJZnrQPCB7MJSBBpfYHaProQBymXbdBRu94J0oMS4slLudTWQpwD+jDc8giP7VAJbgzZszP8nuSnaF4PYdJ3NOl9DmCyUGXcm1cHfAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770172101; c=relaxed/simple;
	bh=CvYzjfP7rw4yGGJRdX8B4balTna1wcyExbLjMjY+2gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKv005y7Am/y9dJ+wV163L1vs0bTxDlDO79IZYe61dxaAX7eZVtuxCfGW7o2/mH6+MDpSVcSHsoVLpNis+bZ3lrEvkvfmLTjzDP11HWptitlLkCZqozn8DR0xdhcSIBx7q5N8Eb8edSKw+sfxVGf+scZHsyVSiJSBINJcScv2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPev4Nj6; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so4024174a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 18:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172099; x=1770776899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjmnnaJ+dU4QzslBxUrlmdhSXDXCpeTGjd28jp/dBEQ=;
        b=NPev4Nj6MZv8TtZc5TUkucKKyaCeCQFsQeDygiaMV3DK5IAeeRLiU0dxtGdpj5xcH4
         FN+KIgKdn5EflUydJEQft++zWabJhZEIQAk6hvvkjlfyIBTO8oV2Le6VA9+skcivWo+n
         020qaMgi3VlPbfuQOQUg3ElgP78KM2bA1RIpka7vVlVGk+ynlQCY/dE5LQZfLC9NlFiH
         90S1Ybquy2LRunlQZANJs4Sufrvsstfico932Ta2S5gCno6quztZSon7KZnCOMvqqSol
         PHvIVOkL+3QYplbeRudvvr+zFGsthi9a52ELD4j1quPiaMEgQhAW3BiBSolzW5WcV7kx
         s5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172099; x=1770776899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjmnnaJ+dU4QzslBxUrlmdhSXDXCpeTGjd28jp/dBEQ=;
        b=K3+/sTOOq0ySqfPrCUzDuR1YD3iwAstal93DSVN/UwTJS/Mh6lvcTonKA0SABX1cZi
         TWr44liGOdcrYFDxrYpdwli+245AhWEDj/rqNGBqWNN2fao4PEicUmDyUix0lKWfyNPe
         X9yDepFwMbRvOAf3PgxH7jykjv6ALqY1zWRZWCplcDr/g0OyUCHcow6LptprIC/9I8L3
         ZS+tTWtTrDvBkK77Yn/rnY0TFcYI+J+ussZJwkaxhddmwgoJs+uMOv4JfhS4oK4J04P6
         q2Si3Yz+/cpQ7lLk4/UhrIEGgPoy7gBOzqbgC3ZWUlyKfH19iYVz6c9Pt3X+VO1tT3Au
         ZswQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA8lq3RGXUidT5roLEMxViu0PsdpMFgw6MrMTjMW7qAAq/6Q9Hd71ygLptP9oxNDpFmXo7t3PxZmxv3u08@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5UhXAdHY7dQ1hY1cDOe6grEra984+ll7y8o1HjsXF5h5NMtXW
	Uiu3+C2/XUL20KntE8MUl+K4cli2R1/pYlxjhA6e0WalHT1Yhm1cPYFe
X-Gm-Gg: AZuq6aI62nzyUh0ovyTzXX/eh0/KkfGuMJNcgsh0YEOn6rwv9LVZ8nhUmJhtLjyBcaI
	AFeT7QRPFzcby6cYZdfAT2H4RQCiFoIvclAVAqOOqR8gHkEl4hS2IBkpFtZHVlLxopiQBMCFzXt
	uqzS8DIukVV+EPewN7xzs94GP1dsD0JBM9FvlTbUu1qs6spNv7278UlsMBxVYuJ00aNqFlWg16M
	Ml4G92gVVGm/Xd25uXImnFAczd0GzQ1vBN6x7m1+E8ruRXeNpldRrYFCwqdlMkqAo21Ohjs3dSi
	eKtgqNIFXljNnOUgfvk5SlMShKV4/xzwAoUSR8GyN91FYIsI9lnjuhP1FQ3mmAyFMCfFnMWGlMQ
	Q3E46YowQnuD0spkg1EQ6kLo/IJ1ZC5bb6JPSwLd+7twXOJODliaNmCB68oPGY51tN/DM0l94/A
	GOWGkBbc6uMSjEqvHY18/2ylULlP5cJZQSXxv0hIY5PDuR/mXoSPw1kf7h2aYo9PabJtS4bdKTI
	jr8GrZYGCj8oayZ
X-Received: by 2002:a05:6a20:a122:b0:370:73c1:6a87 with SMTP id adf61e73a8af0-393724cde89mr1471194637.58.1770172099431;
        Tue, 03 Feb 2026 18:28:19 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93397c472sm6721415ad.89.2026.02.03.18.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:28:18 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 421DD1200C31; Wed,  4 Feb 2026 11:28:17 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 01/13] x86/um: nommu: elf loader for fdpic
Date: Wed,  4 Feb 2026 11:27:59 +0900
Message-ID: <fa22ec46b0d78df65a005d4a33d05edebbbd381d.1770170302.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770170302.git.thehajime@gmail.com>
References: <cover.1770170302.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,google.com,oracle.com,vger.kernel.org,xmission.com,kernel.org,zeniv.linux.org.uk,suse.cz,kvack.org];
	TAGGED_FROM(0.00)[bounces-76238-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thehajime@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xmission.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kvack.org:email,suse.cz:email]
X-Rspamd-Queue-Id: 47F6AE0D99
X-Rspamd-Action: no action

As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
loader, FDPIC ELF loader.  In this commit, we added necessary
definitions in the arch, as UML has not been used so far.  It also
updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Acked-by: Kees Cook <kees@kernel.org>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/include/asm/mmu.h            | 5 +++++
 arch/um/include/asm/ptrace-generic.h | 6 ++++++
 arch/x86/um/asm/elf.h                | 8 ++++++--
 fs/Kconfig.binfmt                    | 2 +-
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 07d48738b402..82a919132aff 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -21,6 +21,11 @@ typedef struct mm_context {
 	spinlock_t sync_tlb_lock;
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
+
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long   exec_fdpic_loadmap;
+	unsigned long   interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(mm)						\
diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 86d74f9d33cf..62e9916078ec 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -29,6 +29,12 @@ struct pt_regs {
 
 #define PTRACE_OLDSETOPTIONS 21
 
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+#define PTRACE_GETFDPIC		31
+#define PTRACE_GETFDPIC_EXEC	0
+#define PTRACE_GETFDPIC_INTERP	1
+#endif
+
 struct task_struct;
 
 extern long subarch_ptrace(struct task_struct *child, long request,
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 22d0111b543b..388fe669886c 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -9,6 +9,7 @@
 #include <skas.h>
 
 #define CORE_DUMP_USE_REGSET
+#define ELF_FDPIC_CORE_EFLAGS  0
 
 #ifdef CONFIG_X86_32
 
@@ -158,8 +159,11 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 extern unsigned long um_vdso_addr;
 #define AT_SYSINFO_EHDR 33
-#define ARCH_DLINFO	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr)
-
+#define ARCH_DLINFO						\
+do {								\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr);		\
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, 0);			\
+} while (0)
 #endif
 
 typedef unsigned long elf_greg_t;
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 1949e25c7741..0a92bebd5f75 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
-	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
+	depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !MMU)
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
-- 
2.43.0


