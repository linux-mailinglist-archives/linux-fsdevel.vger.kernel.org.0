Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A3E25EEB0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Sep 2020 17:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgIFPi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 11:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbgIFPh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:37:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37642C061574;
        Sun,  6 Sep 2020 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Resent-To:Resent-Message-ID:Resent-Date:
        Resent-From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        In-Reply-To:References; bh=LfLL8EfsLWPIVjA/qPAWihJpKpYF6WwKrtOh6YoaCRo=; b=aC
        rzbhqAhDdhaB2zSoT939OFEKayNRNESuNwWSR/JF0bT4K//OcKN8+QFwA8C/NiMCgTNL2oua4W9gW
        FHLpoF1wcgMTLoMDODfT1V67DVfGTSpbhKdKPeRBXPy4G1jG+81pBgtiLjdJrDoE26xk64CTxm7+k
        nTtKzxJLAhbZMHfqArqJeN/5ARe/Qv9ZbmyodB/LCJp3aUoZU0sHcvepWW3F+sT/6a2vf3fgpTRwJ
        GL4kEAauGYoyY+gBjUuwdx2eDo0O2quAioJCVGNxdjw+YQovBTRqhqdMjm0q8mv4/MsmcEtIn6cLy
        AuHAnC1voBrpBLrN0fl0TzCXjUKQ9bAg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwjC-0000zo-Aw; Sun, 06 Sep 2020 15:37:14 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
        by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwWV-0000B1-Ck
        for willy@casper.infradead.org; Sun, 06 Sep 2020 15:24:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=LfLL8EfsLWPIVjA/qPAWihJpKpYF6WwKrtOh6YoaCRo=; b=pb+O6KRbKVxzlOQ0kZphehB/5E
        RVuu8H/S5OHCMHe/NIZ1UQPRbT3j+Cdmwn3Mf0X2PMrwjYi2CPCAGc4hOyc7O4fRRrCeUciLj2caO
        Bln7S4omLUOQS+8nm0H8Ppm7WmF5GvICpKqKzGR8VUfBdd+xbxvA1HJ4uupx4C/KrhD49r6casVYu
        1EBUOAaWeO0wfOY9WrAVNvU9C+7Azt704JTp+leOt6FuskxiXNjuPllvxm9Ys/z9yNc8NbISIgp6C
        9HGeO2RDOyUVU0xTEU1fGhPKerS7PGTHSZb6+UHpZu4wlWrcWNxR+4W62/VEOVfVVKGq48XNXa3Fo
        sq4rVOvQ==;
Received: from mout.gmx.net ([212.227.15.18])
        by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwWT-0005b2-M0
        for willy@infradead.org; Sun, 06 Sep 2020 15:24:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599405842;
        bh=wSyb8ELnZwbF8mdKE3qNGQu3+WS5EHnrrE3a8pgI2FU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Z8bCWCfC/qHhUYXb1rHkj/UlgrP+oHynklr36+cT9GPsMpokFn5k/MmXQKsOQRXYv
         zEyu9hQoc4UNtVjBk1yAutAzRZq4DZU8Iocf1N0v5QdWK8FTlGNfPlJNvAzZUrFTTJ
         Q01JbsibVDee+D+HZdqtT8hbTwGQFRQpQamhAc/A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.73.70]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N79uI-1kbluA1E3I-017Vsn; Sun, 06 Sep 2020 17:24:02 +0200
