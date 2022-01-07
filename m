Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E89487348
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 08:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiAGHEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 02:04:55 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48873 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbiAGHEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:04:54 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id EB9D23203029;
        Fri,  7 Jan 2022 02:04:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jan 2022 02:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        Ns1Bd939+gzK3jJWdv4pIUmFxaCXkJRyL1b73HgkGBI=; b=qBE5C7AbFuB6u/8A
        G7iro8O09FSWEIP/ADOro/BzN/3KitcB7iEoISL7zucV3rbM+XVLkwNH0MdAIk2y
        U0Cry/I5E2pgj/S81O19mpmOnLbP/R0Fcj8Cvd6bgpQ/HLNAWqfYoIcsn6sjY7zA
        4F6kIIN2aOaHfkELNuM9urvCm5+3ZZDy8+Xw2Oe5hnhf/I/XnpzuCAMwyW6KiFud
        YsfaRLbvPvdm2AAF7X+mo3yi3cZX3nM8282do73Hg4ori7LCdWcZ2aDHcCnitOkW
        jyCBhnkpVMVq2ugC3I87cd3qnmSddCg+YaYseG+gOolZJ0y4CG97SL+spqlMKkn/
        uVOutQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Ns1Bd939+gzK3jJWdv4pIUmFxaCXkJRyL1b73HgkG
        BI=; b=WN6RuXbTdueWUFHkW+LBx80YpqintQ2W4tI7OgM89mpTv1C9FHZuO2XXV
        kFeRcsBtxXOr3F7ICoW5yPi7Mrcu+PzDZiTxp8y/LjspJlj1FKLq1XmfPbGrBXZk
        4fhhZEBxkltrpbnTNE79f8Hxb94aAhM//iGDAPvco9rc2gZ6LkDISWXcutQd1vuB
        viIB+RbRwLdNe7GiHbrJM/sZTDHskJPOMiom+MjvSY2Cw4R8rgtNokWx5iOwXSED
        bAG+eiccaG7TvH3gTwrFQoh7K1W7CNDte+uUtvH31jxccJmrfONgnKqX0+BhC/gS
        jdYGKi46buxqyZRqQZHmak4jEOc+Q==
X-ME-Sender: <xms:FebXYTJFQLifKoHrriWM_uVrHCIu34SGue2FrhE7Ziji5Hz9rsmzHw>
    <xme:FebXYXJ-lp9YCvwXNut7XX7lf_yveUA-yqVjecyEYOqw4gqGjB524sVqyLfZ59SXw
    7T2te7HThMN>
X-ME-Received: <xmr:FebXYbuaJo3NN_arHzEwCBcpIkC40XNl1yrRX_rpYWdxwmFKeRQGA2ten7PCHOOo_oioyNTuDETtG6ptyW-XGjCSq8LSM-WVtjcr6eu5LpC1z9CfgHnVXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegtddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:FebXYcZPu9sLUwaUFpxkBhbJIAMRNpjgjp60NPKdYjANdf-J-MiQzw>
    <xmx:FebXYaafOFOKVksph1Osh3CdF4cbjHLzSkiSSIqyfjppcb8qayYAJg>
    <xmx:FebXYQC6efDitOnTtDsV8GwRVs0w52ahN0T1ufM-DT2pn46Myd7eLQ>
    <xmx:FebXYTA0aNaBScNQ3V8AIYYzKH_8JubTA5aykXOKILtK6wTFvfunRg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 02:04:51 -0500 (EST)
Message-ID: <b14cd1790c18e2be0ab6e5cfce91dee5611ceb9d.camel@themaw.net>
Subject: Re: [PATCH] namei: clear nd->root.mnt before O_CREAT unlazy
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
Date:   Fri, 07 Jan 2022 15:04:46 +0800
In-Reply-To: <YdfVG56XZnkePk7c@zeniv-ca.linux.org.uk>
References: <20220105180259.115760-1-bfoster@redhat.com>
         <4a13a560520e1ef522fcbb9f7dfd5e8c88d5b238.camel@themaw.net>
         <YdfVG56XZnkePk7c@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-01-07 at 05:52 +0000, Al Viro wrote:
