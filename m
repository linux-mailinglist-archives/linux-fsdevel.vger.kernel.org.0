Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1A23F6999
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhHXTMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 15:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhHXTMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:12:52 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FB7C0613D9
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 12:12:08 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w4so37926574ljh.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ML8yvEkHn2MMk7DHTb7xofUolC2C3CbamkHF2ym8ns=;
        b=CCvgl77rDwn5Xdz1iPvHjiRdu483Ntev3TcN1slHj28zjY6a9duK7ML3JIaywIunKM
         w7nES36Axak0acr4X5y4QNLO1kuG+eou5mTFd146IBmALhGfdMfGMEKtTm/ogAFSulo2
         ZaDnOTkeFwweTIBsmOW50zL/o3x7KoH0lX+B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ML8yvEkHn2MMk7DHTb7xofUolC2C3CbamkHF2ym8ns=;
        b=Yuvo4iPckV3QudJWboR1BhDxNrQH4aXl6fET+GL7ZEpEk+U+zeGIeAWjOPMtEOG0sw
         nIVPjtdK23GhNt+XYGdhsmIw4mE1sD/7dd6KdZglHzlmfABiR/v4Hwmvp83d6NzOkgaL
         HKSnlZDgg6PCxYbJ1K4VLjml5UryTr7S4+ywkXGj89uyOeVilwULiuX7RVMZgdWr5qvG
         k+3mA4nar7qSeRAKjZDsk4Qeukx2zq4uEf5N0fr4Mp5EzgKN8CSMoHWGPwGvb9Ha4b/Z
         fBEIDlmOZuIdvkjgmm2rhNfx6b8gcL6JiRaedUxbH0GMFYpUglB71aC5AraAnqISYYXq
         IkOA==
X-Gm-Message-State: AOAM532lwzvlE0vlD58c3CjPlwZ1vbDTbsecdcbPk18cKU5shsfoVDz1
        cNle0Qge3DVt9S7cRG1d1IFiqE8aF+fdGf1A
X-Google-Smtp-Source: ABdhPJz0I+hs8vDwCEBV8rAjFH0nMs2xv7yCMI5DcvTDlkgk1MkoeZiNDo3FEHzRyMqGCcWLlgJVSA==
X-Received: by 2002:a2e:8109:: with SMTP id d9mr33004462ljg.495.1629832326432;
        Tue, 24 Aug 2021 12:12:06 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id b12sm1811846ljf.62.2021.08.24.12.12.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 12:12:06 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id p15so1595049ljn.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 12:12:05 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr32903544ljc.251.1629832325371;
 Tue, 24 Aug 2021 12:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com> <YSVCAJDYShQke6Sy@casper.infradead.org>
In-Reply-To: <YSVCAJDYShQke6Sy@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 12:11:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
Message-ID: <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Choosing short words at random from /usr/share/dict/words:

I don't think you're getting my point.

In fact, you're just making it WORSE.

"short" and "greppable" is not the main issue here.

"understandable" and "follows other conventions" is.

And those "other conventions" are not "book binders in the 17th
century". They are about operating system design.

So when you mention "slab" as a name example, that's not the argument
you think it is. That's a real honest-to-goodness operating system
convention name that doesn't exactly predate Linux, but is most
certainly not new.

In fact, "slab" is a bad example for another reason: we don't actually
really use it outside of the internal implementation of the slab
cache. The name we actually *use* tends to be "kmalloc()" or similar,
which most definitely has a CS history that goes back even further and
is not at all confusing to anybody.

So no. This email just convinces me that you have ENTIRELY the wrong
approach to naming and is just making me more convinced that "folio"
came from the wrong kind of thinking.

Because "random short words" is absolutely the last thing you should look at.

             Linus
