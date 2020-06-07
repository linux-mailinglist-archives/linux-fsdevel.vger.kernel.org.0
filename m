Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E31F0CD5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgFGQOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jun 2020 12:14:05 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51184 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgFGQOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:14:04 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jhxvp-0002cG-P9; Sun, 07 Jun 2020 10:13:57 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jhxvo-00019j-Gk; Sun, 07 Jun 2020 10:13:57 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
        <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
        <202006051903.C44988B@keescook>
        <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
        <20200606201956.rvfanoqkevjcptfl@ast-mbp>
        <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
        <20200607014935.vhd3scr4qmawq7no@ast-mbp>
        <CAHk-=wiUjZV5VmdqUOGjpNMmobGQKyZpaa=MuJ-5XM3Da86zBg@mail.gmail.com>
Date:   Sun, 07 Jun 2020 11:09:52 -0500
In-Reply-To: <CAHk-=wiUjZV5VmdqUOGjpNMmobGQKyZpaa=MuJ-5XM3Da86zBg@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 6 Jun 2020 19:19:56 -0700")
Message-ID: <87zh9e6enj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jhxvo-00019j-Gk;;;mid=<87zh9e6enj.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+muq+Q+C7rIVT84MbZG4uY5MVdL5DGEpI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 498 ms - load_scoreonly_sql: 0.15 (0.0%),
        signal_user_changed: 12 (2.4%), b_tie_ro: 10 (2.0%), parse: 1.66
        (0.3%), extract_message_metadata: 20 (4.1%), get_uri_detail_list: 3.2
        (0.6%), tests_pri_-1000: 8 (1.6%), tests_pri_-950: 1.47 (0.3%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 84 (16.9%), check_bayes:
        82 (16.5%), b_tokenize: 9 (1.9%), b_tok_get_all: 10 (1.9%),
        b_comp_prob: 3.1 (0.6%), b_tok_touch_all: 56 (11.2%), b_finish: 0.93
        (0.2%), tests_pri_0: 354 (71.1%), check_dkim_signature: 0.97 (0.2%),
        check_dkim_adsp: 3.3 (0.7%), poll_dns_idle: 0.79 (0.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 8 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Jun 6, 2020 at 6:49 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>>
>> I'm not aware of execve issues. I don't remember being cc-ed on them.
>> To me this 'lets remove everything' patch comes out of nowhere with
>> a link to three month old patch as a justification.
>
> Well, it's out of nowhere as far as bpf is concerned, but we've had a
> fair amount of discussions about execve cleanups (and a fair amount of
> work too, not just discussion) lately
>
> So it comes out of "execve is rather grotty", and trying to make it
> simpler have fewer special cases.
>
>> So far we had two attempts at converting netfilter rules to bpf. Both ended up
>> with user space implementation and short cuts.
>
> So I have a question: are we convinced that doing this "netfilter
> conversion" in user space is required at all?
>
> I realize that yes, running clang is not something we'd want to do in
> kernel space, that's not what I'm asking.
>
> But how much might be doable at kernel compile time (run clang to
> generate bpf statically when building the kernel) together with some
> simplistic run-time parameterized JITting for the table details that
> the kernel could do on its own without a real compiler?
>
> Because the problem with this code isn't the "use bpf for netfilter
> rules", it's the "run a user mode helper". The execve thing is
> actually only incidental, it also ends up being a somewhat interesting
> issue wrt namespacing and security (and bootstrapping - I'm not
> convinced people want to have a clang bpf compiler in initrd etc).
>
> So particularly if we accept the fact that we won't necessarily need
> all of netfilter converted in general - some will be just translated
> entirely independently in user space and not use netfilter at all
> (just bpf loaded normally)
>
> IOW there would potentially only be a (fairly small?) core set that
> the kernel would need to be able to handle "natively".
>
> Am I just blathering?

I wish I could answer you.

All the code does at this time is connect some ipv4 bpfilter specific
setsockopt commands to a usermode helper with a read pipe and a write
pipe.  The userspace portion does absolutely nothing with those
commands.

I don't have the foggiest idea what that code hopes to be doing when
that code is fully fleshed out.

If the goal is to become a backwards compatible compiler from historic
netfilter commands to bpf it isn't the craziest design in the world.
But that isn't what is implemented today.

With no users it just isn't clear what the code needs to be doing so I
can't tell what needs to be done to bugs in the code.  I can't answer
which behaviors do the users care about.

Eric
