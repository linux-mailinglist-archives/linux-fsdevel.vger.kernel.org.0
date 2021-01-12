Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1772F23EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 01:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbhALA2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 19:28:06 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59039 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbhALA2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:28:03 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 42F73222E;
        Mon, 11 Jan 2021 19:27:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Jan 2021 19:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        mcgJzGD7kBstNVYClmQaG2fm4yqoh5N5djxOd23Gxzc=; b=22wRD83eD7OJP1Z3
        gC+LH43pRNZXNfYc4s5RuH1R2Hz8f03Sbmg0sOv3UNoVx9UdqvMdNDQssXh5P0Bz
        yEhw4vNCrgW6eWRlwOwHt2cdERlKAdsBAoc6z7Pf0CWnyZtLWPG3J3/QkndhiAIA
        49BPbVLDs+x5RAXJMcil/O8yq7KFKid5BjE1lejzfi3nh68vJcqRuM3rILso4+h2
        qTl1gQE9u1B0EuWY6HlAEESlN9AZINnirKfC6GwN9PeeUR+oc6bDhIb5JvWzcMD1
        RLB88/RRwHCoio0TP036dtupf+EpGZICJE5XIwhi5failq325bUhDMxERQqYsYqH
        VsDdSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=mcgJzGD7kBstNVYClmQaG2fm4yqoh5N5djxOd23Gx
        zc=; b=haLOcqhQ3tUaKY48wMlI6IHUxpMSU0baG2k0OgS08JaugqaJnWUHEPIEl
        zCiClXRpERP9P7ypjTDNzO/QLFh9LJS/0q7jbVRPOpQH0hcb7DKmCRY6iak1bIfg
        owI6ErPnP7wvO49MObBbg5MjdTD1gkMds9CAKBzQgrM1CuffZi+wRoaAPkT+AjXp
        27gdlSDuNrirz+PJHMscc+dgimg+VO7X+sVO+Z9u5Zy70gnUAR4WySe2fVfLe1Ta
        xu700JJS5RPHYVbidgCfBOII4zGBdfLK/iFDLu+DlnyCLuP1xNGnKjOXTE73fZtO
        hTl2I+lZ1rSWiSLFrBKmDGK5odpeg==
X-ME-Sender: <xms:4-z8X_mB7EdbQj5HsZ0rjojq4pTDL84qjuNanSvAqrw7381qIq-PjQ>
    <xme:4-z8Xy0p-yOBKms6S331R_QIpp4hyaCEU_P1H1RR2Or0QZPPNeOE9em9zCriz-TMv
    H0VR9WR5z3X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eikeeggeeuvdevgfefiefhudekkeegheeileejveethedutedvveehudffjeevudenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvddurdeggedrudefuddrvdefne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgv
    nhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:4-z8X1pOy-tm8m0pufk_Ss8Y37XkBoD8r1xyXHnYMj4PUcEGWeVhcg>
    <xmx:4-z8X3mk0Jk8OpanDTo_bN17auPtLHmsGa18rckjMQJTPF1ycz-bbg>
    <xmx:4-z8X92BarscU_Lc-emjKicyg6O4j_7oRvZfu1xWOEvRMWwhBV4B0Q>
    <xmx:5Oz8X4SORf2oTk9BDiQILlmW-Q_-kGK82dnCLIDmW8XhbahyvTQQyg>
Received: from mickey.themaw.net (unknown [121.44.131.23])
        by mail.messagingengine.com (Postfix) with ESMTPA id 148621080063;
        Mon, 11 Jan 2021 19:27:12 -0500 (EST)
Message-ID: <1a1a8435f6b5fdeb2aec143737dddb2f70872c38.camel@themaw.net>
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
Date:   Tue, 12 Jan 2021 08:27:09 +0800
In-Reply-To: <CAC2o3D+_Cscy4HyQhigh3DQvth7EJgQFA8PX94=XC5R30fwRwQ@mail.gmail.com>
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
         <CAC2o3DJqK0ECrRnO0oArgHV=_S7o35UzfP4DSSXZLJmtLbvrKg@mail.gmail.com>
         <04675888088a088146e3ca00ca53099c95fbbad7.camel@themaw.net>
         <CAC2o3D+qsH3suFk4ZX9jbSOy3WbMHdb9j6dWUhWuvt1RdLOODA@mail.gmail.com>
         <75de66869bd584903055996fb0e0bab2b57acd68.camel@themaw.net>
         <42efbb86327c2f5a8378d734edc231e3c5a34053.camel@themaw.net>
         <CAC2o3D+W70pzEd0MQ1Osxnin=j2mxwH4KdAYwR1mB67LyLbf5Q@mail.gmail.com>
         <aa193477213228daf85acdae7c31e1bfff3d694c.camel@themaw.net>
         <CAC2o3D+_Cscy4HyQhigh3DQvth7EJgQFA8PX94=XC5R30fwRwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-01-11 at 17:02 +0800, Fox Chen wrote:
