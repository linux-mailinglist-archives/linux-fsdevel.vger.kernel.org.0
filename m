Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1E324BF3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 15:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgHTNpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 09:45:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57008 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbgHTNpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:45:10 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8ksB-007NiG-Rg; Thu, 20 Aug 2020 07:44:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8ksA-0004Dd-GC; Thu, 20 Aug 2020 07:44:55 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, oleg@redhat.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com,
        walken@google.com, daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20200820002053.1424000-1-surenb@google.com>
        <87zh6pxzq6.fsf@x220.int.ebiederm.org>
        <20200820124241.GJ5033@dhcp22.suse.cz>
        <87lfi9xz7y.fsf@x220.int.ebiederm.org>
        <87d03lxysr.fsf@x220.int.ebiederm.org>
        <20200820132631.GK5033@dhcp22.suse.cz>
Date:   Thu, 20 Aug 2020 08:41:18 -0500
In-Reply-To: <20200820132631.GK5033@dhcp22.suse.cz> (Michal Hocko's message of
        "Thu, 20 Aug 2020 15:26:31 +0200")
Message-ID: <874koxxwn5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k8ksA-0004Dd-GC;;;mid=<874koxxwn5.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+9RLaNZi9SdSNbGn/Jf2ose2Z5ahlD0FA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michal Hocko <mhocko@suse.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 932 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.1%), b_tie_ro: 9 (0.9%), parse: 1.49 (0.2%),
         extract_message_metadata: 19 (2.0%), get_uri_detail_list: 6 (0.6%),
        tests_pri_-1000: 15 (1.6%), tests_pri_-950: 1.31 (0.1%),
        tests_pri_-900: 1.07 (0.1%), tests_pri_-90: 88 (9.4%), check_bayes: 82
        (8.7%), b_tokenize: 20 (2.1%), b_tok_get_all: 15 (1.6%), b_comp_prob:
        4.4 (0.5%), b_tok_touch_all: 37 (3.9%), b_finish: 1.04 (0.1%),
        tests_pri_0: 783 (84.0%), check_dkim_signature: 0.96 (0.1%),
        check_dkim_adsp: 10 (1.1%), poll_dns_idle: 0.39 (0.0%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 8 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in __set_oom_adj when not necessary
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Thu 20-08-20 07:54:44, Eric W. Biederman wrote:
>> ebiederm@xmission.com (Eric W. Biederman) writes:
>> 
>> 2> Michal Hocko <mhocko@suse.com> writes:
>> >
>> >> On Thu 20-08-20 07:34:41, Eric W. Biederman wrote:
>> >>> Suren Baghdasaryan <surenb@google.com> writes:
>> >>> 
>> >>> > Currently __set_oom_adj loops through all processes in the system to
>> >>> > keep oom_score_adj and oom_score_adj_min in sync between processes
>> >>> > sharing their mm. This is done for any task with more that one mm_users,
>> >>> > which includes processes with multiple threads (sharing mm and signals).
>> >>> > However for such processes the loop is unnecessary because their signal
>> >>> > structure is shared as well.
>> >>> > Android updates oom_score_adj whenever a tasks changes its role
>> >>> > (background/foreground/...) or binds to/unbinds from a service, making
>> >>> > it more/less important. Such operation can happen frequently.
>> >>> > We noticed that updates to oom_score_adj became more expensive and after
>> >>> > further investigation found out that the patch mentioned in "Fixes"
>> >>> > introduced a regression. Using Pixel 4 with a typical Android workload,
>> >>> > write time to oom_score_adj increased from ~3.57us to ~362us. Moreover
>> >>> > this regression linearly depends on the number of multi-threaded
>> >>> > processes running on the system.
>> >>> > Mark the mm with a new MMF_PROC_SHARED flag bit when task is created with
>> >>> > CLONE_VM and !CLONE_SIGHAND. Change __set_oom_adj to use MMF_PROC_SHARED
>> >>> > instead of mm_users to decide whether oom_score_adj update should be
>> >>> > synchronized between multiple processes. To prevent races between clone()
>> >>> > and __set_oom_adj(), when oom_score_adj of the process being cloned might
>> >>> > be modified from userspace, we use oom_adj_mutex. Its scope is changed to
>> >>> > global and it is renamed into oom_adj_lock for naming consistency with
>> >>> > oom_lock. Since the combination of CLONE_VM and !CLONE_SIGHAND is rarely
>> >>> > used the additional mutex lock in that path of the clone() syscall should
>> >>> > not affect its overall performance. Clearing the MMF_PROC_SHARED flag
>> >>> > (when the last process sharing the mm exits) is left out of this patch to
>> >>> > keep it simple and because it is believed that this threading model is
>> >>> > rare. Should there ever be a need for optimizing that case as well, it
>> >>> > can be done by hooking into the exit path, likely following the
>> >>> > mm_update_next_owner pattern.
>> >>> > With the combination of CLONE_VM and !CLONE_SIGHAND being quite rare, the
>> >>> > regression is gone after the change is applied.
>> >>> 
>> >>> So I am confused.
>> >>> 
>> >>> Is there any reason why we don't simply move signal->oom_score_adj to
>> >>> mm->oom_score_adj and call it a day?
>> >>
>> >> Yes. Please read through 44a70adec910 ("mm, oom_adj: make sure processes
>> >> sharing mm have same view of oom_score_adj")
>> >
>> > That explains why the scores are synchronized.
>> >
>> > It doesn't explain why we don't do the much simpler thing and move
>> > oom_score_adj from signal_struct to mm_struct. Which is my question.
>> >
>> > Why not put the score where we need it to ensure that the oom score
>> > is always synchronized?  AKA on the mm_struct, not the signal_struct.
>> 
>> Apologies.  That 44a70adec910 does describe that some people have seen
>> vfork users set oom_score.  No details unfortunately.
>> 
>> I will skip the part where posix calls this undefined behavior.  It
>> breaks userspace to change.
>> 
>> It still seems like the code should be able to buffer oom_adj during
>> vfork, and only move the value onto mm_struct during exec.
>
> If you can handle vfork by other means then I am all for it. There were
> no patches in that regard proposed yet. Maybe it will turn out simpler
> then the heavy lifting we have to do in the oom specific code.

I expect something like this completley untested patch will work.

Eric


 fs/exec.c                    |    4 ++++
 fs/proc/base.c               |   30 ++++++------------------------
 include/linux/mm_types.h     |    4 ++++
 include/linux/sched/signal.h |    4 +---
 kernel/fork.c                |    3 +--
 mm/oom_kill.c                |   12 ++++++------
 6 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9b723d2560d1..e7eed5212c6c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1139,6 +1139,10 @@ static int exec_mmap(struct mm_struct *mm)
 	vmacache_flush(tsk);
 	task_unlock(tsk);
 	if (old_mm) {
+		mm->oom_score_adj = old_mm->oom_score_adj;
+		mm->oom_score_adj_min = old_mm->oom_score_adj_min;
+		if (tsk->vfork_done)
+			mm->oom_score_adj = tsk->vfork_oom_score_adj;
 		mmap_read_unlock(old_mm);
 		BUG_ON(active_mm != old_mm);
 		setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 617db4e0faa0..795fa0a8db52 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1103,33 +1103,15 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
 		}
 	}
 
-	task->signal->oom_score_adj = oom_adj;
-	if (!legacy && has_capability_noaudit(current, CAP_SYS_RESOURCE))
-		task->signal->oom_score_adj_min = (short)oom_adj;
-	trace_oom_score_adj_update(task);
-
 	if (mm) {
 		struct task_struct *p;
 
-		rcu_read_lock();
-		for_each_process(p) {
-			if (same_thread_group(task, p))
-				continue;
-
-			/* do not touch kernel threads or the global init */
-			if (p->flags & PF_KTHREAD || is_global_init(p))
-				continue;
-
-			task_lock(p);
-			if (!p->vfork_done && process_shares_mm(p, mm)) {
-				p->signal->oom_score_adj = oom_adj;
-				if (!legacy && has_capability_noaudit(current, CAP_SYS_RESOURCE))
-					p->signal->oom_score_adj_min = (short)oom_adj;
-			}
-			task_unlock(p);
-		}
-		rcu_read_unlock();
-		mmdrop(mm);
+		mm->oom_score_adj = oom_adj;
+		if (!legacy && has_capability_noaudit(current, CAP_SYS_RESOURCE))
+			mm->oom_score_adj_min = (short)oom_adj;
+		trace_oom_score_adj_update(task);
+	} else {
+		task->signal->vfork_oom_score_adj = oom_adj;
 	}
 err_unlock:
 	mutex_unlock(&oom_adj_mutex);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 496c3ff97cce..b865048ab25a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -542,6 +542,10 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+
+		short oom_score_adj;		/* OOM kill score adjustment */
+		short oom_score_adj_min;	/* OOM kill score adjustment min value.
+					 * Only settable by CAP_SYS_RESOURCE. */
 	} __randomize_layout;
 
 	/*
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 1bad18a1d8ba..a69eb9e0d247 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -218,9 +218,7 @@ struct signal_struct {
 	 * oom
 	 */
 	bool oom_flag_origin;
