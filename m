Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED747C517
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 18:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbhLURgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 12:36:07 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:40538 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240435AbhLURgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:36:07 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:44578)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mzj3V-009677-7v; Tue, 21 Dec 2021 10:36:05 -0700
Received: from ip68-227-161-49.om.om.cox.net ([68.227.161.49]:54094 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mzj3U-0048xo-5Q; Tue, 21 Dec 2021 10:36:04 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>,
        Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20211221021744.864115-1-longman@redhat.com>
        <87lf0e7y0k.fsf@email.froward.int.ebiederm.org>
        <4f67dc4c-7038-7dde-cad9-4feeaa6bc71b@redhat.com>
Date:   Tue, 21 Dec 2021 11:35:57 -0600
In-Reply-To: <4f67dc4c-7038-7dde-cad9-4feeaa6bc71b@redhat.com> (Waiman Long's
        message of "Tue, 21 Dec 2021 11:41:27 -0500")
Message-ID: <87czlp7tdu.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mzj3U-0048xo-5Q;;;mid=<87czlp7tdu.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.161.49;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX180lGSi0e9hseN5KMysEPq9tcqjvvxHmw4=
X-SA-Exim-Connect-IP: 68.227.161.49
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XMSubMetaSxObfu_03,XMSubMetaSx_00,XM_B_SpammyWords autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4710]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Waiman Long <longman@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 484 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.7 (1.0%), b_tie_ro: 3.3 (0.7%), parse: 1.18
        (0.2%), extract_message_metadata: 13 (2.6%), get_uri_detail_list: 3.3
        (0.7%), tests_pri_-1000: 4.2 (0.9%), tests_pri_-950: 1.08 (0.2%),
        tests_pri_-900: 0.85 (0.2%), tests_pri_-90: 71 (14.6%), check_bayes:
        69 (14.3%), b_tokenize: 7 (1.3%), b_tok_get_all: 9 (1.9%),
        b_comp_prob: 2.3 (0.5%), b_tok_touch_all: 48 (9.9%), b_finish: 0.75
        (0.2%), tests_pri_0: 375 (77.3%), check_dkim_signature: 0.47 (0.1%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 0.79 (0.2%), tests_pri_10:
        1.67 (0.3%), tests_pri_500: 10 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exec: Make suid_dumpable apply to SUID/SGID binaries irrespective of invoking users
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Adding a couple of other people who have expressed opinions on how
to mitigate this issue in the kernel.

Waiman Long <longman@redhat.com> writes:

> On 12/21/21 10:55, Eric W. Biederman wrote:
>> Waiman Long <longman@redhat.com> writes:
>>
>>> The begin_new_exec() function checks for SUID or SGID binaries by
>>> comparing effective uid and gid against real uid and gid and using
>>> the suid_dumpable sysctl parameter setting only if either one of them
>>> differs.
>>>
>>> In the special case that the uid and/or gid of the SUID/SGID binaries
>>> matches the id's of the user invoking it, the suid_dumpable is not
>>> used and SUID_DUMP_USER will be used instead. The documentation for the
>>> suid_dumpable sysctl parameter does not include that exception and so
>>> this will be an undocumented behavior.
>>>
>>> Eliminate this undocumented behavior by adding a flag in the linux_binprm
>>> structure to designate a SUID/SGID binary and use it for determining
>>> if the suid_dumpable setting should be applied or not.
>> I see that you are making the code match the documentation.
>> What harm/problems does this mismatch cause in practice?
>> What is the motivation for this change?
>>
>> I am trying to see the motivation but all I can see is that
>> in the case where suid and sgid do nothing in practice the code
>> does not change dumpable.  The point of dumpable is to refuse to
>> core dump when it is not safe.  In this case since nothing happened
>> in practice it is safe.
>>
>> So how does this matter in practice.  If there isn't a good
>> motivation my feel is that it is the documentation that needs to be
>> updated rather than the code.
>>
>> There are a lot of warts to the suid/sgid handling during exec.  This
>> just doesn't look like one of them
>
> This patch is a minor mitigation in response to the security
> vulnerability as posted in
> https://www.openwall.com/lists/oss-security/2021/10/20/2 (aka
> CVE-2021-3864). In particular, the Su PoC (tested on CentOS 7) showing
> that the su invokes /usr/sbin/unix_chkpwd which is also a SUID
> binary. The initial su invocation won't generate a core dump because
> the real uid and euid differs, but the second unix_chkpwd invocation
> will. This patch eliminates this hole by making sure that all SUID
> binaries follow suid_dumpable setting.

All that is required to take advantage of this vulnerability is
for an suid program to exec something that will coredump.  That
exec resets the dumpability.

While the example exploit is execing a suid program it is not required
that the exec'd program be suid.

This makes your proposed change is not a particularly effective mitigation.


The best idea I have seen to mitigate this from the kernel side is:

1) set RLIMIT_CORE to 0 during an suid exec
2) update do_coredump to honor an rlimit of 0 for pipes

Anecdotally this should not effect the common systems that pipe
coredumps into programs as those programs are reported to honor
RLIMIT_CORE of 0.  This needs to be verified.

If those programs do honor RLIMIT_CORE of 0 we won't have any user
visible changes if they never see coredumps from a program with a
RLIMIT_CORE of 0.


I have been meaning to audit userspace and see if the common coredump
catchers truly honor an RLIMIT_CORE of 0.  Unfortunately I have not
found time to do that yet.


Eric
