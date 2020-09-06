Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8890A25EEE4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Sep 2020 17:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgIFPru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 11:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgIFPha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:37:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36A8C061575;
        Sun,  6 Sep 2020 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Resent-To:Resent-Message-ID:Resent-Date:
        Resent-From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        In-Reply-To:References; bh=/u0+yrSlw03aBtAYCusgZd8I7ARa19CGm1otMTTspw0=; b=N6
        iE7zMwzDHtR87N3toXZeISABN9RMyEko3UXEinJBb9CrEcERuqvtMhVt66RHkyAZ3ZOWXvjfYEx+6
        eK3x8bJfCVTMIOmEelmx4GGAyHgZjbZCX314Ht+Kehbe2vW29HYru4BNoGFhpCfQJ20QWz+kum9Qg
        JEVW6+ZMNbJ3U5ZECWgm1zmg2EQ2mJXwlX7vLGrLx8vjOsijxmXXxi1ijcvB58hA9gRNzCoUYejl5
        ylgG/sTj5yvZb40eIkEO/MZ/ZS7PVaIHjCzN8/HL22MSaES0JQg5rnkgavR8sadk0LUcKnX1syEYl
        20PDa3X/5CcR193tcKKNA4mLdy+waEcA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwjG-00010C-Hv; Sun, 06 Sep 2020 15:37:18 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
        by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwWx-0000CM-8o
        for willy@casper.infradead.org; Sun, 06 Sep 2020 15:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/u0+yrSlw03aBtAYCusgZd8I7ARa19CGm1otMTTspw0=; b=jHdrNayA+D0+l3TsROlqvEngbU
        hhhOYtZcw+hNeSQGFBo7oVYykFLUCi3zXdviK/z559iiv9B34eCDWuy/r8gVGuNF6UkPgyNz9Uv8z
        4slgUBNC5rvKyVW0st5lSkincFgyV+6KwjP/KMSN0FgG9jmWEQq++H/JTCAD75Lvs3PH3BkS6/CMF
        wIxqiHmDldo3slS3TlkoIriWRePv6lzUncIzzM2miMyC/ff+HCYTa97x3ozzLHLvfZEA89LCs+gz8
        uwOWwcn3AP1+O0iVJkxPhMSanoaO2XLPriKpJ3ZTwBtVaU0t/vdSuAhhdf7fh2a6yog1Wj2nuG6DD
        StOuEDZw==;
Received: from mout.gmx.net ([212.227.15.19])
        by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwWv-0005h9-DM
        for willy@infradead.org; Sun, 06 Sep 2020 15:24:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599405872;
        bh=FGUtm7UcaPXHO1b8O1ignGpXik1HpzO5bGlUoqXvgqQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=GQBAQka9GqYlQb18RoC4xepBLLtdIfIEWARSBCiDa6U566emMfgWg+uJH0gXX9b4K
         Pv9RjjwdHMQp9PkDgK7Y+M8rBOe6YzUBEMLohqKRxhoP+ZVXMspMJc8LmQMT74l5Sq
         Esvm9IBqBCk5A7rTsixN8BUA9oq/P9tWNnmNW6I8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.73.70]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Ml6mE-1kxr7k07Ei-00lSsJ; Sun, 06 Sep 2020 17:24:32 +0200
