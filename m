Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E0A24C0FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 16:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgHTOxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 10:53:02 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46092 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgHTOw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:52:59 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8lvs-00Aq9f-QJ; Thu, 20 Aug 2020 08:52:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8lvr-0002V7-SF; Thu, 20 Aug 2020 08:52:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>, timmurray@google.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        esyr@redhat.com, christian@kellner.me, areber@redhat.com,
        shakeelb@google.com, cyphar@cyphar.com, oleg@redhat.com,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, minchan@kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200820002053.1424000-1-surenb@google.com>
        <87zh6pxzq6.fsf@x220.int.ebiederm.org>
        <20200820124241.GJ5033@dhcp22.suse.cz>
        <87lfi9xz7y.fsf@x220.int.ebiederm.org>
        <87d03lxysr.fsf@x220.int.ebiederm.org>
        <20200820132631.GK5033@dhcp22.suse.cz>
        <20200820133454.ch24kewh42ax4ebl@wittgenstein>
        <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
        <20200820140054.fdkbotd4tgfrqpe6@wittgenstein>
        <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
Date:   Thu, 20 Aug 2020 09:49:11 -0500
In-Reply-To: <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Thu, 20 Aug 2020 23:18:40 +0900")
Message-ID: <87k0xtv0d4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k8lvr-0002V7-SF;;;mid=<87k0xtv0d4.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19eJAV7OrO6lFoLS+9WugMFiMdwgaSwTyw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Spam-Relay-Country: 
X-Spam-Timing: total 515 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 12 (2.4%), b_tie_ro: 10 (2.0%), parse: 1.82
        (0.4%), extract_message_metadata: 16 (3.1%), get_uri_detail_list: 3.4
        (0.7%), tests_pri_-1000: 6 (1.2%), tests_pri_-950: 1.43 (0.3%),
        tests_pri_-900: 1.15 (0.2%), tests_pri_-90: 126 (24.4%), check_bayes:
        119 (23.0%), b_tokenize: 10 (1.9%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 2.9 (0.6%), b_tok_touch_all: 94 (18.2%), b_finish: 0.95
        (0.2%), tests_pri_0: 327 (63.5%), check_dkim_signature: 0.78 (0.2%),
        check_dkim_adsp: 2.9 (0.6%), poll_dns_idle: 0.99 (0.2%), tests_pri_10:
        3.6 (0.7%), tests_pri_500: 15 (2.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in __set_oom_adj when not necessary
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> On 2020/08/20 23:00, Christian Brauner wrote:
>> On Thu, Aug 20, 2020 at 10:48:43PM +0900, Tetsuo Handa wrote:
>>> On 2020/08/20 22:34, Christian Brauner wrote:
>>>> On Thu, Aug 20, 2020 at 03:26:31PM +0200, Michal Hocko wrote:
>>>>> If you can handle vfork by other means then I am all for it. There were
>>>>> no patches in that regard proposed yet. Maybe it will turn out simpler
>>>>> then the heavy lifting we have to do in the oom specific code.
>>>>
>>>> Eric's not wrong. I fiddled with this too this morning but since
>>>> oom_score_adj is fiddled with in a bunch of places this seemed way more
>>>> code churn then what's proposed here.
>>>
>>> I prefer simply reverting commit 44a70adec910d692 ("mm, oom_adj: make sure
>>> processes sharing mm have same view of oom_score_adj").
>>>
>>>   https://lore.kernel.org/patchwork/patch/1037208/
>> 
>> I guess this is a can of worms but just or the sake of getting more
>> background: the question seems to be whether the oom adj score is a
>> property of the task/thread-group or a property of the mm. I always
>> thought the oom score is a property of the task/thread-group and not the
>> mm which is also why it lives in struct signal_struct and not in struct
>> mm_struct. But
>> 
>> 44a70adec910 ("mm, oom_adj: make sure processes sharing mm have same view of oom_score_adj")
>> 
>> reads like it is supposed to be a property of the mm or at least the
>> change makes it so.
>
> Yes, 44a70adec910 is trying to go towards changing from a property of the task/thread-group
> to a property of mm. But I don't think we need to do it at the cost of "__set_oom_adj() latency
> Yong-Taek Lee and Tim Murray have reported" and "complicity for supporting
> vfork() => __set_oom_adj() => execve() sequence".

The thing is commit 44a70adec910d692 ("mm, oom_adj: make sure processes
sharing mm have same view of oom_score_adj") has been in the tree for 4
years.

That someone is just now noticing a regression is their problem.  The
change is semantics is done and decided.  We can not reasonably revert
at this point without risking other regressions.

Given that the decision has already been made to make oom_adj
effectively per mm.  There is no point on have a debate if we should do
it.

Eric


