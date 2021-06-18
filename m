Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B53C3ACEE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 17:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhFRP3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 11:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235287AbhFRP1Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:27:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC9AC613F8;
        Fri, 18 Jun 2021 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624029915;
        bh=NHOS2nztwy3TA+UNsV1grnaocamfRVknn2bPidaA5FY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MsH/rZ6zgcN3OZ3VksgVcZw7p0GkwSiQIs0e0M146anlN07e+LtuTNZJtMNX19Z3n
         nK0YAcHXMFRp6Ww3aeU2IeK7dayH/oFksRtViMA8Vw5Fu4OwYICRUJfyAgnDui/dse
         KsNx+StDFiRQLYEVS2tql35L6Q0KO4XDUAO7XNCfxNpFPADPv+y8tKGf0/tPhmXULi
         X1GwAnJOgqJeGU3iZqJcGSiJzhFn4Fxo42FDA/jfJfQBaXZd1D+191pU0AjT2ggvAl
         YsVhslXvtgJOeEBBiY/BL21hEQPrcfOcFHig226JIdakPF6BjS5V5TmANhKh8VAkwC
         F24nqiBo3I/WA==
Received: by mail-wr1-f43.google.com with SMTP id n7so11213112wri.3;
        Fri, 18 Jun 2021 08:25:15 -0700 (PDT)
X-Gm-Message-State: AOAM5332RXq47gGF3OkH7EtmNa+um2zgZ8B2LYmnQl+QmUvP2YA+u0TP
        KJ57seSJqhyD/nHlBMp1H2BB7XaNimpe+ndKw5U=
X-Google-Smtp-Source: ABdhPJwc6DpkbV+fodDt4YAJuBzYGSctWSkisb/MMNiiuizd+kWbF/VQwayKNBMXMKrMjTcal/YisCxFk23GdbEL1B0=
X-Received: by 2002:a5d:4e12:: with SMTP id p18mr13645900wrt.105.1624029914249;
 Fri, 18 Jun 2021 08:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
 <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com>
 <f2764b10-dd0d-cabf-0264-131ea5829fed@infradead.org> <CAHk-=whPPWYXKQv6YjaPQgQCf+78S+0HmAtyzO1cFMdcqQp5-A@mail.gmail.com>
 <c2002123-795c-20ae-677c-a35ba0e361af@infradead.org> <051421e0-afe8-c6ca-95cd-4dc8cd20a43e@huawei.com>
 <200ea6f7-0182-9da1-734c-c49102663ccc@redhat.com> <CAHk-=wjEThm5Kyockk1kJhd_K-P+972t=SnEj-WX9KcKPW0-Qg@mail.gmail.com>
 <9d7873b6-e35c-ae38-9952-a1df443b2aea@redhat.com> <CAHk-=wgW6yfsLUtepANX2PVkADR_7WDzk05YVhtw1ZBmDEGT2Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgW6yfsLUtepANX2PVkADR_7WDzk05YVhtw1ZBmDEGT2Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 18 Jun 2021 17:23:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3L6B9HXsOXSu9_c6pz1kN91Vig6EPsetLuYVW=M72XaQ@mail.gmail.com>
Message-ID: <CAK8P3a3L6B9HXsOXSu9_c6pz1kN91Vig6EPsetLuYVW=M72XaQ@mail.gmail.com>
Subject: Re: [PATCH] afs: fix no return statement in function returning non-void
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tom Rix <trix@redhat.com>, Zheng Zengkai <zhengzengkai@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hulk Robot <hulkci@huawei.com>, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 12:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jun 16, 2021 at 9:22 AM Tom Rix <trix@redhat.com> wrote:
> >
> > to fix, add an unreachable() to the generic BUG()
> >
> > diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> > index f152b9bb916f..b250e06d7de2 100644
> > --- a/include/asm-generic/bug.h
> > +++ b/include/asm-generic/bug.h
> > @@ -177,7 +177,10 @@ void __warn(const char *file, int line, void
> > *caller, unsigned taint,
> >
> >   #else /* !CONFIG_BUG */
> >   #ifndef HAVE_ARCH_BUG
> > -#define BUG() do {} while (1)
> > +#define BUG() do {                                             \
> > +               do {} while (1);                                \
> > +               unreachable();                                  \
> > +       } while (0)
> >   #endif
>
> I'm a bit surprised that the compiler doesn't make that code after an
> infinite loop automatically be marked "unreachable". But at the same I
> can imagine the compiler doing some checks without doing real flow
> analysis, and doing "oh, that conditional branch is unconditional".
>
> So this patch at least makes sense to me and I have no objections to
> it, even if it makes me go "silly compiler, we shouldn't have to tell
> you this".
>
> So Ack from me on this.

I've tried to figure out what the compiler is trying to do here, and it's
still weird. When I saw the patch posted, I misread it as having just
unreachable() without the loop, and that would have been bad
because it triggers undefined behavior.

What I found is a minimal test case of

static int f(void)
{
   do {} while (1);
}

to trigger the warning with any version of gcc (not clang), but none of
these other variations cause a warning:

 // not static -> no warning!
int f(void)
{
   do {} while (1);
}

// some return statement anywhere in the function, no warning
static int f(int i)
{
  if (i)
      return 0;
   do {} while (1);
}

// annotated as never returning, as discussed in this thread
static int __attribute__((noreturn)) f(void)
{
   do {} while (1);
}

// unreachable annotation, as suggested by Tom
static int f(void)
{
   do {} while (1);
   __builtin_unreachable();
}

The last three are obviously intentional, as the warning is only for functions
that can *never* return but lack an annotation. I have no idea why the warning
is only for static functions though.

All my randconfig builds for arm/arm64/x86 missed this problem since those
architectures have a custom BUG() implementation with an inline asm.
I've taken them out now and found only two other instances of the issue so far:
arbitrary_virt_to_machine() and ppc64 get_hugepd_cache_index(). My preference
would be to annotate these as __noreturn, but change to the asm-generic
BUG() is probably better.

        Arnd