From:   John Wood <john.wood@gmx.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Wood <john.wood@gmx.com>
Subject: [RFC PATCH 6/9] security/fbfam: Mitigate a fork brute force attack
Date:   Sun,  6 Sep 2020 17:24:19 +0200
Message-Id: <20200906152419.7313-1-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CWSxwusOyPimutvXHB158vpVFv4Ki0ydyrkpH0mlS9pJ3Ew2sds
 dXaet9nquVcKEfdgC3lVUbJ9laiwsvcBwR2RWY+RJTwhQx689k0tIqq7okI6ubG8eZoJIYy
 jgZnaq59cZ96/Cw0Fj9GLzUxA8YKnjHFA+xDYDD7US/anfPfWt1U50MxQ7o91+Qt7djzfDm
 ldPlNhljTAUuM8y/p9+Lg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CHkubrO+3ek=:wHfRzU0dt2zIbkMp8pYQqw
 MB/Z/K+9PCGdVftPoVytsQDjXHNFoVPGUQEohybAq8XeFODkbIw5xLYGrOP3pWBxjkcDP5Ksy
 Ve3Q3TcRm3pwESSUjDq23+iZHjdLeaO9/RXqmybZj+HqOuqzyEbr8yI0dqHTMqwz3H41OweE9
 j6x3l1DyxewM3t2cMGnCG5mpHx8+NyMiaNjwAGuhxFTVXaErkazCKW7QYqBfQSagtevaqQEcg
 PwiokvxbdkI07QMSetZOx58RCy7718c3kQIhyiJJyNltjc+uAUrV+TzrCCyYE8NT7w38lX+yt
 Bde9hHGWEDlwAAg6Ai/uK0fchm7UjO0vmDS9ZS4rwsjA/7zHx/Eh1BdzmPCd/AGYrhbYsQ7fu
 0Ssfla7ZOjkCaE5xrdLOCwCtAnKymoIn6CIflGgq4i3hhqKZedcxmdeYAGpwqLUnVaEQbx61O
 kbIZlkqRynFvlcrJ3ogllMzuvoFyyTg9Zf+O9FAi5w6UP6K/TUGPeBFU9Fm+Zfrau+QCkgJQ1
 iXp8rMUTJgT2d9i0AeHZEU5G53nzDDhwzLwJ81y7ampcJrQbZNFomqUIWs6vBg4jKswMIGy/D
 eejpACotpeoI/85Q6UdsdQ7/yM6/PQ2fEM+xoOwXfNynt7UGB/6ILXfkj/sRWkF6G/ow7Judv
 wQR1CFlxdjNgKSCE6i+1BjGgGFBQvqTZEILvIAdV3g0YNo1IRv1E4q7qHbGUWIzAY5XBQ8QxH
 Ttgu92Gm41urcgD9bEChfdekIOejJm2G4DuFEDkE/ss86vfWp6IqJvuIIBq5FVcj26XX9tRJP
 ebop0NXreSJAg27lQyp7XtZd9c8T8RxJgAJSjqoK47jrGhlU2F93ggP+BC1fTJsz247ToZPOg
 2aAm27iEvPaOgMiMuuZ2DINMGttTBfXXFz381n23bO5k1u1T3MGqKoJS4/Oxk1oLwIBkxTzqt
 gVdS3204IGRFCeuHrZCkQcnVxtiNXReegsF5bF8ziDOpoSWDEoN0U36WBGAkyu50eF7tEqNN3
 fvXwFYSfoYM9cQLcSv64mm/tTmm8x+agQgqUUgRiUqst7DYUGT0pIym6RbazJMCiKnI9lvM7j
 Y98beh4/mGgs08Dv2c2UKCScZK0BiekmY6LenGSfU2Bkl372Lqvk4BYCWBQrRJ+2GkGASCJ1J
 UsKT+WjcjLHPhFJbABqTAtnZsavRnXuFmO8aRqdwkc720x5vKwa+dsojZR+Gnu/xoZ8DCiI+1
 7UuxcDhJ/rcvWbqHiZz+5n9tTMHMVopUxWsPpUQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200906_112433_668709_02F8DBC4 
X-CRM114-Status: GOOD (  21.35  )
X-Spam-Score: -0.7 (/)
X-Spam-Report: SpamAssassin version 3.4.4 on merlin.infradead.org summary:
 Content analysis details:   (-0.7 points)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.7 RCVD_IN_DNSWL_LOW      RBL: Sender listed at https://www.dnswl.org/,
                             low trust
                             [212.227.15.19 listed in list.dnswl.org]
  0.0 FREEMAIL_FROM          Sender email is commonly abused enduser mail
                             provider
                             [john.wood[at]gmx.com]
  0.0 SPF_HELO_NONE          SPF: HELO does not publish an SPF Record
 -0.0 SPF_PASS               SPF: sender matches SPF record
 -0.0 RCVD_IN_MSPIKE_H2      RBL: Average reputation (+2)
                             [212.227.15.19 listed in wl.mailspike.net]
  0.1 DKIM_SIGNED            Message has a DKIM or DK signature, not necessarily
                             valid
 -0.1 DKIM_VALID             Message has at least one valid DKIM or DK signature
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to mitigate a fork brute force attack it is necessary to kill
all the offending tasks. This tasks are all the ones that share the
statistical data with the current task (the task that has crashed).

Since the attack detection is done in the function fbfam_handle_attack()
that is called every time a core dump is triggered, only is needed to
kill the others tasks that share the same statistical data, not the
current one as this is in the path to be killed.

When the SIGKILL signal is sent to the offending tasks from the function
fbfam_kill_tasks(), this one will be called again during the core dump
due to the shared statistical data shows a quickly crashing rate. So, to
avoid kill again the same tasks due to a recursive call of this
function, it is necessary to disable the attack detection.

To disable this attack detection, add a condition in the function
fbfam_handle_attack() to not compute the crashing rate when the jiffies
stored in the statistical data are set to zero.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 security/fbfam/fbfam.c | 76 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/security/fbfam/fbfam.c b/security/fbfam/fbfam.c
index 3aa669e4ea51..173a6122390f 100644
=2D-- a/security/fbfam/fbfam.c
+++ b/security/fbfam/fbfam.c
@@ -4,8 +4,11 @@
 #include <linux/errno.h>
 #include <linux/gfp.h>
 #include <linux/jiffies.h>
