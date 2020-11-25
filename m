Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A222C362A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 02:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgKYBQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 20:16:45 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:33198 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgKYBQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 20:16:44 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1khjQH-00DP0u-OF; Tue, 24 Nov 2020 18:16:41 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1khjQE-006zGz-6X; Tue, 24 Nov 2020 18:16:41 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Geoff Levand <geoff@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
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
Date:   Tue, 24 Nov 2020 19:16:14 -0600
In-Reply-To: <ed83033f-80af-5be0-ecbe-f2bf5c2075e9@infradead.org> (Geoff
        Levand's message of "Tue, 24 Nov 2020 15:44:50 -0800")
Message-ID: <877dqap76p.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1khjQE-006zGz-6X;;;mid=<877dqap76p.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19yr+iR8zQMQYApk63ErxsqFDsoyfNFS0o=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Geoff Levand <geoff@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2903 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (0.4%), b_tie_ro: 9 (0.3%), parse: 0.92 (0.0%),
         extract_message_metadata: 18 (0.6%), get_uri_detail_list: 2.1 (0.1%),
        tests_pri_-1000: 15 (0.5%), tests_pri_-950: 1.20 (0.0%),
        tests_pri_-900: 1.03 (0.0%), tests_pri_-90: 92 (3.2%), check_bayes: 84
        (2.9%), b_tokenize: 8 (0.3%), b_tok_get_all: 10 (0.3%), b_comp_prob:
        3.1 (0.1%), b_tok_touch_all: 58 (2.0%), b_finish: 0.87 (0.0%),
        tests_pri_0: 320 (11.0%), check_dkim_signature: 0.53 (0.0%),
        check_dkim_adsp: 3.4 (0.1%), poll_dns_idle: 2422 (83.4%),
        tests_pri_10: 2.4 (0.1%), tests_pri_500: 2439 (84.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v2 02/24] exec: Simplify unshare_files
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Geoff Levand <geoff@infradead.org> writes:

> On 11/24/20 12:14 PM, Arnd Bergmann wrote:
>> On Tue, Nov 24, 2020 at 8:58 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> On Tue, Nov 24, 2020 at 11:55 AM Eric W. Biederman
>>> <ebiederm@xmission.com> wrote:
>>>>
>>>> If cell happens to be dead we can remove a fair amount of generic kernel
>>>> code that only exists to support cell.
>>>
>>> Even if some people might still use cell (which sounds unlikely), I
>>> think we can remove the spu core dumping code.
>> 
>> The Cell blade hardware (arch/powerpc/platforms/cell/) that I'm listed
>> as a maintainer for is very much dead, but there is apparently still some
>> activity on the Playstation 3 that Geoff Levand maintains.
>> 
>> Eric correctly points out that the PS3 firmware no longer boots
>> Linux (OtherOS), but AFAIK there are both users with old firmware
>> and those that use a firmware exploit to run homebrew code including
>> Linux.
>> 
>> I would assume they still use the SPU and might also use the core
>> dump code in particular. Let's see what Geoff thinks.
>
> There are still PS3-Linux users out there.  They use 'Homebrew' firmware
> released through 'Hacker' forums that allow them to run Linux on
> non-supported systems.  They are generally hobbies who don't post to
> Linux kernel mailing lists.  I get direct inquiries regularly asking
> about how to update to a recent kernel.  One of the things that attract
> them to the PS3 is the Cell processor and either using or programming
> the SPUs.
>
> It is difficult to judge how much use the SPU core dump support gets,
> but if it is not a cause of major problems I feel we should consider
> keeping it.

I just took a quick look to get a sense how much tool support there is.

In the gdb tree I found this 2019 commit abf516c6931a ("Remove Cell
Broadband Engine debugging support").  Which basically removes the code
in gdb that made sense of the spu coredumps.

I would not say the coredump support is a source major problems, but it
is a challenge to understand.  One of the pieces of code in there that
is necessary to make the coredump support work reliable, a call to
unshare_files, Oleg whole essentially maintains the ptrace and coredump
support did not know why it was there, and it was not at all obvious
when I looked at the code.

So we are certainly in maintainers loosing hours of time figuring out
what is going on and spending time fixing fuzzer bugs related to the
code.

At the minimum I will add a few more comments so people reading the code
can realize why it is there.   Perhaps putting the relevant code behind
a Kconfig so it is only built into the kernel when spufs is present.

I think we are at a point we we can start planning on removing the
coredump support.  The tools to read it are going away.  None of what is
there is bad, but it is definitely a special case, and it definitely has
a maintenance cost.

Eric


