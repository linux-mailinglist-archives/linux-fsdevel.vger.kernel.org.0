Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E54D32C551
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450719AbhCDAUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:00 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:47154 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452456AbhCCPvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:51:16 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lHTlY-00FcgR-S5; Wed, 03 Mar 2021 08:50:25 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lHTlX-0000vV-Ri; Wed, 03 Mar 2021 08:50:24 -0700
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
        <m1blc1gxdx.fsf@fess.ebiederm.org>
        <CALCv0x2-Q9o7k1jhzN73nZ9F5+tcp7T8SkLKQWXW=1gLLJNegA@mail.gmail.com>
Date:   Wed, 03 Mar 2021 09:50:23 -0600
In-Reply-To: <CALCv0x2-Q9o7k1jhzN73nZ9F5+tcp7T8SkLKQWXW=1gLLJNegA@mail.gmail.com>
        (Ilya Lipnitskiy's message of "Tue, 2 Mar 2021 23:01:16 -0800")
Message-ID: <m1r1kwdyo0.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lHTlX-0000vV-Ri;;;mid=<m1r1kwdyo0.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19zA/lsFUb7Jgarg+h7HqfyzQCN+3IxXT8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4982]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 492 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.4 (0.9%), b_tie_ro: 3.1 (0.6%), parse: 1.17
        (0.2%), extract_message_metadata: 13 (2.7%), get_uri_detail_list: 3.5
        (0.7%), tests_pri_-1000: 16 (3.3%), tests_pri_-950: 1.67 (0.3%),
        tests_pri_-900: 1.25 (0.3%), tests_pri_-90: 65 (13.1%), check_bayes:
        63 (12.9%), b_tokenize: 10 (2.0%), b_tok_get_all: 10 (2.0%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 38 (7.8%), b_finish: 0.65
        (0.1%), tests_pri_0: 379 (76.9%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.81 (0.2%), tests_pri_10:
        1.74 (0.4%), tests_pri_500: 5 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: exec error: BUG: Bad rss-counter
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:

> On Tue, Mar 2, 2021 at 11:37 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
>>
>> > On Mon, Mar 1, 2021 at 12:43 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >>
>> >> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
>> >>
>> >> > Eric, All,
>> >> >
>> >> > The following error appears when running Linux 5.10.18 on an embedded
>> >> > MIPS mt7621 target:
>> >> > [    0.301219] BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:1
>> >> >
>> >> > Being a very generic error, I started digging and added a stack dump
>> >> > before the BUG:
>> >> > Call Trace:
>> >> > [<80008094>] show_stack+0x30/0x100
>> >> > [<8033b238>] dump_stack+0xac/0xe8
>> >> > [<800285e8>] __mmdrop+0x98/0x1d0
>> >> > [<801a6de8>] free_bprm+0x44/0x118
>> >> > [<801a86a8>] kernel_execve+0x160/0x1d8
>> >> > [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
>> >> > [<80003198>] ret_from_kernel_thread+0x14/0x1c
>> >> >
>> >> > So that's how I got to looking at fs/exec.c and noticed quite a few
>> >> > changes last year. Turns out this message only occurs once very early
>> >> > at boot during the very first call to kernel_execve. current->mm is
>> >> > NULL at this stage, so acct_arg_size() is effectively a no-op.
>> >>
>> >> If you believe this is a new error you could bisect the kernel
>> >> to see which change introduced the behavior you are seeing.
>> >>
>> >> > More digging, and I traced the RSS counter increment to:
>> >> > [<8015adb4>] add_mm_counter_fast+0xb4/0xc0
>> >> > [<80160d58>] handle_mm_fault+0x6e4/0xea0
>> >> > [<80158aa4>] __get_user_pages.part.78+0x190/0x37c
>> >> > [<8015992c>] __get_user_pages_remote+0x128/0x360
>> >> > [<801a6d9c>] get_arg_page+0x34/0xa0
>> >> > [<801a7394>] copy_string_kernel+0x194/0x2a4
>> >> > [<801a880c>] kernel_execve+0x11c/0x298
>> >> > [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
>> >> > [<80003198>] ret_from_kernel_thread+0x14/0x1c
>> >> >
>> >> > In fact, I also checked vma_pages(bprm->vma) and lo and behold it is set to 1.
>> >> >
>> >> > How is fs/exec.c supposed to handle implied RSS increments that happen
>> >> > due to page faults when discarding the bprm structure? In this case,
>> >> > the bug-generating kernel_execve call never succeeded, it returned -2,
>> >> > but I didn't trace exactly what failed.
>> >>
>> >> Unless I am mistaken any left over pages should be purged by exit_mmap
>> >> which is called by mmput before mmput calls mmdrop.
>> > Good to know. Some more digging and I can say that we hit this error
>> > when trying to unmap PFN 0 (is_zero_pfn(pfn) returns TRUE,
>> > vm_normal_page returns NULL, zap_pte_range does not decrement
>> > MM_ANONPAGES RSS counter). Is my understanding correct that PFN 0 is
>> > usable, but special? Or am I totally off the mark here?
>>
>> It would be good to know if that is the page that get_user_pages_remote
>> returned to copy_string_kernel.  The zero page that is always zero,
>> should never be returned when a writable mapping is desired.
>
> Indeed, pfn 0 is returned from get_arg_page: (page is 0x809cf000,
> page_to_pfn(page) is 0) and it is the same page that is being freed and not
> refcounted in mmput/zap_pte_range. Confirmed with good old printk. Also,
> ZERO_PAGE(0)==0x809fc000 -> PFN 5120.
>
> I think I have found the problem though, after much digging and thanks to all
> the information provided. init_zero_pfn() gets called too late (after
> the call to
> is_zero_pfn(0) from mmput returns true), until then zero_pfn == 0, and after,
> zero_pfn == 5120. Boom.
>
> So PFN 0 is special, but only for a little bit, enough for something
> on my system
> to call kernel_execve :)
>
> Question: is my system not supposed to be calling kernel_execve this
> early or does
> init_zero_pfn() need to happen earlier? init_zero_pfn is currently a
> core_initcall.

Looking quickly it seems that init_zero_pfn() is in mm/memory.c and is
common for both mips and x86.  Further it appears init_zero_pfn() has
been that was since 2009 a13ea5b75964 ("mm: reinstate ZERO_PAGE").

Given the testing that x86 gets and that nothing like this has been
reported it looks like whatever driver is triggering the kernel_execve
is doing something wrong. 

Because honestly.  If the zero page isn't working there is not a chance
that anything in userspace is working so it is clearly much too early.

I suspect there is some driver that is initialized very early that is
doing something that looks innocuous (like triggering a hotplug event)
and that happens to cause a call_usermode_helper which then calls
kernel_execve.

Eric