From:   John Wood <john.wood@gmx.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Wood <john.wood@gmx.com>
Subject: [RFC PATCH 5/9] security/fbfam: Detect a fork brute force attack
Date:   Sun,  6 Sep 2020 17:23:48 +0200
Message-Id: <20200906152348.7259-1-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ce2fa8zkw8hMoZnGJWba4J2u0Ujafy2LgQ4ULuHrUMjjsmanX5K
 6v4vD1h+jltrylt2Ue/wdj1v+DBJElQbaqLQobQ+pG2EltTZOkdj7HACMGJ3g14c9cLnDST
 m9pIo7lhC+fxNlDbcnNimV/RH9A15m7E8nMVfLP9pt3uJwzKIiMCdrCFMcjuiHviF3QNDo/
 Xgu37dEsD2lz64fANXFZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i6jAOeTSv58=:mXKQksFzPVbuhbFTajnYyj
 29QmE2sPzW7hE6LrZCYWkld5zJTd9z1RQ5kO+H68PXLqu2aj+R6aJ1+umeRBsH1RryMZHnaYA
 IrtpSYprCvxjFF2/+MHHXtYPq7CmvHmmJBsyxYULoH/cu6M7KDYs/dpHJ6gvoviP28jgBqYqy
 oKDMV5Eio4mW4Nzu3oiQcu2DU8c3+7/3W0GETgESK4I84F2eMuYafPHOHRxJPEeYl3fe8JmlW
 oRfv784ZgSRvEgJuGjjk5kgk4QL8nivIDNeMr9Ci5HAOTyl+k3Q4hLxkmq6+2/nnho9Vbk8zo
 JO5/Ac99uMfyMoH0qvRVDIfUEKaFeqxwQBap2Csu4pEcvksQjlizvaBkuWM5QPLgnmAZFEf/z
 0zPGzkZFiF29KVLdNOPsBnJ8hbiK2xNGI5NJTAvIadG6zcKBvX4M1VXgbEKk46GfM0wNfbF4P
 bVW5F9d1gXbyXVFwv1LCaEugELL0eL7Jw/kpke0P2FR0EXTZjB4eR99W0e4ZfheI7zokaMMSF
 7savyd4dhvISCJ7iUAEAmm5RVSc00eBEQPn3jNnamDjB0doj9gQn5y1dR8Y5cHCR0umaIwbxY
 Kjw2GLhj1VddMRaR9IwBzhomN8d8qHc53r74qdGFS2zin4WDSDVcA+uJyDjOOJ89iKUpSNNmq
 mrrXIW5+vhrUU/AtTxkMjJO0pxMWIPEtUB+VLvfj2+3Gl42LH2JyW5SR1fxADR6mHBjFuwIZm
 o5AlwhSe+XkSAmQVtNR4Jf7xj04Ig/CSqrKZBm6rNO++Tn38e6Tk6yPlU8Ia2WF4X6FHIvL7y
 GyKmFfMHsfe2qd8MeSG1D0jDoRcJ9+3tAWj7Z+SQPxTH69Z92rYDYjyINHs64bB9P7M1BgIVw
 d9n41NTk3PY+Q3UqwR1Gl752Lf6aL7WFZrFQ2R850Q2YAP98j2Wash+kXNy0XEGqocSQdha8J
 QW/m2K8Byq0OjvZCawv8bJiA5u8j8qC1nSyfo0Yvc1cjAYgSBRekizTQPQgx4ePqKHst028KX
 /9hcWuK1MN9a9jDl0+e4ryCoV9j3wECLeNrOveOJubdsE297JiDTiKcmYCYzKNg7NJIEgEn/H
 Vbx/tJDoW/KZWEzOO0T+uXTVoS1XcDsw4pYnGT2dv6Ikb6PBCwiFHQVmAti98Z0fKbiwMh9zP
 3kfweGCVu2L0m01Ukd6eISRu6cyKW4TScWjMavIPM5CetQULNg3I/o5YPjiDjuEJ3AY98pItr
 y7lOi2vLi4HuWZ8d80rN5DeNL1dKiQVHFx5EeyA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200906_112405_925120_0F385A79 
X-CRM114-Status: GOOD (  16.18  )
X-Spam-Score: -0.7 (/)
X-Spam-Report: SpamAssassin version 3.4.4 on merlin.infradead.org summary:
 Content analysis details:   (-0.7 points)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.7 RCVD_IN_DNSWL_LOW      RBL: Sender listed at https://www.dnswl.org/,
                             low trust
                             [212.227.15.18 listed in list.dnswl.org]
  0.0 FREEMAIL_FROM          Sender email is commonly abused enduser mail
                             provider
                             [john.wood[at]gmx.com]
  0.0 SPF_HELO_NONE          SPF: HELO does not publish an SPF Record
 -0.0 SPF_PASS               SPF: sender matches SPF record
 -0.0 RCVD_IN_MSPIKE_H2      RBL: Average reputation (+2)
                             [212.227.15.18 listed in wl.mailspike.net]
  0.1 DKIM_SIGNED            Message has a DKIM or DK signature, not necessarily
                             valid
 -0.1 DKIM_VALID             Message has at least one valid DKIM or DK signature
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To detect a fork brute force attack it is necessary to compute the
crashing rate of the application. This calculation is performed in each
fatal fail of a task, or in other words, when a core dump is triggered.
If this rate shows that the application is crashing quickly, there is a
clear signal that an attack is happening.

