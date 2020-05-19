Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FC31D965D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 14:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgESMc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 08:32:29 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53264 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgESMc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 08:32:28 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb1Q2-0000vi-W0; Tue, 19 May 2020 06:32:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb1Q2-0007fz-6K; Tue, 19 May 2020 06:32:26 -0600
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
        <87sgfwuoi3.fsf@x220.int.ebiederm.org> <87eergunqs.fsf@igel.home>
Date:   Tue, 19 May 2020 07:28:46 -0500
In-Reply-To: <87eergunqs.fsf@igel.home> (Andreas Schwab's message of "Tue, 19
        May 2020 14:12:59 +0200")
Message-ID: <87ftbwun0h.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb1Q2-0007fz-6K;;;mid=<87ftbwun0h.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/TJHeqM7kG/mxWux7jgYWK9a5y1fosOwQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Andreas Schwab <schwab@linux-m68k.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 410 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.1 (1.0%), b_tie_ro: 2.8 (0.7%), parse: 0.65
        (0.2%), extract_message_metadata: 10 (2.4%), get_uri_detail_list: 0.95
        (0.2%), tests_pri_-1000: 4.3 (1.1%), tests_pri_-950: 1.08 (0.3%),
        tests_pri_-900: 0.87 (0.2%), tests_pri_-90: 206 (50.2%), check_bayes:
        200 (48.7%), b_tokenize: 5 (1.2%), b_tok_get_all: 6 (1.4%),
        b_comp_prob: 1.44 (0.3%), b_tok_touch_all: 184 (44.9%), b_finish: 0.75
        (0.2%), tests_pri_0: 171 (41.6%), check_dkim_signature: 0.62 (0.2%),
        check_dkim_adsp: 4.1 (1.0%), poll_dns_idle: 0.04 (0.0%), tests_pri_10:
        2.8 (0.7%), tests_pri_500: 8 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/4] exec: Change uselib(2) IS_SREG() failure to EACCES
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Mai 19 2020, Eric W. Biederman wrote:
>
>> I am wondering if there are source trees for libc4 or libc5 around
>> anywhere that we can look at to see how usage of uselib evolved.
>
> libc5 is available from archive.debian.org.
>
> http://archive.debian.org/debian-archive/debian/pool/main/libc/libc/libc_5.4.46.orig.tar.gz

Interesting.

It appears that the old a.out code to make use of uselib remained in
the libc5 sources but it was all conditional on the being compiled not
to use ELF.

libc5 did provide a wrapper for the uselib system call.

It appears glibc also provides a wrapper for the uselib system call
named: uselib@GLIBC_2.2.5.

I don't see a glibc header file that provides a declaration for uselib
though.

So the question becomes did anyone use those glibc wrappers.

Eric