> On Mon, Jan 11, 2021 at 4:42 PM Ian Kent <raven@themaw.net> wrote:
> > On Mon, 2021-01-11 at 15:04 +0800, Fox Chen wrote:
> > > On Mon, Jan 11, 2021 at 12:20 PM Ian Kent <raven@themaw.net>
> > > wrote:
> > > > On Mon, 2021-01-11 at 11:19 +0800, Ian Kent wrote:
> > > > > On Wed, 2021-01-06 at 10:38 +0800, Fox Chen wrote:
> > > > > > Hi Ian,
> > > > > > 
> > > > > > I am rethinking this problem. Can we simply use a global
> > > > > > lock?
> > > > > > 
> > > > > >  In your original patch 5, you have a global mutex
> > > > > > attr_mutex
> > > > > > to
> > > > > > protect attr, if we change it to a rwsem, is it enough to
> > > > > > protect
> > > > > > both
> > > > > > inode and attr while having the concurrent read ability?
> > > > > > 
> > > > > > like this patch I submitted. ( clearly, I missed
> > > > > > __kernfs_iattrs
> > > > > > part,
> > > > > > but just about that idea )
> > > > > > https://lore.kernel.org/lkml/20201207084333.179132-1-foxhlchen@gmail.com/
> > > > > 
> > > > > I don't think so.
> > > > > 
> > > > > kernfs_refresh_inode() writes to the inode so taking a read
> > > > > lock
> > > > > will allow multiple processes to concurrently update it which
> > > > > is
> > > > > what we need to avoid.
> > > 
> > > Oh, got it. I missed the inode part. my bad. :(
> > > 
> > > > > It's possibly even more interesting.
> > > > > 
> > > > > For example, kernfs_iop_rmdir() and kernfs_iop_mkdir() might
> > > > > alter
> > > > > the inode link count (I don't know if that would be the sort
> > > > > of
> > > > > thing
> > > > > they would do but kernfs can't possibly know either). Both of
> > > > > these
> > > > > functions rely on the VFS locking for exclusion but the inode
> > > > > link
> > > > > count is updated in kernfs_refresh_inode() too.
> > > > > 
> > > > > That's the case now, without any patches.
> > > > 
> > > > So it's not so easy to get the inode from just the kernfs
> > > > object
> > > > so these probably aren't a problem ...
> > > 
> > > IIUC only when dop->revalidate, iop->lookup being called, the
> > > result
> > > of rmdir/mkdir will be sync with vfs.
> > 
> > Don't quite get what you mean here?
> > 
> > Do you mean something like, VFS objects are created on user access
> > to the file system. Given that user access generally means path
> > resolution possibly followed by some operation.
> > 
> > I guess those VFS objects will go away some time after the access
> > but even thought the code looks like that should happen pretty
> > quickly after I've observed that these objects stay around longer
> > than expected. There wouldn't be any use in maintaining a least
> > recently used list of dentry candidates eligible to discard.
> 
> Yes, that is what I meant. I think the duration may depend on the
> current ram pressure. though not quite sure, I'm still digging this
> part of code.

The dentries on the LRU list are the ones that will get pruned
for things like memory pressure and drop caches invocations.

But it's a bit hard to grok that because it happens separately
so it's not something you pick up (if your like me) from linearly
scanning the code.

Ian

> 
> > > kernfs_node is detached from vfs inode/dentry to save ram.
> > > 
> > > > > I'm not entirely sure what's going on in
> > > > > kernfs_refresh_inode().
> > > > > 
> > > > > It could be as simple as being called with a NULL inode
> > > > > because
> > > > > the dentry concerned is negative at that point. I haven't had
> > > > > time to look closely at it TBH but I have been thinking about
> > > > > it.
> > > 
> > > um, It shouldn't be called with a NULL inode, right?
> > > 
> > > inode->i_mode = kn->mode;
> > > 
> > > otherwise will crash.
> > 
> > Yes, you're right about that.
> > 
> > > > Certainly this can be called without a struct iattr having been
> > > > allocated ... and given it probably needs to remain a pointer
> > > > rather than embedded in the node the inode link count update
> > > > can't easily be protected from concurrent updates.
> > > > 
> > > > If it was ok to do the allocation at inode creation the problem
> > > > becomes much simpler to resolve but I thought there were
> > > > concerns
> > > > about ram consumption (although I don't think that was exactly
> > > > what
> > > > was said?).
> > > > 
> > > 
> > > you meant iattr to be allocated at inode creation time??
> > > yes, I think so. it's due to ram consumption.
> > 
> > I did, yes.
> > 
> > The actual problem is dealing with multiple concurrent updates to
> > the inode link count, the rest can work.
> > 
> > Ian
> > 
> 
> fox

