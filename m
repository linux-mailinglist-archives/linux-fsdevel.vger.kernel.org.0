Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458DA3EA86A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 18:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhHLQSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 12:18:53 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:34132 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhHLQSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:18:53 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:43426)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mEDPR-00CQHg-B6; Thu, 12 Aug 2021 10:18:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:42228 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mEDPQ-00EqWu-5G; Thu, 12 Aug 2021 10:18:20 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Florian Weimer <fweimer@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Christian =?utf-8?Q?K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-unionfs@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210812084348.6521-1-david@redhat.com>
        <87r1eyg8h6.fsf@oldenburg.str.redhat.com>
Date:   Thu, 12 Aug 2021 11:17:24 -0500
In-Reply-To: <87r1eyg8h6.fsf@oldenburg.str.redhat.com> (Florian Weimer's
        message of "Thu, 12 Aug 2021 14:20:37 +0200")
Message-ID: <877dgqfxij.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mEDPQ-00EqWu-5G;;;mid=<877dgqfxij.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+fUaUYby0ovoa4j4axcDNjRQxbnPUhyZI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Florian Weimer <fweimer@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 564 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (1.8%), b_tie_ro: 9 (1.5%), parse: 1.10 (0.2%),
         extract_message_metadata: 3.8 (0.7%), get_uri_detail_list: 1.92
        (0.3%), tests_pri_-1000: 15 (2.6%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 1.15 (0.2%), tests_pri_-90: 85 (15.1%), check_bayes:
        84 (14.8%), b_tokenize: 22 (3.9%), b_tok_get_all: 13 (2.3%),
        b_comp_prob: 3.6 (0.6%), b_tok_touch_all: 41 (7.3%), b_finish: 0.85
        (0.2%), tests_pri_0: 424 (75.1%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 0.96 (0.2%), tests_pri_10:
        2.4 (0.4%), tests_pri_500: 13 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Florian Weimer <fweimer@redhat.com> writes:

> * David Hildenbrand:
>
>> There are some (minor) user-visible changes with this series:
>> 1. We no longer deny write access to shared libaries loaded via legacy
>>    uselib(); this behavior matches modern user space e.g., via dlopen().
>> 2. We no longer deny write access to the elf interpreter after exec
>>    completed, treating it just like shared libraries (which it often is).
>
> We have a persistent issue with people using cp (or similar tools) to
> replace system libraries.  Since the file is truncated first, all
> relocations and global data are replaced by file contents, result in
> difficult-to-diagnose crashes.  It would be nice if we had a way to
> prevent this mistake.  It doesn't have to be MAP_DENYWRITE or MAP_COPY.
> It could be something completely new, like an option that turns every
> future access beyond the truncation point into a signal (rather than
> getting bad data or bad code and crashing much later).
>
> I don't know how many invalid copy operations are currently thwarted by
> the current program interpreter restriction.  I doubt that lifting the
> restriction matters.

I suspect that what should happen is that we should make shared
libraries and executables read-only on disk.

We could potentially take this a step farther and introduce a new sysctl
that causes "mmap(adr, len, PROT_EXEC, MAP_SHARED, fd, off)" but not
PROT_WRITE to fail if the file can be written by anyone.  That sysctl
could even deny chown adding write access to the file if there are
mappings open.

Given that there hasn't been enough pain for people to install shared
libraries read-only yet I suspect just installing executables and shared
libraries without write-permissions on disk is enough to prevent the
hard to track down bugs you have been talking about.

>> 3. We always deny write access to the file linked via /proc/pid/exe:
>>    sys_prctl(PR_SET_MM_EXE_FILE) will fail if write access to the file
>>    cannot be denied, and write access to the file will remain denied
>>    until the link is effectivel gone (exec, termination,
>>    PR_SET_MM_EXE_FILE) -- just as if exec'ing the file.
>>
>> I was wondering if we really care about permanently disabling write access
>> to the executable, or if it would be good enough to just disable write
>> access while loading the new executable during exec; but I don't know
>> the history of that -- and it somewhat makes sense to deny write access
>> at least to the main executable. With modern user space -- dlopen() -- we
>> can effectively modify the content of shared libraries while being used.
>
> Is there a difference between ET_DYN and ET_EXEC executables?

What is being changed is how we track which files to denying write
access on.  Instead of denying write-access based on a per mapping (aka
mmap) basis, the new code is only denying access to /proc/self/exe.

Because the method of tracking is much coarser is why the interper stops
being protected.  The code doesn't care how the mappings happen, only
if the file is /proc/self/exe or not.

Eric

