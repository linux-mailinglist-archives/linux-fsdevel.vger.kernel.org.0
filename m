Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA315A1AAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 23:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbiHYVBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 17:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiHYVBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:01:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A76A3450
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 14:01:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u5so18272110wrt.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 14:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Z63zwi7cGAuKiNoBIs10Ekj9CC9KQ4p8G+KukTWva3I=;
        b=SJaPKdEKD3cZ4U2ILmGJ7YYl8jrjkW+umstaVhULXfth/8eB87EBEKn/1mLbA1W76X
         PzwduEhBRnRX4YqA+aiPXjDTcwdjcfx/3gAU9DBS4WBTJpRmqny0NPSmw9G9ochTOInu
         2WeWfYenhoC74R53yv/Z0OwTJEtmrKUx6FM/amJ0sZsda7+BI8NV+YKEpXHvhWWUIQjL
         jIvX/rug3aVUgMdrWNpc6nGPjyF4/U1BUWb17IFkiyO/CnXUmbpjEQXfrqIv9bH9Ityb
         Jo9HX3MLhnjEaryWcsPgu/zFHTD87Za/Foj2KTeWLFsfxj4oLiPHVvekJWAPqw55D4IJ
         wP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Z63zwi7cGAuKiNoBIs10Ekj9CC9KQ4p8G+KukTWva3I=;
        b=Kyqx9zbc4xSYXFfloibWoZUWjil4c6w/c3kq1eyMOm/9iG/alkjpdo+PlO4a1t/gp9
         o8619MUhZNrisJDrOil2y1V5F+K1DYmjQCfBpqLW12NEsJvorjG6rHL88VrB1XB/bjlc
         osROeiL0yMdLc/4345+Z8r8SlWCRJj4+IZEmguFsO/3iDAlR1MN8wJtjQXtDT1AYx3bO
         9S+8SuHS8dbFWj5g3m4HnKzYZ75AgGJKsaUv5lyh4ewQ4C87po2g4vrPiu4flYpEpUnx
         6SLA4Xc4J/+ONHXXouuRirkDQcij62Ltd3yKi5O2gOGlda5ujGJibj1Zo+P3TCcorJym
         QNiw==
X-Gm-Message-State: ACgBeo31po3VyHmeTxlpNgabRnG1y5L3+8QNPqRYzRm++i07ALRDMUDm
        CfDNCQFwOUbpRUVOVdIlAU8s4w==
X-Google-Smtp-Source: AA6agR6CHzaozIjR/7Q20mq4qiXqh3OzKi41CUQLkIeloF4Lpy2xCkUYlbFCvfPNRwRzxYHUk2X5VA==
X-Received: by 2002:a5d:5b19:0:b0:225:3ed4:ff64 with SMTP id bx25-20020a5d5b19000000b002253ed4ff64mr3336331wrb.537.1661461285500;
        Thu, 25 Aug 2022 14:01:25 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id i14-20020adffdce000000b00225213fd4a9sm220877wrs.33.2022.08.25.14.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:01:24 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     arnd@arndb.de, linux-arch@vger.kernel.org
Cc:     richard.henderson@linaro.org, mattst88@gmail.com,
        vgupta@kernel.org, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, bcain@quicinc.com,
        chenhuacai@kernel.org, geert@linux-m68k.org, gerg@linux-m68k.org,
        monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org,
        shorne@gmail.com, deller@gmx.de, mpe@ellerman.id.au,
        palmer@dabbelt.com, hca@linux.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2] include/linux: declare cpuinfo_op in processor.h
Date:   Thu, 25 Aug 2022 21:59:43 +0100
Message-Id: <20220825205942.1713914-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

RISC-V is missing a prototype for cpuinfo_op, triggering complaints
from sparse. Rather than adding yet another `extern const struct
seq_operations cpuinfo_op;` to an arch specific header file, create a
generic variant and include it across the board.

Several archs already have a declaration in asm/processor.h - migrate
these to include linux/processor.h instead. Most archs do not declare
cpuinfo_op so one sparse complaint off their books.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v1:
- Per Geert, use linux/processor.h & include it on all archs &
- Squash to a single patch

