Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C77124C189
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 17:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgHTPKD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 11:10:03 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51558 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbgHTPJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:09:58 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8mCJ-00As2t-L1; Thu, 20 Aug 2020 09:09:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8mCI-0005bS-RZ; Thu, 20 Aug 2020 09:09:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, adobriyan@gmail.com, akpm@linux-foundation.org,
        gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
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
        <874koxxwn5.fsf@x220.int.ebiederm.org>
        <20200820140451.GC4546@redhat.com> <20200820143626.GD4546@redhat.com>
Date:   Thu, 20 Aug 2020 10:06:11 -0500
In-Reply-To: <20200820143626.GD4546@redhat.com> (Oleg Nesterov's message of
        "Thu, 20 Aug 2020 16:36:27 +0200")
Message-ID: <874koxuzks.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k8mCI-0005bS-RZ;;;mid=<874koxuzks.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+X45oycrmBVkIpLi2wH8sohT7Ra+gBq0E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 372 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (2.5%), b_tie_ro: 8 (2.1%), parse: 0.89 (0.2%),
        extract_message_metadata: 3.4 (0.9%), get_uri_detail_list: 1.26 (0.3%),
         tests_pri_-1000: 4.7 (1.3%), tests_pri_-950: 1.35 (0.4%),
        tests_pri_-900: 1.16 (0.3%), tests_pri_-90: 100 (27.0%), check_bayes:
        99 (26.6%), b_tokenize: 9 (2.3%), b_tok_get_all: 8 (2.1%),
        b_comp_prob: 2.3 (0.6%), b_tok_touch_all: 76 (20.5%), b_finish: 1.04
        (0.3%), tests_pri_0: 230 (61.8%), check_dkim_signature: 0.77 (0.2%),
        check_dkim_adsp: 2.7 (0.7%), poll_dns_idle: 1.02 (0.3%), tests_pri_10:
        3.0 (0.8%), tests_pri_500: 9 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in __set_oom_adj when not necessary
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 08/20, Oleg Nesterov wrote:
>>
>> On 08/20, Eric W. Biederman wrote:
>> >
>> > --- a/fs/exec.c
>> > +++ b/fs/exec.c
>> > @@ -1139,6 +1139,10 @@ static int exec_mmap(struct mm_struct *mm)
>> >  	vmacache_flush(tsk);
>> >  	task_unlock(tsk);
>> >  	if (old_mm) {
>> > +		mm->oom_score_adj = old_mm->oom_score_adj;
>> > +		mm->oom_score_adj_min = old_mm->oom_score_adj_min;
>> > +		if (tsk->vfork_done)
>> > +			mm->oom_score_adj = tsk->vfork_oom_score_adj;
>>
>> too late, ->vfork_done is NULL after mm_release().
>>
>> And this can race with __set_oom_adj(). Yes, the current code is racy too,
>> but this change adds another race, __set_oom_adj() could already observe
>> ->mm != NULL and update mm->oom_score_adj.
>   ^^^^^^^^^^^^
>
> I meant ->mm == new_mm.
>
> And another problem. Suppose we have
>
> 	if (!vfork()) {
> 		change_oom_score();
> 		exec();
> 	}
>
> the parent can be killed before the child execs, in this case vfork_oom_score_adj
> will be lost.

Yes.

Looking at include/uapi/linux/oom.h it appears that there are a lot of
oom_score_adj values that are reserved.  So it should be completely
possible to initialize vfork_oom_score_adj to -32768 aka SHRT_MIN, and
use that as a flag to see if it is active or not.

Likewise for vfork_oom_score_adj_min if we need to duplicate that one as
well.


That deals with that entire class of race.  We still have races during
exec about vfork_done being cleared before the new ->mm == new_mm.
While that is worth fixing is an independent issue.  

Eric

