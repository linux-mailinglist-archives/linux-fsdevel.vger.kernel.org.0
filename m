Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2413DC148
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 00:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhG3WyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 18:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhG3WyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:54:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D07EC06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 15:53:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x8so7521437lfe.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 15:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYbtWfX/VpaE9nHQJkZCw7fSJcFmIUlyV/5TayfE7hA=;
        b=Fqxp+6NowYbKv5rRJ/gXfT9fQE7WNRfQMz7ewsVfXqQCI/6qccNDGPRAZ8zIWLRWJw
         fn5tMHr8L2OzrRt1sMfOgIznX3bwi2JxoMG5PJWoRba5cMouN2loaRB8zJe9tVwaWunw
         MagpwR4oinoVQdlPXNhpjkx0/5EUNLis/kcmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYbtWfX/VpaE9nHQJkZCw7fSJcFmIUlyV/5TayfE7hA=;
        b=PgP3vWPXydFCsB/3VnFmLdHyTHWlTMagiiNgfLZ5aQK/5+hq8UUOjADJP/1hQ5hKVm
         kWWve7MtYXgnG5pDBAvpt/vwIBkEOicSIolnSFjSjWivFKASDdPPwlYftW6K1jCNc7TZ
         wazKbXHcp3OVYjCZL9Qie4hgo+e/9lJaBvPiqm/26N+glc7gGU3ycsW/Xl6eWIkYZM9d
         aFOeK+LefiZ+QgxbwWXMQNseUpRrTtjMhjHPK0R5lH2KK7EkwhKJKb/6O1bf4wEV2UBs
         7ciegloQbFI/OzZDmmBwVXNQnHyJQ2nZ1y21stSGBOjiv4RB4elIu+TvEzbp6JIqj5P8
         BXMw==
X-Gm-Message-State: AOAM533ssuEqSw11SApDLNGNA088V/t6Hriijk+aoyKDKQgXiiXRbttf
        TGRd7CYh/LZDZwiLyu9OoISvMb3drk1GS77g3Wc=
X-Google-Smtp-Source: ABdhPJyR/1qA6BCfL02vD7vuZeHXD42ciVglGYpTfEo4EBfEzcaRDbd22gLBOAnR6WFyTzc8LB/DIw==
X-Received: by 2002:a19:d609:: with SMTP id n9mr3699232lfg.198.1627685632814;
        Fri, 30 Jul 2021 15:53:52 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id m6sm281578lfo.0.2021.07.30.15.53.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 15:53:51 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id z2so20928245lft.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 15:53:50 -0700 (PDT)
X-Received: by 2002:ac2:44ad:: with SMTP id c13mr3528996lfm.377.1627685630269;
 Fri, 30 Jul 2021 15:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210729222635.2937453-1-sspatil@android.com> <20210729222635.2937453-2-sspatil@android.com>
 <CAHk-=wh-DWvsFykwAy6uwyv24nasJ39d7SHT+15x+xEXBtSm_Q@mail.gmail.com>
 <cee514d6-8551-8838-6d61-098d04e226ca@android.com> <CAHk-=wjStQurUzSAPVajL6Rj=CaPuSSgwaMO=0FJzFvSD66ACw@mail.gmail.com>
In-Reply-To: <CAHk-=wjStQurUzSAPVajL6Rj=CaPuSSgwaMO=0FJzFvSD66ACw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jul 2021 15:53:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrfasYJUaZ-rJmYt9xa=DqmJ5-sVRG7cJ2X8nNcSXp9g@mail.gmail.com>
Message-ID: <CAHk-=wjrfasYJUaZ-rJmYt9xa=DqmJ5-sVRG7cJ2X8nNcSXp9g@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: pipe: wakeup readers everytime new data written
 is to pipe
To:     Sandeep Patil <sspatil@android.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 12:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll mull it over a bit more, but whatever I'll do I'll do before rc4
> and mark it for stable.

Ok, I ended up committing the minimal possible change (and fixing up
the comment above it).

It's very much *not* the original behavior either, but that original
behavior was truly insane ("wake up for each hunk written"), and I'm
trying to at least keep the kernel code from doing actively stupid
things.

Since that old patch of mine worked for your test-case, then clearly
that realm-core library didn't rely on _that_ kind of insane internal
kernel implementation details exposed as semantics. So The minimal
patch basically says "each write() system call wil do at least one
wake-up, whether really necessary or not".

I also intentionally kept the read side untouched, in that there
apparently still isn't a case that would need the confused semantics
for read events.

End result: the commit message is a lot bigger than the patch, with
most of it being trying to explain the background.

I've pushed it out as commit 3a34b13a88ca ("pipe: make pipe writes
always wake up readers"). Holler if you notice anything odd remaining.

              Linus
