Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2495D1BC754
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 19:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgD1R6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 13:58:24 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51462 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgD1R6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:58:23 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTUUw-0008S4-H8; Tue, 28 Apr 2020 11:58:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTUUv-00068u-LG; Tue, 28 Apr 2020 11:58:22 -0600
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
        <878sihgfzh.fsf@x220.int.ebiederm.org>
        <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
        <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wiBYMoimvtc_DrwKN5EaQ98AmPryqYX6a-UE_VGP6LMrw@mail.gmail.com>
Date:   Tue, 28 Apr 2020 12:55:07 -0500
In-Reply-To: <CAHk-=wiBYMoimvtc_DrwKN5EaQ98AmPryqYX6a-UE_VGP6LMrw@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 28 Apr 2020 09:53:22 -0700")
Message-ID: <87pnbr8phg.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTUUv-00068u-LG;;;mid=<87pnbr8phg.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19/UlenhLPHsqhEZAfwxw9ynR2w+0kVTag=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4714]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 392 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.8%), b_tie_ro: 9 (2.4%), parse: 0.87 (0.2%),
         extract_message_metadata: 19 (4.8%), get_uri_detail_list: 1.82 (0.5%),
         tests_pri_-1000: 15 (3.8%), tests_pri_-950: 1.28 (0.3%),
        tests_pri_-900: 1.03 (0.3%), tests_pri_-90: 92 (23.5%), check_bayes:
        82 (20.9%), b_tokenize: 7 (1.7%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 2.1 (0.5%), b_tok_touch_all: 64 (16.4%), b_finish: 0.81
        (0.2%), tests_pri_0: 239 (60.9%), check_dkim_signature: 0.63 (0.2%),
        check_dkim_adsp: 2.7 (0.7%), poll_dns_idle: 0.33 (0.1%), tests_pri_10:
        3.0 (0.8%), tests_pri_500: 8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 0/2] proc: Ensure we see the exit of each process tid exactly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Apr 28, 2020 at 5:20 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> In short I don't think this change will introduce any regressions.
>
> I think the series looks fine, but I also think the long explanation
> (that I snipped in this reply) in the cover letter should be there in
> the kernel tree.

When I have been adding patchsets like this to my tree I have been doing
merge --no-ff so I can create a place for explanations like this, and I
will do the same with this.

I already have Alexey Gladkov's proc changes, and my next_tgid cleanup
on a branch of proc changes in my tree already.

> So if you send me this as a single pull request, with that explanation
> (either in the email or in the signed tag - although you don't seem to
> use tags normally - so that we have that extra commentary for
> posterity, that sounds good.

I hope you don't mind if I combind this with some other proc changes.
If you do mind I will put this on a separate topic branch.

Right now it just seems easier for me to keep track of if I keep my
number of topics limited.

> That said, this fix seems to not matter for normal operation, so
> unless it's holding up something important, maybe it's 5.8 material?

Yes, this is 5.8 material.

I am just aiming to get review before I put in linux-next, and later
send it to your for merging.  I should have mentioned that in the cover
letter.

I am noticing that removing technical debt without adding more technical
debt is quite a challenge.

Eric


