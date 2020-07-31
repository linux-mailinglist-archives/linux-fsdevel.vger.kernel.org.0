Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9107C2349B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 18:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbgGaQxV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 12:53:21 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:46164 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbgGaQxV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:53:21 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1YHW-003sY1-8H; Fri, 31 Jul 2020 10:53:18 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1YHV-0000kf-F7; Fri, 31 Jul 2020 10:53:18 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <87h7tsllgw.fsf@x220.int.ebiederm.org>
        <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
        <87d04fhkyz.fsf@x220.int.ebiederm.org>
        <87h7trg4ie.fsf@x220.int.ebiederm.org>
        <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
        <878sf16t34.fsf@x220.int.ebiederm.org>
        <87pn8c1uj6.fsf_-_@x220.int.ebiederm.org>
        <20200731062804.GA26171@redhat.com>
Date:   Fri, 31 Jul 2020 11:50:07 -0500
In-Reply-To: <20200731062804.GA26171@redhat.com> (Oleg Nesterov's message of
        "Fri, 31 Jul 2020 08:28:05 +0200")
Message-ID: <87sgd7zl1c.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k1YHV-0000kf-F7;;;mid=<87sgd7zl1c.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19AdY/PVTkYjPBRhTuY/YJb2t9RCuO9C/M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4982]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 404 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.8%), b_tie_ro: 10 (2.5%), parse: 1.09
        (0.3%), extract_message_metadata: 4.1 (1.0%), get_uri_detail_list:
        1.84 (0.5%), tests_pri_-1000: 3.5 (0.9%), tests_pri_-950: 1.19 (0.3%),
        tests_pri_-900: 1.07 (0.3%), tests_pri_-90: 97 (24.0%), check_bayes:
        96 (23.6%), b_tokenize: 7 (1.8%), b_tok_get_all: 7 (1.6%),
        b_comp_prob: 2.1 (0.5%), b_tok_touch_all: 76 (18.8%), b_finish: 0.90
        (0.2%), tests_pri_0: 259 (64.1%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.5 (0.6%), poll_dns_idle: 0.93 (0.2%), tests_pri_10:
        2.6 (0.6%), tests_pri_500: 14 (3.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] exec: Conceal the other threads from wakeups during exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> Eric, I won't comment the intent, but I too do not understand this idea.
>
> On 07/30, Eric W. Biederman wrote:
>>
>> [This change requires more work to handle TASK_STOPPED and TASK_TRACED]
>
> Yes. And it is not clear to me how can you solve this.

I was imagining something putting TASK_STOPPED and TASK_TRACED in a loop
that verified they should be in that state before exiting so they could
handle spurious wake ups.

There are a many subtlties in that code, especially in the conversion
fo TASK_STOPPED to TASK_TRACED.  So I suspect something more would be
required but I have not looked yet to see how tricky that would be.

>> [This adds a new lock ordering dependency siglock -> pi_lock -> rq_lock ]
>
> Not really, ttwu() can be safely called with siglock held and it takes
> pi_lock + rq_lock. Say, signal_wake_up().

Good point.

>> +int make_task_wakekill(struct task_struct *p)
>> +{
>> +	unsigned long flags;
>> +	int cpu, success = 0;
>> +	struct rq_flags rf;
>> +	struct rq *rq;
>> +	long state;
>> +
>> +	/* Assumes p != current */
>> +	preempt_disable();
>> +	/*
>> +	 * If we are going to change a thread waiting for CONDITION we
>> +	 * need to ensure that CONDITION=1 done by the caller can not be
>> +	 * reordered with p->state check below. This pairs with mb() in
>> +	 * set_current_state() the waiting thread does.
>> +	 */
>> +	raw_spin_lock_irqsave(&p->pi_lock, flags);
>> +	smp_mb__after_spinlock();
>> +	state = p->state;
>> +
>> +	/* FIXME handle TASK_STOPPED and TASK_TRACED */
>> +	if ((state == TASK_KILLABLE) ||
>> +	    (state == TASK_INTERRUPTIBLE)) {
>> +		success = 1;
>> +		cpu = task_cpu(p);
>> +		rq = cpu_rq(cpu);
>> +		rq_lock(rq, &rf);
>> +		p->state = TASK_WAKEKILL;
>
> You can only do this if the task was already deactivated. Just suppose it
> is preempted or does something like
>
> 	set_current_sate(TASK_INTERRUPTIBLE);
>
> 	if (CONDITION) {
> 		// make_task_wakekill() sets state = TASK_WAKEKILL
> 		__set_current_state(TASK_RUNNING);
> 		return;
> 	}
>
> 	schedule();

You are quite right.

So that bit of code would need to be:
	if (!task->on_rq)
        	goto out;
	if ((state == TASK_KILLABLE) ||
            (state == TASK_INTERRUPTIBLE)) {
            ...

Eric