-	short oom_score_adj;		/* OOM kill score adjustment */
-	short oom_score_adj_min;	/* OOM kill score adjustment min value.
-					 * Only settable by CAP_SYS_RESOURCE. */
+	short vfork_oom_score_adj;		/* OOM kill score adjustment */
 	struct mm_struct *oom_mm;	/* recorded mm when the thread group got
 					 * killed by the oom killer */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 3049a41076f3..1ba4deaa2f98 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1584,8 +1584,7 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 	tty_audit_fork(sig);
 	sched_autogroup_fork(sig);
 
-	sig->oom_score_adj = current->signal->oom_score_adj;
-	sig->oom_score_adj_min = current->signal->oom_score_adj_min;
+	sig->vfork_oom_score_adj = current->mm->oom_score_adj;
 
 	mutex_init(&sig->cred_guard_mutex);
 	mutex_init(&sig->exec_update_mutex);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index e90f25d6385d..0412f64e74c1 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -213,7 +213,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 	 * unkillable or have been already oom reaped or the are in
 	 * the middle of vfork
 	 */
-	adj = (long)p->signal->oom_score_adj;
+	adj = (long)p->mm->oom_score_adj;
 	if (adj == OOM_SCORE_ADJ_MIN ||
 			test_bit(MMF_OOM_SKIP, &p->mm->flags) ||
 			in_vfork(p)) {
@@ -403,7 +403,7 @@ static int dump_task(struct task_struct *p, void *arg)
 		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
 		mm_pgtables_bytes(task->mm),
 		get_mm_counter(task->mm, MM_SWAPENTS),
-		task->signal->oom_score_adj, task->comm);
+		task->mm->oom_score_adj, task->comm);
 	task_unlock(task);
 
 	return 0;
