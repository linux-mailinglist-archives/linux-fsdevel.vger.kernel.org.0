Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D58624BCA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 14:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgHTMuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 08:50:19 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40948 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgHTMt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:49:27 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8k0I-00Adm1-K2; Thu, 20 Aug 2020 06:49:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8k0H-0004wa-Os; Thu, 20 Aug 2020 06:49:14 -0600
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
Date:   Thu, 20 Aug 2020 07:45:37 -0500
In-Reply-To: <20200820124241.GJ5033@dhcp22.suse.cz> (Michal Hocko's message of
        "Thu, 20 Aug 2020 14:42:41 +0200")
Message-ID: <87lfi9xz7y.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k8k0H-0004wa-Os;;;mid=<87lfi9xz7y.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+DAdP7WXJ3+fqaabHe/txON167hJBjJH8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4972]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michal Hocko <mhocko@suse.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 466 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.4%), b_tie_ro: 10 (2.1%), parse: 1.03
        (0.2%), extract_message_metadata: 14 (3.1%), get_uri_detail_list: 2.1
        (0.4%), tests_pri_-1000: 13 (2.8%), tests_pri_-950: 1.35 (0.3%),
        tests_pri_-900: 1.16 (0.2%), tests_pri_-90: 67 (14.3%), check_bayes:
        65 (13.9%), b_tokenize: 10 (2.1%), b_tok_get_all: 11 (2.4%),
        b_comp_prob: 3.6 (0.8%), b_tok_touch_all: 35 (7.5%), b_finish: 1.00
        (0.2%), tests_pri_0: 338 (72.5%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 0.66 (0.1%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 13 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in __set_oom_adj when not necessary
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Thu 20-08-20 07:34:41, Eric W. Biederman wrote:
>> Suren Baghdasaryan <surenb@google.com> writes:
>> 
>> > Currently __set_oom_adj loops through all processes in the system to
>> > keep oom_score_adj and oom_score_adj_min in sync between processes
>> > sharing their mm. This is done for any task with more that one mm_users,
>> > which includes processes with multiple threads (sharing mm and signals).
>> > However for such processes the loop is unnecessary because their signal
>> > structure is shared as well.
>> > Android updates oom_score_adj whenever a tasks changes its role
>> > (background/foreground/...) or binds to/unbinds from a service, making
>> > it more/less important. Such operation can happen frequently.
>> > We noticed that updates to oom_score_adj became more expensive and after
>> > further investigation found out that the patch mentioned in "Fixes"
>> > introduced a regression. Using Pixel 4 with a typical Android workload,
>> > write time to oom_score_adj increased from ~3.57us to ~362us. Moreover
>> > this regression linearly depends on the number of multi-threaded
>> > processes running on the system.
>> > Mark the mm with a new MMF_PROC_SHARED flag bit when task is created with
>> > CLONE_VM and !CLONE_SIGHAND. Change __set_oom_adj to use MMF_PROC_SHARED
>> > instead of mm_users to decide whether oom_score_adj update should be
>> > synchronized between multiple processes. To prevent races between clone()
>> > and __set_oom_adj(), when oom_score_adj of the process being cloned might
>> > be modified from userspace, we use oom_adj_mutex. Its scope is changed to
>> > global and it is renamed into oom_adj_lock for naming consistency with
>> > oom_lock. Since the combination of CLONE_VM and !CLONE_SIGHAND is rarely
>> > used the additional mutex lock in that path of the clone() syscall should
>> > not affect its overall performance. Clearing the MMF_PROC_SHARED flag
>> > (when the last process sharing the mm exits) is left out of this patch to
>> > keep it simple and because it is believed that this threading model is
>> > rare. Should there ever be a need for optimizing that case as well, it
>> > can be done by hooking into the exit path, likely following the
>> > mm_update_next_owner pattern.
>> > With the combination of CLONE_VM and !CLONE_SIGHAND being quite rare, the
>> > regression is gone after the change is applied.
>> 
>> So I am confused.
>> 
>> Is there any reason why we don't simply move signal->oom_score_adj to
>> mm->oom_score_adj and call it a day?
>
> Yes. Please read through 44a70adec910 ("mm, oom_adj: make sure processes
> sharing mm have same view of oom_score_adj")

That explains why the scores are synchronized.

It doesn't explain why we don't do the much simpler thing and move
oom_score_adj from signal_struct to mm_struct. Which is my question.

Why not put the score where we need it to ensure that the oom score
is always synchronized?  AKA on the mm_struct, not the signal_struct.

Eric

