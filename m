Return-Path: <linux-fsdevel+bounces-1173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AB07D6DF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BDB7B21236
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B7028E17;
	Wed, 25 Oct 2023 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDECItOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D428E03
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:02:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD0819F
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698242540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EC7RFMR3rA+1DRsmRuXrj1V+WaMGVpdP+bUvoE8xfhg=;
	b=HDECItOP9L2+uAH1MssFAO4S6q2z19xgzFF9BHpp9eSqTAO8hGMwTA7WU94CvfvF8SL7Cb
	lHjKer3/ZNKr7F+pOqpSlue2mNdXDVuPAhIKhVU2qOLvo5s+DUKgdEz/blT7IOzTR9VpMq
	lNt4GBx9vhwGWQctkU1x/m4GFSCUkVA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-dbKmaiDBOfaz98eqyGaeug-1; Wed, 25 Oct 2023 10:02:18 -0400
X-MC-Unique: dbKmaiDBOfaz98eqyGaeug-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99c8bbc902eso359177766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242537; x=1698847337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EC7RFMR3rA+1DRsmRuXrj1V+WaMGVpdP+bUvoE8xfhg=;
        b=avlPMUtiNDlAPwK8hrzg2n5hXDUC5C8MfKkCKlxE2Xczmf5CUVcma0K0FYAAPy0aHY
         refJxbnBXm1s1aL8v2Zn/GH/LFjCWPlYs1ZGGlf6YBpTI6FLxbIHMB8c2uDuEn72W98J
         /Vqck0gpKdgftr84WtkMrttJ+wT1DCy3mF4VKc+5DYflb19rklke18vPabI8ZQ0XIYXc
         Hfh6r/nMsMqpn6/LvBsvZfj8l2fOKUG6PD/gp5Q/95LIMCSo1z7wnVaOoS9kbPndI6K+
         kpYeUHlWtoXZfh9CrCMxPMlRMFnVVAV8yTrOh8lZnXD59SHdc+W3C2lHmX/15p9NpUhI
         dv1A==
X-Gm-Message-State: AOJu0Yw4YcW/MWfecgtokYrc5oZzNurLA4/QYy9VnoJk/1eLkOt3lCq+
	e8ReK2Hq+RRO5DG7qwdAosa70EJMaXJynq+Bz4qgEx+MU8FbydJNKBPUlxNrsqjmmhoQRx2fVJr
	VWM1YWaebtk42lHUp42Gcw7/nqsXPtAT40ppdkyEw31FMfMQKtUU7TmO/lJzdCkzpnN2yzmtSGe
	xEKmfos3paJA==
X-Received: by 2002:a17:907:6093:b0:9ba:2f20:3d7b with SMTP id ht19-20020a170907609300b009ba2f203d7bmr13334970ejc.71.1698242537127;
        Wed, 25 Oct 2023 07:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjMjmoMNoYOpgsb76Zi6H4tYS6A+eLzcgNpATF2jXSDinHL2btMGhhvP35HJjX0s8ljGUJzA==
X-Received: by 2002:a17:907:6093:b0:9ba:2f20:3d7b with SMTP id ht19-20020a170907609300b009ba2f203d7bmr13334928ejc.71.1698242536775;
        Wed, 25 Oct 2023 07:02:16 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm9857073ejc.154.2023.10.25.07.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:02:15 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew House <mattlloydhouse@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 6/6] wire up syscalls for statmount/listmount
