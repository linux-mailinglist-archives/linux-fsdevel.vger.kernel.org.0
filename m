Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49E326AB2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 19:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgIORx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 13:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgIORxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:53:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F504C061788
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 10:53:05 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w11so4081632lfn.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5EdDP5TwLdVY+wZC2Mc3xNI5SqRb91I6yJNFAUYDPA=;
        b=SF6ZGFUAklQG7wFEMMK7S8YbMY6pG0AwQL8q0xidLzQvFAafGZhYPU7XRuqfSClCLm
         XCeDRH62u3B/2ufMPQWjq3JySnOhdMP1u8SxO/aKybwicZpKMtUR3ToTvG/VSYoRcn52
         z6zQr8NVsuG5WXwCh4d14g31PkQgn9QF5mNE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5EdDP5TwLdVY+wZC2Mc3xNI5SqRb91I6yJNFAUYDPA=;
        b=WxcAVpsCC1IXaObhvgdKBXW7SmpjWecQXwmsLOTjAsJzqTFB9Lvd09dlYEQBmFJkiW
         jc6axJS/yvEUOaXUm6kezr4bm7jEdxC4C5NS+5kuJhhVr+CumaIGucmdOe7u3nLUrJ61
         e+YCxdHBA4LZ2hSCNwU3mv1s6GGdxjgDqjEtKCBRvWut14Ffm6R6SsqViHtQaW0wxmQf
         Z6mKQJmqFSeFTv1HMMni5ZGBjlennQF8gCGUz2cM876HUDjsD2friSihuLfhFL0FuGzG
         aEoVslOnkZvUqoNfPdt8w0P7X+ujYQm6c6QV8ULsXpwh0TdqSaguPyuizid7piHfiiqg
         FfoA==
X-Gm-Message-State: AOAM533jMuOLa35io36Il0/LeSvCCs9OccewgG4u5GuI7ltp7TGl5rIv
        /GCLMmHPhA8mfLhlVdcAbYIVk1r4abS18w==
X-Google-Smtp-Source: ABdhPJyGu/wNRZDrqu8Fbo3+ezeIYgQ8hso5IdOIl+OCOM6wB4xelVHRfilUGWHci4LsRgviPBWKmA==
X-Received: by 2002:a19:640b:: with SMTP id y11mr6068316lfb.373.1600192383289;
        Tue, 15 Sep 2020 10:53:03 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z141sm4107612lfc.171.2020.09.15.10.53.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:53:01 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id u21so3606547ljl.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 10:53:01 -0700 (PDT)
X-Received: by 2002:a05:651c:514:: with SMTP id o20mr7743769ljp.312.1600192381258;
 Tue, 15 Sep 2020 10:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <ed8442fd-6f54-dd84-cd4a-941e8b7ee603@MichaelLarabel.com>
In-Reply-To: <ed8442fd-6f54-dd84-cd4a-941e8b7ee603@MichaelLarabel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Sep 2020 10:52:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfUakuFJko5cC_gHFyCngZ9vx-NFXv=OCmAD2p4XhRig@mail.gmail.com>
Message-ID: <CAHk-=wjfUakuFJko5cC_gHFyCngZ9vx-NFXv=OCmAD2p4XhRig@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Michael Larabel <Michael@michaellarabel.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 7:22 AM Michael Larabel
<Michael@michaellarabel.com> wrote:
>
> Still running more benchmarks and on more systems, but so far at least
> as the Apache test is concerned this patch does seem to largely address
> the issue. The performance with the default 1000 page_lock_unfairness
> was yielding results more similar to 5.8 and in some cases tweaking the
> value did help improve the performance. A PLU value of 4~5 seems to
> yield the best performance.

Yeah. Although looking at those results, they are somewhat mixed - I
think the benchmark is just not very stable performance-wise.

Looking at your 250 concurrent users numbers, it's strange how that
unfairness=5 value gets performance _so_ much better than anything
else (including 5.8), so I do think that this benchmark is just very
borderline sensitive to this all, and some of the variation may just
be almost random.

We've often seen how cache placement etc can cause big differences on
benchmarks that just do one thing over and over.

But the big picture is fairly clear: apache siege absolutely hates the
complete fairness, and clearly the hybrid thing works fine.

The fact that a "unfairness count" of 4-5 seems to be consistently
fairly good (and sometimes seems clearly better than the "completely
unfair" behavior) makes me feel better about things, though. I was
suspecting that would be a somewhat reasonable value, and I _hope_
that it's small enough that it still gets rid of the watchdog issues
that the original fairness patch was aiming to fix.

> The results though with Hackbench and Redis that exhibited similar drops
> from the commit in question remained mixed.

The hackbench numbers seemed fairly randomly sensitive before too.

I wouldn't worry about it as long as there's no clear regression on a
load that seems realistic. We know the page lock is important, and we
do know that the _real_ fix in many ways is to try to not get
contention in the first place. Either by trying to avoid the page lock
entirely (ie the approach that Willy is pursuing), or by maybe trying
to have a reader-writer mode or something.

So in a very real sense, all this page lock fairness stuff is still
just a symptom of a more fundamental problem, even though I think that
the fairness itself is also a fairly fundamental thing.

                  Linus
