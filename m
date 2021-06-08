Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E914D39EBBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 03:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhFHB6G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 21:58:06 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:52097 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230321AbhFHB6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:58:04 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 750AC580362;
        Mon,  7 Jun 2021 21:56:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Jun 2021 21:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        d9H1flms8CAnmkfkTGXC7fqtRulSUIecdP1SarbhnhQ=; b=xojxKX2E8lqI+ts1
        su1B0PH5K3eQgfxkrK8N/NVZaLs+ouU7rmwb23GLDipImoPEUtRzhKTTYUNtwANx
        qfYz1subDb5XJEgbEer1t0wkmgu64ErOax6FdqF7VX7TKO3AesAY1Ksox70Wrx+U
        uIzrmNx8b+jCMpnbX4BayJ39Td8jGAiKud+f4wn0WlSw785+kl/6Q5FerDylE9uY
        yOe35ag2WrLJNQF05slYPrsxSnIaS+dnM1RKLP9Dt2ETh01pwnoQR9XmP8xZ9NFQ
        9b/LEOHKxCCRD7ykZg/OO0u2nxtTGHkNqWdVW0pq7bwS2lcMaS1oqB8j9yUHLF+0
        U+H+QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=d9H1flms8CAnmkfkTGXC7fqtRulSUIecdP1Sarbhn
        hQ=; b=Aw/FAvgfDcvDS1oNUjvX1/jZMmjSbWUESBqtCChZH9IxsCMS+hMsULbVY
        PiFnhGy2NxnVTgYQ6q3/hxCo0BSxI9NTnk9TTfWI2Wrno3xqrxcKsRhLA/DrILau
        P8u97K+S9rTA1/H7ShI/PDMlwbIP80iPTQ3ITRuiLPw2d0Xurj84TZsyt3RhM0Fi
        UtkHtVCmyMoB+Q1AJwglt5fWIGUXRZMGr4woK5OcMOGzHYG55QU0t+0aCWrSqW3g
        NsH/m0FdxIosEM/XgSnKK8jMqQpWq/uqn25IYcxG747muzpPgn0BznROKrOHNoL/
        LC6yneveE33pJuj/B/b1JaFRAx1VA==
X-ME-Sender: <xms:Os6-YEZLW2AeVqhbCrRd5RcquhmBC6amB6XpDhBm3aANb5OdVhJZzg>
    <xme:Os6-YPYM_mwCj6YX16e8A-UP9krv25MgvDWN2Brbpc3A0pw_ZC2zwieVxoU1oO-w8
    xQWND8zW2v5>
X-ME-Received: <xmr:Os6-YO_g-OUQKr6nNzDWVL1Mc-9eXWrtsCpqjZqDNKQIlp7sHaprGLRM4q1DiYsZ5qdzhcOVpcH58PvRjUfkQrYERilLig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtkedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:Os6-YOrrRWj0QiKJIKYcrZ7sccLDHya-ONPM0u7yLsAESgMHJZefsA>
    <xmx:Os6-YPpytds8-iG84Jl-ZJYwj9org-8xXHYUutVrhMvnvwMP9CM4gg>
    <xmx:Os6-YMQs7dyB-FR124JlBOj8xmXnkGSBVZWnFtHoE_acSRV6G_6b9w>
    <xmx:O86-YIT49_mgovE_SNIQBRpRtpXGay3AsHWfdOMDJeydztN0c2TR2g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jun 2021 21:56:05 -0400 (EDT)
Message-ID: <5e34e74c7c6d6b58165702824b8b0ad914a6a5b9.camel@themaw.net>
Subject: Re: [PATCH v5 3/6] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Jun 2021 09:56:01 +0800
In-Reply-To: <87lf7lil7y.fsf@disp2133>
References: <162306058093.69474.2367505736322611930.stgit@web.messagingengine.com>
         <162306072498.69474.16160057168984328507.stgit@web.messagingengine.com>
         <87lf7lil7y.fsf@disp2133>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-06-07 at 13:27 -0500, Eric W. Biederman wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > If there are many lookups for non-existent paths these negative
> > lookups
> > can lead to a lot of overhead during path walks.
> > 
> > The VFS allows dentries to be created as negative and hashed, and
> > caches
> > them so they can be used to reduce the fairly high overhead
> > alloc/free
> > cycle that occurs during these lookups.
> > 
> > Use the kernfs node parent revision to identify if a change has
> > been
> > made to the containing directory so that the negative dentry can be
> > discarded and the lookup redone.
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/kernfs/dir.c |   53 +++++++++++++++++++++++++++++++------------
> > ----------
> >  1 file changed, 31 insertions(+), 22 deletions(-)
> > 
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index b88432c48851f..5ae95e8d1aea1 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -1039,13 +1039,32 @@ static int kernfs_dop_revalidate(struct
> > dentry *dentry, unsigned int flags)
> >         if (flags & LOOKUP_RCU)
> >                 return -ECHILD;
> >  
> > -       /* Always perform fresh lookup for negatives */
> > -       if (d_really_is_negative(dentry))
> > -               goto out_bad_unlocked;
> > -
> >         kn = kernfs_dentry_node(dentry);
> >         mutex_lock(&kernfs_mutex);
> >  
> > +       /* Negative hashed dentry? */
> > +       if (!kn) {
> > +               struct dentry *d_parent = dget_parent(dentry);
> > +               struct kernfs_node *parent;
> > +
> > +               /* If the kernfs parent node has changed discard
> > and
> > +                * proceed to ->lookup.
> > +                */
> > +               parent = kernfs_dentry_node(d_parent);
> > +               if (parent) {
> > +                       if (kernfs_dir_changed(parent, dentry)) {
> > +                               dput(d_parent);
> > +                               goto out_bad;
> > +                       }
> > +               }
> > +               dput(d_parent);
> > +
> > +               /* The kernfs node doesn't exist, leave the dentry
> > +                * negative and return success.
> > +                */
> > +               goto out;
> > +       }
> 
> What part of this new negative hashed dentry check needs the
> kernfs_mutex?
> 
> I guess it is the reading of kn->dir.rev.

I have an irresistible urge to keep the rb tree stable when
accessing it. It was probably not necessary most of the times
I did it, IIUC even a rebalance will leave the node address
unchanged so it should be just removals and moves to worry
about.
 
> 
> Since all you are doing is comparing if two fields are equal it
> really should not matter.  Maybe somewhere there needs to be a
> sprinkling of primitives like READ_ONCE.

There is one case that looks tricky, rename will call ->rename()
and a bit later do the move. Thinking about it a READ_ONCE might
be needed even now but taking the rwsem is probably enough.

Not sure about that one?

Moving this out from under the rwsem would be good to do.

Ian
> 
> It just seems like such a waste to put all of that under kernfs_mutex
> on the off chance kn->dir.rev will change while it is being read.
> 
> Eric


