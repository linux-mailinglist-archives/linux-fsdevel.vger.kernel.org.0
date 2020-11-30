Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2692C901F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 22:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgK3VjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 16:39:00 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50834 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgK3Vi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:38:59 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kjqsC-001UG6-3z; Mon, 30 Nov 2020 14:38:16 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kjqsB-002aGy-5i; Mon, 30 Nov 2020 14:38:15 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Geoff Levand <geoff@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
        <20201120231441.29911-2-ebiederm@xmission.com>
        <20201123175052.GA20279@redhat.com>
        <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
        <87im9vx08i.fsf@x220.int.ebiederm.org>
        <87pn42r0n7.fsf@x220.int.ebiederm.org>
        <CAHk-=wi-h8y5MK83DA6Vz2TDSQf4eEadddhWLTT_94bP996=Ug@mail.gmail.com>
        <CAK8P3a3z1tZSSSyK=tZOkUTqXvewJgd6ntHMysY0gGQ7hPWwfw@mail.gmail.com>
        <ed83033f-80af-5be0-ecbe-f2bf5c2075e9@infradead.org>
        <877dqap76p.fsf@x220.int.ebiederm.org>
        <CAK8P3a0hPG1cTxksTBCJHkAV_=TLZLCi2pZYMk2Dc2-kLzD3rg@mail.gmail.com>
Date:   Mon, 30 Nov 2020 15:37:45 -0600
In-Reply-To: <CAK8P3a0hPG1cTxksTBCJHkAV_=TLZLCi2pZYMk2Dc2-kLzD3rg@mail.gmail.com>
        (Arnd Bergmann's message of "Fri, 27 Nov 2020 21:29:33 +0100")
Message-ID: <87o8jeh6fq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kjqsB-002aGy-5i;;;mid=<87o8jeh6fq.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/cLPgLNNg/8c6pqCnXbBCnlUkV3ILlp1o=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Arnd Bergmann <arnd@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 412 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (0.9%), b_tie_ro: 2.6 (0.6%), parse: 0.71
        (0.2%), extract_message_metadata: 9 (2.1%), get_uri_detail_list: 1.82
        (0.4%), tests_pri_-1000: 10 (2.5%), tests_pri_-950: 1.00 (0.2%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 65 (15.7%), check_bayes:
        64 (15.4%), b_tokenize: 7 (1.6%), b_tok_get_all: 9 (2.1%),
        b_comp_prob: 2.3 (0.5%), b_tok_touch_all: 43 (10.5%), b_finish: 0.66
        (0.2%), tests_pri_0: 310 (75.1%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.84 (0.2%), tests_pri_10:
        2.7 (0.6%), tests_pri_500: 8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 02/24] exec: Simplify unshare_files
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> On Wed, Nov 25, 2020 at 2:16 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> > On 11/24/20 12:14 PM, Arnd Bergmann wrote:
>> >
>> > There are still PS3-Linux users out there.  They use 'Homebrew' firmware
>> > released through 'Hacker' forums that allow them to run Linux on
>> > non-supported systems.  They are generally hobbies who don't post to
>> > Linux kernel mailing lists.  I get direct inquiries regularly asking
>> > about how to update to a recent kernel.  One of the things that attract
>> > them to the PS3 is the Cell processor and either using or programming
>> > the SPUs.
>> >
>> > It is difficult to judge how much use the SPU core dump support gets,
>> > but if it is not a cause of major problems I feel we should consider
>> > keeping it.
>>
>> I just took a quick look to get a sense how much tool support there is.
>>
>> In the gdb tree I found this 2019 commit abf516c6931a ("Remove Cell
>> Broadband Engine debugging support").  Which basically removes the code
>> in gdb that made sense of the spu coredumps.
>
> Ah, I had not realized this was gone already. The code in gdb for
> seamlessly debugging programs across CPU and SPU was clearly
> more complex than the kernel portion for the coredump, so it makes
> sense this was removed eventually.
>
>> I would not say the coredump support is a source major problems, but it
>> is a challenge to understand.  One of the pieces of code in there that
>> is necessary to make the coredump support work reliable, a call to
>> unshare_files, Oleg whole essentially maintains the ptrace and coredump
>> support did not know why it was there, and it was not at all obvious
>> when I looked at the code.
>>
>> So we are certainly in maintainers loosing hours of time figuring out
>> what is going on and spending time fixing fuzzer bugs related to the
>> code.
>
> I also spent some amount of time on this code earlier this year Christoph
> did some refactoring, and we could both have used that time better.
>
>> At the minimum I will add a few more comments so people reading the code
>> can realize why it is there.   Perhaps putting the relevant code behind
>> a Kconfig so it is only built into the kernel when spufs is present.
>>
>> I think we are at a point we we can start planning on removing the
>> coredump support.  The tools to read it are going away.  None of what is
>> there is bad, but it is definitely a special case, and it definitely has
>> a maintenance cost.
>
> How about adding a comment in the coredump code so it can get
> removed the next time someone comes across it during refactoring,
> or when they find a bug that can't easily be worked around?

Did my proposed patch look ok?

> That way there is still a chance of using it where needed, but
> hopefully it won't waste anyone's time when it gets in the way.

Sounds good to me.

> If there are no objections, I can also send a patch to remove
> CONFIG_PPC_CELL_NATIVE, PPC_IBM_CELL_BLADE and
> everything that depends on those symbols, leaving only the
> bits needed by ps3 in the arch/powerpc/platforms/cell directory.

That also seems reasonable.  My read of the history suggests that
code has been out of commission for a decade or so, and not having it to
trip over (just present in the history) seems very reasonable.

Eric