+#include <linux/pid.h>
 #include <linux/printk.h>
+#include <linux/rcupdate.h>
 #include <linux/refcount.h>
+#include <linux/sched/signal.h>
 #include <linux/signal.h>
 #include <linux/slab.h>

@@ -24,7 +27,8 @@ unsigned long sysctl_crashing_rate_threshold =3D 30000;
  * struct fbfam_stats - Fork brute force attack mitigation statistics.
  * @refc: Reference counter.
  * @faults: Number of crashes since jiffies.
- * @jiffies: First fork or execve timestamp.
+ * @jiffies: First fork or execve timestamp. If zero, the attack detectio=
n is
+ *           disabled.
  *
  * The purpose of this structure is to manage all the necessary informati=
on to
  * compute the crashing rate of an application. So, it holds a first fork=
 or
@@ -175,13 +179,69 @@ int fbfam_exit(void)
 }

 /**
- * fbfam_handle_attack() - Fork brute force attack detection.
+ * fbfam_kill_tasks() - Kill the offending tasks
+ *
+ * When a fork brute force attack is detected it is necessary to kill all=
 the
+ * offending tasks. Since this function is called from fbfam_handle_attac=
k(),
+ * and so, every time a core dump is triggered, only is needed to kill th=
e
+ * others tasks that share the same statistical data, not the current one=
 as
+ * this is in the path to be killed.
+ *
+ * When the SIGKILL signal is sent to the offending tasks, this function =
will be
+ * called again during the core dump due to the shared statistical data s=
hows a
+ * quickly crashing rate. So, to avoid kill again the same tasks due to a
+ * recursive call of this function, it is necessary to disable the attack
+ * detection setting the jiffies to zero.
+ *
+ * To improve the for_each_process loop it is possible to end it when all=
 the
+ * tasks that shared the same statistics are found.
+ *
+ * Return: -EFAULT if the current task doesn't have statistical data. Zer=
o
+ *         otherwise.
+ */
+static int fbfam_kill_tasks(void)
+{
+	struct fbfam_stats *stats =3D current->fbfam_stats;
+	struct task_struct *p;
+	unsigned int to_kill, killed =3D 0;
+
+	if (!stats)
+		return -EFAULT;
+
+	to_kill =3D refcount_read(&stats->refc) - 1;
+	if (!to_kill)
+		return 0;
+
+	/* Disable the attack detection */
+	stats->jiffies =3D 0;
+	rcu_read_lock();
+
+	for_each_process(p) {
+		if (p =3D=3D current || p->fbfam_stats !=3D stats)
+			continue;
+
+		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_PID);
+		pr_warn("fbfam: Offending process with PID %d killed\n",
+			p->pid);
+
+		killed +=3D 1;
+		if (killed >=3D to_kill)
+			break;
+	}
+
+	rcu_read_unlock();
+	return 0;
+}
+
+/**
+ * fbfam_handle_attack() - Fork brute force attack detection and mitigati=
on.
  * @signal: Signal number that causes the core dump.
  *
  * The crashing rate of an application is computed in milliseconds per fa=
ult in
  * each crash. So, if this rate goes under a certain threshold there is a=
 clear
  * signal that the application is crashing quickly. At this moment, a for=
k brute
- * force attack is happening.
+ * force attack is happening. Under this scenario it is necessary to kill=
 all
+ * the offending tasks in order to mitigate the attack.
  *
  * Return: -EFAULT if the current task doesn't have statistical data. Zer=
o
  *         otherwise.
@@ -195,6 +255,10 @@ int fbfam_handle_attack(int signal)
 	if (!stats)
 		return -EFAULT;

+	/* The attack detection is disabled */
+	if (!stats->jiffies)
+		return 0;
+
 	if (!(signal =3D=3D SIGILL || signal =3D=3D SIGBUS || signal =3D=3D SIGK=
ILL ||
 	      signal =3D=3D SIGSEGV || signal =3D=3D SIGSYS))
 		return 0;
@@ -205,9 +269,11 @@ int fbfam_handle_attack(int signal)
 	delta_time =3D jiffies64_to_msecs(delta_jiffies);
 	crashing_rate =3D delta_time / (u64)stats->faults;

-	if (crashing_rate < (u64)sysctl_crashing_rate_threshold)
-		pr_warn("fbfam: Fork brute force attack detected\n");
+	if (crashing_rate >=3D (u64)sysctl_crashing_rate_threshold)
+		return 0;

+	pr_warn("fbfam: Fork brute force attack detected\n");
+	fbfam_kill_tasks();
 	return 0;
 }

=2D-
2.25.1

