Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865FC1D9A6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 16:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgESOw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 10:52:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37020 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbgESOw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 10:52:56 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb3bx-0008JE-F3; Tue, 19 May 2020 08:52:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb3bw-0007PX-LR; Tue, 19 May 2020 08:52:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <20200518055457.12302-1-keescook@chromium.org>
        <20200518055457.12302-2-keescook@chromium.org>
        <20200518130251.zih2s32q2rxhxg6f@wittgenstein>
        <CAG48ez1FspvvypJSO6badG7Vb84KtudqjRk1D7VyHRm06AiEbQ@mail.gmail.com>
        <20200518144627.sv5nesysvtgxwkp7@wittgenstein>
        <87blmk3ig4.fsf@x220.int.ebiederm.org> <87mu64uxq1.fsf@igel.home>
        <87sgfwuoi3.fsf@x220.int.ebiederm.org> <87eergunqs.fsf@igel.home>
        <87ftbwun0h.fsf@x220.int.ebiederm.org>
        <20200519132931.3b7yugfv2ajry6y7@wittgenstein>
Date:   Tue, 19 May 2020 09:49:11 -0500
In-Reply-To: <20200519132931.3b7yugfv2ajry6y7@wittgenstein> (Christian
        Brauner's message of "Tue, 19 May 2020 15:29:31 +0200")
Message-ID: <87lflot1y0.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb3bw-0007PX-LR;;;mid=<87lflot1y0.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+GoK2xVX0YWNeBbAsbjSkBSt5zCIxXph8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 351 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (2.9%), b_tie_ro: 9 (2.5%), parse: 0.77 (0.2%),
         extract_message_metadata: 12 (3.6%), get_uri_detail_list: 1.82 (0.5%),
         tests_pri_-1000: 20 (5.8%), tests_pri_-950: 1.03 (0.3%),
        tests_pri_-900: 0.79 (0.2%), tests_pri_-90: 58 (16.6%), check_bayes:
        57 (16.2%), b_tokenize: 7 (1.9%), b_tok_get_all: 8 (2.3%),
        b_comp_prob: 2.4 (0.7%), b_tok_touch_all: 37 (10.5%), b_finish: 0.69
        (0.2%), tests_pri_0: 237 (67.3%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.5 (0.7%), poll_dns_idle: 0.96 (0.3%), tests_pri_10:
        1.79 (0.5%), tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/4] exec: Change uselib(2) IS_SREG() failure to EACCES
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Tue, May 19, 2020 at 07:28:46AM -0500, Eric W. Biederman wrote:
>> Andreas Schwab <schwab@linux-m68k.org> writes:
>> 
>> > On Mai 19 2020, Eric W. Biederman wrote:
>> >
>> >> I am wondering if there are source trees for libc4 or libc5 around
>> >> anywhere that we can look at to see how usage of uselib evolved.
>> >
>> > libc5 is available from archive.debian.org.
>> >
>> > http://archive.debian.org/debian-archive/debian/pool/main/libc/libc/libc_5.4.46.orig.tar.gz
>> 
>> Interesting.
>> 
>> It appears that the old a.out code to make use of uselib remained in
>> the libc5 sources but it was all conditional on the being compiled not
>> to use ELF.
>> 
>> libc5 did provide a wrapper for the uselib system call.
>> 
>> It appears glibc also provides a wrapper for the uselib system call
>> named: uselib@GLIBC_2.2.5.
>> 
>> I don't see a glibc header file that provides a declaration for uselib
>> though.
>> 
>> So the question becomes did anyone use those glibc wrappers.
>
> The only software I could find was ski, the ia64 instruction set
> emulator, which apparently used to make use of this and when glibc
> removed they did:
>
> #define uselib(libname) syscall(__NR_uselib, libname)
>
> but they only define it for the sake of the internal syscall list they
> maintain so not actively using it. I just checked, ski is available on
> Fedora 31 and Fedora has USELIB disabled.
> Codesearch on Debian yields no users that actively use the syscall for
> anything.

I think there is a very good argument that no one builds libraries
usable with uselib anymore.  The ELF version requires a ET_EXEC binary
with one PT_LOAD segment that is loaded at a fixed virtual address.
This is a format that does not allow for relocation processing, the
loading executable has to ``know'' where the symbols are in the loaded
binary, and they have to be build to run at distinct virtual addresses.

I think I could conjure up some linker scripts to do that with no more
linker support than we use to build the kernel, but it is not easy to
maintain binaries and libraries like that as code changes.  Which is
why we switched to ELF in the first place.

I think the tooling challenges plus not being able to find anything
using uselib anymore make a solid argument for going to a distribution
and asking them to stop enabling CONFIG_USELIB in their kernels.

Eric


