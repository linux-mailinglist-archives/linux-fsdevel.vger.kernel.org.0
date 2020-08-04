Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA8623BA65
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 14:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgHDMdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 08:33:03 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:36261 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727779AbgHDMcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:32:16 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id C94F6580552;
        Tue,  4 Aug 2020 08:32:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 04 Aug 2020 08:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        GQrvTmzmmFYdgKDOjC8EuXBs0YT7HCIH7S0aDNWKxu4=; b=clTQFpIMSolCW6jY
        xc99NEC4kl0YqyNOsm6qSVHOkZFRyhaNemvV42oGz7IHHSv3+EpRvRgaPZX4cMIy
        uG0kY97csqAYzzeIO62vthsBgZrguMDBKu/4hEXIjO4S9A+KjMpZagxQ5rSB+eIx
        O5n0AO9Qqsy1lDc9obh3cjdW33gc9VxRh7KFRLYeHawdsj7/3L8vr7yb2w8VxEy4
        6F9I8qHqZYZzJPQ2+9u5WHdCut/HdViUN3H6TEGza9MYaxUCBpBxQSfW58VjyVwo
        /k3Ao5jizSrnCh6TCBW6h/8qVBg4fpTax4o6yrywHYuGXFDhRak1DbcxlLj+7Lht
        VWfBLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=GQrvTmzmmFYdgKDOjC8EuXBs0YT7HCIH7S0aDNWKx
        u4=; b=CdBBGHL97gKyORvrfh7sIlaBs00XY1tMVHmMDPzGTQSg4+bSBCCqF0hFt
        IEOc0mHjwjmFv+oIHhMtp9t73oOn8Cksi2OJH0E+hhO5fxCI2oRe2y2ODq1db5vE
        GjMdoyORzN3OkoEAWJJkbhe/oM+BTvd34+WwFilOZM1ls0pcUHGNrzmgJupL0lwh
        ZmXqcQagnbWVfqbkqhUP6hOgg1Y6/bJVv9Xw4qEUzBuicH9wojYTrZau8RYBRimo
        kL6iylsRcEy5jdV1F/iCrShzmtZ0eV4NnoWaj6K31/l79V0bN9nFYTr5bevOyUts
        izE9B7fraIwpvRSS6TWlVZ+ve9TtQ==
X-ME-Sender: <xms:TFUpX4-ox1o4MRnKnWdE272jhCVKtxE-9wztQZddi5qFKWRXZKovwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeigdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peduudekrddvtdekrdegjedrudeiudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:TFUpXwtbPbbZc6pREsPaXvlLpznOoU3pBIZOBhXXNNcVQ2h0mLttnw>
    <xmx:TFUpX-D9bye0WAANnM0viVcGOmAzEJX1_LFFaakEqE-0b_L9nXh0Yg>
    <xmx:TFUpX4fEKfhE8UMAm7Q4DP_ltPtsf8PFO0R1s9TQiYNAy1w7fbTTDQ>
    <xmx:TVUpXwoVZSDciaCCPlUM353wOLXDPtV5BJH8lEGIxW6IJfby6hy0zw>
Received: from mickey.themaw.net (unknown [118.208.47.161])
        by mail.messagingengine.com (Postfix) with ESMTPA id 078F830600A6;
        Tue,  4 Aug 2020 08:32:07 -0400 (EDT)
Message-ID: <3341383b655b39697b4dcdb9f64c5f3bc46a6ac4.camel@themaw.net>
Subject: Re: [PATCH 06/18] fsinfo: Add a uniquifier ID to struct mount [ver
 #21]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Aug 2020 20:32:04 +0800
In-Reply-To: <20200804104108.GC32719@miu.piliscsaba.redhat.com>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
         <159646183662.1784947.5709738540440380373.stgit@warthog.procyon.org.uk>
         <20200804104108.GC32719@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-08-04 at 12:41 +0200, Miklos Szeredi wrote:
> On Mon, Aug 03, 2020 at 02:37:16PM +0100, David Howells wrote:
> > Add a uniquifier ID to struct mount that is effectively unique over
> > the
> > kernel lifetime to deal around mnt_id values being reused.  This
> > can then
> > be exported through fsinfo() to allow detection of replacement
> > mounts that
> > happen to end up with the same mount ID.
> > 
> > The normal mount handle is still used for referring to a particular
> > mount.
> > 
> > The mount notification is then changed to convey these unique mount
> > IDs
> > rather than the mount handle.
> > 
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > ---
> > 
> >  fs/mount.h        |    3 +++
> >  fs/mount_notify.c |    4 ++--
> >  fs/namespace.c    |    3 +++
> >  3 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/mount.h b/fs/mount.h
> > index 85456a5f5a3a..1037781be055 100644
> > --- a/fs/mount.h
> > +++ b/fs/mount.h
> > @@ -79,6 +79,9 @@ struct mount {
> >  	int mnt_expiry_mark;		/* true if marked for
> > expiry */
> >  	struct hlist_head mnt_pins;
> >  	struct hlist_head mnt_stuck_children;
> > +#ifdef CONFIG_FSINFO
> > +	u64	mnt_unique_id;		/* ID unique over lifetime of
> > kernel */
> > +#endif
> 
> Not sure if it's worth making conditional.
> 
> >  #ifdef CONFIG_MOUNT_NOTIFICATIONS
> >  	struct watch_list *mnt_watchers; /* Watches on dentries within
> > this mount */
> >  #endif
> > diff --git a/fs/mount_notify.c b/fs/mount_notify.c
> > index 44f570e4cebe..d8ba66ed5f77 100644
> > --- a/fs/mount_notify.c
> > +++ b/fs/mount_notify.c
> > @@ -90,7 +90,7 @@ void notify_mount(struct mount *trigger,
> >  	n.watch.type	= WATCH_TYPE_MOUNT_NOTIFY;
> >  	n.watch.subtype	= subtype;
> >  	n.watch.info	= info_flags | watch_sizeof(n);
> > -	n.triggered_on	= trigger->mnt_id;
> > +	n.triggered_on	= trigger->mnt_unique_id;
> >  
> >  	switch (subtype) {
> >  	case NOTIFY_MOUNT_EXPIRY:
> > @@ -102,7 +102,7 @@ void notify_mount(struct mount *trigger,
> >  	case NOTIFY_MOUNT_UNMOUNT:
> >  	case NOTIFY_MOUNT_MOVE_FROM:
> >  	case NOTIFY_MOUNT_MOVE_TO:
> > -		n.auxiliary_mount	= aux->mnt_id;
> > +		n.auxiliary_mount = aux->mnt_unique_id;
> 
> Hmm, so we now have two ID's:
> 
>  - one can be used to look up the mount
>  - one is guaranteed to be unique
> 
> With this change the mount cannot be looked up with
> FSINFO_FLAGS_QUERY_MOUNT,
> right?
> 
> Should we be merging the two ID's into a single one which has both
> properties?

I'd been thinking we would probably need to change to 64 bit ids
for a while now and I thought that was what was going to happen.

We'll need to change libmount and current code but better early
on than later.

Ian

> 
> >  		break;
> >  
> >  	default:
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index b2b9920ffd3c..1db8a64cd76f 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -115,6 +115,9 @@ static int mnt_alloc_id(struct mount *mnt)
> >  	if (res < 0)
> >  		return res;
> >  	mnt->mnt_id = res;
> > +#ifdef CONFIG_FSINFO
> > +	mnt->mnt_unique_id = atomic64_inc_return(&vfs_unique_counter);
> > +#endif
> >  	return 0;
> >  }
> >  
> > 
> > 

