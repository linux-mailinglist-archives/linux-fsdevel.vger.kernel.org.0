Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516EF3F1B04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 15:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbhHSN6b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 09:58:31 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59828 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbhHSN6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:58:23 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:57326)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mGiY4-000ia2-O6; Thu, 19 Aug 2021 07:57:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:52186 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mGiY3-00AqBr-Kq; Thu, 19 Aug 2021 07:57:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     bfields@fieldses.org (J. Bruce Fields)
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        David Hildenbrand <david@redhat.com>,
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
        "\<linux-fsdevel\@vger.kernel.org\>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
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
        <20210818154217.GB24115@fieldses.org>
Date:   Thu, 19 Aug 2021 08:56:52 -0500
In-Reply-To: <20210818154217.GB24115@fieldses.org> (J. Bruce Fields's message
        of "Wed, 18 Aug 2021 11:42:17 -0400")
Message-ID: <87bl5tv8pn.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1mGiY3-00AqBr-Kq;;;mid=<87bl5tv8pn.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+peADQdS13oBRstgvxG3nqTM38ZOsjU00=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;bfields@fieldses.org (J. Bruce Fields)
X-Spam-Relay-Country: 
X-Spam-Timing: total 496 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.4 (0.9%), b_tie_ro: 3.0 (0.6%), parse: 1.49
        (0.3%), extract_message_metadata: 14 (2.8%), get_uri_detail_list: 1.83
        (0.4%), tests_pri_-1000: 18 (3.6%), tests_pri_-950: 1.02 (0.2%),
        tests_pri_-900: 0.95 (0.2%), tests_pri_-90: 121 (24.4%), check_bayes:
        117 (23.6%), b_tokenize: 17 (3.4%), b_tok_get_all: 12 (2.4%),
        b_comp_prob: 2.9 (0.6%), b_tok_touch_all: 82 (16.5%), b_finish: 0.77
        (0.2%), tests_pri_0: 322 (65.0%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 4.5 (0.9%), poll_dns_idle: 0.12 (0.0%), tests_pri_10:
        2.7 (0.5%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bfields@fieldses.org (J. Bruce Fields) writes:

> On Fri, Aug 13, 2021 at 05:49:19PM -0700, Andy Lutomirski wrote:
>> I’ll bite.  How about we attack this in the opposite direction: remove
>> the deny write mechanism entirely.
>
> For what it's worth, Windows has open flags that allow denying read or
> write opens.  They also made their way into the NFSv4 protocol, but
> knfsd enforces them only against other NFSv4 clients.  Last I checked,
> Samba attempted to emulate them using flock (and there's a comment to
> that effect on the flock syscall in fs/locks.c).  I don't know what Wine
> does.
>
> Pavel Shilovsky posted flags adding O_DENY* flags years ago:
>
> 	https://lwn.net/Articles/581005/
>
> I keep thinking I should look back at those some day but will probably
> never get to it.
>
> I've no idea how Windows applications use them, though I'm told it's
> common.

I don't know in any detail.  I just have this memory of not being able
to open or do anything with a file on windows while any application has
it open.

We limit mandatory locks to filesystems that have the proper mount flag
and files that are sgid but are not executable.  Reusing that limit we
could probably allow such a behavior in Linux without causing chaos.

Without being very strict about which files can participate I can just
imagine someone hiding their presence by not allowing other applications
the ability to write to utmp or a log file.

In the windows world where everything evolved with those kinds of
restrictions it is probably fine (although super annoying).

Eric
