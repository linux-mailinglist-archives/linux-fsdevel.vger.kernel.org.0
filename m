Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C61346E0C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2019 06:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbfFOEB0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jun 2019 00:01:26 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:44794 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfFOEB0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jun 2019 00:01:26 -0400
Received: by mail-lf1-f51.google.com with SMTP id r15so3003029lfm.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2019 21:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNCCQDzXq6yRFhVLoEUQSeznUefXALf/b6AvjDf5zbk=;
        b=K+NlbgNmc77iE+WvrjEBgMNlZucBcKdO/O5/nk7OZOBx6QGiPLKgW6xHqeUKR/z1/9
         zyhhdNgrB4+1BFo6Zu6tRLbi1YgVBxzcym14Fw3e1Cvu/GabpqLG0GbD6xnKbRNydIPE
         3038hUhYpnFUOgY2FK0lkFrB+J3deHeUX1FtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LNCCQDzXq6yRFhVLoEUQSeznUefXALf/b6AvjDf5zbk=;
        b=MJaoZGF6y9tRwCUrDXrUgbZZt2SFJGzIwOrqDe++KmbjiE5r1eU+43AwwpagyXXN0w
         r05Ev0bPN9riZP9/AruzKAHT2VE+DsQ/4Zw0bL4c8bWGZvmcb1omLcXfRgEsD4DruV7m
         HyHtBUlqoV84yj0OH1bMYpd0BPuFUWSiXKdWhRte24sD+n7W9HVSuBzM0ASK4J4ZX5e3
         TD+nTJZ9WqiE0/A8cT/sw9rMrV+wvvTuIzwF2dOK36tg11CBQL1gdUL6Hxv0PCw8mzeG
         kckKYlUyFpNABtJ67RIT6S2lqiW3A/DSWOLvOwjfma+BLpjuicw2F7fIYTRcKuHAwLCM
         3ogg==
X-Gm-Message-State: APjAAAXpZ+6hZoM8YKiuCgl5UnF+ojc/1VroTwoW3rYBACtIQ4N1BRJp
        qMXS7wTX8VXjYA8R2lw8CgYhpkiucJk=
X-Google-Smtp-Source: APXvYqylm0jY7Zh+scteXSQuuKBwBbUdFk6dbPobs1BFd3B+GX3ZQoE17q7UTyAF2tNN1TXSPs7IRA==
X-Received: by 2002:a19:740e:: with SMTP id v14mr51779692lfe.144.1560571284436;
        Fri, 14 Jun 2019 21:01:24 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x20sm886616ljc.15.2019.06.14.21.01.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 21:01:24 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id m23so4248896lje.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2019 21:01:23 -0700 (PDT)
X-Received: by 2002:a2e:b003:: with SMTP id y3mr18772815ljk.72.1560571283486;
 Fri, 14 Jun 2019 21:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel> <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel> <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel> <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
In-Reply-To: <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Jun 2019 18:01:07 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
Message-ID: <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
Subject: Re: pagecache locking (was: bcachefs status update) merged)
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 5:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I do not believe that posix itself actually requires that at all,
> although extended standards may.

So I tried to see if I could find what this perhaps alludes to.

And I suspect it's not in the read/write thing, but the pthreads side
talks about atomicity.

Interesting, but I doubt if that's actually really intentional, since
the non-thread read/write behavior specifically seems to avoid the
whole concurrency issue.

The pthreads atomicity thing seems to be about not splitting up IO and
doing it in chunks when you have m:n threading models, but can be
(mis-)construed to have threads given higher atomicity guarantees than
processes.

               Linus
