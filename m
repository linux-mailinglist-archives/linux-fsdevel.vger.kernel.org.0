Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C863EBF0B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 02:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbhHNAks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 20:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbhHNAks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 20:40:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65557C061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Aug 2021 17:40:20 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z2so23182845lft.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Aug 2021 17:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjaD5q8QKwN+jVDLQ1RW7mDtRCj+6oZDCsHq9KfG01Y=;
        b=YpOsIIGWVbrxvz1V+JMlOsSqwlXM3DAd2BzbAfkLqR4kAf3OBmXelOKWLmXLhmfuGJ
         GCgWpJKZXGVCvc3L1o2SMTScR6NM9a1dV9DxbX2yx8cNWio3lx9uqdF+TNZfvO08YgDr
         +4aalKdiJdLNJEYdvsumzmmrrfihiRB2cpXmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjaD5q8QKwN+jVDLQ1RW7mDtRCj+6oZDCsHq9KfG01Y=;
        b=IjOM4EPM7h22Z/xfXIWdmznKRvITwug9G7IWZV35flZlwhx7nlMnSAuD/rnF0VFP2z
         glA7FPTfiZ9lKIu2s/7COm4+0jUxxys52u6oD3IxeHBgJyj0kd0JhTwNBCUhIl4pwbUX
         LX9so7pD/2YLZPE/7IWCCjLHvRdg/cTKmRV6TjMpvmUF9N1XAtp/nTT7JTkz/p8gERhz
         DV85Tl8QB1Opeex6O0+th57YIkfP4ueBpg3MNPIMDlLKax4pKhMlO7LjIBTZHXkujnrF
         xEEO6+gnY4vhHUY5k6CGIALFgphTrQnPSZdkXb3L6qjf6hk/S7Xm/y2E1+92z9ONmrTR
         Y8bg==
X-Gm-Message-State: AOAM531PGgsmw2EkjCiNLQtFNmasvJtJhxcA0tiKQM5yDsRGOgtdJfl9
        Da0Grm1To/9CmGgGFHH8qQXVBT9BGqRSsUxFIbY=
X-Google-Smtp-Source: ABdhPJzraIhCzIZMYvSyHrMG1HC1TftsKnb/PApNDcVROkFZu0VGMq8kNXg2p5+xXhkkR1SqbejSgA==
X-Received: by 2002:a05:6512:224a:: with SMTP id i10mr3661214lfu.510.1628901618685;
        Fri, 13 Aug 2021 17:40:18 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id m25sm309869lfl.240.2021.08.13.17.40.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 17:40:18 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h17so18078636ljh.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Aug 2021 17:40:18 -0700 (PDT)
X-Received: by 2002:a05:6512:1290:: with SMTP id u16mr3294932lfs.487.1628901124175;
 Fri, 13 Aug 2021 17:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com> <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com> <87h7ft2j68.fsf@disp2133>
In-Reply-To: <87h7ft2j68.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Aug 2021 14:31:46 -1000
X-Gmail-Original-Message-ID: <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
Message-ID: <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 10:18 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Florian Weimer, would it be possible to get glibc's ld.so implementation to use
> MAP_SHARED?  Just so people reading the code know what to expect of the
> kernel?  As far as I can tell there is not a practical difference
> between a read-only MAP_PRIVATE and a read-only MAP_SHARED.

There's a huge difference.

For one, you actually don't necessarily want read-only. Doing COW on
library images is quite common for things like relocation etc (you'd
_hope_ everything is PC-relative, but no)

So no. Never EVER use MAP_SHARED unless you literally expect to have
two different mappings that need to be kept in sync and one writes the
other.

I'll just repeat: stop arguing about this case. If somebody writes to
a busy library, THAT IS A FUNDAMENTAL BUG, and nobody sane should care
at all about it apart from the "you get what you deserve".

What's next? Do you think glibc should also map every byte in the user
address space so that user programs don't get SIGSEGV when they have
wild pointers?

Again - that's a user BUG and trying to "work around" a wild pointer
is a worse fix than the problem it tries to fix.

The exact same thing is true for shared library (or executable)
mappings. Trying to work around people writing to them is *worse* than
the bug of doing so.

Stop this completely inane discussion already.

                  Linus
