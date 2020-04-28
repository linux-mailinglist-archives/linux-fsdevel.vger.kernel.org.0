Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F1F1BCBCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 21:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgD1S7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 14:59:25 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40408 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbgD1S7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:59:17 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTVRq-0006CO-SR; Tue, 28 Apr 2020 12:59:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTVRp-0008Dw-TJ; Tue, 28 Apr 2020 12:59:14 -0600
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
Date:   Tue, 28 Apr 2020 13:55:59 -0500
In-Reply-To: <CAHk-=wiBYMoimvtc_DrwKN5EaQ98AmPryqYX6a-UE_VGP6LMrw@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 28 Apr 2020 09:53:22 -0700")
Message-ID: <87zhav783k.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTVRp-0008Dw-TJ;;;mid=<87zhav783k.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+44fCaHUGC/vbIUsbeMqGGqVgZVm2JC/M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4947]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 431 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 10 (2.3%), parse: 0.99
        (0.2%), extract_message_metadata: 15 (3.5%), get_uri_detail_list: 0.82
        (0.2%), tests_pri_-1000: 26 (6.0%), tests_pri_-950: 1.40 (0.3%),
        tests_pri_-900: 1.22 (0.3%), tests_pri_-90: 139 (32.3%), check_bayes:
        137 (31.9%), b_tokenize: 5 (1.3%), b_tok_get_all: 15 (3.6%),
        b_comp_prob: 1.96 (0.5%), b_tok_touch_all: 111 (25.6%), b_finish: 1.06
        (0.2%), tests_pri_0: 224 (52.0%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 0.72 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 0/2] proc: Ensure we see the exit of each process tid exactly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Apr 28, 2020 at 5:20 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> In short I don't think this change will introduce any regressions.
>
> I think the series looks fine.

Mind if I translate that into

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
on the patches?

Eric
