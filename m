Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B1D329283
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 21:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhCAUqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 15:46:48 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:47616 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242642AbhCAUom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:44:42 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lGpOT-006C0N-V3; Mon, 01 Mar 2021 13:43:54 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lGpOT-0003CY-2q; Mon, 01 Mar 2021 13:43:53 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
Date:   Mon, 01 Mar 2021 14:43:51 -0600
In-Reply-To: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
        (Ilya Lipnitskiy's message of "Sun, 28 Feb 2021 19:28:13 -0800")
Message-ID: <m1wnuqhaew.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lGpOT-0003CY-2q;;;mid=<m1wnuqhaew.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ZsUJ86c4hhhX5oCFbgiwx0LuN3v/uMm4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4725]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 539 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.1%), b_tie_ro: 10 (1.8%), parse: 1.21
        (0.2%), extract_message_metadata: 5 (1.0%), get_uri_detail_list: 3.0
        (0.6%), tests_pri_-1000: 3.5 (0.6%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 73 (13.6%), check_bayes:
        72 (13.3%), b_tokenize: 10 (1.8%), b_tok_get_all: 11 (2.0%),
        b_comp_prob: 3.4 (0.6%), b_tok_touch_all: 44 (8.1%), b_finish: 0.90
        (0.2%), tests_pri_0: 423 (78.5%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 1.04 (0.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: exec error: BUG: Bad rss-counter
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:

> Eric, All,
>
> The following error appears when running Linux 5.10.18 on an embedded
> MIPS mt7621 target:
> [    0.301219] BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:1
>
> Being a very generic error, I started digging and added a stack dump
> before the BUG:
> Call Trace:
> [<80008094>] show_stack+0x30/0x100
> [<8033b238>] dump_stack+0xac/0xe8
> [<800285e8>] __mmdrop+0x98/0x1d0
> [<801a6de8>] free_bprm+0x44/0x118
> [<801a86a8>] kernel_execve+0x160/0x1d8
> [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
> [<80003198>] ret_from_kernel_thread+0x14/0x1c
>
> So that's how I got to looking at fs/exec.c and noticed quite a few
> changes last year. Turns out this message only occurs once very early
> at boot during the very first call to kernel_execve. current->mm is
> NULL at this stage, so acct_arg_size() is effectively a no-op.

If you believe this is a new error you could bisect the kernel
to see which change introduced the behavior you are seeing.

> More digging, and I traced the RSS counter increment to:
> [<8015adb4>] add_mm_counter_fast+0xb4/0xc0
> [<80160d58>] handle_mm_fault+0x6e4/0xea0
> [<80158aa4>] __get_user_pages.part.78+0x190/0x37c
> [<8015992c>] __get_user_pages_remote+0x128/0x360
> [<801a6d9c>] get_arg_page+0x34/0xa0
> [<801a7394>] copy_string_kernel+0x194/0x2a4
> [<801a880c>] kernel_execve+0x11c/0x298
> [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
> [<80003198>] ret_from_kernel_thread+0x14/0x1c
>
> In fact, I also checked vma_pages(bprm->vma) and lo and behold it is set to 1.
>
> How is fs/exec.c supposed to handle implied RSS increments that happen
> due to page faults when discarding the bprm structure? In this case,
> the bug-generating kernel_execve call never succeeded, it returned -2,
> but I didn't trace exactly what failed.

Unless I am mistaken any left over pages should be purged by exit_mmap
which is called by mmput before mmput calls mmdrop.

AKA it looks very very fishy this happens and this does not look like
an execve error.

On the other hand it would be good to know why kernel_execve is failing.
Then the error handling paths could be scrutinized, and we can check to
see if everything that should happen on an error path does.

> Interestingly, this "BUG:" message is timing-dependent. If I wait a
> bit before calling free_bprm after bprm_execve the message seems to go
> away (there are 3 other cores running and calling into kernel_execve
> at the same time, so there is that). The error also only ever happens
> once (probably because no more page faults happen?).
>
> I don't know enough to propose a proper fix here. Is it decrementing
> the bprm->mm RSS counter to account for that page fault? Or is
> current->mm being NULL a bigger problem?

This is call_usermode_helper calls kernel_execve from a kernel thread
forked by kthreadd.  Which means current->mm == NULL is expected, and
current->active_mm == &init_mm.

Similarly I bprm->mm having an incremented RSS counter appears correct.

The question is why doesn't that count get consistently cleaned up.

> Apologies in advance, but I have looked hard and do not see a clear
> resolution for this even in the latest kernel code.

I may be blind but I see two possibilities.

1) There is a memory stomp that happens early on and bad timing causes
   the memory stomp to result in an elevated rss count.

2) There is a buggy error handling path, and whatever failure you are
    running into that early in boot walks through that buggy failure
    path.

I don't think this is a widespread issue or yours would not be the first
report like this I have seen.

The two productive paths I can see for tracing down your problem are:
1) git bisect (assuming you have a known good version)
2) Figuring out what exec failed.

I really think exec_mmap should have cleaned up anything in the mm.  So
the fact that it doesn't worries me.

Eric
