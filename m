Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A6E1D9FEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 20:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgESSqM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 14:46:12 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60656 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESSqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 14:46:12 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7Fi-0005kT-4o; Tue, 19 May 2020 12:46:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7Fh-00056u-AM; Tue, 19 May 2020 12:46:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200518055457.12302-1-keescook@chromium.org>
        <87a724t153.fsf@x220.int.ebiederm.org>
        <202005190918.D2BD83F7C@keescook>
        <87o8qjstyw.fsf@x220.int.ebiederm.org>
        <202005191052.0A6B1D5843@keescook>
Date:   Tue, 19 May 2020 13:42:28 -0500
In-Reply-To: <202005191052.0A6B1D5843@keescook> (Kees Cook's message of "Tue,
        19 May 2020 10:56:08 -0700")
Message-ID: <87sgfvrckr.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb7Fh-00056u-AM;;;mid=<87sgfvrckr.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18MccEeDar1/0mLamXCyDMxW4fspzZPKe8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1588]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 433 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 10 (2.2%), parse: 1.40
        (0.3%), extract_message_metadata: 20 (4.7%), get_uri_detail_list: 2.8
        (0.6%), tests_pri_-1000: 9 (2.1%), tests_pri_-950: 2.1 (0.5%),
        tests_pri_-900: 1.84 (0.4%), tests_pri_-90: 81 (18.7%), check_bayes:
        79 (18.2%), b_tokenize: 12 (2.8%), b_tok_get_all: 10 (2.2%),
        b_comp_prob: 4.6 (1.1%), b_tok_touch_all: 47 (10.9%), b_finish: 1.10
        (0.3%), tests_pri_0: 289 (66.8%), check_dkim_signature: 1.10 (0.3%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 0.49 (0.1%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 9 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/4] Relocate execve() sanity checks
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, May 19, 2020 at 12:41:27PM -0500, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> > and given the LSM hooks, I think the noexec check is too late as well.
>> > (This is especially true for the coming O_MAYEXEC series, which will
>> > absolutely need those tests earlier as well[1] -- the permission checking
>> > is then in the correct place: during open, not exec.) I think the only
>> > question is about leaving the redundant checks in fs/exec.c, which I
>> > think are a cheap way to retain a sense of robustness.
>> 
>> The trouble is when someone passes through changes one of the permission
>> checks for whatever reason (misses that they are duplicated in another
>> location) and things then fail in some very unexpected way.
>
> Do you think this series should drop the "late" checks in fs/exec.c?
> Honestly, the largest motivation for me to move the checks earlier as
> I've done is so that other things besides execve() can use FMODE_EXEC
> during open() and receive the same sanity-checking as execve() (i.e the
> O_MAYEXEC series -- the details are still under discussion but this
> cleanup will be needed regardless).

I think this series should drop the "late" checks in fs/exec.c  It feels
less error prone, and it feels like that would transform this into
something Linus would be eager to merge because series becomes a cleanup
that reduces line count.

I haven't been inside of open recently enough to remember if the
location you are putting the check fundamentally makes sense.  But the
O_MAYEXEC bits make a pretty strong case that something of the sort
needs to happen.

I took a quick look but I can not see clearly where path_noexec
and the regular file tests should go.

I do see that you have code duplication with faccessat which suggests
that you haven't put the checks in the right place.

I am wondering if we need something distinct to request the type of the
file being opened versus execute permissions.

All I know is being careful and putting the tests in a good logical
place makes the code more maintainable, whereas not being careful
results in all kinds of sharp corners that might be exploitable.
So I think it is worth digging in and figuring out where those checks
should live.  Especially so that code like faccessat does not need
to duplicate them.

Eric

