Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859C93F9C0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbhH0QAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 12:00:05 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:52212 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbhH0QAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:00:05 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:43614)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mJeG4-009BWI-Gt; Fri, 27 Aug 2021 09:59:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57244 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mJeFz-001ekB-NI; Fri, 27 Aug 2021 09:59:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Shawn Anastasio" <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Gabriel Krisman Bertazi" <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Marco Elver" <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Christian =?utf-8?Q?K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs\@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Florian Weimer" <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
        <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
        <87lf56bllc.fsf@disp2133>
        <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
        <87eeay8pqx.fsf@disp2133>
        <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
        <87h7ft2j68.fsf@disp2133>
        <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
        <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
        <CAHk-=wiJ0u33h2CXAO4b271Diik=z4jRt64=Gt6YV2jV4ef27g@mail.gmail.com>
        <b60e9bd1-7232-472d-9c9c-1d6593e9e85e@www.fastmail.com>
        <0ed69079-9e13-a0f4-776c-1f24faa9daec@redhat.com>
        <87mtp3g8gv.fsf@disp2133>
        <04e61e79ebad4a5d872d0a2b5be4c23d@AcuMS.aculab.com>
Date:   Fri, 27 Aug 2021 10:58:32 -0500
In-Reply-To: <04e61e79ebad4a5d872d0a2b5be4c23d@AcuMS.aculab.com> (David
        Laight's message of "Fri, 27 Aug 2021 08:22:07 +0000")
Message-ID: <87fsuug9qv.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mJeFz-001ekB-NI;;;mid=<87fsuug9qv.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18o5haSFLbKAaOyrbFGNCpTZ+ZVgKismqA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;David Laight <David.Laight@ACULAB.COM>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2688 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 10 (0.4%), b_tie_ro: 8 (0.3%), parse: 1.69 (0.1%),
         extract_message_metadata: 13 (0.5%), get_uri_detail_list: 1.20 (0.0%),
         tests_pri_-1000: 28 (1.0%), tests_pri_-950: 1.31 (0.0%),
        tests_pri_-900: 1.20 (0.0%), tests_pri_-90: 2272 (84.5%), check_bayes:
        2268 (84.4%), b_tokenize: 22 (0.8%), b_tok_get_all: 8 (0.3%),
        b_comp_prob: 2.7 (0.1%), b_tok_touch_all: 2230 (83.0%), b_finish: 1.23
        (0.0%), tests_pri_0: 349 (13.0%), check_dkim_signature: 0.70 (0.0%),
        check_dkim_adsp: 2.8 (0.1%), poll_dns_idle: 0.54 (0.0%), tests_pri_10:
        2.3 (0.1%), tests_pri_500: 7 (0.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:

> From: Eric W. Biederman
>> Sent: 26 August 2021 23:14
> ...
>> I also ran into this issue not too long ago when I refactored the
>> usermode_driver code.  My challenge was not being in userspace
>> the delayed fput was not happening in my kernel thread.  Which meant
>> that writing the file, then closing the file, then execing the file
>> consistently reported -ETXTBSY.
>> 
>> The kernel code wound up doing:
>> 	/* Flush delayed fput so exec can open the file read-only */
>> 	flush_delayed_fput();
>> 	task_work_run();
>> 
>> As I read the code the delay for userspace file descriptors is
>> always done with task_work_add, so userspace should not hit
>> that kind of silliness, and should be able to actually close
>> the file descriptor before the exec.
>
> If task_work_add ends up adding it to a task that is already
> running on a different cpu, and that cpu takes a hardware
> interrupt that takes some time and/or schedules the softint
> code to run immediately the hardware interrupt completes
> then it may well be possible for userspace to have 'issues'.

It it task_work_add(current).  Which punts the work to the return to
userspace.

> Any flags associated with O_DENY_WRITE would need to be cleared
> synchronously in the close() rather then in any delayed fput().

Eric
