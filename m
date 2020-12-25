Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEC82E2A0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Dec 2020 07:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgLYGvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Dec 2020 01:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgLYGvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Dec 2020 01:51:17 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D1DC061573;
        Thu, 24 Dec 2020 22:50:37 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id q137so3493852iod.9;
        Thu, 24 Dec 2020 22:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I41NoPE2PFeA6hnau+XUtVHcpXOt5PQjNu23pBB7t2U=;
        b=DuPsaCLcoHgwNBZRe3f034K5cLHK4ORuMrnJdwlDWSl3W8qzIJb3EK2kcfQksI0WiZ
         4xyX3QsxvpbzMuip410pA8t+NbmM2dGUd8Q+ceE9PIxPfhxmYAaWc/B+NhMHJv6fZmug
         tBaH3GmpFAgnTPCbfLeTqync4w2gNLAZQIsblJVqaV5QEIwSSNRAXnnUeekhO6jwpjnN
         nlm3c2ytAYFshGk4aenLMjfjHX8B+vz9sxCNHrVLCHbvK4tFDlCA/9BOEnkXJK+6W0BG
         BDvh5DZ70rWGXLG5gdir67xHBcODjzXyBmVGVXJO0BNunYu6wq0aYLUMjqQuVTLzSe8U
         2TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I41NoPE2PFeA6hnau+XUtVHcpXOt5PQjNu23pBB7t2U=;
        b=pX7koRfoNvHr1UJ12B1UdWggPjNZTMywV54m6ILzQ3N2IxKEXPbxfnwsATH4IMdjun
         WARoOn2pp4oYDDEtouZTUdGPyRAMoEM0oJrH+f+z6L76wd7RPqrxZDVydNqfQS5Quy+w
         FADhfFkAHRG/MsgMZMqTHVUMgJBkLNo2VZqs7DyszUXAiwWPIve+VzBgaEOl6Zb7Wv07
         pGXLL5SwSXq2SY32PpcLsvgWjWT+CG24Gs7HaWz6rjeT6A+uY2ZNxPC+tQjlM5uyCnKY
         9eHAM+4JJ9rlAfIxiwphAjUe+gRoO/90SoEi3DfKt8vPprRlUyQ8BUVxLYMoPdgbOI3e
         JR0w==
X-Gm-Message-State: AOAM533TUOIb4hvxjWaZW7qxE38+x0V6HNGjeRFZ5KX9IZC7wYOO3skH
        8alOvHKBbIzchtlmTzV7ZkuDkg20nOA++xQV9Pc=
X-Google-Smtp-Source: ABdhPJxW/7olVTwSLSxAeDUa9+MyGpck3OUpRCcWnhkXvdhNMekK8dnYLB8VUVELPkQvghbeq+v8sxS9ebPGitS3nHo=
X-Received: by 2002:a02:a60a:: with SMTP id c10mr28503608jam.123.1608879036430;
 Thu, 24 Dec 2020 22:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20201221195055.35295-1-vgoyal@redhat.com> <20201221195055.35295-4-vgoyal@redhat.com>
 <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223185044.GQ874@casper.infradead.org> <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org> <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org> <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20201224121352.GT874@casper.infradead.org>
In-Reply-To: <20201224121352.GT874@casper.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 25 Dec 2020 08:50:25 +0200
Message-ID: <CAOQ4uxj5YS9LSPoBZ3uakb6NeBG7g-Zeu+8Vt57tizEH6xu0cw@mail.gmail.com>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
To:     Matthew Wilcox <willy@infradead.org>,
        Sargun Dhillon <sargun@sargun.me>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 24, 2020 at 2:13 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Dec 24, 2020 at 11:32:55AM +0200, Amir Goldstein wrote:
