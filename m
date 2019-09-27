Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 472C7C0DB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 23:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfI0V60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 17:58:26 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:44663 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfI0V60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:58:26 -0400
Received: by mail-pg1-f181.google.com with SMTP id i14so4129901pgt.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2019 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuw8hxq0DylUDEW7q7+M1o9OUZzAvCdwyghW70aBjzo=;
        b=WmxTdKgIVzQF3fQ443jwjpeN8KbSalfQE3hnCI238qadl1T+DDou6TS0m5gNEr5lyD
         +VZC1p9ILR0/SkXsMNR3fyoAhY36uPC95LhPq69S6AYdzVEJwBksNKpjnVWjgs2obYn8
         XYk/CVjXgngaO2rWjmndT7q1p/MU++TaL07hsoTr+i+HTNuk3kzyVKNW6c8jDgREW5sz
         RYofgMNXzWppIOxdocfZQ4kqHqKufNcAeNDHNGC7ugK9OaLmK6pp3e3YJR5vYtPBVNm3
         CTbNhobBRFK348USxiCX5UVnoJHH09E2HINsKPcicFyFuICJEnlhO1805qUltKC9/Wpu
         2slA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuw8hxq0DylUDEW7q7+M1o9OUZzAvCdwyghW70aBjzo=;
        b=CI9W64X/5venzVxxHBTMSUOxuW8lafEzGVhOClF4e1Bv9oVoxRD7WSR8TzSv3gV9Dd
         nU+Keh0ecLR6bADwm161TJFmnt6XrDgXbw6iEt1qberK8Jgg8USCwgQJrLcBbTnMhRJV
         rN/KXeCTC3n6h3cY0HzZwFf3pGLINjjqxTJU8cms7lpNmeV3RLZ/HZELyKiAb8XfRf08
         4NiqqcR3ijyuf+CXDx07CIkT774SFPvSqIC+QJJlveN26dfsJzR74NUco9xT4E6v17OP
         XvB5KeiE3OhG9El8mN9owk25VnClqxkcHvIBiGz6LQtDM0bJu5RUv3Vvh6fBoidNNeW1
         5IAw==
X-Gm-Message-State: APjAAAXFKqVLTbR7xI1WhFcMCfP3/O5cmJwuWWmmdNGd9yGTiVP1u14q
        sUG7UhBN5E7fbWM8MgGH/tDEDItELXLN9N4+l7jQYQ==
X-Google-Smtp-Source: APXvYqyiPQL5d1uFbJwUkD8gbdy0oxEv702oj7SMThdXYkLYfpeNleVXpRvGj/TmVrDaSHYw8s/7h8Y5PU7tPRbDpiU=
X-Received: by 2002:a17:90a:ff18:: with SMTP id ce24mr12342106pjb.123.1569621504669;
 Fri, 27 Sep 2019 14:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj85tOp8WjcUp6gwstp4Cg2WT=p209S=fOzpWAgqqQPKg@mail.gmail.com>
 <20190915145905.hd5xkc7uzulqhtzr@willie-the-truck> <25289.1568379639@warthog.procyon.org.uk>
 <28447.1568728295@warthog.procyon.org.uk> <20190917170716.ud457wladfhhjd6h@willie-the-truck>
 <15228.1568821380@warthog.procyon.org.uk> <5385.1568901546@warthog.procyon.org.uk>
 <20190923144931.GC2369@hirez.programming.kicks-ass.net> <20190927095107.GA13098@andrea>
 <20190927124929.GB4643@worktop.programming.kicks-ass.net> <CAKwvOd=pZYiozmGv+DVpzJ1u9_0k4CXb3M1EAcu22DQF+bW0fA@mail.gmail.com>
In-Reply-To: <CAKwvOd=pZYiozmGv+DVpzJ1u9_0k4CXb3M1EAcu22DQF+bW0fA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 27 Sep 2019 14:58:13 -0700
Message-ID: <CAKwvOd=LAdy5vMMfiadkHBmySG3BySzjpzQtKjadu7x6NEx8vQ@mail.gmail.com>
Subject: Re: Do we need to correct barriering in circular-buffers.rst?
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 27, 2019 at 1:43 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 27, 2019 at 5:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > Barring LTO the above works for perf because of inter-translation-unit
> > function calls, which imply a compiler barrier.
> >
> > Now, when the compiler inlines, it looses that sync point (and thereby
> > subtlely changes semantics from the non-inline variant). I suspect LTO
> > does the same and can cause subtle breakage through this transformation.
>
> Do you have a bug report or godbolt link for the above?  I trust that
> you're familiar enough with the issue to be able to quickly reproduce
> it?  These descriptions of problems are difficult for me to picture in
> code or generated code, and when I try to read through
> memory-barriers.txt my eyes start to glaze over (then something else
> catches fire and I have to go put that out).  Having a concise test
> case I think would better illustrate potential issues with LTO that
> we'd then be able to focus on trying to fix/support.
>

Further, if we identified a case were the existing invariants were
broken under LTO, such a case could be added to
CONFIG_DEBUG_LOCKING_API_SELFTESTS (or whatever the most appropriate
kself test is).

-- 
Thanks,
~Nick Desaulniers
