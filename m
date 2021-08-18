Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AE03F009B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 11:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhHRJgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 05:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhHRJfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:35:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04029C0613A3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 02:35:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p38so3417425lfa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oiHvib23/P491CLaRgXvFmChy35OD4Cm4iT1dt+Oh64=;
        b=ZEXrzZn8yIRrwRBAbkQqjyDUM1Y1ntGz22UCVGWj4pa8ds9y1rSNm13RRW2Zbu1ewG
         rBn6QqJmL0FXQmDfsvP4crAiRZoezMZEvTCPpEdS1lWr+KIwFbDoQFfLqsbyi+aIyMn3
         2cpqNcKCR2xP4oZ+5okAnYjRgAPhb7/oHmHRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oiHvib23/P491CLaRgXvFmChy35OD4Cm4iT1dt+Oh64=;
        b=Mm/8b6EylT+lgOjbB9IpejuaLRQp0iBpPkt3HFeeALTQNPeYbRn+IAC2wtjxLvWAt6
         5g3hpucwVaQw+hPswShVJu8OmAWVuhz70jzR1MO8nwrGYierNbgOoWAPOsl9mOcxXvrF
         ev5LWr28mMO9ptFN1Nt7pUg6PE1RhZL2dh6NxiPK+MOMWxOauC6jMB4jCAMsP5MevYs7
         g2UL1IEVRQ5YDwwYOjJe2sCLUaH4T6rfaHtYAOSzgaHOhwaVB6+m+TODtM3uOHvymSb7
         gFAoxhwhlD76VtvmaMy8nDcqrE/5p0KshoXwwlpD/3OgpbTptwGkIHKTLFCOzim4Ywxy
         iblg==
X-Gm-Message-State: AOAM5308g6gxs3Zk5ByoFRT+/+D6haRFa/o2ZCdHfs27emX1WORvBAUn
        4uWmWHyLxlUN1OswL+LleSsVxwGBYPO4KO3Q+RrkCg==
X-Google-Smtp-Source: ABdhPJwoXvjX95NQrkUEtTh9/QSK0DDOWwz14GzEQTgLURMiW93dA3wt3YYyRzKwajrJJxceQBuTcuJDyIYDiI2xWhI=
X-Received: by 2002:a05:6512:952:: with SMTP id u18mr3991386lft.288.1629279302276;
 Wed, 18 Aug 2021 02:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com> <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133> <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com> <YRcyqbpVqwwq3P6n@casper.infradead.org>
 <87k0kkxbjn.fsf_-_@disp2133>
In-Reply-To: <87k0kkxbjn.fsf_-_@disp2133>
From:   Rodrigo Campos <rodrigo@kinvolk.io>
Date:   Wed, 18 Aug 2021 11:34:26 +0200
Message-ID: <CACaBj2ZgrA2JeeGenXxEf5ha6OYaFrj2=iuVXnQxC=kZLZpjng@mail.gmail.com>
Subject: Re: Removing Mandatory Locks
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 6:49 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Matthew Wilcox <willy@infradead.org> writes:
>
> > On Fri, Aug 13, 2021 at 05:49:19PM -0700, Andy Lutomirski wrote:
> >> [0] we have mandatory locks, too. Sigh.
> >
> > I'd love to remove that.  Perhaps we could try persuading more of the
> > distros to disable the CONFIG option first.
>
> Yes.  The support is disabled in RHEL8.

If it helps, it seems to be enabled on the just released debian stable:
    $ grep CONFIG_MANDATORY_FILE_LOCKING /boot/config-5.10.0-8-amd64
    CONFIG_MANDATORY_FILE_LOCKING=y

Also the new 5.13 kernel in experimental has it too:
    $ grep CONFIG_MANDATORY_FILE_LOCKING /boot/config-5.13.0-trunk-amd64
    CONFIG_MANDATORY_FILE_LOCKING=y