I pushed it out for LKP to take a look at, and was all good there.
Only added one person per arch & the mailing lists to stay within a
1024 character CC list. Please scream if I picked the wrong person.
---
 arch/alpha/kernel/setup.c               | 1 +
 arch/arc/kernel/setup.c                 | 1 +
 arch/arm/kernel/setup.c                 | 1 +
 arch/arm64/kernel/cpuinfo.c             | 1 +
 arch/csky/kernel/cpu-probe.c            | 1 +
 arch/hexagon/kernel/setup.c             | 1 +
 arch/ia64/kernel/setup.c                | 1 +
 arch/loongarch/kernel/proc.c            | 1 +
 arch/m68k/kernel/setup_mm.c             | 1 +
 arch/m68k/kernel/setup_no.c             | 1 +
 arch/microblaze/include/asm/processor.h | 2 --
 arch/microblaze/kernel/cpu/mb.c         | 1 +
 arch/mips/kernel/proc.c                 | 1 +
 arch/nios2/kernel/cpuinfo.c             | 1 +
 arch/openrisc/kernel/setup.c            | 1 +
 arch/parisc/kernel/setup.c              | 1 +
 arch/powerpc/kernel/setup-common.c      | 1 +
 arch/riscv/kernel/cpu.c                 | 3 ++-
 arch/s390/include/asm/processor.h       | 2 +-
 arch/s390/kernel/processor.c            | 1 +
 arch/sh/include/asm/processor.h         | 1 -
 arch/sh/kernel/cpu/proc.c               | 1 +
 arch/sparc/include/asm/cpudata.h        | 2 --
 arch/sparc/kernel/cpu.c                 | 1 +
 arch/um/kernel/um_arch.c                | 1 +
 arch/x86/include/asm/processor.h        | 2 --
 arch/x86/kernel/cpu/proc.c              | 1 +
 arch/xtensa/kernel/setup.c              | 1 +
 fs/proc/cpuinfo.c                       | 3 +--
 include/linux/processor.h               | 2 ++
 30 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index b4fbbba30aa2..d2c2546e9b1a 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -46,6 +46,7 @@
 #include <asm/io.h>
 #include <linux/log2.h>
 #include <linux/export.h>
