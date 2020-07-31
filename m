Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE2F234A61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbgGaRmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 13:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733265AbgGaRmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:42:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66796C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 10:42:08 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id s9so17292915lfs.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=28cR6MxZbujlZ14NZ0HVtiSgAqlUlORhwpPRlaJnnaw=;
        b=ARF0tJgweiX8TuwD/1AuE8ihqF28A/0GG/2hOKEe5zsa5dn6IQ7vjuiCyXUDIEpTTu
         zkma0hSorXfSXFzP5ErNIzvSEoDve/Vh8jrM5DAnEExvyO5v/D6+sPEczzTrI1FPjJfl
         t4GEgq5BrOqFLTYFU8zRTlt69XfwnP6VESCBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28cR6MxZbujlZ14NZ0HVtiSgAqlUlORhwpPRlaJnnaw=;
        b=EhCkQonEdXTXzqiQrND2xmI5ipxRgudeWPIuJiddbnjGWKzfZhbwVczeitqbqmid/C
         KMfLBEwAAXEKHJM9Tf5MVmovzdJTYkvx2j8PwTQ81KrrGIJIC5kwg5j9QZ34b07ZDchJ
         bbjFWc3IcyK7tG0fyE4541ATua5GUX3O7gXdiK1dQ3Wh/eLtwUsH6KP3SritqyZA85lh
         C5588+6jYNi4vp2pmtsHJ33wJjVvbTihmqqoT68gtA2zY4t9tAvBCOMo9Z91B830ywZm
         j3/bKxgfRTEDXN97NhmOfUH+AdhisfmRYHd1qClqK8vu4rfY6QJNH7px5BwUp/VQ2qz5
         XGJQ==
X-Gm-Message-State: AOAM531S3f5lcVhv2C2xzv5fy5joU0EWpOTD3EPTqFYrA9Ixu7tQrxC2
        3qwPGa31EhlrqfhK5QJHf9p8L/PIoAY=
X-Google-Smtp-Source: ABdhPJzcNsKJZlDPPICzYnJA20wtyk8HwGAGJWFVcQQcq5rdnE3BTd5BDtaxdyEzBSK1odJT1soS9A==
X-Received: by 2002:a05:6512:3583:: with SMTP id m3mr2492517lfr.146.1596217326422;
        Fri, 31 Jul 2020 10:42:06 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id o68sm2074330lff.57.2020.07.31.10.42.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 10:42:05 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id s16so18021463ljc.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 10:42:04 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr2425348ljj.312.1596217324449;
 Fri, 31 Jul 2020 10:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <87h7tsllgw.fsf@x220.int.ebiederm.org> <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
 <87d04fhkyz.fsf@x220.int.ebiederm.org> <87h7trg4ie.fsf@x220.int.ebiederm.org>
 <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
 <878sf16t34.fsf@x220.int.ebiederm.org> <87pn8c1uj6.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wjMcHGDh8Wx+dwaYHOGVNN+zzCPEKZEc5qb3spsEydNKg@mail.gmail.com> <87pn8by58y.fsf@x220.int.ebiederm.org>
In-Reply-To: <87pn8by58y.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Jul 2020 10:41:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_5Lu_3OACT4pSqrf1eJ3=PR_fUjL1vLSbBZM2_OAC5w@mail.gmail.com>
Message-ID: <CAHk-=wh_5Lu_3OACT4pSqrf1eJ3=PR_fUjL1vLSbBZM2_OAC5w@mail.gmail.com>
Subject: Re: [RFC][PATCH] exec: Conceal the other threads from wakeups during exec
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 31, 2020 at 10:19 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Even limited to opt-in locations I think the trick of being able to
> transform the wait-state may solve that composition problem.

So the part I found intriguing was the "catch things in the signal
handling path".

Catching things there - and *only* there - would avoid a lot of the
problems we had with the freezer. When you're about to return to user
mode, there are no lock inversions etc.

And it kind of makes conceptual sense to do, since what you're trying
to capture is the signal group - so using the signal state to do so
seems like a natural thing to do. No touching of any runqueues or
scheduler data structures, do everything _purely_ with the signal
handling pathways.

So that "feels" ok to me.

That said, I do wonder if there are nasty nasty latency issues with
odd users. Normally, you'd expect that execve() with other threads in
the group shouldn't be a performance issue, because people simply
shouldn't do that. So it might be ok.

And if you capture them all in the signal handling pathway, that ends
up being a very convenient place to zap them all too, so maybe my
latency worry is misguided.

IOW, I think that you could try to do your "freese other threads" not
at all like the freezer, but more like a "collect all threads in their
signal handler parts as the first phase of zapping them".

So maybe this approach is salvageable. I see where something like the
above could work well. But I say that with a lot of handwaving, and
maybe if I see the patch I'd go "Christ, I was a complete idiot for
ever even suggesting that".

                    Linus
