Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A1326ADA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 21:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgIOTd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 15:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgIOTdG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:33:06 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F8C061788
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 12:33:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so3834945ljg.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4adhV9rWK5fVJfVLfsA1RpAgGhE1SKba3wPMEBwlHQ=;
        b=RMErlYgJlXkb0Vz5F+GbJlAflS7CDOBEDAnHgQ6XVorvnlASnwLA1/u0rSrYkXuFQM
         mNgrBeUfGtILyZVOTcMIj+g0bkAfmvZpba3gU5I2q4S9ORj5JefAeBSRKnVWXI5NSMTF
         vNpL7v5vEzpKJDwkYko3HD1FM2oHMq+fF9Jz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4adhV9rWK5fVJfVLfsA1RpAgGhE1SKba3wPMEBwlHQ=;
        b=KKQhBCLiXR2UQm81xtukCsXcLEGTdiPJXqkO2iocC/9iwEgLZ/vkmJJUKwFLUjqCaY
         SC3Mo6YYsAMPot2sUnmm1MdAlcMwz5syW1L4VdgHUXiJ2AQFhbjVyTZpcHA4l1KW3q02
         aL1ywv9IX2f1NLExRexc81gK9vMAm1m1n3YWiQpdLWPW3zMrLwVMxJ1t4aj1nGNT/QCe
         9MjZ91gympiG/6eMmbz+vaReO/srLBYr+CXXTup8kpw03bAWzxYsI9jY7A7rh/MOMDzu
         Hno8/m2J8RpiR9XZcJjYDFTg3Jb56vBlpsjmxUoo/bAUeqIk2cVJs0OdJXGbYNasTcZ2
         F7mw==
X-Gm-Message-State: AOAM533pHgqK36HEtcHTPRb80BJWcuk7hwQeQQB/y/nmzeJCsbps02CJ
        U3Amvz9/tdUSRDeo24q/+5Q0ZSHM18zSEw==
X-Google-Smtp-Source: ABdhPJxKTFO8064GQlgQHvK+x55IfOTGrc82FQ795sRNqK9f2hkCjS1HfrAPX54py6MPV60FnZdEGQ==
X-Received: by 2002:a2e:8541:: with SMTP id u1mr8052006ljj.101.1600198383014;
        Tue, 15 Sep 2020 12:33:03 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 16sm4265067ljr.3.2020.09.15.12.33.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 12:33:01 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id u21so3856674ljl.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 12:33:01 -0700 (PDT)
X-Received: by 2002:a2e:7819:: with SMTP id t25mr6952577ljc.371.1600198380912;
 Tue, 15 Sep 2020 12:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net> <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
 <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net> <CAHk-=wimdSWe+GVBKwB0_=ZKX2ZN5JEqK5yA99toab4MAoYAsg@mail.gmail.com>
 <CAHk-=wimjnAsoDUjkanC2BQTntwK4qtzmPdBbtmgM=MMhR6B2w@mail.gmail.com> <a9faedf1-c528-38e9-2ac4-e8847ecda0f2@tessares.net>
In-Reply-To: <a9faedf1-c528-38e9-2ac4-e8847ecda0f2@tessares.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Sep 2020 12:32:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHPE3Q-qARO+vqbN0FSHwQXCYSmKcrjgxqVLJun5DjhA@mail.gmail.com>
Message-ID: <CAHk-=wiHPE3Q-qARO+vqbN0FSHwQXCYSmKcrjgxqVLJun5DjhA@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 12:26 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> I don't know if this info is useful but I just checked and I can
> reproduce the issue with a single CPU.

Good thinking.

> And the trace is very similar to the previous one:

.. and yes, now there are no messy traces, they all have that
__lock_page_killable() unambiguously in them (and the only '?' entries
are just from stale stuff on the stack which is due to stack frames
that aren't fully initialized and old stack frame data shining
through).

So it does seem like the previous trace uncertainty was likely just a
cross-CPU issue.

Was that an actual UP kernel? It might be good to try that too, just
to see if it could be an SMP race in the page locking code.

After all, one such theoretical race was one reason I started the rewrite.

                       Linus
