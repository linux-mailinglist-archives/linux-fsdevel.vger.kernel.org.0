Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D276D1D95C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 14:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgESMA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 08:00:29 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55794 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgESMA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 08:00:28 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb0v1-00053s-PB; Tue, 19 May 2020 06:00:23 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb0uu-0004Bg-MP; Tue, 19 May 2020 06:00:23 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
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
Date:   Tue, 19 May 2020 06:56:36 -0500
In-Reply-To: <87mu64uxq1.fsf@igel.home> (Andreas Schwab's message of "Tue, 19
        May 2020 10:37:26 +0200")
Message-ID: <87sgfwuoi3.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb0uu-0004Bg-MP;;;mid=<87sgfwuoi3.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18KHCvzrkAL+KkT291e5MaUNnZX1ztiKf4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,TR_Symld_Words,
        T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Andreas Schwab <schwab@linux-m68k.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 6659 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.5 (0.1%), b_tie_ro: 3.1 (0.0%), parse: 1.01
        (0.0%), extract_message_metadata: 10 (0.2%), get_uri_detail_list: 0.90
        (0.0%), tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.08 (0.0%),
        tests_pri_-900: 0.85 (0.0%), tests_pri_-90: 49 (0.7%), check_bayes: 48
        (0.7%), b_tokenize: 4.2 (0.1%), b_tok_get_all: 6 (0.1%), b_comp_prob:
        1.48 (0.0%), b_tok_touch_all: 34 (0.5%), b_finish: 0.59 (0.0%),
        tests_pri_0: 6178 (92.8%), check_dkim_signature: 0.35 (0.0%),
        check_dkim_adsp: 6008 (90.2%), poll_dns_idle: 6398 (96.1%),
        tests_pri_10: 2.6 (0.0%), tests_pri_500: 406 (6.1%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 1/4] exec: Change uselib(2) IS_SREG() failure to EACCES
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Mai 18 2020, Eric W. Biederman wrote:
>
>> If it was only libc4 and libc5 that used the uselib system call then it
>> can probably be removed after enough time.
>
> Only libc4 used it, libc5 was already ELF.

binfmt_elf.c supports uselib.  In a very a.out ish way.  Do you know if
that support was ever used?

If we are truly talking a.out only we should be able to make uselib
conditional on a.out support in the kernel which is strongly mostly
disabled at this point.

I am wondering if there are source trees for libc4 or libc5 around
anywhere that we can look at to see how usage of uselib evolved.

Eric
