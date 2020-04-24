Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93271B7F62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 21:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgDXTyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 15:54:38 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51924 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDXTyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:54:38 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jS4PE-0002zY-Dz; Fri, 24 Apr 2020 13:54:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jS4PD-0007HH-Hs; Fri, 24 Apr 2020 13:54:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wgXEJdkgGzZQzBDGk7ijjVdAVXe=G-mkFSVng_Hpwd4tQ@mail.gmail.com>
        <87tv19tv65.fsf@x220.int.ebiederm.org>
        <CAHk-=wj-K3fqdMr-r8WgS8RKPuZOuFbPXCEUe9APrdShn99xsA@mail.gmail.com>
Date:   Fri, 24 Apr 2020 14:51:25 -0500
In-Reply-To: <CAHk-=wj-K3fqdMr-r8WgS8RKPuZOuFbPXCEUe9APrdShn99xsA@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 24 Apr 2020 11:02:35 -0700")
Message-ID: <87mu70psqq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jS4PD-0007HH-Hs;;;mid=<87mu70psqq.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/r83cUDMsvQlOeMJelnJ6NFAsyWlR86Vo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4816]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 471 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.1%), b_tie_ro: 9 (1.9%), parse: 0.93 (0.2%),
         extract_message_metadata: 14 (3.1%), get_uri_detail_list: 3.0 (0.6%),
        tests_pri_-1000: 19 (4.0%), tests_pri_-950: 1.09 (0.2%),
        tests_pri_-900: 0.83 (0.2%), tests_pri_-90: 73 (15.5%), check_bayes:
        72 (15.2%), b_tokenize: 11 (2.3%), b_tok_get_all: 10 (2.2%),
        b_comp_prob: 3.0 (0.6%), b_tok_touch_all: 44 (9.4%), b_finish: 0.73
        (0.2%), tests_pri_0: 342 (72.5%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 1.83 (0.4%), poll_dns_idle: 0.37 (0.1%),
        tests_pri_10: 1.71 (0.4%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH v2 2/2] proc: Ensure we see the exit of each process tid exactly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Apr 23, 2020 at 8:36 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> At one point my brain I had forgetten that xchg can not take two memory
>> arguments and had hoped to be able to provide stronger guarnatees than I
>> can.  Which is where I think the structure of exchange_pids came from.
>
> Note that even if we were to have a "exchange two memory locations
> atomically" instruction (and we don't - even a "double cmpxchg" is
> actually just a double-_sized_ one, not a two different locations
> one), I'm not convinced it makes sense.
>
> There's no way to _walk_ two lists atomically. Any user will only ever
> walk one or the other, so it's not sensible to try to make the two
> list updates be atomic.
>
> And if a user for some reason walks both, the walking itself will
> obviously then be racy - it does one or the other first, and can see
> either the old state, or the new state - or see _neither_ (ie if you
> walk it twice, you might see neither task, or you might see both, just
> depending on order or walk).
>
>> I do agree the clearer we can write things, the easier it is for
>> someone else to come along and follow.
>
> Your alternate write of the function seems a bit more readable to me,
> even if the main effect might be just that it was split up a bit and
> added a few comments and whitespace.
>
> So I'm more happier with that one. That said:
>
>> We can not use a remove and reinser model because that does break rcu
>> accesses, and complicates everything else.  With a swap model we have
>> the struct pids pointer at either of the tasks that are swapped but
>> never at nothing.
>
> I'm not suggesting removing the pid entirely - like making task->pid
> be NULL. I'm literally suggesting just doing the RCU list operations
> as "remove and re-insert".
>
> And that shouldn't break anything, for the same reason that an atomic
> exchange doesn't make sense: you can only ever walk one of the lists
> at a time. And regardless of how you walk it, you might not see the
> new state (or the old state) reliably.
>
> Put another way:
>
>>         void hlist_swap_before_rcu(struct hlist_node *left, struct hlist_node *right)
>>         {
>>                 struct hlist_node **lpprev = left->pprev;
>>                 struct hlist_node **rpprev = right->pprev;
>>
>>                 rcu_assign_pointer(*lpprev, right);
>>                 rcu_assign_pointer(*rpprev, left);
>
> These are the only two assignments that matter for anything that walks
> the list (the pprev ones are for things that change the list, and they
> have to have exclusions in place).
>
> And those two writes cannot be atomic anyway, so you fundamentally
> will always be in the situation that a walker can miss one of the
> tasks.
>
> Which is why I think it would be ok to just do the RCU list swap as a
> "remove left, remove right, add left, add right" operation. It doesn't
> seem fundamentally different to a walker than the "switch left/right"
> operation, and it seems much simpler.
>
> Is there something I'm missing?


The problem with

remove
remove
add
add
is:

A lookup that hit between the remove and the add could return nothing.

The function kill_pid_info does everything it can to handle this case
today does:

int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid)
{
	int error = -ESRCH;
	struct task_struct *p;

	for (;;) {
		rcu_read_lock();
		p = pid_task(pid, PIDTYPE_PID);
		if (p)
			error = group_send_sig_info(sig, info, p, PIDTYPE_TGID);
		rcu_read_unlock();
		if (likely(!p || error != -ESRCH))
			return error;

		/*
		 * The task was unhashed in between, try again.  If it
		 * is dead, pid_task() will return NULL, if we race with
		 * de_thread() it will find the new leader.
		 */
	}
}

Now kill_pid_info is signalling the entire task and is just using
PIDTYPE_PID to find a thread in the task.

With the remove then add model there will be a point where pid_task
will return nothing, because ever so briefly the lists will be
empty.

However with an actually swap we will find a task and kill_pid_info
will work.  It pathloglical cases lock_task_sighand might have to loop
and we would need to find the new task that has the given pid.  But
kill_pid_info is guaranteed to work with swaps and will fail with
remove add.


> But I'm *not* suggesting that we change these simple parts to be
> "remove thread_pid or pid pointer, and then insert a new one":
>
>>                 /* Swap thread_pid */
>>                 rpid = left->thread_pid;
>>                 lpid = right->thread_pid;
>>                 rcu_assign_pointer(left->thread_pid, lpid);
>>                 rcu_assign_pointer(right->thread_pid, rpid);
>>
>>                 /* Swap the cached pid value */
>>                 WRITE_ONCE(left->pid, pid_nr(lpid));
>>                 WRITE_ONCE(right->pid, pid_nr(rpid));
>>         }
>
> because I agree that for things that don't _walk_ the list, but just
> look up "thread_pid" vs "pid" atomically but asynchronously, we
> obviously need to get one or the other, not some kind of "empty"
> state.

For PIDTYPE_PID and PIDTYPE_TGID these practically aren't lists but
pointers to the appropriate task.  Only for PIDTYPE_PGID and PIDTYPE_SID
do these become lists in practice.

That not-really-a-list status allows for signel delivery to indivdual
processes to happen in rcu context.  Which is where we would get into
trouble with add/remove.

Since signals are guaranteed to be delivered to the entire session
or the entire process group all of the list walking happens under
the tasklist_lock currently.  Which really keeps list walking from
being a concern.

>> Does that look a little more readable?
>
> Regardless, I find your new version at least a lot more readable, so
> I'm ok with it.

Good. Then I will finish cleaning it up and go with that version.

> It looks like Oleg found an independent issue, though.

Yes, and I will definitely work through those.

Eric
