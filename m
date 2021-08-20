Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0213F2E33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbhHTOhK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 10:37:10 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44284 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbhHTOhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:37:09 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:51336)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mH5d9-0030Xa-2U; Fri, 20 Aug 2021 08:36:23 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:50936 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mH5d7-00E1Uf-NO; Fri, 20 Aug 2021 08:36:22 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Christian =?utf-8?Q?K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <David.Laight@aculab.com>,
        linux-unionfs@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210816194840.42769-1-david@redhat.com>
        <20210816194840.42769-3-david@redhat.com>
        <CAHk-=wgsLtJ7=+NGGSEbTw9XBh7qyf4Py9-jBdajGnPTxU1hZg@mail.gmail.com>
        <d90a7dfd-11c8-c4e1-1c59-91aad5a7f08e@redhat.com>
Date:   Fri, 20 Aug 2021 09:36:12 -0500
In-Reply-To: <d90a7dfd-11c8-c4e1-1c59-91aad5a7f08e@redhat.com> (David
        Hildenbrand's message of "Fri, 20 Aug 2021 10:46:45 +0200")
Message-ID: <87o89srxnn.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mH5d7-00E1Uf-NO;;;mid=<87o89srxnn.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/R8bcNDwnS1a7/MlpKHI9VJFt1fxhrUow=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;David Hildenbrand <david@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 739 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (1.6%), b_tie_ro: 10 (1.4%), parse: 1.68
        (0.2%), extract_message_metadata: 14 (1.9%), get_uri_detail_list: 2.6
        (0.3%), tests_pri_-1000: 17 (2.4%), tests_pri_-950: 1.30 (0.2%),
        tests_pri_-900: 1.21 (0.2%), tests_pri_-90: 98 (13.3%), check_bayes:
        96 (13.0%), b_tokenize: 22 (3.0%), b_tok_get_all: 12 (1.7%),
        b_comp_prob: 3.4 (0.5%), b_tok_touch_all: 55 (7.4%), b_finish: 0.81
        (0.1%), tests_pri_0: 413 (55.9%), check_dkim_signature: 0.84 (0.1%),
        check_dkim_adsp: 2.5 (0.3%), poll_dns_idle: 160 (21.6%), tests_pri_10:
        4.3 (0.6%), tests_pri_500: 172 (23.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/7] kernel/fork: factor out replacing the current MM exe_file
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 19.08.21 22:51, Linus Torvalds wrote:
>> So I like this series.
>>
>> However, logically, I think this part in replace_mm_exe_file() no
>> longer makes sense:
>>
>> On Mon, Aug 16, 2021 at 12:50 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> +       /* Forbid mm->exe_file change if old file still mapped. */
>>> +       old_exe_file = get_mm_exe_file(mm);
>>> +       if (old_exe_file) {
>>> +               mmap_read_lock(mm);
>>> +               for (vma = mm->mmap; vma && !ret; vma = vma->vm_next) {
>>> +                       if (!vma->vm_file)
>>> +                               continue;
>>> +                       if (path_equal(&vma->vm_file->f_path,
>>> +                                      &old_exe_file->f_path))
>>> +                               ret = -EBUSY;
>>> +               }
>>> +               mmap_read_unlock(mm);
>>> +               fput(old_exe_file);
>>> +               if (ret)
>>> +                       return ret;
>>> +       }
>>
>> and should just be removed.
>>
>> NOTE! I think it makes sense within the context of this patch (where
>> you just move code around), but that it should then be removed in the
>> next patch that does that "always deny write access to current MM
>> exe_file" thing.
>>
>> I just quoted it in the context of this patch, since the next patch
>> doesn't actually show this code any more.
>>
>> In the *old* model - where the ETXTBUSY was about the mmap() of the
>> file - the above tests make sense.
>>
>> But in the new model, walking the mappings just doesn't seem to be a
>> sensible operation any more. The mappings simply aren't what ETXTBUSY
>> is about in the new world order, and so doing that mapping walk seems
>> nonsensical.
>>
>> Hmm?
>
> I think this is somewhat another kind of "stop user space trying
> to do stupid things" thingy, not necessarily glued to ETXTBUSY:
> don't allow replacing exe_file if that very file is still mapped
> and consequently eventually still in use by the application.
>
> I don't think it necessarily has many things to do with ETXTBUSY:
> we only check if there is a VMA mapping that file, not that it's
> a VM_DENYWRITE mapping.
>
> That code originates from
>
> commit 4229fb1dc6843c49a14bb098719f8a696cdc44f8
> Author: Konstantin Khlebnikov <khlebnikov@openvz.org>
> Date:   Wed Jul 11 14:02:11 2012 -0700
>
>     c/r: prctl: less paranoid prctl_set_mm_exe_file()
>
>     "no other files mapped" requirement from my previous patch (c/r: prctl:
>     update prctl_set_mm_exe_file() after mm->num_exe_file_vmas removal) is too
>     paranoid, it forbids operation even if there mapped one shared-anon vma.
>       Let's check that current mm->exe_file already unmapped, in this case
>     exe_file symlink already outdated and its changing is reasonable.
>
>
> The statement "exe_file symlink already outdated and its
> changing is reasonable" somewhat makes sense.
>
>
> Long story short, I think this check somehow makes a bit of sense, but
> we wouldn't lose too much if we drop it -- just another sanity check.
>
> Your call :)

There has been quite a bit of conversation of the years about how bad is
it to allow changing /proc/self/exe as some userspace depends on it.

I think this check is there to keep from changing /proc/self/exe
arbitrarily.

Maybe it is all completely silly and we should not care about the code
that thinks /proc/self/exe is a reliable measure of anything, but short
of that I think we should either keep the code or put in some careful
thought as to which restrictions make sense when changing
/proc/self/exe.

Eric

