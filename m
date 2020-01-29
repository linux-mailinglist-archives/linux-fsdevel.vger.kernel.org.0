Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF4E14D021
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 19:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgA2SJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 13:09:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28558 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726245AbgA2SJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580321392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PuvkLv/oIw9Q/DG8YMeMuQ1BSWZb/tsSFT2ktsDil9M=;
        b=C7pTkNQxPu7fjgicQHE8IJhId0G6K2/m+jEg7H6+NM7Qwg6OnoBAbgVa1XwDKDmTZWfB8x
        0hdHW4gjLCKE3JqZAhi2ZsZnkF+h03VN1R0FXEbdWGBjSiOGdB2Gc8lKyZFwCgo6SQmBD/
        h9T1kUEZGb+57gCX6bLxLi5PgSGBJQw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-RzleVpA9P3indHUTkTcoHw-1; Wed, 29 Jan 2020 13:09:43 -0500
X-MC-Unique: RzleVpA9P3indHUTkTcoHw-1
Received: by mail-wm1-f72.google.com with SMTP id t17so236448wmi.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 10:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PuvkLv/oIw9Q/DG8YMeMuQ1BSWZb/tsSFT2ktsDil9M=;
        b=gPG4ptziIaL1QZBFITFFUlUXYE0o7yUjt2P9xLLBuy3yDrrpoC8uQpfv1PeScEFVL2
         KWNdgSnrjvVojZHjGAlVwK67TCexSxlL0REPlEjdVKDYPB9ZJE2EhQ1CkIT1vIWrpnKb
         xEWQZtkkx4+CqcDvzcKhGGQmzKEGsbH34xywdNoUunMXk75spew5wnpApbNA2EH8GLHK
         R2+7O/fclGJukUMg4o9NEJl5LV2fB7LdfZFg/+bfEua8KoskWdGaGEjl14Zeuohi+63W
         afiK89O0RE5alpxrXJs8/QPayOMp/O6l1GjYSMR53XGEZct2oBST8Ps5BGHf2cpWpr5g
         CN3w==
X-Gm-Message-State: APjAAAV3Egh16nyv5kFdpu+8bxL6bw7Vb8iTb0ttM0AnLp4S4d6jQoJH
        XmYZD6cdE0PKob0WYBuotSmOqT4NeoDA3AJQUVfEempP9hCIlWvFFuVjsR02evtNN4NnPs2P0pY
        Nir05e9bu/4QDEvexvMXtbSnwrw==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr436980wmg.63.1580321382597;
        Wed, 29 Jan 2020 10:09:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1RpprGonPlEm6g7ZSIDmngGnsx8ltMy/qtsYuE7+BQkwzMwemGOvhlG6C+tZ+eVipbvkanw==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr436956wmg.63.1580321382243;
        Wed, 29 Jan 2020 10:09:42 -0800 (PST)
Received: from dhcp-1-195.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.googlemail.com with ESMTPSA id m7sm3695976wrr.40.2020.01.29.10.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 10:09:41 -0800 (PST)
From:   Grzegorz Halat <ghalat@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, ghalat@redhat.com, ssaner@redhat.com,
        atomlin@redhat.com, oleksandr@redhat.com, vbendel@redhat.com,
        kirill@shutemov.name, khlebnikov@yandex-team.ru,
        borntraeger@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Qian Cai <cai@lca.pw>
Subject: [PATCH 1/1] mm: sysctl: add panic_on_inconsistent_mm sysctl
Date:   Wed, 29 Jan 2020 19:08:51 +0100
Message-Id: <20200129180851.551109-1-ghalat@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Memory management subsystem performs various checks at runtime,
if an inconsistency is detected then such event is being logged and kernel
continues to run. While debugging such problems it is helpful to collect
memory dump as early as possible. Currently, there is no easy way to panic
kernel when such error is detected.

It was proposed[1] to panic the kernel if panic_on_oops is set but this
approach was not accepted. One of alternative proposals was introduction of
a new sysctl.

