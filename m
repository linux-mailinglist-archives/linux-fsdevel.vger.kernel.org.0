Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0741B7DA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 20:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgDXSNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 14:13:54 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47536 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgDXSNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:13:54 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jS2pk-0001i0-LL; Fri, 24 Apr 2020 12:13:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jS2pi-0008NB-5O; Fri, 24 Apr 2020 12:13:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
Date:   Fri, 24 Apr 2020 13:10:40 -0500
In-Reply-To: <20200424173927.GB26802@redhat.com> (Oleg Nesterov's message of
        "Fri, 24 Apr 2020 19:39:28 +0200")
Message-ID: <87h7x8sqjj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jS2pi-0008NB-5O;;;mid=<87h7x8sqjj.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18vFbjen3QEL+8U6HAHWr3unr7JC5DnSxc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4986]
        *  0.7 XMSubLong Long Subject
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1699 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.6 (0.3%), b_tie_ro: 3.2 (0.2%), parse: 1.08
        (0.1%), extract_message_metadata: 4.5 (0.3%), get_uri_detail_list: 2.2
        (0.1%), tests_pri_-1000: 2.2 (0.1%), tests_pri_-950: 1.08 (0.1%),
        tests_pri_-900: 0.85 (0.0%), tests_pri_-90: 61 (3.6%), check_bayes: 60
        (3.5%), b_tokenize: 6 (0.3%), b_tok_get_all: 7 (0.4%), b_comp_prob:
        1.76 (0.1%), b_tok_touch_all: 43 (2.5%), b_finish: 0.68 (0.0%),
        tests_pri_0: 1606 (94.5%), check_dkim_signature: 0.38 (0.0%),
        check_dkim_adsp: 1228 (72.3%), poll_dns_idle: 1225 (72.1%),
        tests_pri_10: 2.6 (0.2%), tests_pri_500: 7 (0.4%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH v2 2/2] proc: Ensure we see the exit of each process tid exactly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/23, Eric W. Biederman wrote:
>>
>> When the thread group leader changes during exec and the old leaders
>> thread is reaped proc_flush_pid
>
> This is off-topic, but let me mention this before I forget...
>
> Note that proc_flush_pid() does nothing if CONFIG_PROC_FS=n, this mean
> that in this case release_task() leaks thread_pid.

Good catch.  Wow.  I seem to be introducing almost as many bugs as I am
fixing right now.  Ouch.

>> +void exchange_tids(struct task_struct *ntask, struct task_struct *otask)
>> +{
>> +	/* pid_links[PIDTYPE_PID].next is always NULL */
>> +	struct pid *npid = READ_ONCE(ntask->thread_pid);
>> +	struct pid *opid = READ_ONCE(otask->thread_pid);
>> +
>> +	rcu_assign_pointer(opid->tasks[PIDTYPE_PID].first, &ntask->pid_links[PIDTYPE_PID]);
>> +	rcu_assign_pointer(npid->tasks[PIDTYPE_PID].first, &otask->pid_links[PIDTYPE_PID]);
>> +	rcu_assign_pointer(ntask->thread_pid, opid);
>> +	rcu_assign_pointer(otask->thread_pid, npid);
>> +	WRITE_ONCE(ntask->pid_links[PIDTYPE_PID].pprev, &opid->tasks[PIDTYPE_PID].first);
>> +	WRITE_ONCE(otask->pid_links[PIDTYPE_PID].pprev, &npid->tasks[PIDTYPE_PID].first);
>> +	WRITE_ONCE(ntask->pid, pid_nr(opid));
>> +	WRITE_ONCE(otask->pid, pid_nr(npid));
>> +}
>
> Oh, at first glance this breaks posix-cpu-timers.c:lookup_task(), the last
> user of has_group_leader_pid().
>
> I think that we should change lookup_task() to return "struct *pid", this
> should simplify the code... Note that none of its callers needs task_struct.
>
> And, instead of thread_group_leader/has_group_leader_pid checks we should
> use pid_has_task(TGID).

Somehow I thought we could get away without fiddling with that right
now, but on second glance I can see the races.

I played with this earlier and I agree returning a struct pid *
is desirable.  I will see if I can track down the patches I was
playing with as that definitely needs to get fixed first.

> After that, this patch should kill has_group_leader_pid().
>
> What do you think?

I agree completely.  has_group_leader_pid is the same as
thread_group_leader after this so should be removed.  Especially as it
won't have any users.

There are several other potential cleanups as well.  Such as not
using a hlist for PIDTYPE_PID.  Which would allow us to run the hlists
through struct signal_struct instead.  I think that would clean things
up but that touches so many things it may just be pointless code churn.

Just for mentioning I am thinking we should rename PIDTYPE_PID to
PIDTYPE_TID just to create a distance in peoples minds between
the kernel concepts and the user space concepts.

Eric