Date: Wed, 25 Oct 2023 16:02:04 +0200
Message-ID: <20231025140205.3586473-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025140205.3586473-1-mszeredi@redhat.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up all archs.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 3 +++
 arch/arm/tools/syscall.tbl                  | 3 +++
 arch/arm64/include/asm/unistd32.h           | 4 ++++
 arch/ia64/kernel/syscalls/syscall.tbl       | 3 +++
 arch/m68k/kernel/syscalls/syscall.tbl       | 3 +++
 arch/microblaze/kernel/syscalls/syscall.tbl | 3 +++
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 3 +++
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 3 +++
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 3 +++
 arch/parisc/kernel/syscalls/syscall.tbl     | 3 +++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 3 +++
 arch/s390/kernel/syscalls/syscall.tbl       | 3 +++
 arch/sh/kernel/syscalls/syscall.tbl         | 3 +++
 arch/sparc/kernel/syscalls/syscall.tbl      | 3 +++
 arch/x86/entry/syscalls/syscall_32.tbl      | 3 +++
 arch/x86/entry/syscalls/syscall_64.tbl      | 2 ++
 arch/xtensa/kernel/syscalls/syscall.tbl     | 3 +++
 include/uapi/asm-generic/unistd.h           | 8 +++++++-
 18 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index ad37569d0507..6c23bf68eff0 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -492,3 +492,6 @@
 560	common	set_mempolicy_home_node		sys_ni_syscall
 561	common	cachestat			sys_cachestat
 562	common	fchmodat2			sys_fchmodat2
+# 563 reserved for map_shadow_stack
+564	common	statmount			sys_statmount
+565	common	listmount			sys_listmount
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index c572d6c3dee0..d110a832899b 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -466,3 +466,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 78b68311ec81..b0a994c9ff3c 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -911,6 +911,10 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
+#define __NR_statmount 454
+__SYSCALL(__NR_statmount, sys_statmount)
+#define __NR_listmount 455
+__SYSCALL(__NR_listmount, sys_listmount)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 83d8609aec03..c5f45a8fc834 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -373,3 +373,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 259ceb125367..b9cabb746487 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -452,3 +452,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index a3798c2637fd..89c4ed548ce8 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -458,3 +458,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 152034b8e0a0..a9d561698fe2 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -391,3 +391,6 @@
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n32	cachestat			sys_cachestat
 452	n32	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	n32	statmount			sys_statmount
+455	n32	listmount			sys_listmount
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index cb5e757f6621..80a056866da7 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -367,3 +367,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n64	cachestat			sys_cachestat
 452	n64	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	n64	statmount			sys_statmount
+455	n64	listmount			sys_listmount
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 1a646813afdc..139ddc691176 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -440,3 +440,6 @@
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	o32	cachestat			sys_cachestat
 452	o32	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	o32	statmount			sys_statmount
+455	o32	listmount			sys_listmount
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index e97c175b56f9..46fa753f0d64 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -451,3 +451,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 20e50586e8a2..106937744525 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -539,3 +539,6 @@
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 0122cc156952..57dd9202f8d7 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -455,3 +455,6 @@
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
 451  common	cachestat		sys_cachestat			sys_cachestat
 452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454  common	statmount		sys_statmount			sys_statmount
+455  common	listmount		sys_listmount			sys_listmount
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index e90d585c4d3e..0c7407a0e32c 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -455,3 +455,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4ed06c71c43f..a0fd36469478 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -498,3 +498,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 2d0b1bd866ea..4f41977bd4c1 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -457,3 +457,6 @@
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	cachestat		sys_cachestat
 452	i386	fchmodat2		sys_fchmodat2
+# 563 reserved for map_shadow_stack
+454	i386	statmount		sys_statmount
+455	i386	listmount		sys_listmount
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 1d6eee30eceb..a1b3ce7d22cc 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,6 +375,8 @@
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
+454	common	statmount		sys_statmount
+455	common	listmount		sys_listmount
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index fc1a4f3c81d9..73378984702b 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -423,3 +423,6 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+# 453 reserved for map_shadow_stack
+454	common	statmount			sys_statmount
+455	common	listmount			sys_listmount
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index abe087c53b4b..8df6a747e21a 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -823,8 +823,14 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 
+#define __NR_statmount   454
+__SYSCALL(__NR_statmount, sys_statmount)
+
+#define __NR_listmount   455
+__SYSCALL(__NR_listmount, sys_listmount)
+
 #undef __NR_syscalls
-#define __NR_syscalls 453
+#define __NR_syscalls 456
 
 /*
  * 32 bit systems traditionally used different
-- 
2.41.0


