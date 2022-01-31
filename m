Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6DA4A4BE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 17:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380308AbiAaQ0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 11:26:23 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:48490 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbiAaQ0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:26:21 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:36204)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEZVT-00HFE2-D7; Mon, 31 Jan 2022 09:26:20 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:49826 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEZVS-007Isd-8C; Mon, 31 Jan 2022 09:26:18 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <20220131153740.2396974-1-willy@infradead.org>
        <871r0nriy4.fsf@email.froward.int.ebiederm.org>
        <YfgKw5z2uswzMVRQ@casper.infradead.org>
Date:   Mon, 31 Jan 2022 10:26:11 -0600
In-Reply-To: <YfgKw5z2uswzMVRQ@casper.infradead.org> (Matthew Wilcox's message
        of "Mon, 31 Jan 2022 16:13:55 +0000")
Message-ID: <877dafq3bw.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nEZVS-007Isd-8C;;;mid=<877dafq3bw.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19qvjPe966AmDjlX0+1SCeNTH6o1CCUNsg=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_SCC_BODY_TEXT_LINE,T_TM2_M_HEADER_IN_MSG,
        XMSubLong,XM_B_Investor,XM_B_SpammyWords autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XM_B_Investor BODY: Commonly used business phishing phrases
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Matthew Wilcox <willy@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 537 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (1.9%), b_tie_ro: 9 (1.6%), parse: 1.07 (0.2%),
         extract_message_metadata: 14 (2.6%), get_uri_detail_list: 1.97 (0.4%),
         tests_pri_-1000: 15 (2.8%), tests_pri_-950: 1.35 (0.3%),
        tests_pri_-900: 1.09 (0.2%), tests_pri_-90: 153 (28.4%), check_bayes:
        149 (27.8%), b_tokenize: 11 (2.0%), b_tok_get_all: 26 (4.9%),
        b_comp_prob: 4.3 (0.8%), b_tok_touch_all: 103 (19.2%), b_finish: 1.03
        (0.2%), tests_pri_0: 328 (61.1%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.9 (0.5%), poll_dns_idle: 0.71 (0.1%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] binfmt_elf: Take the mmap lock when walking the VMA list
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Jan 31, 2022 at 10:03:31AM -0600, Eric W. Biederman wrote:
>> "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
>> 
>> > I'm not sure if the VMA list can change under us, but dump_vma_snapshot()
>> > is very careful to take the mmap_lock in write mode.  We only need to
>> > take it in read mode here as we do not care if the size of the stack
>> > VMA changes underneath us.
>> >
>> > If it can be changed underneath us, this is a potential use-after-free
>> > for a multithreaded process which is dumping core.
>> 
>> The problem is not multi-threaded process so much as processes that
>> share their mm.
>
> I don't understand the difference.  I appreciate that another process can
> get read access to an mm through, eg, /proc, but how can another process
> (that isn't a thread of this process) modify the VMAs?

There are a couple of ways.

A classic way is a multi-threads process can call vfork, and the
mm_struct is shared with the child until exec is called.

A process can do this more deliberately by forking a child using
clone(CLONE_VM) and not including CLONE_THREAD.   Supporting this case
is a hold over from before CLONE_THREAD was supported in the kernel and
such processes were used to simulate threads.

The practical difference between a CLONE_THREAD thread and a
non-CLONE_THREAD process is that the signal handling is not shared.
Without sharing the signal handlers it does not make sense for a fatal
signal to kill the other process.

From the perspective of coredump generation it stops the execution of
all CLONE_THREAD threads that are going to be part of the coredump
and allows anyone else who shared the mm_struct to keep running.


It also happens that there are subsystems in the kernel that do things
like kthread_use_mm that can also be modifying the mm during a coredump.

Which is why we have dump_vma_snapshot.  Preventing the mm_struct and
the vmas from being modified during a coredump is not really practical.


>> I think rather than take a lock we should be using the snapshot captured
>> with dump_vma_snapshot.  Otherwise we have the very real chance that the
>> two get out of sync.  Which would result in a non-sense core file.
>> 
>> Probably that means that dump_vma_snapshot needs to call get_file on
>> vma->vm_file store it in core_vma_metadata.
>> 
>> Do you think you can fix it something like that?
>
> Uhh .. that seems like it needs a lot more understanding of binfmt_elf
> than I currently possess.  I'd rather spend my time working on folios
> than learning much more about binfmt_elf.  I was just trying to fix an
> assertion failure with the maple tree patches (we now assert that you're
> holding a lock when walking the list of VMAs).

Fair enough.  I will put it on my list of things to address.

Eric

