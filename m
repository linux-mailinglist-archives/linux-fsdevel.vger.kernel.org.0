Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF32A3D7C99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhG0Rv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 13:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhG0Rv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:51:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C89CC061757
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 10:51:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a26so23034807lfr.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBk5RRCD2iLIhOK5co1TZE5o+SAQV6EEDJtV9mSx3y4=;
        b=cHnY7pFfsAdkQyfJFNg5EaWUnAvGvmdR6YdJ+HmkdJ6abnT5bydaZvX2wtF+ok6nr4
         7AGzXW9dGdx60YszoBA4wNaFmE747x3Kk2TBtM5CDprIKnApwqYEvPDQPEyogBzV7JX7
         14joPYpiwvuQTijyCdwG44D45lS6M1/RP7VVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBk5RRCD2iLIhOK5co1TZE5o+SAQV6EEDJtV9mSx3y4=;
        b=ev31zpWRWKN8PI8wFr+1q/QoNdwsDY8hODw59CDliDPXtEIhgAi/4zj/gohi+Vb/yl
         Q7rn4keD3Fa1NxGz9JJJXRC/Xd5ZxpC9tSEbr4TYDwUdofBrwARV8Fxt9OkSEdfgzIzw
         OKwe0oODDVvYXRr8I0YfjuIJLeNobMUrA4V9/VSaLOvNW8POGaZDDdYwz4fVwNpSml9m
         bFw8qxOYzJqYkZurG7mT8CP7ob21V3yhno5YYF7Iir0jbjaa2EnDNBlsfZlqOFIVF5Fr
         ScJqY0MjkbiynexJKhhFuKi1/boF2WRflKuGG4GoZPo4lxPCNnVA6C3bUJMAZCEGRpLX
         j5Tg==
X-Gm-Message-State: AOAM533C3veL/SHc5IBoh3RamQfyCaeNs8fUQl4GfbMUZ0tjuEAmbzMN
        LNmDNwg4jFJFsFk3NIYGpSpqsbC/66QCVQf/pfo=
X-Google-Smtp-Source: ABdhPJy5ZP3+rrjuK+r4xz1fBR15xH8WTMDfEEqF47aAK+on+C+eENwUDaDNipas1/8wrLJENp30gQ==
X-Received: by 2002:ac2:55b4:: with SMTP id y20mr17125434lfg.423.1627408315684;
        Tue, 27 Jul 2021 10:51:55 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id a9sm350158lfs.186.2021.07.27.10.51.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 10:51:54 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id e5so17012552ljp.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 10:51:54 -0700 (PDT)
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr15961914ljg.251.1627408314168;
 Tue, 27 Jul 2021 10:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210724193449.361667-1-agruenba@redhat.com> <20210724193449.361667-2-agruenba@redhat.com>
 <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com>
 <03e0541400e946cf87bc285198b82491@AcuMS.aculab.com> <CAHc6FU4N7vz+jfoUSa45Mr_F0Ht0_PXroWoc5UNkMgFmpKLaNw@mail.gmail.com>
In-Reply-To: <CAHc6FU4N7vz+jfoUSa45Mr_F0Ht0_PXroWoc5UNkMgFmpKLaNw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jul 2021 10:51:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whemWRZRDDvHnesBbTo1hO2qkWkMtGUSfPvEOq7kAfouQ@mail.gmail.com>
Message-ID: <CAHk-=whemWRZRDDvHnesBbTo1hO2qkWkMtGUSfPvEOq7kAfouQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] iov_iter: Introduce iov_iter_fault_in_writeable helper
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 4:14 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> On Tue, Jul 27, 2021 at 11:30 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > Is it actually worth doing any more than ensuring the first byte
> > of the buffer is paged in before entering the block that has
> > to disable page faults?
>
> We definitely do want to process as many pages as we can, especially
> if allocations are involved during a write.

Yeah, from an efficiency standpoint, once you start walking page
tables, it's probably best to just handle as much as you can.

But once you get an error, I don't think it should be "everything is bad".

This is a bit annoying, because while *most* users really just want
that "everything is good", *some* users might just want to handle the
partial success case.

It's why "copy_to/from_user()" returns the number of bytes *not*
written, rather than -EFAULT like get/put_user(). 99% of all users
just want to know "did I write all bytes" (and then checking for a
zero return is a simple and cheap verification of "everything was
ok").

But then very occasionally, you hit a case where you actually want to
know how much of a copy worked. It's rare, but it happens, and the
read/write system calls tend to be the main user of it.

And yes, the fact that "copy_to/from_user()" doesn't return an error
(like get/put_user() does) has confused people many times over the
years. It's annoying, but it's required by those (few) users that
really do want to handle that partial case.

I think this iov_iter_fault_in_readable/writeable() case should do the same.

And no, it's not new to Andreas' patch. iov_iter_fault_in_readable()
is doing the "everything has to be good" thing already.

Which maybe implies that nobody cares about partial reads/writes. Or
it's very very rare - I've seen code that handles page faults in user
space, but it's admittedly been some very special CPU
simulator/emulator checkpointing stuff.

               Linus