Since the crashing rate is computed in milliseconds per fault, if this
rate goes under a certain threshold a warning is triggered.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 fs/coredump.c          |  2 ++
 include/fbfam/fbfam.h  |  2 ++
 security/fbfam/fbfam.c | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 76e7c10edfc0..d4ba4e1828d5 100644
=2D-- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -51,6 +51,7 @@
 #include "internal.h"

 #include <trace/events/sched.h>
+#include <fbfam/fbfam.h>

 int core_uses_pid;
 unsigned int core_pipe_limit;
@@ -825,6 +826,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 fail_creds:
 	put_cred(cred);
 fail:
+	fbfam_handle_attack(siginfo->si_signo);
 	return;
 }

diff --git a/include/fbfam/fbfam.h b/include/fbfam/fbfam.h
index 2cfe51d2b0d5..9ac8e33d8291 100644
=2D-- a/include/fbfam/fbfam.h
+++ b/include/fbfam/fbfam.h
@@ -12,10 +12,12 @@ extern struct ctl_table fbfam_sysctls[];
 int fbfam_fork(struct task_struct *child);
 int fbfam_execve(void);
 int fbfam_exit(void);
+int fbfam_handle_attack(int signal);
 #else
 static inline int fbfam_fork(struct task_struct *child) { return 0; }
 static inline int fbfam_execve(void) { return 0; }
 static inline int fbfam_exit(void) { return 0; }
+static inline int fbfam_handle_attack(int signal) { return 0; }
 #endif

 #endif /* _FBFAM_H_ */
diff --git a/security/fbfam/fbfam.c b/security/fbfam/fbfam.c
index 9be4639b72eb..3aa669e4ea51 100644
=2D-- a/security/fbfam/fbfam.c
+++ b/security/fbfam/fbfam.c
@@ -4,7 +4,9 @@
 #include <linux/errno.h>
 #include <linux/gfp.h>
 #include <linux/jiffies.h>
+#include <linux/printk.h>
 #include <linux/refcount.h>
+#include <linux/signal.h>
 #include <linux/slab.h>

 /**
@@ -172,3 +174,40 @@ int fbfam_exit(void)
 	return 0;
 }

+/**
+ * fbfam_handle_attack() - Fork brute force attack detection.
+ * @signal: Signal number that causes the core dump.
+ *
+ * The crashing rate of an application is computed in milliseconds per fa=
ult in
+ * each crash. So, if this rate goes under a certain threshold there is a=
 clear
+ * signal that the application is crashing quickly. At this moment, a for=
k brute
+ * force attack is happening.
+ *
+ * Return: -EFAULT if the current task doesn't have statistical data. Zer=
o
+ *         otherwise.
+ */
+int fbfam_handle_attack(int signal)
+{
+	struct fbfam_stats *stats =3D current->fbfam_stats;
+	u64 delta_jiffies, delta_time;
+	u64 crashing_rate;
+
+	if (!stats)
+		return -EFAULT;
+
+	if (!(signal =3D=3D SIGILL || signal =3D=3D SIGBUS || signal =3D=3D SIGK=
ILL ||
+	      signal =3D=3D SIGSEGV || signal =3D=3D SIGSYS))
+		return 0;
+
+	stats->faults +=3D 1;
+
+	delta_jiffies =3D get_jiffies_64() - stats->jiffies;
+	delta_time =3D jiffies64_to_msecs(delta_jiffies);
+	crashing_rate =3D delta_time / (u64)stats->faults;
+
+	if (crashing_rate < (u64)sysctl_crashing_rate_threshold)
+		pr_warn("fbfam: Fork brute force attack detected\n");
+
+	return 0;
+}
+
=2D-
2.25.1