+#include <linux/processor.h>
 
 static int alpha_panic_event(struct notifier_block *, unsigned long, void *);
 static struct notifier_block alpha_panic_block = {
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 41f07b3e594e..b681bdd21a0c 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -17,6 +17,7 @@
 #include <linux/of_fdt.h>
 #include <linux/of.h>
 #include <linux/cache.h>
+#include <linux/processor.h>
 #include <uapi/linux/mount.h>
 #include <asm/sections.h>
 #include <asm/arcregs.h>
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1e8a50a97edf..83240c3c0463 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -29,6 +29,7 @@
 #include <linux/compiler.h>
 #include <linux/sort.h>
 #include <linux/psci.h>
+#include <linux/processor.h>
 
 #include <asm/unified.h>
 #include <asm/cp15.h>
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index d7702f39b4d3..4c1b12918aed 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -20,6 +20,7 @@
 #include <linux/personality.h>
 #include <linux/preempt.h>
 #include <linux/printk.h>
+#include <linux/processor.h>
 #include <linux/seq_file.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
diff --git a/arch/csky/kernel/cpu-probe.c b/arch/csky/kernel/cpu-probe.c
index 5f15ca31d3e8..62580f5d0d74 100644
--- a/arch/csky/kernel/cpu-probe.c
+++ b/arch/csky/kernel/cpu-probe.c
@@ -5,6 +5,7 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/processor.h>
 
 #include <abi/reg_ops.h>
 
diff --git a/arch/hexagon/kernel/setup.c b/arch/hexagon/kernel/setup.c
index 1880d9beaf2b..395d2930dbd1 100644
--- a/arch/hexagon/kernel/setup.c
+++ b/arch/hexagon/kernel/setup.c
@@ -13,6 +13,7 @@
 #include <linux/seq_file.h>
 #include <linux/console.h>
 #include <linux/of_fdt.h>
+#include <linux/processor.h>
 #include <asm/io.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index fd6301eafa9d..973725c4ce1e 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -52,6 +52,7 @@
 #include <linux/cpufreq.h>
 #include <linux/kexec.h>
 #include <linux/crash_dump.h>
+#include <linux/processor.h>
 
 #include <asm/mca.h>
 #include <asm/meminit.h>
diff --git a/arch/loongarch/kernel/proc.c b/arch/loongarch/kernel/proc.c
index 5c67cc4fd56d..a8cbebe839e2 100644
--- a/arch/loongarch/kernel/proc.c
+++ b/arch/loongarch/kernel/proc.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/processor.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index e62fa8f2149b..45d82a4839fc 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/nvram.h>
 #include <linux/initrd.h>
+#include <linux/processor.h>
 
 #include <asm/bootinfo.h>
 #include <asm/byteorder.h>
diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index cb6def585851..86dd4b47ff43 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -33,6 +33,7 @@
 #include <linux/initrd.h>
 #include <linux/root_dev.h>
 #include <linux/rtc.h>
+#include <linux/processor.h>
 
 #include <asm/setup.h>
 #include <asm/bootinfo.h>
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 7e9e92670df3..c5877c91116a 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -15,8 +15,6 @@
 #include <asm/current.h>
 
 # ifndef __ASSEMBLY__
-/* from kernel/cpu/mb.c */
-extern const struct seq_operations cpuinfo_op;
 
 # define cpu_relax()		barrier()
 
diff --git a/arch/microblaze/kernel/cpu/mb.c b/arch/microblaze/kernel/cpu/mb.c
index 9581d194d9e4..33f5be916121 100644
--- a/arch/microblaze/kernel/cpu/mb.c
+++ b/arch/microblaze/kernel/cpu/mb.c
@@ -14,6 +14,7 @@
 #include <linux/seq_file.h>
 #include <linux/cpu.h>
 #include <linux/initrd.h>
+#include <linux/processor.h>
 
 #include <linux/bug.h>
 #include <asm/cpuinfo.h>
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 8eba5a1ed664..54a4226cff84 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/processor.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
diff --git a/arch/nios2/kernel/cpuinfo.c b/arch/nios2/kernel/cpuinfo.c
index 203870c4b86d..9641ca55377e 100644
--- a/arch/nios2/kernel/cpuinfo.c
+++ b/arch/nios2/kernel/cpuinfo.c
@@ -12,6 +12,7 @@
 #include <linux/seq_file.h>
 #include <linux/string.h>
 #include <linux/of.h>
+#include <linux/processor.h>
 #include <asm/cpuinfo.h>
 
 struct cpuinfo cpuinfo;
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 0cd04d936a7a..a628c928941b 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -33,6 +33,7 @@
 #include <linux/of_fdt.h>
 #include <linux/of.h>
 #include <linux/device.h>
+#include <linux/processor.h>
 
 #include <asm/sections.h>
 #include <asm/types.h>
diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index f005ddedb50e..d00488507f49 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/start_kernel.h>
+#include <linux/processor.h>
 
 #include <asm/cacheflush.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index dd98f43bd685..12ddcb1401be 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -34,6 +34,7 @@
 #include <linux/of_platform.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
+#include <linux/processor.h>
 #include <asm/io.h>
 #include <asm/paca.h>
 #include <asm/processor.h>
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 0be8a2403212..f28ec528d54a 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -4,8 +4,9 @@
  */
 
 #include <linux/init.h>
-#include <linux/seq_file.h>
 #include <linux/of.h>
+#include <linux/processor.h>
+#include <linux/seq_file.h>
 #include <asm/hwcap.h>
 #include <asm/smp.h>
 #include <asm/pgtable.h>
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index bd66f8e34949..55fbb4f7f7f6 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -33,6 +33,7 @@
 #include <linux/cpumask.h>
 #include <linux/linkage.h>
 #include <linux/irqflags.h>
+#include <linux/processor.h>
 #include <asm/cpu.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
@@ -80,7 +81,6 @@ void s390_adjust_jiffies(void);
 void s390_update_cpu_mhz(void);
 void cpu_detect_mhz_feature(void);
 
-extern const struct seq_operations cpuinfo_op;
 extern void execve_tail(void);
 extern void __bpon(void);
 unsigned long vdso_size(void);
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index a194611ba88c..267886605902 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -17,6 +17,7 @@
 #include <linux/mm_types.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
+#include <linux/processor.h>
 
 #include <asm/diag.h>
 #include <asm/facility.h>
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 85a6c1c3c16e..10c4b4b9af46 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -123,7 +123,6 @@ extern unsigned int mem_init_done;
 
 /* arch/sh/kernel/setup.c */
 const char *get_cpu_subtype(struct sh_cpuinfo *c);
-extern const struct seq_operations cpuinfo_op;
 
 /* thread_struct flags */
 #define SH_THREAD_UAC_NOPRINT	(1 << 0)
diff --git a/arch/sh/kernel/cpu/proc.c b/arch/sh/kernel/cpu/proc.c
index a306bcd6b341..f373a21c6705 100644
--- a/arch/sh/kernel/cpu/proc.c
+++ b/arch/sh/kernel/cpu/proc.c
@@ -2,6 +2,7 @@
 #include <linux/seq_file.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/processor.h>
 #include <asm/machvec.h>
 #include <asm/processor.h>
 
diff --git a/arch/sparc/include/asm/cpudata.h b/arch/sparc/include/asm/cpudata.h
index d213165ee713..f7e690a7860b 100644
--- a/arch/sparc/include/asm/cpudata.h
+++ b/arch/sparc/include/asm/cpudata.h
@@ -7,8 +7,6 @@
 #include <linux/threads.h>
 #include <linux/percpu.h>
 
-extern const struct seq_operations cpuinfo_op;
-
 #endif /* !(__ASSEMBLY__) */
 
 #if defined(__sparc__) && defined(__arch64__)
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 79cd6ccfeac0..ffdc7a825b80 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -12,6 +12,7 @@
 #include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/pgtable.h>
+#include <linux/processor.h>
 
 #include <asm/spitfire.h>
 #include <asm/oplib.h>
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e0de60e503b9..4034f5b959f7 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -9,6 +9,7 @@
 #include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/panic_notifier.h>
+#include <linux/processor.h>
 #include <linux/seq_file.h>
 #include <linux/string.h>
 #include <linux/utsname.h>
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 356308c73951..08ccd453ec4f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -188,8 +188,6 @@ DECLARE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 #define cpu_data(cpu)		boot_cpu_data
 #endif
 
-extern const struct seq_operations cpuinfo_op;
-
 #define cache_line_size()	(boot_cpu_data.x86_cache_alignment)
 
 extern void cpu_detect(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 099b6f0d96bd..5a0699d9ff7d 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -4,6 +4,7 @@
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <linux/cpufreq.h>
+#include <linux/processor.h>
 
 #include "cpu.h"
 
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 9191738f9941..d4417a174887 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/processor.h>
 
 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
 # include <linux/console.h>
diff --git a/fs/proc/cpuinfo.c b/fs/proc/cpuinfo.c
index f38bda5b83ec..ca3065dfecd9 100644
--- a/fs/proc/cpuinfo.c
+++ b/fs/proc/cpuinfo.c
@@ -3,10 +3,9 @@
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/processor.h>
 #include <linux/seq_file.h>
 
-extern const struct seq_operations cpuinfo_op;
-
 static int cpuinfo_open(struct inode *inode, struct file *file)
 {
 	return seq_open(file, &cpuinfo_op);
diff --git a/include/linux/processor.h b/include/linux/processor.h
index dc78bdc7079a..71bdf8626874 100644
--- a/include/linux/processor.h
+++ b/include/linux/processor.h
@@ -59,4 +59,6 @@ do {								\
 
 #endif
 
+extern const struct seq_operations cpuinfo_op;
+
 #endif /* _LINUX_PROCESSOR_H */
-- 
2.37.1