@@ -452,7 +452,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 {
 	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
 		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
-			current->signal->oom_score_adj);
+			current->mm->oom_score_adj);
 	if (!IS_ENABLED(CONFIG_COMPACTION) && oc->order)
 		pr_warn("COMPACTION is disabled!!!\n");
 
@@ -892,7 +892,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
 		K(get_mm_counter(mm, MM_FILEPAGES)),
 		K(get_mm_counter(mm, MM_SHMEMPAGES)),
 		from_kuid(&init_user_ns, task_uid(victim)),
-		mm_pgtables_bytes(mm) >> 10, victim->signal->oom_score_adj);
+		mm_pgtables_bytes(mm) >> 10, victim->mm->oom_score_adj);
 	task_unlock(victim);
 
 	/*
@@ -942,7 +942,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
  */
 static int oom_kill_memcg_member(struct task_struct *task, void *message)
 {
-	if (task->signal->oom_score_adj != OOM_SCORE_ADJ_MIN &&
+	if (task->mm->oom_score_adj != OOM_SCORE_ADJ_MIN &&
 	    !is_global_init(task)) {
 		get_task_struct(task);
 		__oom_kill_process(task, message);
@@ -1089,7 +1089,7 @@ bool out_of_memory(struct oom_control *oc)
 	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
 	    current->mm && !oom_unkillable_task(current) &&
 	    oom_cpuset_eligible(current, oc) &&
-	    current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
+	    current->mm->oom_score_adj != OOM_SCORE_ADJ_MIN) {
 		get_task_struct(current);
 		oc->chosen = current;
 		oom_kill_process(oc, "Out of memory (oom_kill_allocating_task)");
