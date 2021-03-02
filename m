Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA06332B4D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450123AbhCCFaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:30:16 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:54408 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1836513AbhCBUJe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:09:34 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lHApo-008erx-4l; Tue, 02 Mar 2021 12:37:32 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lHApn-0003YR-5S; Tue, 02 Mar 2021 12:37:32 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
        <m1wnuqhaew.fsf@fess.ebiederm.org>
        <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
Date:   Tue, 02 Mar 2021 13:37:30 -0600
In-Reply-To: <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
        (Ilya Lipnitskiy's message of "Mon, 1 Mar 2021 23:59:36 -0800")
Message-ID: <m1blc1gxdx.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lHApn-0003YR-5S;;;mid=<m1blc1gxdx.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+S5nebCJXRDYw+vNfn8hVxJO/OOiW8n5E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 564 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 9 (1.6%), b_tie_ro: 8 (1.3%), parse: 1.27 (0.2%),
        extract_message_metadata: 14 (2.6%), get_uri_detail_list: 2.8 (0.5%),
        tests_pri_-1000: 14 (2.5%), tests_pri_-950: 1.44 (0.3%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 120 (21.3%), check_bayes:
        118 (21.0%), b_tokenize: 11 (1.9%), b_tok_get_all: 9 (1.6%),
        b_comp_prob: 3.4 (0.6%), b_tok_touch_all: 91 (16.1%), b_finish: 1.04
        (0.2%), tests_pri_0: 382 (67.8%), check_dkim_signature: 0.73 (0.1%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.53 (0.1%), tests_pri_10:
        3.2 (0.6%), tests_pri_500: 13 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: exec error: BUG: Bad rss-counter
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:

> On Mon, Mar 1, 2021 at 12:43 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
>>
>> > Eric, All,
>> >
>> > The following error appears when running Linux 5.10.18 on an embedded
>> > MIPS mt7621 target:
>> > [    0.301219] BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:1
>> >
>> > Being a very generic error, I started digging and added a stack dump
>> > before the BUG:
>> > Call Trace:
>> > [<80008094>] show_stack+0x30/0x100
>> > [<8033b238>] dump_stack+0xac/0xe8
>> > [<800285e8>] __mmdrop+0x98/0x1d0
>> > [<801a6de8>] free_bprm+0x44/0x118
>> > [<801a86a8>] kernel_execve+0x160/0x1d8
>> > [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
>> > [<80003198>] ret_from_kernel_thread+0x14/0x1c
>> >
>> > So that's how I got to looking at fs/exec.c and noticed quite a few
>> > changes last year. Turns out this message only occurs once very early
>> > at boot during the very first call to kernel_execve. current->mm is
>> > NULL at this stage, so acct_arg_size() is effectively a no-op.
>>
>> If you believe this is a new error you could bisect the kernel
>> to see which change introduced the behavior you are seeing.
>>
>> > More digging, and I traced the RSS counter increment to:
>> > [<8015adb4>] add_mm_counter_fast+0xb4/0xc0
>> > [<80160d58>] handle_mm_fault+0x6e4/0xea0
>> > [<80158aa4>] __get_user_pages.part.78+0x190/0x37c
>> > [<8015992c>] __get_user_pages_remote+0x128/0x360
>> > [<801a6d9c>] get_arg_page+0x34/0xa0
>> > [<801a7394>] copy_string_kernel+0x194/0x2a4
>> > [<801a880c>] kernel_execve+0x11c/0x298
>> > [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
>> > [<80003198>] ret_from_kernel_thread+0x14/0x1c
>> >
>> > In fact, I also checked vma_pages(bprm->vma) and lo and behold it is set to 1.
>> >
>> > How is fs/exec.c supposed to handle implied RSS increments that happen
>> > due to page faults when discarding the bprm structure? In this case,
>> > the bug-generating kernel_execve call never succeeded, it returned -2,
>> > but I didn't trace exactly what failed.
>>
>> Unless I am mistaken any left over pages should be purged by exit_mmap
>> which is called by mmput before mmput calls mmdrop.
> Good to know. Some more digging and I can say that we hit this error
> when trying to unmap PFN 0 (is_zero_pfn(pfn) returns TRUE,
> vm_normal_page returns NULL, zap_pte_range does not decrement
> MM_ANONPAGES RSS counter). Is my understanding correct that PFN 0 is
> usable, but special? Or am I totally off the mark here?

It would be good to know if that is the page that get_user_pages_remote
returned to copy_string_kernel.  The zero page that is always zero,
should never be returned when a writable mapping is desired.

> Here is the (optimized) stack trace when the counter does not get decremented:
> [<8015b078>] vm_normal_page+0x114/0x1a8
> [<8015dc98>] unmap_page_range+0x388/0xacc
> [<8015e5a0>] unmap_vmas+0x6c/0x98
> [<80166194>] exit_mmap+0xd8/0x1ac
> [<800290c0>] mmput+0x58/0xf8
> [<801a6f8c>] free_bprm+0x2c/0xc4
> [<801a8890>] kernel_execve+0x160/0x1d8
> [<800420e0>] call_usermodehelper_exec_async+0x114/0x194
> [<80003198>] ret_from_kernel_thread+0x14/0x1c
>
>>
>> AKA it looks very very fishy this happens and this does not look like
>> an execve error.
> I think you are right, I'm probably wrong to bother you. However,
> since the thread is already started, let me add linux-mm here :)

It happens during exec.  I don't mind looking and pointing you a useful
direction.

>>
>> On the other hand it would be good to know why kernel_execve is failing.
>> Then the error handling paths could be scrutinized, and we can check to
>> see if everything that should happen on an error path does.
> I can check on this, but likely it's the init system not doing things
> quite in the right order on my platform, or something similar. The
> error is ENOENT from do_open_execat().

That does narrow things down considerably.
After the error all we do is:
Clear in_execve and fs->in_exec.
Return from bprm_execve
Call free_bprm
Which does:
	if (bprm->mm) {
		acct_arg_size(bprm, 0);
		mmput(bprm->mm);
	}

So it really needs to be the mmput that cleans things up.\

I would really verify the correspondence between what get_arg_page
returns and what gets freed in mmput if it is not too difficult.
I think it should just be a page or two.

Eric
