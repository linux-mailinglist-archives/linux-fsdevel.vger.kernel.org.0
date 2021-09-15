Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE00440CC21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhIOSAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:00:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38001 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231158AbhIOSAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:00:17 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B644F5C018F;
        Wed, 15 Sep 2021 13:58:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 15 Sep 2021 13:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilammy.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=5S1OnehGeTh2j
        6G0pKc9tRXifgo4hgNJcTEgxGlmm4M=; b=bT9GxWkJTvUk7BLOb1ez6gw2T6M0v
        kI5unMSDe70RUN0otyyXX6DF6u9NlMJewL6He5RTumD98sRgSElZy1gdbLXt1PGS
        GRYSPArtWvsdgfkWptsrY+IyHRyZPMeosiW23+fcJ8EscVfr5Btx3Us5SlgWwU7V
        ezQEUJmso0PTxlkajqjuDcylNV4Zww7TyVu3WvHmyN+iFEzRPslsuxh2eGmFHHk5
        DjZ0WB4gvdEUsdR96KoLUVjJxPSnoQTP2PMygwN/g+d3rx5PAk7ySDi3zh95HXaT
        wGwR0TRvnWAExagOyfsCoQ/ZCoCYcXX4Ct8aYbU3vlzgkGQThVy7Q6COg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=5S1OnehGeTh2j6G0pKc9tRXifgo4hgNJcTEgxGlmm4M=; b=HrB0Z5pj
        lq7WFYIrlSXhFHejM0L6xyggJteTew8ON/rVISXbXCRBIOqfSV2wmYCT+XYXu3r+
        O5ADClTI1sG2nRwltk/zXT1mF7xTDFZ57TziWGqQCRAIRGlCoN+JokAU14ke91xM
        mfTc0Xg1qVf7IlysSEXuTL1eBSUtUsxKlyrTMdQPYn33IUi74TrnOOfF6kD8Utr1
        dtC/XmpKqsD5R/EpbMUIRNKMWpgS+w2cjQY3CqGBXScLZNRqMALjqrd6SeIQw8Sx
        zmHKSOPnfZUvnuEXjje8qLeGHoY/monzDjALKwO/A49OX4bpG9nRYfo1xlAR4NoN
        Ce0aH8VYXZ07hw==
X-ME-Sender: <xms:YTRCYcecGL-chDgJMLf3HqaCj2FoczxGFYcJQn_wbhtILYYB5G6HxQ>
    <xme:YTRCYeOmv9uWA0cXSCqmIs3zJIVBBvQ2DIAPo_gOGBHU0qU9KNIz5gnX-oS2hYKP5
    vYWdgHa10HA_D9szyQ>
X-ME-Received: <xmr:YTRCYdhYLmtXlWxqPfY6HnI9htBu28Ehufc0zBaqx9kycr8tDfzFMaeUB37RsV8SavEpgF100WQmLVsrrZ-lRX_jBiqK4pNZeBpdlXC9uBTbiFDFbrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlvgig
    vghiucfnohiiohhvshhkhicuoehmvgesihhlrghmmhihrdhnvghtqeenucggtffrrghtth
    gvrhhnpeetueejheekjeeuveeihefgueehleelgefgheefffefkeejudeujeejuefgteeu
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esihhlrghmmhihrdhnvght
X-ME-Proxy: <xmx:YTRCYR9QkcKMutVZcx6wUxAZ5QHEmbK-ckCpe1im176ev1kJQxBBjQ>
    <xmx:YTRCYYu7smBWquoFYpLDT2qJYhbzK3DVf-ZsHuxAJRlZn7XRb3oWiQ>
    <xmx:YTRCYYFYo68mdvB-jVR2vasKnWnyUWo0NjaTj2VVQTa03wY1xvY02Q>
    <xmx:YTRCYULtU-cLVex47Rdraf6dYIQJKPWapPIAa8_D2anQRY5Gs_foTQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 13:58:55 -0400 (EDT)
From:   Alexei Lozovsky <me@ilammy.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 02/12] genirq: Use unsigned long for IRQ counters
Date:   Thu, 16 Sep 2021 02:58:38 +0900
Message-Id: <20210915175848.162260-3-me@ilammy.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915175848.162260-1-me@ilammy.net>
References: <20210911034808.24252-1-me@ilammy.net>
 <20210915175848.162260-1-me@ilammy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Widen the counters to unsigned long. In fact, some counters already
