Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E3E3F2122
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 21:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhHSTzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 15:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234138AbhHSTzr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:55:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71009610A5;
        Thu, 19 Aug 2021 19:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629402911;
        bh=a7hA2i1JEu2oNE3vKMxIBbK/e83UydJxEWPDh43mTdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3CMeAe9SK80ZY+a4MOWda/Fzm7Lfq0N6tpDOQ1W5hDmmhy2reBm34QrnQERUxJul
         G9sn5DE0WvICokk4lAbvyR49dzprb1tLXbgIhoH5y971HD9nOraJGCjdViLUgrlj69
         xCtoQhhp32pkD3/CmK/DFFnvx1yveF/Kid9C0jkVqDKc89DF+J5GviG2L8HcD/3tQP
         i/iIH7pjAOy/I/r/PQ742Asin6ojMCpwfg9OVnJ8Fq0rzmGnN2lUFtg1Osau5wBr3w
         KsvJAEvNOyMWi1gs+8nhqECbO+wdtwingfK/846hL5TUxVerK9wWFKAgMGNZUNxasE
         V2Hg7ToCX2MqQ==
Date:   Thu, 19 Aug 2021 12:55:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: Removing Mandatory Locks
Message-ID: <YR63HOPASyh21DjK@gmail.com>
References: <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133>
 <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133>
 <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
 <YRcyqbpVqwwq3P6n@casper.infradead.org>
 <87k0kkxbjn.fsf_-_@disp2133>
 <0c2af732e4e9f74c9d20b09fc4b6cbae40351085.camel@kernel.org>
 <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 19, 2021 at 12:15:08PM -0700, Linus Torvalds wrote:
> On Thu, Aug 19, 2021 at 11:39 AM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > I'm all for ripping it out too. It's an insane interface anyway.
> >
> > I've not heard a single complaint about this being turned off in
> > fedora/rhel or any other distro that has this disabled.
> 
> I'd love to remove it, we could absolutely test it. The fact that
> several major distros have it disabled makes me think it's fine.
> 
> But as always, it would be good to check Android.
> 
> The desktop distros tend to have the same tools and programs, so if
> Fedora and RHEL haven't needed it for years, then it's likely stale in
> Debian too (despite being enabled).
> 
> But Android tends to be very different. Does anybody know?
> 

As far as I know, Android never uses mandatory file locking.  While
CONFIG_MANDATORY_LOCKING=y is typically set (as it's "default y" upstream),
I can't find anywhere in the Android source tree that uses the "mand" mount
option, let alone anything actually using mandatory locks.  (I'm assuming that
Documentation/filesystems/mandatory-locking.rst is up-to-date regarding what
userspace actually has to do to use it.)

- Eric
