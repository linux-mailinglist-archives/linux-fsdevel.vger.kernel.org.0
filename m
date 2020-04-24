Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB13D1B6BFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 05:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgDXDgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 23:36:17 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37994 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDXDgR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:36:17 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRp8S-0003fD-Ei; Thu, 23 Apr 2020 21:36:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRp8R-0007ZJ-Fb; Thu, 23 Apr 2020 21:36:16 -0600
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
Date:   Thu, 23 Apr 2020 22:33:06 -0500
In-Reply-To: <CAHk-=wgXEJdkgGzZQzBDGk7ijjVdAVXe=G-mkFSVng_Hpwd4tQ@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 23 Apr 2020 13:28:18 -0700")
Message-ID: <87tv19tv65.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jRp8R-0007ZJ-Fb;;;mid=<87tv19tv65.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+K74FabDAcvn7I1S0sCNkQEUS9knirSzk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 605 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.0%), b_tie_ro: 10 (1.7%), parse: 1.23
        (0.2%), extract_message_metadata: 17 (2.9%), get_uri_detail_list: 3.8
        (0.6%), tests_pri_-1000: 22 (3.7%), tests_pri_-950: 1.27 (0.2%),
        tests_pri_-900: 1.00 (0.2%), tests_pri_-90: 123 (20.3%), check_bayes:
        120 (19.8%), b_tokenize: 11 (1.8%), b_tok_get_all: 56 (9.3%),
        b_comp_prob: 3.2 (0.5%), b_tok_touch_all: 46 (7.7%), b_finish: 0.90
        (0.1%), tests_pri_0: 414 (68.4%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.34 (0.1%), tests_pri_10:
        3.0 (0.5%), tests_pri_500: 7 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/2] proc: Ensure we see the exit of each process tid exactly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Apr 23, 2020 at 12:42 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> +void exchange_tids(struct task_struct *ntask, struct task_struct *otask)
>> +{
>> +       /* pid_links[PIDTYPE_PID].next is always NULL */
>> +       struct pid *npid = READ_ONCE(ntask->thread_pid);
>> +       struct pid *opid = READ_ONCE(otask->thread_pid);
>> +
>> +       rcu_assign_pointer(opid->tasks[PIDTYPE_PID].first, &ntask->pid_links[PIDTYPE_PID]);
>> +       rcu_assign_pointer(npid->tasks[PIDTYPE_PID].first, &otask->pid_links[PIDTYPE_PID]);
>> +       rcu_assign_pointer(ntask->thread_pid, opid);
>> +       rcu_assign_pointer(otask->thread_pid, npid);
>> +       WRITE_ONCE(ntask->pid_links[PIDTYPE_PID].pprev, &opid->tasks[PIDTYPE_PID].first);
>> +       WRITE_ONCE(otask->pid_links[PIDTYPE_PID].pprev, &npid->tasks[PIDTYPE_PID].first);
>> +       WRITE_ONCE(ntask->pid, pid_nr(opid));
>> +       WRITE_ONCE(otask->pid, pid_nr(npid));
>> +}
>
> This function is _very_ hard to read as written.
>
> It really wants a helper function to do the swapping per hlist_head
> and hlist_node, I think. And "opid/npid" is very hard to see, and the
> naming doesn't make much sense (if it's an "exchange", then why is it
> "old/new" - they're symmetric).
>
> At least something like
>
>         struct hlist_head *old_pid_hlist = opid->tasks + PIDTYPE_PID;
>         struct hlist_head *new_pid_hlist = npid->tasks + PIDTYPE_PID;
>         struct hlist_node *old_pid_node = otask->pid_links + PIDTYPE_PID;
>         struct hlist_node *new_pid_node = ntask->pid_links + PIDTYPE_PID;
>
>         struct hlist_node *old_first_node = old_pid_hlist->first;
>         struct hlist_node *new_first_node = new_pid_hlist->first;
>
> and then trying to group up the first/pprev/thread_pid/pid  accesses
> so that you them together, and using a helper function that does the
> whole switch, so that you'd have
>
>         /* Move new node to old hlist, and update thread_pid/pid fields */
>         insert_pid_pointers(old_pid_hlist, new_pid_node, new_first_node);
>         rcu_assign_pointer(ntask->thread_pid, opid);
>         WRITE_ONCE(ntask->pid, pid_nr(opid));
>
>         /* Move old new to new hlist, and update thread_pid/pid fields */
>         insert_pid_pointers(new_pid_hlist, old_pid_node, old_first_node);
>         rcu_assign_pointer(otask->thread_pid, npid);
>         WRITE_ONCE(otask->pid, pid_nr(npid));
>
> or something roughly like that.
>
> (And the above still uses "old/new", which as mentioned sounds wrong
> to me. Maybe it should just be "a_xyz" and "b_xyz"? Also note that I
> did this in my MUA, so I could have gotten the names and types wrong
> etc).
>
> I think that would make it look at least _slightly_ less like random
> line noise and easier to follow.
>
> But maybe even a rcu_hlist_swap() helper? We have one for regular
> lists. Do we really have to do it all written out, not do it with a
> "remove and reinsert" model?

At one point my brain I had forgetten that xchg can not take two memory
arguments and had hoped to be able to provide stronger guarnatees than I
can.  Which is where I think the structure of exchange_pids came from.

I do agree the clearer we can write things, the easier it is for
someone else to come along and follow.

We can not use a remove and reinser model because that does break rcu
accesses, and complicates everything else.  With a swap model we have
the struct pids pointer at either of the tasks that are swapped but
never at nothing.  With a remove/reinsert model we have to deal the
addittional possibility of the pids not pointing at a thread at all
which can result in things like signals not being delivered at all.

I played with it a bit and the best I have been able to come up is:

	void hlist_swap_before_rcu(struct hlist_node *left, struct hlist_node *right)
	{
		struct hlist_node **lpprev = left->pprev;
		struct hlist_node **rpprev = right->pprev;
	
		rcu_assign_pointer(*lpprev, right);
		rcu_assign_pointer(*rpprev, left);
		WRITE_ONCE(left->pprev,  rpprev);
		WRITE_ONCE(right->pprev, lpprev);
	}
	
	void exchange_tids(struct task_struct *left, struct task_struct *right)
	{
		struct hlist_node *lnode = &left->pid_links[PIDTYPE_PID];
		struct hlist_node *rnode = &right->pid_links[PIDTYPE_PID];
		struct pid *lpid, *rpid;
	
		/* Replace the single entry tid lists with each other */
		hlist_swap_before_rcu(lnode, rnode);

		/* Swap thread_pid */
		rpid = left->thread_pid;
		lpid = right->thread_pid;
		rcu_assign_pointer(left->thread_pid, lpid);
		rcu_assign_pointer(right->thread_pid, rpid);

                /* Swap the cached pid value */
		WRITE_ONCE(left->pid, pid_nr(lpid));
		WRITE_ONCE(right->pid, pid_nr(rpid));
	}

hlists because they are not doubly linked can legitimately swap their
beginnings or their tails.  Something that regular lists can not,
and I think that is exactly the general purpose semantic I want.

Does that look a little more readable?

Eric
