Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EBA1BA2FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 13:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgD0Lyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 07:54:39 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42240 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0Lyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:54:38 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT2LN-00056H-AR; Mon, 27 Apr 2020 05:54:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT2LM-0007g2-Ct; Mon, 27 Apr 2020 05:54:37 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <87blnemj5t.fsf_-_@x220.int.ebiederm.org>
        <20200426172207.GA30118@redhat.com>
Date:   Mon, 27 Apr 2020 06:51:23 -0500
In-Reply-To: <20200426172207.GA30118@redhat.com> (Oleg Nesterov's message of
        "Sun, 26 Apr 2020 19:22:07 +0200")
Message-ID: <878sihjgec.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jT2LM-0007g2-Ct;;;mid=<878sihjgec.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Hy5/LYsdoQjtguvFKGpsNQj0NXSTcRnw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4905]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 490 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.2%), b_tie_ro: 9 (1.9%), parse: 1.00 (0.2%),
         extract_message_metadata: 3.5 (0.7%), get_uri_detail_list: 1.68
        (0.3%), tests_pri_-1000: 3.7 (0.8%), tests_pri_-950: 1.33 (0.3%),
        tests_pri_-900: 1.02 (0.2%), tests_pri_-90: 93 (19.0%), check_bayes:
        92 (18.7%), b_tokenize: 8 (1.6%), b_tok_get_all: 37 (7.5%),
        b_comp_prob: 2.2 (0.4%), b_tok_touch_all: 41 (8.5%), b_finish: 1.03
        (0.2%), tests_pri_0: 353 (72.2%), check_dkim_signature: 1.16 (0.2%),
        check_dkim_adsp: 4.1 (0.8%), poll_dns_idle: 0.89 (0.2%), tests_pri_10:
        2.5 (0.5%), tests_pri_500: 12 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 2/6] posix-cpu-timers: Use PIDTYPE_TGID to simplify the logic in lookup_task
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> Eric,
>
> I am sick today and can't read the code, but I feel this patch is not
> right ... please correct me.


> So, iiuc when posix_cpu_timer_create() is called and CPUCLOCK_PERTHREAD
> is false we roughly have
>
> 	task = pid_task(pid, PIDTYPE_TGID);			// lookup_task()
>
> 	/* WINDOW */
>
> 	timer->it.cpu.pid = = get_task_pid(task, PIDTYPE_TGID)	// posix_cpu_timer_create()
>
> Now suppose that we race with mt-exec and this "task" is the old leader;
> it can be release_task()'ed in the WINDOW above and then get_task_pid()
> will return NULL.

Except it is asking for PIDTYPE_TGID.

task->signal even if it is freed (which it won't be in a mt-exec)
is valid until after an rcu window.

release_task()
   put_task_struct_rcu_user()
      call_rcu(..., delayed_put_task_struct())
... rcu delay ...
delayed_put_task_struct()
   put_task_struct()
      __put_task_struct()
         put_signal_struct()
            free_signal_struct()

Which means that task->signal->pids[PIDTYPE_TGID] will remain valid even
across mt-exec.

Further the only change I have introduced is to perform this work under
rcu_read_lock vs taking a reference to task_struct.  As the reference to
task_struct does not prevent release_task, the situation with respect
to races in the rest of the code does not change.

Hmm....

If the case instead is:
> 	timer->it.cpu.pid = get_task_pid(task, PIDTYPE_PID)	// posix_cpu_timer_create()

Which can also happen for threads in the same thread group.
I have to agree that we can wind up with a NULL pid.

And that is a brand new bug, because we didn't use to use pids.
Sigh.


> That is why I suggested to change lookup_task() to return "struct pid*"
> to eliminate the pid -> task -> pid transition.

Yes.  I have to agree.  Getting rid of the pid -> task -> pid transition
looks important to close bugs like that.

> Apart from the same_thread_group() check for the "thread" case we do not
> need task_struct at all, lookup_task() can do
>
> 	if (thread) {
> 		p = pid_task(pid, PIDTYPE_PID);
> 		if (p && !same_thread_group(p, current))
> 			pid = NULL;
> 	} else {
> 		... gettime check ...
>
> 		if (!pid_has_task(pid, PIDTYPE_TGID))
> 			pid = NULL;
> 	}
>
> 	return pid;
>
> No?

There is also the posix_cpu_clock_get, where we immediately use the
clock instead of create something we can use later.

I want to say the gettime case is another reason to go through the whole
transition but the code can just as easily say "pid = task_tgid(current)"
as it can "p = current";

Eric

