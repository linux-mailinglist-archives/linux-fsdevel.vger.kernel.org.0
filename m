Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CC62E6C51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Dec 2020 00:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbgL1Wzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgL1Ti3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:38:29 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38003C061793;
        Mon, 28 Dec 2020 11:37:49 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id m23so10331895ioy.2;
        Mon, 28 Dec 2020 11:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCBCEsht9qkuf5Ona8kNwyBV6hGMdb7gZ2iBC9FCRP4=;
        b=Q9TFyFiU7kqB2e88OvbB+lyrxcqI/TwitqgP1IRr2q0KyCnDwRUvNMmbcq/LEBjqsW
         /Y5dx1Q06XyUqXGZjLbFw2iHPeeK93uA0ylkM67TpDI/HIAWTNTqNG96uzh3CGn1me3X
         8zzi6Q0LFo7dkNPzNvt6pYi5Qx/LnklEoUg2xKmSZZNriamx9QpU3wdtxg1j8Cxs4NW4
         BCuMNLC0Rxwu1nF6lfYzNDzXViws/ObGDaJxXzSu5REzpnhHnHWqYHLqXRKBqfJOr5vp
         b8n63vg6pkw+JKr7g8q6DfJSo56I61rHrZsimKFOIj3SK+4VwRE7gz57NoLAFiAFPl1z
         XlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCBCEsht9qkuf5Ona8kNwyBV6hGMdb7gZ2iBC9FCRP4=;
        b=Zl5CjcWqttiletmGIAXFJRwHyUG4CSun7387arNXuxgL6mPb8Jq0kQ89ZZKm/tS4rl
         KWMA8+4u3kPL7YMxj2TZh36R0f0YwXq2gGfMKA7he1hYKLUgGUy5dIAc98CR8L4nXiAd
         nmXBP9ONp8yBpJa3BLINPMlzR4Z8ebgh66bMxlAsaEcjcHEHGjPk2m8EnYwDYKrRzsOM
         9lFWF5pOpyru858eyRQBA7lw50eilnuDYORRK/04QbPIpPWQkOalxD9GGc9KWxvz4OPB
         7D4YF+KczH+Ekcgar1ufNMDqHUd3wjk96njekm/HkEliep7mFVbxSUNDtG053tfI7qxh
         Lr8A==
X-Gm-Message-State: AOAM530dnL/SkEXkMrr4wPdvjr3awNy2vEE/mbX1iMMypKBNSKTi+HWb
        NybL2QSIqEmRhIizDYXiLh88QYvW/u3Wy9httTc=
X-Google-Smtp-Source: ABdhPJw7C7qxRijlGNpz54cxtrCtrh8jFk9tDMaZzuvDrGOoZYY3dhbizc2BsSDNyomhfLcDoRpzH8Ul4lCQrIfgFfo=
X-Received: by 2002:a5e:de08:: with SMTP id e8mr37384460iok.203.1609184268515;
 Mon, 28 Dec 2020 11:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223185044.GQ874@casper.infradead.org> <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org> <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org> <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20201224121352.GT874@casper.infradead.org> <CAOQ4uxj5YS9LSPoBZ3uakb6NeBG7g-Zeu+8Vt57tizEH6xu0cw@mail.gmail.com>
 <1334bba9cefa81f80005f8416680afb29044379c.camel@kernel.org>
 <20201228155618.GA6211@casper.infradead.org> <5bc11eb2e02893e7976f89a888221c902c11a2b4.camel@kernel.org>
In-Reply-To: <5bc11eb2e02893e7976f89a888221c902c11a2b4.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 28 Dec 2020 21:37:37 +0200
Message-ID: <CAOQ4uxhFz=Uervz6sMuz=RcFUWAxyLEhBrWnjQ+U0Jj_AaU59w@mail.gmail.com>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
To:     Jeff Layton <jlayton@kernel.org>, Sargun Dhillon <sargun@sargun.me>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 28, 2020 at 7:26 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Mon, 2020-12-28 at 15:56 +0000, Matthew Wilcox wrote:
> > On Mon, Dec 28, 2020 at 08:25:50AM -0500, Jeff Layton wrote:
> > > To be clear, the main thing you'll lose with the method above is the
> > > ability to see an unseen error on a newly opened fd, if there was an
> > > overlayfs mount using the same upper sb before your open occurred.
> > >
> > > IOW, consider two overlayfs mounts using the same upper layer sb:
> > >
> > > ovlfs1                              ovlfs2
> > > ----------------------------------------------------------------------
> > > mount
> > > open fd1
> > > write to fd1
> > > <writeback fails>
> > >                             mount (upper errseq_t SEEN flag marked)
> > > open fd2
> > > syncfs(fd2)
> > > syncfs(fd1)
> > >
> > >
> > > On a "normal" (non-overlay) fs, you'd get an error back on both syncfs
> > > calls. The first one has a sample from before the error occurred, and
> > > the second one has a sample of 0, due to the fact that the error was
> > > unseen at open time.
> > >
> > > On overlayfs, with the intervening mount of ovlfs2, syncfs(fd1) will
> > > return an error and syncfs(fd2) will not. If we split the SEEN flag into
> > > two, then we can ensure that they both still get an error in this
> > > situation.
> >
> > But do we need to?  If the inode has been evicted we also lose the errno.
> > The guarantee we provide is that a fd that was open before the error
> > occurred will see the error.  An fd that's opened after the error occurred
> > may or may not see the error.
> >
>
> In principle, you can lose errors this way (which was the justification
> for making errseq_sample return 0 when there are unseen errors). E.g.,
> if you close fd1 instead of doing a syncfs on it, that error will be
> lost forever.
>
> As to whether that's OK, it's hard to say. It is a deviation from how
> this works in a non-containerized situation, and I'd argue that it's
> less than ideal. You may or may not see the error on fd2, but it's
> dependent on events that take place outside the container and that
> aren't observable from within it. That effectively makes the results
> non-deterministic, which is usually a bad thing in computing...
>

I understand that user experience inside containers will deviate from
non containerized use cases. I can't say that I fully understand the
situations that deviate.

Having said that, I never objected to the SEEN flag split.
To me, the split looks architecturally correct. If not for anything else,
then for not observing past errors inside the overlay mount.
I think you still need to convince Matthew though.

The question remains what, if anything, should be nominated for
stable. I was trying to propose the minimal patch that fixes the
most basic syncfs overlayfs issues. In that context, it seemed
that the issues that SEEN flag split solves are not on the
MUST HAVE list, but maybe I am wrong.

Sargun,

How about sending another version of your patch, with or without the
SEEN flag split (up to you) but not only for both the volatile and non-
volatile cases, following my proposal.

At least we can continue debating on a concrete patch instead of
an envisioned combination of pieces posted to the list.

If you can give some examples of use cases that the patch fixes
with and without the SEEN flag split that could be useful for the
discussion.

Thanks,
Amir.
