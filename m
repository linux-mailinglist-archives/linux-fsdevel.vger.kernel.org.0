Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783944A4D69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 18:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350377AbiAaRjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 12:39:00 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:34846 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350348AbiAaRi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:38:59 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:39938)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEadm-006TnZ-D3; Mon, 31 Jan 2022 10:38:58 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:53122 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEadk-00Ek8G-Sm; Mon, 31 Jan 2022 10:38:57 -0700
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
        <877dafq3bw.fsf@email.froward.int.ebiederm.org>
        <YfgPwPvopO1aqcVC@casper.infradead.org>
Date:   Mon, 31 Jan 2022 11:38:49 -0600
In-Reply-To: <YfgPwPvopO1aqcVC@casper.infradead.org> (Matthew Wilcox's message
        of "Mon, 31 Jan 2022 16:35:12 +0000")
Message-ID: <87pmo7olee.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nEadk-00Ek8G-Sm;;;mid=<87pmo7olee.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX195xKksb9tu1SBZnByujzw772B/SHtjq3k=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_SCC_BODY_TEXT_LINE,T_TM2_M_HEADER_IN_MSG,
        XMSubLong,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Matthew Wilcox <willy@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 648 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 10 (1.5%), parse: 0.95
        (0.1%), extract_message_metadata: 13 (2.0%), get_uri_detail_list: 2.1
        (0.3%), tests_pri_-1000: 11 (1.7%), tests_pri_-950: 1.28 (0.2%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 260 (40.2%), check_bayes:
        254 (39.3%), b_tokenize: 8 (1.3%), b_tok_get_all: 8 (1.3%),
        b_comp_prob: 3.1 (0.5%), b_tok_touch_all: 231 (35.7%), b_finish: 1.02
        (0.2%), tests_pri_0: 317 (49.0%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 17 (2.7%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 26 (4.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] binfmt_elf: Take the mmap lock when walking the VMA list
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Jan 31, 2022 at 10:26:11AM -0600, Eric W. Biederman wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> > On Mon, Jan 31, 2022 at 10:03:31AM -0600, Eric W. Biederman wrote:
>> >> "Matthew Wilcox (Oracle)" <willy@infradead.org> writes:
>> >> 
>> >> > I'm not sure if the VMA list can change under us, but dump_vma_snapshot()
>> >> > is very careful to take the mmap_lock in write mode.  We only need to
>> >> > take it in read mode here as we do not care if the size of the stack
>> >> > VMA changes underneath us.
>> >> >
>> >> > If it can be changed underneath us, this is a potential use-after-free
>> >> > for a multithreaded process which is dumping core.
>> >> 
>> >> The problem is not multi-threaded process so much as processes that
>> >> share their mm.
>> >
>> > I don't understand the difference.  I appreciate that another process can
>> > get read access to an mm through, eg, /proc, but how can another process
>> > (that isn't a thread of this process) modify the VMAs?
>> 
>> There are a couple of ways.
>> 
>> A classic way is a multi-threads process can call vfork, and the
>> mm_struct is shared with the child until exec is called.
>
> While true, I thought the semantics of vfork() were that the parent
> was suspended.  Given that, it can't core dump until the child execs
> ... right?

The thread that called vfork is suspended.  The other threads can
continue to execute.

>> A process can do this more deliberately by forking a child using
>> clone(CLONE_VM) and not including CLONE_THREAD.   Supporting this case
>> is a hold over from before CLONE_THREAD was supported in the kernel and
>> such processes were used to simulate threads.
>
> That is a multithreaded process then!  Maybe not in the strict POSIX
> compliance sense, but the intent is to be a multithreaded process.
> ie multiple threads of execution, sharing an address space.

Sometimes.  From a coredump perspective it is just another process
that happens to share the mm.  Like the vfork process.

For a while the coredump code was trying to kill and possibly dump all
of these ``threads'' that shared a vm.  The practical problem was that
a failing exec after vfork could trigger a coredump that would kill
it's parent process.

So when I look at these from a coredump or signal perspective I just
treat them as weird processes that happen to share an mm_struct.

>> It also happens that there are subsystems in the kernel that do things
>> like kthread_use_mm that can also be modifying the mm during a coredump.
>
> Yikes.  That's terrifying.  It's really legitimate for a kthread to
> attach to a process and start tearing down VMAs?

I don't know how much VMA manipulation makes sense but it is legitimate
to attach to an mm and do those things as Jann pointed out.

> Thanks.  Now that I've disclosed it's a UAF, I hope you're able to
> get to it soon.  Otherwise we should put this band-aid in for now
> and you can address it properly in the fullness of time.

Working on it now.

Eric

