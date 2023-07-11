Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D32C74F514
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 18:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjGKQYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 12:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjGKQYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:24:47 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A01E4F
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 09:24:44 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.88 [66.187.233.88]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-as8gT4mYNRCpOZzkVb8UAQ-1; Tue, 11 Jul 2023 12:18:36 -0400
X-MC-Unique: as8gT4mYNRCpOZzkVb8UAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0B20809F8F;
        Tue, 11 Jul 2023 16:17:51 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.45.225.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4558200AD6E;
        Tue, 11 Jul 2023 16:17:23 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        James.Bottomley@HansenPartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dalias@libc.org,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        dhowells@redhat.com, fenghua.yu@intel.com, fweimer@redhat.com,
        geert@linux-m68k.org, glebfm@altlinux.org, gor@linux.ibm.com,
        hare@suse.com, hpa@zytor.com, ink@jurassic.park.msu.ru,
        jhogan@kernel.org, kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
        luto@kernel.org, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, namhyung@kernel.org,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp
Subject: [PATCH v4 4/5] tools headers UAPI: Sync files changed by new fchmodat2 syscall
Date:   Tue, 11 Jul 2023 18:16:06 +0200
Message-Id: <22294b3b68050a70eaaa962eff46b8672bc2f7e8.1689092120.git.legion@kernel.org>
In-Reply-To: <cover.1689092120.git.legion@kernel.org>
References: <cover.1689074739.git.legion@kernel.org> <cover.1689092120.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

That add support for this new syscall in tools such as 'perf trace'.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 tools/include/uapi/asm-generic/unistd.h             | 5 ++++-
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 2 ++
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 2 ++
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 2 ++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 2 ++
 5 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index dd7d8e10f16d..76b5922b0d39 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -817,8 +817,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#define __NR_fchmodat2 452
+__SYSCALL(__NR_fchmodat2, sys_fchmodat2)
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 453
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 3f1886ad9d80..434728af4eaa 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -365,3 +365,5 @@
 448	n64	process_mrelease		sys_process_mrelease
 449	n64	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+# 451 reserved for cachestat
+452	n64	fchmodat2			sys_fchmodat2
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index a0be127475b1..6b70b6705bd7 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -537,3 +537,5 @@
 448	common	process_mrelease		sys_process_mrelease
 449	common  futex_waitv                     sys_futex_waitv
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
+# 451 reserved for cachestat
+452	common	fchmodat2			sys_fchmodat2
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index b68f47541169..0ed90c9535b0 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -453,3 +453,5 @@
 448  common	process_mrelease	sys_process_mrelease		sys_process_mrelease
 449  common	futex_waitv		sys_futex_waitv			sys_futex_waitv
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
+# 451 reserved for cachestat
+452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..a008724a1f48 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,8 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+# 451 reserved for cachestat
+452	common	fchmodat2		sys_fchmodat2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.33.8

