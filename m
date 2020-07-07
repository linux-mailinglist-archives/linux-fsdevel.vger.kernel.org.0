Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1292174D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgGGRN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:13:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33938 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGRNz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:13:55 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jsrAC-0004jJ-2G; Tue, 07 Jul 2020 11:13:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jsrAA-0000lm-TW; Tue, 07 Jul 2020 11:13:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
        <20200702164140.4468-13-ebiederm@xmission.com>
        <20200703203021.paebx25miovmaxqt@ast-mbp.dhcp.thefacebook.com>
        <873668s2j8.fsf@x220.int.ebiederm.org>
        <20200704155052.kmrest5useyxcfnu@wittgenstein>
Date:   Tue, 07 Jul 2020 12:09:05 -0500
In-Reply-To: <20200704155052.kmrest5useyxcfnu@wittgenstein> (Christian
        Brauner's message of "Sat, 4 Jul 2020 17:50:52 +0200")
Message-ID: <87mu4bjlqm.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jsrAA-0000lm-TW;;;mid=<87mu4bjlqm.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18xg/9AOxJCx9+kag+rX8lbj8yMBnwD6cc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_PhishingBody,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMSubLong,XM_B_Phish66 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4355]
        *  0.7 XMSubLong Long Subject
        *  2.0 XM_B_Phish66 BODY: Obfuscated XMission
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 670 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 9 (1.4%), parse: 1.95 (0.3%),
         extract_message_metadata: 23 (3.5%), get_uri_detail_list: 4.8 (0.7%),
        tests_pri_-1000: 15 (2.3%), tests_pri_-950: 1.35 (0.2%),
        tests_pri_-900: 1.10 (0.2%), tests_pri_-90: 106 (15.8%), check_bayes:
        104 (15.5%), b_tokenize: 13 (2.0%), b_tok_get_all: 11 (1.7%),
        b_comp_prob: 4.0 (0.6%), b_tok_touch_all: 71 (10.5%), b_finish: 1.10
        (0.2%), tests_pri_0: 493 (73.6%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 8 (1.1%), poll_dns_idle: 0.29 (0.0%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 11 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 13/16] exit: Factor thread_group_exited out of pidfd_poll
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Fri, Jul 03, 2020 at 04:37:47PM -0500, Eric W. Biederman wrote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> 
>> > On Thu, Jul 02, 2020 at 11:41:37AM -0500, Eric W. Biederman wrote:
>> >> Create an independent helper thread_group_exited report return true
>> >> when all threads have passed exit_notify in do_exit.  AKA all of the
>> >> threads are at least zombies and might be dead or completely gone.
>> >> 
>> >> Create this helper by taking the logic out of pidfd_poll where
>> >> it is already tested, and adding a missing READ_ONCE on
>> >> the read of task->exit_state.
>> >> 
>> >> I will be changing the user mode driver code to use this same logic
>> >> to know when a user mode driver needs to be restarted.
>> >> 
>> >> Place the new helper thread_group_exited in kernel/exit.c and
>> >> EXPORT it so it can be used by modules.
>> >> 
>> >> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> >> ---
>> >>  include/linux/sched/signal.h |  2 ++
>> >>  kernel/exit.c                | 24 ++++++++++++++++++++++++
>> >>  kernel/fork.c                |  6 +-----
>> >>  3 files changed, 27 insertions(+), 5 deletions(-)
>> >> 
>> >> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
>> >> index 0ee5e696c5d8..1bad18a1d8ba 100644
>> >> --- a/include/linux/sched/signal.h
>> >> +++ b/include/linux/sched/signal.h
>> >> @@ -674,6 +674,8 @@ static inline int thread_group_empty(struct task_struct *p)
>> >>  #define delay_group_leader(p) \
>> >>  		(thread_group_leader(p) && !thread_group_empty(p))
>> >>  
>> >> +extern bool thread_group_exited(struct pid *pid);
>> >> +
>> >>  extern struct sighand_struct *__lock_task_sighand(struct task_struct *task,
>> >>  							unsigned long *flags);
>> >>  
>> >> diff --git a/kernel/exit.c b/kernel/exit.c
>> >> index d3294b611df1..a7f112feb0f6 100644
>> >> --- a/kernel/exit.c
>> >> +++ b/kernel/exit.c
>> >> @@ -1713,6 +1713,30 @@ COMPAT_SYSCALL_DEFINE5(waitid,
>> >>  }
>> >>  #endif
>> >>  
>> >> +/**
>> >> + * thread_group_exited - check that a thread group has exited
>> >> + * @pid: tgid of thread group to be checked.
>> >> + *
>> >> + * Test if thread group is has exited (all threads are zombies, dead
>> >> + * or completely gone).
>> >> + *
>> >> + * Return: true if the thread group has exited. false otherwise.
>> >> + */
>> >> +bool thread_group_exited(struct pid *pid)
>> >> +{
>> >> +	struct task_struct *task;
>> >> +	bool exited;
>> >> +
>> >> +	rcu_read_lock();
>> >> +	task = pid_task(pid, PIDTYPE_PID);
>> >> +	exited = !task ||
>> >> +		(READ_ONCE(task->exit_state) && thread_group_empty(task));
>> >> +	rcu_read_unlock();
>> >> +
>> >> +	return exited;
>> >> +}
>> >
>> > I'm not sure why you think READ_ONCE was missing.
>> > It's different in wait_consider_task() where READ_ONCE is needed because
>> > of multiple checks. Here it's done once.
>> 
>> In practice it probably has no effect on the generated code.  But
>> READ_ONCE is about telling the compiler not to be clever.  Don't use
>> tearing loads or stores etc.  When all of the other readers are using
>> READ_ONCE I just get nervous if we have a case that doesn't.
>
> That's not true. The only place where READ_ONCE(->exit_state) is used is
> in wait_consider_task() and nowhere else. We had that discussion a while
> ago where I or someone proposed to simply place a READ_ONCE() around all
> accesses to exit_state for the sake of kcsan and we agreed that it's
> unnecessary and not to do this.
> But it obviously doesn't hurt to have it.

There is a larger discussion to be had around the proper handling of
exit_state.

In this particular case because we are accessing exit_state with
only rcu_read_lock protection, because the outcome of the read
is about correctness, and because the compiler has nothing else
telling it not to re-read exit_state, I believe we actually need
the READ_ONCE.

At the same time it would take a pretty special compiler to want to
reaccess that field in thread_group_exited.

I have looked through and I don't find any of the other access of
exit_state where the result is about correctness (so that we care)
and we don't hold tasklist_lock.

But I have removed the necessary wording from the commit comment.

There is a much larger discussion to be had about what to do with
exit_state, because I think I found about half the accesses were
slightly buggy in one form or another.

Eric