> On Fri, Jan 07, 2022 at 07:46:10AM +0800, Ian Kent wrote:
> > On Wed, 2022-01-05 at 13:02 -0500, Brian Foster wrote:
> > > The unlazy sequence of an rcuwalk lookup occurs a bit earlier than
> > > normal for O_CREAT lookups (i.e. in open_last_lookups()). The
> > > create
> > > logic here historically invoked complete_walk(), which clears the
> > > nd->root.mnt pointer when appropriate before the unlazy.  This
> > > changed in commit 72287417abd1 ("open_last_lookups(): don't abuse
> > > complete_walk() when all we want is unlazy"), which refactored the
> > > create path to invoke unlazy_walk() and not consider nd->root.mnt.
> > > 
> > > This tweak negatively impacts performance on a concurrent
> > > open(O_CREAT) workload to multiple independent mounts beneath the
> > > root directory. This attributes to increased spinlock contention on
> > > the root dentry via legitimize_root(), to the point where the
> > > spinlock becomes the primary bottleneck over the directory inode
> > > rwsem of the individual submounts. For example, the completion rate
> > > of a 32k thread aim7 create/close benchmark that repeatedly passes
> > > O_CREAT to open preexisting files drops from over 700k "jobs per
> > > minute" to 30, increasing the overall test time from a few minutes
> > > to over an hour.
> > > 
> > > A similar, more simplified test to create a set of opener tasks
> > > across a set of submounts can demonstrate the problem more quickly.
> > > For example, consider sets of 100 open/close tasks each running
> > > against 64 independent filesystem mounts (i.e. 6400 tasks total),
> > > with each task completing 10k iterations before it exits. On an
> > > 80xcpu box running v5.16.0-rc2, this test completes in 50-55s. With
> > > this patch applied, the same test completes in 10-15s.
> > > 
> > > This is not the most realistic workload in the world as it factors
> > > out inode allocation in the filesystem. The contention can also be
> > > avoided by more selective use of O_CREAT or via use of relative
> > > pathnames. That said, this regression appears to be an
> > > unintentional
> > > side effect of code cleanup and might be unexpected for users.
> > > Restore original behavior prior to commit 72287417abd1 by factoring
> > > the rcu logic from complete_walk() into a new helper and invoke
> > > that
> > > from both places.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > >  fs/namei.c | 37 +++++++++++++++++++++----------------
> > >  1 file changed, 21 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 1f9d2187c765..b32fcbc99929 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -856,6 +856,22 @@ static inline int d_revalidate(struct dentry
> > > *dentry, unsigned int flags)
> > >                 return 1;
> > >  }
> > >  
> > > +static inline bool complete_walk_rcu(struct nameidata *nd)
> > > +{
> > > +       if (nd->flags & LOOKUP_RCU) {
> > > +               /*
> > > +                * We don't want to zero nd->root for scoped-
> > > lookups
> > > or
> > > +                * externally-managed nd->root.
> > > +                */
> > > +               if (!(nd->state & ND_ROOT_PRESET))
> > > +                       if (!(nd->flags & LOOKUP_IS_SCOPED))
> > > +                               nd->root.mnt = NULL;
> > > +               nd->flags &= ~LOOKUP_CACHED;
> > > +               return try_to_unlazy(nd);
> > > +       }
> > > +       return true;
> > > +}
> > > +
> > >  /**
> > >   * complete_walk - successful completion of path walk
> > >   * @nd:  pointer nameidata
> > > @@ -871,18 +887,8 @@ static int complete_walk(struct nameidata *nd)
> > >         struct dentry *dentry = nd->path.dentry;
> > >         int status;
> > >  
> > > -       if (nd->flags & LOOKUP_RCU) {
> > > -               /*
> > > -                * We don't want to zero nd->root for scoped-
> > > lookups
> > > or
> > > -                * externally-managed nd->root.
> > > -                */
> > > -               if (!(nd->state & ND_ROOT_PRESET))
> > > -                       if (!(nd->flags & LOOKUP_IS_SCOPED))
> > > -                               nd->root.mnt = NULL;
> > > -               nd->flags &= ~LOOKUP_CACHED;
> > > -               if (!try_to_unlazy(nd))
> > > -                       return -ECHILD;
> > > -       }
> > > +       if (!complete_walk_rcu(nd))
> > > +               return -ECHILD;
> > >  
> > >         if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
> > >                 /*
> > > @@ -3325,10 +3331,9 @@ static const char *open_last_lookups(struct
> > > nameidata *nd,
> > >                 BUG_ON(nd->flags & LOOKUP_RCU);
> > >         } else {
> > >                 /* create side of things */
> > > -               if (nd->flags & LOOKUP_RCU) {
> > > -                       if (!try_to_unlazy(nd))
> > > -                               return ERR_PTR(-ECHILD);
> > > -               }
> > > +               if (!complete_walk_rcu(nd))
> > > +                       return ERR_PTR(-ECHILD);
> > > +
> > >                 audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
> > >                 /* trailing slashes? */
> > >                 if (unlikely(nd->last.name[nd->last.len]))
> > 
> > Looks good, assuming Al is ok with the re-factoring.
> > Reviewed-by: Ian Kent <raven@themaw.net>
> 
> Ummm....  Mind resending that?  I'm still digging myself from under
> the huge pile of mail, and this seems to have been lost in process...

Brain wrote and sent the patch, I'm sure he'll resent it.

The re-factor I mention is just pulling out the needed bits from
complete_walk() rather than open coding it or reverting the original
change, commit 72287417abd1 ("open_last_lookups(): don't abuse
complete_walk() when all we want is unlazy").

Ian


