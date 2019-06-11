Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3DC3C321
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 06:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391120AbfFKEzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 00:55:36 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:45595 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390229AbfFKEzg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:55:36 -0400
Received: by mail-lf1-f41.google.com with SMTP id u10so8218724lfm.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2019 21:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0NVFIKvZo+cTD+d9Ui7mDkyi5Oxsx4RGqTwt9X3ykk=;
        b=J42kFBk4S2k8nsKBY9fwhx/vZSEYU/OLrOlYGuYtsIl7R1OW7G6cP1AqGwj2+yGLg2
         EYdlAVSm3K888i1Z/0BN2vG2wscFrXTIpee8gDD08eNXZ7Iutd7Co9x7wrC2XzSTo6Wr
         D0e1tE4Z4fwwQjCOh4OvXBe5BDfZKYbAU0USA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0NVFIKvZo+cTD+d9Ui7mDkyi5Oxsx4RGqTwt9X3ykk=;
        b=gjzmYz7ti7BcFcBAFOILFLo+1cxuDYo1nUM8LRQDlPlt0ALeQheIoS1paG6jgY6oul
         RIXwVRrosU/8PUJxMGEpPK7DjdJ43oHIZguRm4YpYkbzOoWj601mevWpbhqc9wIIZAT7
         IXdSjF+t6dRWsYqZL/S+vJdjtVw2eD79LhMcZ1lpyokGG1K3+pw4UWkMlOL+xf7Xz3A2
         6EjmfoZQkpo9rG7Z/CkjnbdYfzE0sr77JyitOhWpNbJ7qarTzEzAuH2qbarTF/z55BBg
         dS/lGolMdcTfoLF2muUBjRle5whKp3v5OCSH4urGRspiialu2f68HTAd7XkQAL3cdE/3
         ZjEw==
X-Gm-Message-State: APjAAAWtqGfLFRBhCVm9m/sUfGU6g51XTd1d5U6I/hAOEeD1PEeHxLJC
        aJ32g8ZYdY6rwdMKLlU0Rg3TsbNt604=
X-Google-Smtp-Source: APXvYqyPZmTAFILqJkKwy2oPQstaHeC2mxFte/PJldP+o0+jRTvGqpC/R8wZ31cF9rp6GQYwTLnXLg==
X-Received: by 2002:a19:4017:: with SMTP id n23mr39602855lfa.112.1560228933741;
        Mon, 10 Jun 2019 21:55:33 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id j90sm2334332ljb.29.2019.06.10.21.55.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 21:55:32 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id h10so4283874ljg.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2019 21:55:32 -0700 (PDT)
X-Received: by 2002:a2e:9c03:: with SMTP id s3mr23108926lji.209.1560228931996;
 Mon, 10 Jun 2019 21:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com> <20190611011737.GA28701@kmo-pixel>
In-Reply-To: <20190611011737.GA28701@kmo-pixel>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jun 2019 18:55:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=wizTF+NbMrSRG-bc-LyuT7PUJ1QRAR8q_anOd6mY+9Z4A@mail.gmail.com>
Message-ID: <CAHk-=wizTF+NbMrSRG-bc-LyuT7PUJ1QRAR8q_anOd6mY+9Z4A@mail.gmail.com>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker merged)
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 3:17 PM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
>
>
> > Why does the regular page lock (at a finer granularity) not suffice?
>
> Because the lock needs to prevent pages from being _added_ to the page cache -
> to do it with a page granularity lock it'd have to be part of the radix tree,

No, I understand that part, but I still think we should be able to do
the locking per-page rather than over the whole mapping.

When doing dio, you need to iterate over old existing pages anyway in
that range (otherwise the "no _new_ pages" part is kind of pointless
when there are old pages there), so my gut feel is that you might as
well at that point also "poison" the range you are doin dio on. With
the xarray changes, we might be better at handling ranges. That was
one of the arguments for the xarrays over the old radix tree model,
after all.

And I think the dio code would ideally want to have a range-based lock
anyway, rather than one global one. No?

Anyway, don't get me wrong. I'm not entirely against a "stop adding
pages" model per-mapping if it's just fundamentally simpler and nobody
wants anything fancier. So I'm certainly open to it, assuming it
doesn't add any real overhead to the normal case.

But I *am* against it when it has ad-hoc locking and random
anti-recursion things.

So I'm with Dave on the "I hope we can avoid the recursive hacks" by
making better rules. Even if I disagree with him on the locking thing
- I'd rather put _more_stress on the standard locking and make sure it
really works, over having multiple similar locking models because they
don't trust each other.

               Linus