use unsigned long and we merely make the other ones agree. that's
one of the reasons for the change: using the same type everywhere
means that counter sum wraps around in a consistent manner,
allowing accurate accounting of the total number of interrupts.

Another aspect is simply widening the type on architectures where
this is possible (i.e., 64-bit ones). 32-bit architectures will keep
32-bit counters, 64-bit archs will be able to use 64-bit counters.
Since 64-bit counters have such huge range, it's unlikely that they
will wrap around in the first place.

Signed-off-by: Alexei Lozovsky <me@ilammy.net>
---
 fs/proc/softirqs.c          | 2 +-
 fs/proc/stat.c              | 2 +-
 include/linux/kernel_stat.h | 6 +++---
 kernel/rcu/tree.h           | 2 +-
 kernel/rcu/tree_stall.h     | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/softirqs.c b/fs/proc/softirqs.c
index 12901dcf57e2..2bc05c23d22e 100644
--- a/fs/proc/softirqs.c
+++ b/fs/proc/softirqs.c
@@ -19,7 +19,7 @@ static int show_softirqs(struct seq_file *p, void *v)
 	for (i = 0; i < NR_SOFTIRQS; i++) {
 		seq_printf(p, "%12s:", softirq_to_name[i]);
 		for_each_possible_cpu(j)
-			seq_printf(p, " %10u", kstat_softirqs_cpu(i, j));
+			seq_printf(p, " %10lu", kstat_softirqs_cpu(i, j));
 		seq_putc(p, '\n');
 	}
 	return 0;
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 6561a06ef905..d9d89d7a959c 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -142,7 +142,7 @@ static int show_stat(struct seq_file *p, void *v)
 		sum		+= arch_irq_stat_cpu(i);
 
 		for (j = 0; j < NR_SOFTIRQS; j++) {
-			unsigned int softirq_stat = kstat_softirqs_cpu(j, i);
+			unsigned long softirq_stat = kstat_softirqs_cpu(j, i);
 
 			per_softirq_sums[j] += softirq_stat;
 			sum_softirq += softirq_stat;
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 90f2e2faf999..41541ce67dfa 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -37,7 +37,7 @@ struct kernel_cpustat {
 
 struct kernel_stat {
 	unsigned long irqs_sum;
-	unsigned int softirqs[NR_SOFTIRQS];
+	unsigned long softirqs[NR_SOFTIRQS];
 };
 
 DECLARE_PER_CPU(struct kernel_stat, kstat);
@@ -59,7 +59,7 @@ static inline void kstat_incr_softirqs_this_cpu(unsigned int irq)
 	__this_cpu_inc(kstat.softirqs[irq]);
 }
 
-static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
+static inline unsigned long kstat_softirqs_cpu(unsigned int irq, int cpu)
 {
 	return READ_ONCE(kstat_cpu(cpu).softirqs[irq]);
 }
@@ -72,7 +72,7 @@ extern unsigned int kstat_irqs_usr(unsigned int irq);
 /*
  * Number of interrupts per cpu, since bootup
  */
-static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
+static inline unsigned long kstat_cpu_irqs_sum(unsigned int cpu)
 {
 	return READ_ONCE(kstat_cpu(cpu).irqs_sum);
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 305cf6aeb408..94e4f022f995 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -242,7 +242,7 @@ struct rcu_data {
 	char rcu_cpu_has_work;
 
 	/* 7) Diagnostic data, including RCU CPU stall warnings. */
-	unsigned int softirq_snap;	/* Snapshot of softirq activity. */
+	unsigned long softirq_snap;	/* Snapshot of softirq activity. */
 	/* ->rcu_iw* fields protected by leaf rcu_node ->lock. */
 	struct irq_work rcu_iw;		/* Check for non-irq activity. */
 	bool rcu_iw_pending;		/* Is ->rcu_iw pending? */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 6c76988cc019..35e67275b5b4 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -435,7 +435,7 @@ static void print_cpu_stall_info(int cpu)
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s%s\n",
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%lu/%lu fqs=%ld %s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
@@ -510,7 +510,7 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 		       data_race(rcu_state.gp_flags),
 		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
 		       gpk->__state);
-		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%u\n",
+		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%lu\n",
 		       cpu, kstat_softirqs_cpu(TIMER_SOFTIRQ, cpu));
 	}
 }
-- 
2.25.1

