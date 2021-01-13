Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B1D2F4580
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 08:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbhAMHsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 02:48:37 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35589 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbhAMHsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 02:48:36 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CA58A5C041D;
        Wed, 13 Jan 2021 02:47:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 13 Jan 2021 02:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        rVReJbWYQLD0CTokx/0IQLX1p6D+ywlxX157soyK54s=; b=YBzC5U7wawNZfpse
        nGglfYuoZwBJsGBfDg7J/DaivfeJLluuf5EuUJUtoQxnL7Xuc55c10U/d/WCn4dX
        rAqO9M77ta/4dcCwfBwKIy9ib3VYszDvDiU9P4HQ4Fb5qG0orFv12vWRDLfj87xp
        8IcFEt/RSv4AcZrXGQXhQOmErhLcOq3NLzI5tV3mn1MvWpI445u1jiMnNEtJkcsU
        UnSDg7dEQWS/W18rlH0fiGz6fW4plS6kfL5r6OgR3iC0qRw+BOAbEvSTFC8BwxlF
        iVsf0lC48rbi20gfgnso34S9f+Xye0HO37J4ynOWX3hAXX5fGO7lw8ZZbgBBvkiw
        1Sbqnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=rVReJbWYQLD0CTokx/0IQLX1p6D+ywlxX157soyK5
        4s=; b=hHdRHOE1hIksM7uJFe2BTX6MP5U1tnv56tP6chNhJAX5NYnzG1dcKtNrp
        D0s5W97Xd4NuyiZs3FXKNlMZq9OQm6QJZHGXTsKub0hQOcvAS3/+OEaJo2gtT3ql
        a7llMfjsMywTBtywbUL/9E2pgJz7tJyeFAOxnJ5xNf5giOFO0uBCsG05wMV4ucHJ
        nViW/sRkiOB2zMvG8Dnn6VGq74p0F4wCrxSQuB85VU4IYAMgFOpbV6lZg5a2tCIA
        Chdi/OE4aXugz+9q6U9BqIemLfEvBmUOAH8cTKH14ARyIyb1pDO4lOSmgSaNql8M
        7rrp6/218tH7eQyLT82V3cGWUXglQ==
X-ME-Sender: <xms:kKX-X4dPMQjep0bhDhN4SnPXrBWAxd9Rf3r1mxBqAXwV7DzeKCPOzQ>
    <xme:kKX-X6NC3HSMcKVcd38VwwmCb-SD30K6sb-R6bqSl_QtTkDYG7yD2xG2ff58pZtd3
    4ln-TPIA6P7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddugdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eikeeggeeuvdevgfefiefhudekkeegheeileejveethedutedvveehudffjeevudenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvddurdeggedrudefvddrudehtd
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghv
    vghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:kKX-X5gpS2XsUKfWNmcJLUdRna-7mScdybtpj0fnfukeQ_hQXEnavg>
    <xmx:kKX-X9-xYhXdifdtRufESe4JyQw0oXf1dHjxz37BcVGqn9_vFKY-OA>
    <xmx:kKX-X0vaq17nysXEKapmvJHqWTIv0DmSYLioekGajfz4nYAKcJ-DPQ>
    <xmx:kaX-X2LlcKbl4jo25gJeNac-6TI8g1EHP4grsEcdIFO8draT7-T3Og>
Received: from mickey.themaw.net (unknown [121.44.132.150])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3AFC5240062;
        Wed, 13 Jan 2021 02:47:24 -0500 (EST)
Message-ID: <6182b818d4298898875e9bd59fa9a1dcb279db62.camel@themaw.net>
Subject: Re: [PATCH 0/6] kernfs: proposed locking and concurrency improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Wed, 13 Jan 2021 15:47:20 +0800
In-Reply-To: <CAC2o3D+FYJ0b-bL66-C9Xna=R6PvGaPq0fMCmepNbOqX2o8RzA@mail.gmail.com>
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
         <CAC2o3DJqK0ECrRnO0oArgHV=_S7o35UzfP4DSSXZLJmtLbvrKg@mail.gmail.com>
         <04675888088a088146e3ca00ca53099c95fbbad7.camel@themaw.net>
         <CAC2o3D+qsH3suFk4ZX9jbSOy3WbMHdb9j6dWUhWuvt1RdLOODA@mail.gmail.com>
         <75de66869bd584903055996fb0e0bab2b57acd68.camel@themaw.net>
         <42efbb86327c2f5a8378d734edc231e3c5a34053.camel@themaw.net>
         <CAC2o3D+W70pzEd0MQ1Osxnin=j2mxwH4KdAYwR1mB67LyLbf5Q@mail.gmail.com>
         <aa193477213228daf85acdae7c31e1bfff3d694c.camel@themaw.net>
         <CAC2o3D+_Cscy4HyQhigh3DQvth7EJgQFA8PX94=XC5R30fwRwQ@mail.gmail.com>
         <cc784e7a2b65c562d6e8082e5febec4fa74784b7.camel@themaw.net>
         <CAC2o3D+FYJ0b-bL66-C9Xna=R6PvGaPq0fMCmepNbOqX2o8RzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-01-13 at 15:00 +0800, Fox Chen wrote:
