Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CC73F9093
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 01:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243726AbhHZWPZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 18:15:25 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:34684 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbhHZWPY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 18:15:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:43756)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mJNdh-00EQKs-GD; Thu, 26 Aug 2021 16:14:25 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:36634 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mJNdf-00HV1Y-UD; Thu, 26 Aug 2021 16:14:25 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Hildenbrand <david@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
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
        <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs\@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
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
Date:   Thu, 26 Aug 2021 17:13:52 -0500
In-Reply-To: <0ed69079-9e13-a0f4-776c-1f24faa9daec@redhat.com> (David
        Hildenbrand's message of "Thu, 26 Aug 2021 23:47:07 +0200")
Message-ID: <87mtp3g8gv.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1mJNdf-00HV1Y-UD;;;mid=<87mtp3g8gv.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18m5lfQvtNAYQfGYREq2VBtg2jfskLzpXA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;David Hildenbrand <david@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 612 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.3 (0.7%), b_tie_ro: 3.0 (0.5%), parse: 1.59
        (0.3%), extract_message_metadata: 6 (0.9%), get_uri_detail_list: 3.1
        (0.5%), tests_pri_-1000: 11 (1.9%), tests_pri_-950: 1.01 (0.2%),
        tests_pri_-900: 0.95 (0.2%), tests_pri_-90: 101 (16.5%), check_bayes:
        98 (16.1%), b_tokenize: 18 (2.9%), b_tok_get_all: 13 (2.1%),
        b_comp_prob: 3.3 (0.5%), b_tok_touch_all: 61 (9.9%), b_finish: 0.81
        (0.1%), tests_pri_0: 469 (76.6%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 1.26 (0.2%), tests_pri_10:
        2.4 (0.4%), tests_pri_500: 8 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 26.08.21 19:48, Andy Lutomirski wrote:
>> On Fri, Aug 13, 2021, at 5:54 PM, Linus Torvalds wrote:
>>> On Fri, Aug 13, 2021 at 2:49 PM Andy Lutomirski <luto@kernel.org> wrote:
>>>>
>>>> I’ll bite.  How about we attack this in the opposite direction: remove the deny write mechanism entirely.
>>>
>>> I think that would be ok, except I can see somebody relying on it.
>>>
>>> It's broken, it's stupid, but we've done that ETXTBUSY for a _loong_ time.
>>
>> Someone off-list just pointed something out to me, and I think we should push harder to remove ETXTBSY.  Specifically, we've all been focused on open() failing with ETXTBSY, and it's easy to make fun of anyone opening a running program for write when they should be unlinking and replacing it.
>>
>> Alas, Linux's implementation of deny_write_access() is correct^Wabsurd, and deny_write_access() *also* returns ETXTBSY if the file is open for write.  So, in a multithreaded program, one thread does:
>>
>> fd = open("some exefile", O_RDWR | O_CREAT | O_CLOEXEC);
>> write(fd, some stuff);
>>
>> <--- problem is here
>>
>> close(fd);
>> execve("some exefile");
>>
>> Another thread does:
>>
>> fork();
>> execve("something else");
>>
>> In between fork and execve, there's another copy of the open file description, and i_writecount is held, and the execve() fails.  Whoops.  See, for example:
>>
>> https://github.com/golang/go/issues/22315
>>
>> I propose we get rid of deny_write_access() completely to solve this.
>>
>> Getting rid of i_writecount itself seems a bit harder, since a handful of filesystems use it for clever reasons.
>>
>> (OFD locks seem like they might have the same problem.  Maybe we should have a clone() flag to unshare the file table and close close-on-exec things?)
>>
>
> It's not like this issue is new (^2017) or relevant in practice. So no
> need to hurry IMHO. One step at a time: it might make perfect sense to
> remove ETXTBSY, but we have to be careful to not break other user
> space that actually cares about the current behavior in practice.

It is an old enough issue that I agree there is no need to hurry.

I also ran into this issue not too long ago when I refactored the
usermode_driver code.  My challenge was not being in userspace
the delayed fput was not happening in my kernel thread.  Which meant
that writing the file, then closing the file, then execing the file
consistently reported -ETXTBSY.

The kernel code wound up doing:
	/* Flush delayed fput so exec can open the file read-only */
	flush_delayed_fput();
	task_work_run();

As I read the code the delay for userspace file descriptors is
always done with task_work_add, so userspace should not hit
that kind of silliness, and should be able to actually close
the file descriptor before the exec.


On the flip side, I don't know how anything can depend upon getting an
-ETXTBSY.  So I don't think there is any real risk of breaking userspace
if we remove it.

Eric