Add a new sysctl - panic_on_inconsistent_mm. If the sysctl is set then the
kernel will be crashed when an inconsistency is detected by memory
management. This currently means panic when bad page or bad PTE
is detected(this may be extended to other places in MM).

Another use case of this sysctl may be in security-wise environments,
it may be more desired to crash machine than continue to run with
potentially damaged data structures.

Changes since v1 [2]:
- rename the sysctl to panic_on_inconsistent_mm
- move the sysctl from kernel to vm table
- print modules in print_bad_pte() only before calling panic

[1] https://lore.kernel.org/linux-mm/1426495021-6408-1-git-send-email-borntraeger@de.ibm.com/
[2] https://lore.kernel.org/lkml/20200127101100.92588-1-ghalat@redhat.com/

Signed-off-by: Grzegorz Halat <ghalat@redhat.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 14 ++++++++++++++
 include/linux/kernel.h                  |  1 +
 kernel/sysctl.c                         |  9 +++++++++
 mm/memory.c                             |  8 ++++++++
 mm/page_alloc.c                         |  4 +++-
 5 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 64aeee1009ca..57f7926a64b8 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -61,6 +61,7 @@ Currently, these files are in /proc/sys/vm:
 - overcommit_memory
 - overcommit_ratio
 - page-cluster
+- panic_on_inconsistent_mm
 - panic_on_oom
 - percpu_pagelist_fraction
 - stat_interval
@@ -741,6 +742,19 @@ extra faults and I/O delays for following faults if they would have been part of
 that consecutive pages readahead would have brought in.
 
 
+panic_on_inconsistent_mm
+========================
+
+Controls the kernel's behaviour when inconsistency is detected
+by memory management code, for example bad page state or bad PTE.
+
+0: try to continue operation.
+
+1: panic immediately.
+
+The default value is 0.
+
+
 panic_on_oom
 ============
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0d9db2a14f44..b3bd94c558ab 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -518,6 +518,7 @@ extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in
 extern int panic_timeout;
 extern unsigned long panic_print;
 extern int panic_on_oops;
+extern int panic_on_inconsistent_mm;
 extern int panic_on_unrecovered_nmi;
 extern int panic_on_io_nmi;
 extern int panic_on_warn;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 70665934d53e..a9733311e3a1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1303,6 +1303,15 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &two,
 	},
+	{
+		.procname	= "panic_on_inconsistent_mm",
+		.data		= &panic_on_inconsistent_mm,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{
 		.procname	= "panic_on_oom",
 		.data		= &sysctl_panic_on_oom,
diff --git a/mm/memory.c b/mm/memory.c
index 45442d9a4f52..b29a18077a6a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -71,6 +71,7 @@
 #include <linux/dax.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/module.h>
 
 #include <trace/events/kmem.h>
 
@@ -88,6 +89,8 @@
 #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
 #endif
 
+int panic_on_inconsistent_mm __read_mostly;
+
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 /* use the per-pgdat data instead for discontigmem - mbligh */
 unsigned long max_mapnr;
@@ -543,6 +546,11 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 		 vma->vm_ops ? vma->vm_ops->fault : NULL,
 		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
 		 mapping ? mapping->a_ops->readpage : NULL);
+
+	if (panic_on_inconsistent_mm) {
+		print_modules();
+		panic("Bad page map detected");
+	}
 	dump_stack();
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d047bf7d8fd4..a20cd3ece5ba 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -643,9 +643,11 @@ static void bad_page(struct page *page, const char *reason,
 	if (bad_flags)
 		pr_alert("bad because of flags: %#lx(%pGp)\n",
 						bad_flags, &bad_flags);
-	dump_page_owner(page);
 
+	dump_page_owner(page);
 	print_modules();
+	if (panic_on_inconsistent_mm)
+		panic("Bad page state detected");
 	dump_stack();
 out:
 	/* Leave bad fields for debug, except PageBuddy could make trouble */
-- 
2.21.1