> On Wed, Jan 13, 2021 at 1:17 PM Ian Kent <raven@themaw.net> wrote:
> > On Mon, 2021-01-11 at 17:02 +0800, Fox Chen wrote:
> > > On Mon, Jan 11, 2021 at 4:42 PM Ian Kent <raven@themaw.net>
> > > wrote:
> > > > On Mon, 2021-01-11 at 15:04 +0800, Fox Chen wrote:
> > > > > On Mon, Jan 11, 2021 at 12:20 PM Ian Kent <raven@themaw.net>
> > > > > wrote:
> > > > > > On Mon, 2021-01-11 at 11:19 +0800, Ian Kent wrote:
> > > > > > > On Wed, 2021-01-06 at 10:38 +0800, Fox Chen wrote:
> > > > > > > > Hi Ian,
> > > > > > > > 
> > > > > > > > I am rethinking this problem. Can we simply use a
> > > > > > > > global
> > > > > > > > lock?
> > > > > > > > 
> > > > > > > >  In your original patch 5, you have a global mutex
> > > > > > > > attr_mutex
> > > > > > > > to
> > > > > > > > protect attr, if we change it to a rwsem, is it enough
> > > > > > > > to
> > > > > > > > protect
> > > > > > > > both
> > > > > > > > inode and attr while having the concurrent read
> > > > > > > > ability?
> > > > > > > > 
> > > > > > > > like this patch I submitted. ( clearly, I missed
> > > > > > > > __kernfs_iattrs
> > > > > > > > part,
> > > > > > > > but just about that idea )
> > > > > > > > https://lore.kernel.org/lkml/20201207084333.179132-1-foxhlchen@gmail.com/
> > > > > > > 
> > > > > > > I don't think so.
> > > > > > > 
> > > > > > > kernfs_refresh_inode() writes to the inode so taking a
> > > > > > > read
> > > > > > > lock
> > > > > > > will allow multiple processes to concurrently update it
> > > > > > > which
> > > > > > > is
> > > > > > > what we need to avoid.
> > > > > 
> > > > > Oh, got it. I missed the inode part. my bad. :(
> > > > > 
> > > > > > > It's possibly even more interesting.
> > > > > > > 
> > > > > > > For example, kernfs_iop_rmdir() and kernfs_iop_mkdir()
> > > > > > > might
> > > > > > > alter
> > > > > > > the inode link count (I don't know if that would be the
> > > > > > > sort
> > > > > > > of
> > > > > > > thing
> > > > > > > they would do but kernfs can't possibly know either).
> > > > > > > Both of
> > > > > > > these
> > > > > > > functions rely on the VFS locking for exclusion but the
> > > > > > > inode
> > > > > > > link
> > > > > > > count is updated in kernfs_refresh_inode() too.
> > > > > > > 
> > > > > > > That's the case now, without any patches.
> > > > > > 
> > > > > > So it's not so easy to get the inode from just the kernfs
> > > > > > object
> > > > > > so these probably aren't a problem ...
> > > > > 
> > > > > IIUC only when dop->revalidate, iop->lookup being called, the
> > > > > result
> > > > > of rmdir/mkdir will be sync with vfs.
> > > > 
> > > > Don't quite get what you mean here?
> > > > 
> > > > Do you mean something like, VFS objects are created on user
> > > > access
> > > > to the file system. Given that user access generally means path
> > > > resolution possibly followed by some operation.
> > > > 
> > > > I guess those VFS objects will go away some time after the
> > > > access
> > > > but even thought the code looks like that should happen pretty
> > > > quickly after I've observed that these objects stay around
> > > > longer
> > > > than expected. There wouldn't be any use in maintaining a least
> > > > recently used list of dentry candidates eligible to discard.
> > > 
> > > Yes, that is what I meant. I think the duration may depend on the
> > > current ram pressure. though not quite sure, I'm still digging
> > > this
> > > part of code.
> > > 
> > > > > kernfs_node is detached from vfs inode/dentry to save ram.
> > > > > 
> > > > > > > I'm not entirely sure what's going on in
> > > > > > > kernfs_refresh_inode().
> > > > > > > 
> > > > > > > It could be as simple as being called with a NULL inode
> > > > > > > because
> > > > > > > the dentry concerned is negative at that point. I haven't
> > > > > > > had
> > > > > > > time to look closely at it TBH but I have been thinking
> > > > > > > about
> > > > > > > it.
> > > > > 
> > > > > um, It shouldn't be called with a NULL inode, right?
> > > > > 
> > > > > inode->i_mode = kn->mode;
> > > > > 
> > > > > otherwise will crash.
> > > > 
> > > > Yes, you're right about that.
> > > > 
> > > > > > Certainly this can be called without a struct iattr having
> > > > > > been
> > > > > > allocated ... and given it probably needs to remain a
> > > > > > pointer
> > > > > > rather than embedded in the node the inode link count
> > > > > > update
> > > > > > can't easily be protected from concurrent updates.
> > > > > > 
> > > > > > If it was ok to do the allocation at inode creation the
> > > > > > problem
> > > > > > becomes much simpler to resolve but I thought there were
> > > > > > concerns
> > > > > > about ram consumption (although I don't think that was
> > > > > > exactly
> > > > > > what
> > > > > > was said?).
> > > > > > 
> > > > > 
> > > > > you meant iattr to be allocated at inode creation time??
> > > > > yes, I think so. it's due to ram consumption.
> > > > 
> > > > I did, yes.
> > > > 
> > > > The actual problem is dealing with multiple concurrent updates
> > > > to
> > > > the inode link count, the rest can work.
> > 
> > Umm ... maybe I've been trying to do this in the wrong place all
> > along.
> > 
> > You know the inode i_lock looks like the sensible thing to use to
> > protect these updates.
> > 
> > Something like this for that last patch should work:
> > 
> > kernfs: use i_lock to protect concurrent inode updates
> > 
> > From: Ian Kent <raven@themaw.net>
> > 
> > The inode operations .permission() and .getattr() use the kernfs
> > node
> > write lock but all that's needed is to keep the rb tree stable
> > while
> > updating the inode attributes as well as protecting the update
> > itself
> > against concurrent changes.
> > 
> > And .permission() is called frequently during path walks and can
> > cause
> > quite a bit of contention between kernfs node opertations and path
> > walks when the number of concurrant walks is high.
> > 
> > To change kernfs_iop_getattr() and kernfs_iop_permission() to take
> > the rw sem read lock instead of the write lock an addtional lock is
> > needed to protect against multiple processes concurrently updating
> > the inode attributes and link count in kernfs_refresh_inode().
> > 
> > The inode i_lock seems like the sensible thing to use to protect
> > these
> > inode attribute updates so use it in kernfs_refresh_inode().
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/kernfs/inode.c |   10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> > index ddaf18198935..e26fa5115821 100644
> > --- a/fs/kernfs/inode.c
> > +++ b/fs/kernfs/inode.c
> > @@ -171,6 +171,7 @@ static void kernfs_refresh_inode(struct
> > kernfs_node *kn, struct inode *inode)
> >  {
> >         struct kernfs_iattrs *attrs = kn->iattr;
> > 
> > +       spin_lock(inode->i_lock);
> >         inode->i_mode = kn->mode;
> >         if (attrs)
> >                 /*
> > @@ -181,6 +182,7 @@ static void kernfs_refresh_inode(struct
> > kernfs_node *kn, struct inode *inode)
> > 
> >         if (kernfs_type(kn) == KERNFS_DIR)
> >                 set_nlink(inode, kn->dir.subdirs + 2);
> > +       spin_unlock(inode->i_lock);
> >  }
> > 
> >  int kernfs_iop_getattr(const struct path *path, struct kstat
> > *stat,
> > @@ -189,9 +191,9 @@ int kernfs_iop_getattr(const struct path *path,
> > struct kstat *stat,
> >         struct inode *inode = d_inode(path->dentry);
> >         struct kernfs_node *kn = inode->i_private;
> > 
> > -       down_write(&kernfs_rwsem);
> > +       down_read(&kernfs_rwsem);
> >         kernfs_refresh_inode(kn, inode);
> > -       up_write(&kernfs_rwsem);
> > +       up_read(&kernfs_rwsem);
> > 
> >         generic_fillattr(inode, stat);
> >         return 0;
> > @@ -281,9 +283,9 @@ int kernfs_iop_permission(struct inode *inode,
> > int mask)
> > 
> >         kn = inode->i_private;
> > 
> > -       down_write(&kernfs_rwsem);
> > +       down_read(&kernfs_rwsem);
> >         kernfs_refresh_inode(kn, inode);
> > -       up_write(&kernfs_rwsem);
> > +       up_read(&kernfs_rwsem);
> > 
> >         return generic_permission(inode, mask);
> >  }
> > 
> 
> It looks good on my local machine, let me test my benchmark on a big
> machine. :)
> 
> Also, I wonder why i_lock?? what if I use a local spin_lock, will
> there be any difference???

I think that amounts to using a global lock (ie. static) not a
per-object lock which is needed to reduce contention.

> 
> static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode
> *inode)
> {
>         struct kernfs_iattrs *attrs = kn->iattr;
>         static DEFINE_SPINLOCK(inode_lock);
> 
>         spin_lock(&inode_lock);
>         inode->i_mode = kn->mode;
>         if (attrs)
>                 /*
>                  * kernfs_node has non-default attributes get them
> from
>                  * persistent copy in kernfs_node.
>                  */
>                 set_inode_attr(inode, attrs);
> 
>         if (kernfs_type(kn) == KERNFS_DIR)
>                 set_nlink(inode, kn->dir.subdirs + 2);
>         spin_unlock(&inode_lock);
> }
> 
> 
> 
> thanks,
> fox

