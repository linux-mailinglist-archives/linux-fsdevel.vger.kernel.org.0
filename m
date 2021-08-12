Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771A63EA9C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhHLRtq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:49:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53048 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHLRtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:49:12 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:56990)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mEEot-00CZrX-K4; Thu, 12 Aug 2021 11:48:43 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:43726 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mEEor-00BSXH-NO; Thu, 12 Aug 2021 11:48:42 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Andy Lutomirski" <luto@kernel.org>
Cc:     "David Hildenbrand" <david@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Petr Mladek" <pmladek@suse.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Kees Cook" <keescook@chromium.org>,
        "Greg Ungerer" <gerg@linux-m68k.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        "Chinwen Chang" <chinwen.chang@mediatek.com>,
        "Michel Lespinasse" <walken@google.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        "Huang Ying" <ying.huang@intel.com>,
        "Jann Horn" <jannh@google.com>, "Feng Tang" <feng.tang@intel.com>,
        "Kevin Brodsky" <Kevin.Brodsky@arm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Shawn Anastasio" <shawn@anastas.io>,
        "Steven Price" <steven.price@arm.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Gabriel Krisman Bertazi" <krisman@collabora.com>,
        "Peter Xu" <peterx@redhat.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        "Marco Elver" <elver@google.com>,
        "Daniel Jordan" <daniel.m.jordan@oracle.com>,
        "Nicolas Viennot" <Nicolas.Viennot@twosigma.com>,
        "Thomas Cedeno" <thomascedeno@google.com>,
        "Collin Fijalkovich" <cfijalkovich@google.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Chengguang Xu" <cgxu519@mykernel.net>,
        Christian =?utf-8?Q?K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-unionfs@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
        <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
Date:   Thu, 12 Aug 2021 12:48:31 -0500
In-Reply-To: <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com> (Andy
        Lutomirski's message of "Thu, 12 Aug 2021 10:35:18 -0700")
Message-ID: <87lf56bllc.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mEEor-00BSXH-NO;;;mid=<87lf56bllc.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/OvYtr6rpA2spNYcD/3k7B29elZOFJvvw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4984]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Andy Lutomirski" <luto@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 576 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (2.0%), b_tie_ro: 10 (1.8%), parse: 1.41
        (0.2%), extract_message_metadata: 5 (0.9%), get_uri_detail_list: 2.9
        (0.5%), tests_pri_-1000: 16 (2.7%), tests_pri_-950: 1.23 (0.2%),
        tests_pri_-900: 1.14 (0.2%), tests_pri_-90: 78 (13.5%), check_bayes:
        76 (13.3%), b_tokenize: 23 (4.0%), b_tok_get_all: 13 (2.3%),
        b_comp_prob: 4.1 (0.7%), b_tok_touch_all: 32 (5.6%), b_finish: 0.93
        (0.2%), tests_pri_0: 444 (77.1%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 3.2 (0.6%), poll_dns_idle: 0.98 (0.2%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Andy Lutomirski" <luto@kernel.org> writes:

> On Thu, Aug 12, 2021, at 10:32 AM, Eric W. Biederman wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>> > This series is based on v5.14-rc5 and corresponds code-wise to the
>> > previously sent RFC [1] (the RFC still applied cleanly).
>> >
>> > This series removes all in-tree usage of MAP_DENYWRITE from the kernel
>> > and removes VM_DENYWRITE. We stopped supporting MAP_DENYWRITE for
>> > user space applications a while ago because of the chance for DoS.
>> > The last renaming user is binfmt binary loading during exec and
>> > legacy library loading via uselib().
>> >
>> > With this change, MAP_DENYWRITE is effectively ignored throughout the
>> > kernel. Although the net change is small, I think the cleanup in mmap()
>> > is quite nice.
>> >
>> > There are some (minor) user-visible changes with this series:
>> > 1. We no longer deny write access to shared libaries loaded via legacy
>> >    uselib(); this behavior matches modern user space e.g., via dlopen().
>> > 2. We no longer deny write access to the elf interpreter after exec
>> >    completed, treating it just like shared libraries (which it often is).
>> > 3. We always deny write access to the file linked via /proc/pid/exe:
>> >    sys_prctl(PR_SET_MM_EXE_FILE) will fail if write access to the file
>> >    cannot be denied, and write access to the file will remain denied
>> >    until the link is effectivel gone (exec, termination,
>> >    PR_SET_MM_EXE_FILE) -- just as if exec'ing the file.
>> >
>> > I was wondering if we really care about permanently disabling write access
>> > to the executable, or if it would be good enough to just disable write
>> > access while loading the new executable during exec; but I don't know
>> > the history of that -- and it somewhat makes sense to deny write access
>> > at least to the main executable. With modern user space -- dlopen() -- we
>> > can effectively modify the content of shared libraries while being
>> > used.
>> 
>> So I think what we really want to do is to install executables with
>> and shared libraries without write permissions and immutable.  So that
>> upgrades/replacements of the libraries and executables are forced to
>> rename or unlink them.  We need the immutable bit as CAP_DAC_OVERRIDE
>> aka being root ignores the writable bits when a file is opened for
>> write.  However CAP_DAC_OVERRIDE does not override the immutable state
>> of a file.
>
> If we really want to do this, I think we'd want a different flag
> that's more like sealed.  Non-root users should be able to do this,
> too.
>
> Or we could just more gracefully handle users that overwrite running
> programs.

I had a blind spot, and Florian Weimer made a very reasonable request.
Apparently userspace for shared libraires uses MAP_PRIVATE.

So we almost don't care if the library is overwritten.  We loose some
efficiency and apparently there are some corner cases like the library
being extended past the end of the exiting file that are problematic.

Given that MAP_PRIVATE for shared libraries is our strategy for handling
writes to shared libraries perhaps we just need to use MAP_POPULATE or a
new related flag (perhaps MAP_PRIVATE_NOW) that just makes certain that
everything mapped from the executable is guaranteed to be visible from
the time of the mmap, and any changes from the filesystem side after
that are guaranteed to cause a copy on write.

Once we get that figured out we could consider getting rid of deny-write
entirely.

Eric
