Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FB51D21AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 00:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgEMWDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 18:03:17 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51938 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729775AbgEMWDQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 18:03:16 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYzT4-00009V-MU; Wed, 13 May 2020 16:03:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYzT3-0004MR-Ko; Wed, 13 May 2020 16:03:10 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Rob Landley <rob@landley.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>, dalias@libc.org
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <87eerszyim.fsf_-_@x220.int.ebiederm.org>
        <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
        <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
        <87sgg6v8we.fsf@x220.int.ebiederm.org>
        <f33135b7-caa2-94f3-7563-fab6a1f5da0f@landley.net>
Date:   Wed, 13 May 2020 16:59:35 -0500
In-Reply-To: <f33135b7-caa2-94f3-7563-fab6a1f5da0f@landley.net> (Rob Landley's
        message of "Mon, 11 May 2020 14:10:23 -0500")
Message-ID: <87ftc3lcmw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jYzT3-0004MR-Ko;;;mid=<87ftc3lcmw.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/bb/zy/n+ThDhzZ1lqWLBaPDs3XJ/oeMk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Rob Landley <rob@landley.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 419 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.7%), b_tie_ro: 10 (2.4%), parse: 0.99
        (0.2%), extract_message_metadata: 13 (3.2%), get_uri_detail_list: 1.48
        (0.4%), tests_pri_-1000: 7 (1.7%), tests_pri_-950: 1.54 (0.4%),
        tests_pri_-900: 1.25 (0.3%), tests_pri_-90: 65 (15.5%), check_bayes:
        63 (15.0%), b_tokenize: 9 (2.1%), b_tok_get_all: 9 (2.1%),
        b_comp_prob: 2.9 (0.7%), b_tok_touch_all: 38 (9.1%), b_finish: 1.18
        (0.3%), tests_pri_0: 305 (72.8%), check_dkim_signature: 1.07 (0.3%),
        check_dkim_adsp: 2.5 (0.6%), poll_dns_idle: 0.76 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rob Landley <rob@landley.net> writes:

> On 5/11/20 9:33 AM, Eric W. Biederman wrote:
>> What I do see is that interp_data is just a parameter that is smuggled
>> into the call of search binary handler.  And the next binary handler
>> needs to be binfmt_elf for it to make much sense, as only binfmt_elf
>> (and binfmt_elf_fdpic) deals with BINPRM_FLAGS_EXECFD.
>
> The binfmt_elf_fdpic driver is separate from binfmt_elf for the same reason
> ext2/ext3/ext4 used to have 3 drivers: fdpic is really just binfmt_elf with the
> 4 main sections (text, data, bss, rodata) able to move independently of each
> other (each tracked with its own base pointer).
>
> It's kind of -fPIE on steroids, and various security people have sniffed at it
> over the years to give ASLR more degrees of freedom on with-MMU systems. Many
> moons ago Rich Felker proposed teaching the fdpic loader how to load normal ELF
> binaries so there's just the one loader (there's a flag in the ELF header to say
> whether the sections are independent or not).

Careful with your terminology.  ELF sections are for .o's For
executables ELF have segments.  And reading through the code it is the
program segments that are independently relocatable.

There is a flag but it is defined per architecture and I don't think one
of the architectures define it.

I looked at ARM and apparently with an MMU ARM turns fdpic binaries into
PIE executables.  I am not certain why.

The registers passed to the entry point are also different for both
cases.

I think it would have been nice if the fdpic support had used a
different ELF type, instead of a different depending on using a
different architecture.

All that aside the core dumping code looks to be essentially the same
between binfmt_elf.c and binfmt_elf_fdpic.c.  Do you think people would
be interested in refactoring binfmt_elf.c and binfmt_elf_fdpic.c so that
they could share the same core dumping code?

Eric
