Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC1E1D9E1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 19:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgESRpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 13:45:11 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44348 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESRpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 13:45:11 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb6Ie-0003RI-Nx; Tue, 19 May 2020 11:45:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb6Id-0004jU-PA; Tue, 19 May 2020 11:45:08 -0600
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
Date:   Tue, 19 May 2020 12:41:27 -0500
In-Reply-To: <202005190918.D2BD83F7C@keescook> (Kees Cook's message of "Tue,
        19 May 2020 09:26:04 -0700")
Message-ID: <87o8qjstyw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb6Id-0004jU-PA;;;mid=<87o8qjstyw.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/BewoOodAlU9s75IVSjo2e3P/HkeoZRsY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4326]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 569 ms - load_scoreonly_sql: 0.41 (0.1%),
        signal_user_changed: 12 (2.1%), b_tie_ro: 10 (1.7%), parse: 1.16
        (0.2%), extract_message_metadata: 15 (2.7%), get_uri_detail_list: 2.1
        (0.4%), tests_pri_-1000: 6 (1.0%), tests_pri_-950: 1.37 (0.2%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 228 (40.2%), check_bayes:
        217 (38.2%), b_tokenize: 9 (1.5%), b_tok_get_all: 9 (1.5%),
        b_comp_prob: 3.7 (0.6%), b_tok_touch_all: 192 (33.8%), b_finish: 1.02
        (0.2%), tests_pri_0: 290 (50.9%), check_dkim_signature: 0.66 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 0.57 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/4] Relocate execve() sanity checks
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, May 19, 2020 at 10:06:32AM -0500, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> 
>> > Hi,
>> >
>> > While looking at the code paths for the proposed O_MAYEXEC flag, I saw
>> > some things that looked like they should be fixed up.
>> >
>> >   exec: Change uselib(2) IS_SREG() failure to EACCES
>> > 	This just regularizes the return code on uselib(2).
>> >
>> >   exec: Relocate S_ISREG() check
>> > 	This moves the S_ISREG() check even earlier than it was already.
>> >
>> >   exec: Relocate path_noexec() check
>> > 	This adds the path_noexec() check to the same place as the
>> > 	S_ISREG() check.
>> >
>> >   fs: Include FMODE_EXEC when converting flags to f_mode
>> > 	This seemed like an oversight, but I suspect there is some
>> > 	reason I couldn't find for why FMODE_EXEC doesn't get set in
>> > 	f_mode and just stays in f_flags.
>> 
>> So I took a look at this series.
>> 
>> I think the belt and suspenders approach of adding code in open and then
>> keeping it in exec and uselib is probably wrong.  My sense of the
>> situation is a belt and suspenders approach is more likely to be
>> confusing and result in people making mistakes when maintaining the code
>> than to actually be helpful.
>
> This is why I added the comments in fs/exec.c's redundant checks. When I
> was originally testing this series, I had entirely removed the checks in
> fs/exec.c, but then had nightmares about some kind of future VFS paths
> that would somehow bypass do_open() and result in execve() working on
> noexec mounts, there by allowing for the introduction of a really nasty
> security bug.
>
> The S_ISREG test is demonstrably too late (as referenced in the series),

Yes.  The open of a pipe very much happens when it should not.

The deadlock looks like part of the cred_guard_mutex mess.  I think I
introduced an alternate solution for the specific code paths in the
backtrace when I introduced exec_update_mutex.

The fact that cred_guard_mutex is held over open, while at the same time
cred_guard_mutex is grabbed on open files is very questionable.  Until
my most recent patchset feeding exec /proc/self/maps would also deadlock
this way.

> and given the LSM hooks, I think the noexec check is too late as well.
> (This is especially true for the coming O_MAYEXEC series, which will
> absolutely need those tests earlier as well[1] -- the permission checking
> is then in the correct place: during open, not exec.) I think the only
> question is about leaving the redundant checks in fs/exec.c, which I
> think are a cheap way to retain a sense of robustness.

The trouble is when someone passes through changes one of the permission
checks for whatever reason (misses that they are duplicated in another
location) and things then fail in some very unexpected way.

Eric