> > In current master, syncfs() on any file by any container user will
> > result in full syncfs() of the upperfs, which is very bad for container
> > isolation. This has been partly fixed by Chengguang Xu [1] and I expect
> > his work will be merged soon. Overlayfs still does not do the writeback
> > and syncfs() in overlay still waits for all upper fs writeback to complete,
> > but at least syncfs() in overlay only kicks writeback for upper fs files
> > dirtied by this overlay.
> >
> > [1] https://lore.kernel.org/linux-unionfs/CAJfpegsbb4iTxW8ZyuRFVNc63zg7Ku7vzpSNuzHASYZH-d5wWA@mail.gmail.com/
> >
> > Sharing the same SEEN flag among thousands of containers is also
> > far from ideal, because effectively this means that any given workload
> > in any single container has very little chance of observing the SEEN flag.
>
> Perhaps you misunderstand how errseq works.  If each container samples
> the errseq at startup, then they will all see any error which occurs
> during their lifespan

Meant to say "...very little chance of NOT observing the SEEN flag",
but We are not in disagreement.
My argument against sharing the SEEN flag refers to Vivek's patch of
stacked errseq_sample()/errseq_check_and_advance() which does NOT
sample errseq at overlayfs mount time. That is why my next sentence is:
"I do agree with Matthew that overlayfs should sample errseq...".

> (and possibly an error which occurred before they started up).
>

Right. And this is where the discussion of splitting the SEEN flag started.
Some of us want to treat overlayfs mount time as a true epoc for errseq.
The new container didn't write any files yet, so it should not care about
writeback errors from the past.

I agree that it may not be very critical, but as I wrote before, I think we
should do our best to try and isolate container workloads.

> > To this end, I do agree with Matthew that overlayfs should sample errseq
> > and the best patchset to implement it so far IMO is Jeff's patchset [2].
> > This patch set was written to cater only "volatile" overlayfs mount, but
> > there is no reason not to use the same mechanism for regular overlay
> > mount. The only difference being that "volatile" overlay only checks for
> > error since mount on syncfs() (because "volatile" overlay does NOT
> > syncfs upper fs) and regular overlay checks and advances the overlay's
> > errseq sample on syncfs (and does syncfs upper fs).
> >
> > Matthew, I hope that my explanation of the use case and Jeff's answer
> > is sufficient to understand why the split of the SEEN flag is needed.
> >
> > [2] https://lore.kernel.org/linux-unionfs/20201213132713.66864-1-jlayton@kernel.org/
>
> No, it still feels weird and wrong.
>

All right. Considering your reservations, I think perhaps the split of the
SEEN flag can wait for a later time after more discussions and maybe
not as suitable for stable as we thought.

I think that for stable, it would be sufficient to adapt Surgun's original
syncfs for volatile mount patch [1] to cover the non-volatile case:
on mout:
- errseq_sample() upper fs
- on volatile mount, errseq_check() upper fs and fail mount on un-SEEN error
on syncfs:
- errseq_check() for volatile mount
- errseq_check_and_advance() for non-volatile mount
- errseq_set() overlay sb on upper fs error

Now errseq_set() is not only a hack around __sync_filesystem ignoring
return value of ->sync_fs(). It is really needed for per-overlay SEEN
error isolation in the non-volatile case.

Unless I am missing something, I think we do not strictly need Vivek's
1/3 patch [2] for stable, but not sure.

Sargun,

Do you agree with the above proposal?
Will you make it into a patch?

Vivek, Jefff,

Do you agree that overlay syncfs observing writeback errors that predate
overlay mount time is an issue that can be deferred (maybe forever)?

BTW, in all the discussions we always assumed that stacked fsync() is correct
WRT errseq, but in fact, fsync() can also observe an unseen error that predates
overlay mount.
In order to fix that, we will probably need to split the SEEN flag and some
more errseq acrobatics, but again, not sure it is worth the effort.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/20201202092720.41522-1-sargun@sargun.me/
[2] https://lore.kernel.org/linux-unionfs/20201222151752.GA3248@redhat.com/
