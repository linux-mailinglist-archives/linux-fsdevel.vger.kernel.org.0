Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2722C41ACBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 12:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbhI1KSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 06:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbhI1KSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:18:32 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C69C061604
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 03:16:53 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id y201so29400264oie.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 03:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+Hd389s4zwlrEfU0RxVwCS/ivAyltT+4eJme/lzcYg=;
        b=h8iVziDK5Y0iZjNZU21rA1jfXk8ZyVhrg2BxwrB5EQ+rfU3UBQ0VSrnlgN657y1eC2
         5cy91fTmnghKaGNFrQRT88sNoLzO08tkF3pZQfoS6dYfkmE3Frr9tOhJvZyn1MX3kXwk
         Rr2k28aP6ZGBmxfpd+wFjjIKR2NyA5bUuGl5C3F4rYx/1TaxwWtPlXOoQQ1a8cG1pEJQ
         KOe2DkCsrhcWFL0OxM7kdV1/o9g2bNf09SmvoiqgvmVoZc06IYtTeGYMB1mYKwXD+TmJ
         oLsVSrPRnNhWV8rmFWhTltSC2nz4C4GJQLF1uGg2yMnscsC//xYkuFsd2IZGeI65mOMl
         Akhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+Hd389s4zwlrEfU0RxVwCS/ivAyltT+4eJme/lzcYg=;
        b=SjqIki2CIzjoPMpU+QWKAHStVwK97eJB5dtrg6zovTbAYCjgwDMzewKtZyxHsXnn4a
         QaTcvr8e3K1/hcfldgcTnWDxetGe8eESUQTPYdvaQhjL4fSB1Ntbs2kfKjzjnNmkyzAW
         OuNTaiHoGHtiyPJdEd+w2DDciUoOFQZ1vQUzya/TcAI2iSMp6XVp1u/oCq5FogeYJTE+
         imTwqwxg5mXbP3lCvWNpowjoj4jHkIGKBlSfWcSfFsnq086xBbzv5war2WqMvQ4BIjJD
         9VG3WKBZHWUm2mFBIMiW20RIuSHdBjqDooWLqJZBHmFLFXXrwmKjpFd/vnEbYTadwjRb
         VymQ==
X-Gm-Message-State: AOAM5303rPHFc9fSEWSRdkZ76y7gDFwZfcFJ9gRTDzn5rVVXdXdGbGWI
        kV8BJomimsH4e5d7XdbEmxWrIWDi8qZR6uCQXgaKww==
X-Google-Smtp-Source: ABdhPJyu/CGI5VgCk70sPwQBfKmIuNTUZxtWzIdQClj3dSFa0I6f4kM3g/8YHuYxRaUGVYpZrqyl4HWNuT4300RGk+E=
X-Received: by 2002:aca:f189:: with SMTP id p131mr3052297oih.128.1632824212352;
 Tue, 28 Sep 2021 03:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d6b66705cb2fffd4@google.com> <CACT4Y+ZByJ71QfYHTByWaeCqZFxYfp8W8oyrK0baNaSJMDzoUw@mail.gmail.com>
 <CANpmjNMq=2zjDYJgGvHcsjnPNOpR=nj-gQ43hk2mJga0ES+wzQ@mail.gmail.com>
 <CACT4Y+Y1c-kRk83M-qiFY40its+bP3=oOJwsbSrip5AB4vBnYA@mail.gmail.com>
 <YUpr8Vu8xqCDwkE8@google.com> <CACT4Y+YuX3sVQ5eHYzDJOtenHhYQqRsQZWJ9nR0sgq3s64R=DA@mail.gmail.com>
 <YVHsV+o7Ez/+arUp@google.com> <20210927234543.6waods7rraxseind@treble>
In-Reply-To: <20210927234543.6waods7rraxseind@treble>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 28 Sep 2021 12:16:41 +0200
Message-ID: <CACT4Y+aqBKqJFa-6TuXWHSh0DEYYM9kbyZZohO3Gi_EujafmVA@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: KFENCE: use-after-free in kvm_fastop_exception
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Marco Elver <elver@google.com>,
        syzbot <syzbot+d08efd12a2905a344291@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 28 Sept 2021 at 01:45, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Sep 27, 2021 at 04:07:51PM +0000, Sean Christopherson wrote:
> > I was asking about the exact location to confirm that the explosion is indeed
> > from exception fixup, which is the "unwinder scenario get confused" I was thinking
> > of.  Based on the disassembly from syzbot, that does indeed appear to be the case
> > here, i.e. this
> >
> >   2a:   4c 8b 21                mov    (%rcx),%r12
> >
> > is from exception fixup from somewhere in __d_lookup (can't tell exactly what
> > it's from, maybe KASAN?).
> >
> > > Is there more info on this "the unwinder gets confused"? Bug filed
> > > somewhere or an email thread? Is it on anybody's radar?
> >
> > I don't know if there's a bug report or if this is on anyone's radar.  The issue
> > I've encountered in the past, and what I'm pretty sure is being hit here, is that
> > the ORC unwinder doesn't play nice with out-of-line fixup code, presumably because
> > there are no tables for the fixup.  I believe kvm_fastop_exception() gets blamed
> > because it's the first label that's found when searching back through the tables.
>
> The ORC unwinder actually knows about .fixup, and unwinding through the
> .fixup code worked here, as evidenced by the entire stacktrace getting
> printed.  Otherwise there would have been a bunch of question marks in
> the stack trace.
>
> The problem reported here -- falsely printing kvm_fastop_exception -- is
> actually in the arch-independent printing of symbol names, done by
> __sprint_symbol().  Most .fixup code fragments are anonymous, in the
> sense that they don't have symbols associated with them.  For x86, here
> are the only defined symbols in .fixup:
>
>   ffffffff81e02408 T kvm_fastop_exception
>   ffffffff81e02728 t .E_read_words
>   ffffffff81e0272b t .E_leading_bytes
>   ffffffff81e0272d t .E_trailing_bytes
>   ffffffff81e02734 t .E_write_words
>   ffffffff81e02740 t .E_copy
>
> There's a lot of anonymous .fixup code which happens to be placed in the
> gap between "kvm_fastop_exception" and ".E_read_words".  The kernel
> symbol printing code will go backwards from the given address and will
> print the first symbol it finds.  So any anonymous code in that gap will
> falsely be reported as kvm_fastop_exception().
>
> I'm thinking the ideal way to fix this would be getting rid of the
> .fixup section altogether, and instead place a function's corresponding
> fixup code in a cold part of the original function, with the help of
> asm_goto and cold label attributes.
>
> That way, the original faulting function would be printed instead of an
> obscure reference to an anonymous .fixup code fragment.  It would have
> other benefits as well.  For example, not breaking livepatch...
>
> I'll try to play around with it.

Thanks for debugging this, Josh.
I think your solution can also help arm64 as it has the same issue.
