Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6000D24CCDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 06:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgHUEnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 00:43:19 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:55030 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgHUEnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 00:43:17 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8ytK-008psA-Jl; Thu, 20 Aug 2020 22:43:02 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8ytJ-00009U-Oh; Thu, 20 Aug 2020 22:43:02 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tim Murray <timmurray@google.com>, mingo@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com,
        Shakeel Butt <shakeelb@google.com>, cyphar@cyphar.com,
        Oleg Nesterov <oleg@redhat.com>, adobriyan@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        gladkov.alexey@gmail.com, Michel Lespinasse <walken@google.com>,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de,
        John Johansen <john.johansen@canonical.com>,
        laoar.shao@gmail.com, Minchan Kim <minchan@kernel.org>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <20200820124241.GJ5033@dhcp22.suse.cz>
        <87lfi9xz7y.fsf@x220.int.ebiederm.org>
        <87d03lxysr.fsf@x220.int.ebiederm.org>
        <20200820132631.GK5033@dhcp22.suse.cz>
        <20200820133454.ch24kewh42ax4ebl@wittgenstein>
        <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
        <20200820140054.fdkbotd4tgfrqpe6@wittgenstein>
        <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
        <87k0xtv0d4.fsf@x220.int.ebiederm.org>
        <CAJuCfpHsjisBnNiDNQbm8Yi92cznaptiXYPdc-aVa+_zkuaPhA@mail.gmail.com>
        <20200820162645.GP5033@dhcp22.suse.cz>
Date:   Thu, 20 Aug 2020 23:39:25 -0500
In-Reply-To: <20200820162645.GP5033@dhcp22.suse.cz> (Michal Hocko's message of
        "Thu, 20 Aug 2020 18:26:45 +0200")
Message-ID: <87r1s0txxe.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k8ytJ-00009U-Oh;;;mid=<87r1s0txxe.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18uBSxl8pJIjuyaXaco3WG9+jz0MdU4UDc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4925]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michal Hocko <mhocko@suse.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 437 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (2.9%), b_tie_ro: 11 (2.5%), parse: 1.52
        (0.3%), extract_message_metadata: 18 (4.2%), get_uri_detail_list: 2.6
        (0.6%), tests_pri_-1000: 21 (4.8%), tests_pri_-950: 1.65 (0.4%),
        tests_pri_-900: 6 (1.4%), tests_pri_-90: 103 (23.5%), check_bayes: 95
        (21.6%), b_tokenize: 16 (3.7%), b_tok_get_all: 10 (2.4%), b_comp_prob:
        3.6 (0.8%), b_tok_touch_all: 59 (13.5%), b_finish: 1.59 (0.4%),
        tests_pri_0: 252 (57.6%), check_dkim_signature: 0.93 (0.2%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 0.83 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 14 (3.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in __set_oom_adj when not necessary
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Thu 20-08-20 08:56:53, Suren Baghdasaryan wrote:
> [...]
>> Catching up on the discussion which was going on while I was asleep...
>> So it sounds like there is a consensus that oom_adj should be moved to
>> mm_struct rather than trying to synchronize it among tasks sharing mm.
>> That sounds reasonable to me too. Michal answered all the earlier
>> questions about this patch, so I won't be reiterating them, thanks
>> Michal. If any questions are still lingering about the original patch
>> I'll be glad to answer them.
>
> I think it still makes some sense to go with a simpler (aka less tricky)
> solution which would be your original patch with an incremental fix for
> vfork and the proper ordering (http://lkml.kernel.org/r/20200820124109.GI5033@dhcp22.suse.cz)
> and then make a more complex shift to mm struct on top of that. The
> former will be less tricky to backport to stable IMHO.

So I am confused.

I don't know how a subtle dependency on something in clone
is better than something flat footed in exec.


That said if we are going for a small change why not:

	/*
	 * Make sure we will check other processes sharing the mm if this is
	 * not vfrok which wants its own oom_score_adj.
	 * pin the mm so it doesn't go away and get reused after task_unlock
	 */
	if (!task->vfork_done) {
		struct task_struct *p = find_lock_task_mm(task);

		if (p) {
-			if (atomic_read(&p->mm->mm_users) > 1) {
+			if (atomic_read(&p->mm->mm_users) > p->signal->nr_threads) {
				mm = p->mm;
				mmgrab(mm);
			}
			task_unlock(p);
		}
	}

That would seem to be the minimal change to make this happen.  That has
the advantage that if a processes does vfork it won't always have to
take the slow path.

Moving to the mm_struct is much less racy but this is simple.

Eric
