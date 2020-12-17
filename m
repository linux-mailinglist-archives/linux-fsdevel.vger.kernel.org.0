Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE32A2DD586
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 17:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgLQQzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 11:55:47 -0500
Received: from mout.gmx.net ([212.227.15.18]:53895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgLQQzr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608224054;
        bh=w9NF0Fw8FV4NwKb4DviOu1flMn+fTYZk6inIQEtdZOQ=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=AeB9ceahramBRlMZ2XA277XfJJLneSOzfBIseT0NmGV6A2LKZw1RSLioixwqfr2gl
         FUMN5ieNM17kpzIu5fAw++u5q3Ul8yY0WTW9Syw6EuGgobMzPpmxAFJZi7BEPnRzir
         fxJN3sl8wNjt8lAU9cfTDWPM3sIiXHdBiXYGkZvY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.140.151]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1kopY223Ku-003Mbw; Thu, 17
 Dec 2020 17:54:14 +0100
Date:   Thu, 17 Dec 2020 17:54:13 +0100
From:   Helge Deller <deller@gmx.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc/wchan: Use printk format instead of lookup_symbol_name()
Message-ID: <20201217165413.GA1959@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:/cU26LsCB4k0AOGUILYVTjf5wOZQxoZP+Cg1IsgYa8lcpbhhJo7
 0ff0NLktCEYMtQDgr8p/gSim8wTzFwd/VnDFlwn+UNCsgIjC4mvVfFd60/sKrtLr60eyaVL
 /wdBPTB3M2YOutavuTxRSbbQLSGFcPprGOMvd6bLBHBQgFBktfEkoZT400H+SLe0ShT4bC0
 EonoJnWpJwEURfrjdJKgg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lv1aiHDvxic=:IkcfXGt5HZbPMkDqL36841
 MhVFKQYU7gK0HSPUHLzudst5Oe+AkuvEJ0XyGYrgPZMg1G+H8GStnehD5el0nAMy+JIdPXw0g
 u9ewm5/iwE+mRZOWopmlFWaCzz/R12xI8c5PTSSGC+IJR309b8E/I9oG2PdV8TjRLe1ID0Pas
 1LpiVpTECZAYnVEsUAqLumS9pvw9GREaq3Db0+0eH3dwhxfBPPyqxCwR19Q6hLSpK1rwX6xAo
 Py1VteqRytZuNiQPtc93z5bfo/V6MTu56xk9GrmZ5WR1ZL1AeVu5CP7gm5/q1kMlv4Ij+NETq
 VTJP8e70AjDG/e9LxlhFto5XFcwau4S8ny2EZ0I9Y79bSU8YKcjJevoCyPpn/Y5QSItFB8R7q
 NUaRZ0wdH1F/0FoFphyxtWSr/SBwV3xc8DUZpA7+vb8545aeFHiEzLquc5QEjiPyFw/E7EpAX
 PwS3GFOAMZoZiBjJOEm/EttYNezw8k4TrbflnMxiskeBxjBPQYfoNnAMRGThLXXBYZPEsRSto
 b7cPhfJ2EwyW5W2c3gDqXmEPXhaguKD3ae0o9E74/nA0Y2gfdGOgN0twapNjTESTVY3MxqPu9
 2kNouvai/TqlPFMjdAsLiCVZ1uHNMg5fBim0W2OSF/TksstbFf8lMUbrUvev3mCijDGaA92i/
 ZutvEkHuHSGTi5IP6R1iQIjGdqjsvpKEqZmafbgkw03UW6365JPDYXODlKTBvZoaEb/ascfts
 SF/sUky2U0bsILR5vBGddtLUcl9A1hBKhx0ffQxgmx3N/J6mFHsvIGPn8iyVvG+K7nVYsAyQU
 i4FE2PZlbW5X5m4mcv83PHi8U6l0vZBL83GwkV/m2OHmx2q3letPhem2UKKN2sOGuYU8KDy9g
 /wpI/ar7Sr//LajJcyog==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To resolve the symbol fuction name for wchan, use the printk format
specifier %ps instead of manually looking up the symbol function name
via lookup_symbol_name().

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b362523a9829..c4593e1cafa4 100644
=2D-- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -67,7 +67,6 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/rcupdate.h>
-#include <linux/kallsyms.h>
 #include <linux/stacktrace.h>
 #include <linux/resource.h>
 #include <linux/module.h>
@@ -386,19 +385,17 @@ static int proc_pid_wchan(struct seq_file *m, struct=
 pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
 {
 	unsigned long wchan;
-	char symname[KSYM_NAME_LEN];

-	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		goto print0;
+	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
+		wchan =3D get_wchan(task);
+	else
+		wchan =3D 0;

-	wchan =3D get_wchan(task);
-	if (wchan && !lookup_symbol_name(wchan, symname)) {
-		seq_puts(m, symname);
-		return 0;
-	}
+	if (wchan)
+		seq_printf(m, "%ps", (void *) wchan);
+	else
+		seq_putc(m, '0');

-print0:
-	seq_putc(m, '0');
 	return 0;
 }
 #endif /* CONFIG_KALLSYMS */
