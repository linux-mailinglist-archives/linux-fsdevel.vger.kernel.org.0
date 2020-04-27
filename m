Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783911BA66E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 16:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgD0Ob7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 10:31:59 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54400 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgD0Ob7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:31:59 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT4nW-0003PY-3t; Mon, 27 Apr 2020 08:31:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT4nU-0003ye-W9; Mon, 27 Apr 2020 08:31:49 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
Date:   Mon, 27 Apr 2020 09:28:34 -0500
In-Reply-To: <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 26 Apr 2020 10:40:17 -0700")
Message-ID: <878sihgfzh.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jT4nU-0003ye-W9;;;mid=<878sihgfzh.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18+znDKyGRhbxepUE3Q5lEojaY62DKpFTI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4893]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 708 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.5%), b_tie_ro: 9 (1.3%), parse: 1.07 (0.2%),
         extract_message_metadata: 16 (2.3%), get_uri_detail_list: 3.4 (0.5%),
        tests_pri_-1000: 24 (3.4%), tests_pri_-950: 1.34 (0.2%),
        tests_pri_-900: 1.09 (0.2%), tests_pri_-90: 252 (35.6%), check_bayes:
        249 (35.2%), b_tokenize: 12 (1.7%), b_tok_get_all: 11 (1.6%),
        b_comp_prob: 3.5 (0.5%), b_tok_touch_all: 218 (30.8%), b_finish: 0.99
        (0.1%), tests_pri_0: 388 (54.8%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.3 (0.3%), poll_dns_idle: 0.38 (0.1%), tests_pri_10:
        2.4 (0.3%), tests_pri_500: 8 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 3/6] rculist: Add hlist_swap_before_rcu
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, Apr 26, 2020 at 7:14 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> To support this add hlist_swap_before_rcu.  An hlist primitive that
>> will allow swaping the leading sections of two tasks.  For exchanging
>> the task pids it will just be swapping the hlist_heads of two single
>> entry lists.  But the functionality is more general.
>
> So I have no problems with the series now - the code is much more
> understandable. Partly because of the split-up, partly because of the
> comments, and partly because you explained the special case and why it
> was a valid thing to do...
>
> However, I did start thinking about this case again.
>
> I still don't think the "swap entry" macro is necessarily useful in
> _general_ - any time it's an actual individual entry, that swap macro
> doesn't really work.

But it isn't a "swap entry" macro/function.  I did not even attempt
to make it a "swap entry" function.

I made a chop two lists into two and swap the pieces function.

> So the only reason it works here is because you're actually swapping
> the whole list.
>
> But that, in turn, shouldn't be using that "first node" model at all,
> it should use the hlist_head. That would have made it a lot more
> obvious what is actually going on to me.
>
> Now, the comment very much talks about the head case, but the code
> still looks like it's swapping a non-head thing.
>
> I guess the code technically _works_ with "swap two list ends", but
> does that actually really make sense as an operation?

As an operation yes.  Will anyone else want that operation I don't know.

> So I no longer hate how this patch looks, but I wonder if we should
> just make the whole "this node is the *first* node" a bit more
> explicit in both the caller and in the swapping code.
>
> It could be as simple as replacing just the conceptual types and
> names, so instead of some "pnode1" double-indirect node pointer, we'd
> have
>
>         struct hlist_head *left_head = container_of(left->pprev,
> struct hlist_head, first);
>         struct hlist_head *right_head = container_of(right->pprev,
> struct hlist_head, first);
>
> and then the code would do
>
>         rcu_assign_pointer(right_head->first, left);
>         rcu_assign_pointer(left_head->first, right);
>         WRITE_ONCE(left->pprev,  &right_head->first);
>         WRITE_ONCE(right->pprev,  &left_head->first);
>
> which should generate the exact same code, but makes it clear that
> what we're doing is switching the whole hlist when given the first
> entries.
>
> Doesn't that make what it actually does a lot more understandable?

Understandable is a bit subjective. I think having a well defined hlist
operation I can call makes things more understandable.

I think the getting the list head as:
"head = &task->thread_pid->tasks[PIDTYPE_PID];" is more understandable
and less risky than container_of.

My concern and probably unreasonbable as this is a slow path
with getting the list heads after looking up the pid is that it seems
to add a wait for an additional cache line to load before anything can
happen.

The only way I really know to make this code much more understandable is
to remove the lists entirely for this case.  But that is a much larger
change and it is not clear that it makes the kernel code overall better.
I stared at that for a while and it is an interesting follow on but not
something I want or we even can do before exchange_tids is in place.

> The
> *pnode1/pnode2 games are somewhat opaque, but with that type and name
> change and using "container_of()", the code now fairly naturally reads
> as "oh, we're changing the first pointers in the list heads, and
> making the nodes point back to them" .
>
> Again - the current function _works_ with swapping two hlists in the
> middle (not two entries - it swaps the whole list starting at that
> entry!), so your current patch is in some ways "more generic". I'm
> just suggesting that the generic case doesn't make much sense, and
> that the "we know the first entries, swap the lists" actually is what
> the real use is, and writing it as such makes the code easier to
> understand.

Yep.  That is waht I designed it to do.  I sort of went the other
direction when writing this.  I could start with the list heads and swap
the rest of the lists and get the same code.  But it looked like it
would be a little slower to find the hlist_heads, and I couldn't think
of a good name for the function.  So I figured if I was writing a
fucntion for this case I would write one that was convinient.

For understandability that is my real challenge what is a good name
that people can read and understand what is happening for this swapping
function.

> But I'm not going to insist on this, so this is more an RFC. Maybe
> people disagree, and/or have an actual use case for that "break two
> hlists in the middle, swap the ends" that I find unlikely...
>
> (NOTE: My "convert to hlist_head" code _works_ for that case too
> because the code generation is the same! But it would be really really
> confusing for that code to be used for anything but the first entry).

Yes.

I am open to improvements.  Especially in the naming.

Would hlists_swap_heads_rcu be noticably better?

Eric

