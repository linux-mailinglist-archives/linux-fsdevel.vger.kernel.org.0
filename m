Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68122DD0C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 12:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgLQLuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 06:50:07 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:55985 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727999AbgLQLuG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 06:50:06 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 35EFE94F;
        Thu, 17 Dec 2020 06:49:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 17 Dec 2020 06:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        5eBczb4YqlhC7zf0h6L4Tzg0nNsZh+/50osN0IUETE4=; b=yCHxoa9wEABa+1ih
        n8dde8Sx20BrpgUWtiAxkeANna540J5V/RKGfZthxXmh0m6MsHG+GEGOFBuJc+Eu
        jwmxuZEZzS0IBSYEwi+HndyVMEljEytcNDR9XSuwVcSBmV3Ey7Dq7OBNRSJ0+aCC
        fQUWJMdVnRQUa3JGHyItGdBbvQqbvt6Z0lm9KK3saatEuJhIL+ewzRy2BtTod+TF
        hEv5vJoJnKzI6xlW51zoMbzmUizKIMG6BRqqmhMfspaVQfTAfgjAQ/XRygnLSBy/
        0tT3sFXJLgiS79NGTIIMrOTQPuqb8LesOph7F8p1f3ZWufsDBHoqQrjCCeYJG7t5
        R2ix0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=5eBczb4YqlhC7zf0h6L4Tzg0nNsZh+/50osN0IUET
        E4=; b=BufWaAX+ZzZ6N2h1ilJGLj+fjdkAQWPjIwpi6KO2FneeLJoOSMOUgywFE
        Z1Gar6CL6Dpz4yPyxrhXrbPCKDYkRP4M7CQ0sYYMa7VdhBl497yqNQil48d/OSkh
        raTFeThtguUrcCrRdZw1+KwfR6szS87AkHmVGupIIQVPflfseMQkjMEu8W7jZXaC
        hQOTflP7hxHgK75xlb1WL9gJTVIiL4nbv2QJPB7Z+/pUdoHIrG9egwXxkrK7PTMj
        WGYbyOfnBr1T0rQB/oSb6FtvwOTouZdMIAFj0Mn2WPUgzpkOpTazQ6uJW/u6X7k2
        LZoz2ySwOvWze5looNL+x3QDi11zg==
X-ME-Sender: <xms:qUXbXyviOZaB_imbQEEVxgO1-WiEp5sqJrT4epU9dldWsNyyjAGDfw>
    <xme:qUXbX3cKcglYAfWVntsjFtIkxcG0qQkdCraNb3Hqy3-lkh2B9j67cntaOf2klQVSa
    vA4j0ARWybD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelgedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eikeeggeeuvdevgfefiefhudekkeegheeileejveethedutedvveehudffjeevudenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedutdeirdeiledrvdegjedrvddthe
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghv
    vghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:qUXbX9y2CUrtDYl69eOEM_Szsi4TVFL_W_fwwYVnnlHjGCS3Ih_AIg>
    <xmx:qUXbX9PvH-BdNnCwesYIyayAOxQgNB0KBPfbK-EEHRjWQJNr6Q2WqA>
    <xmx:qUXbXy9z2Gsyy71txcpGw2TuxW1-iDHqtdrxcK558rfHM6yC5NTgbA>
    <xmx:q0XbX3MgX5oQSqLMp0frvyvLWgcW7zKH_BA1v_QCwCLDnj8_kNuock3SGYE>
Received: from mickey.themaw.net (106-69-247-205.dyn.iinet.net.au [106.69.247.205])
        by mail.messagingengine.com (Postfix) with ESMTPA id DC2961080059;
        Thu, 17 Dec 2020 06:48:53 -0500 (EST)
Message-ID: <c8a6c9adc3651e64cf694f580a8cb3d87d7cb893.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, viro@zeniv.linux.org.uk
Date:   Thu, 17 Dec 2020 19:48:49 +0800
In-Reply-To: <a39b73a53778094279522f1665be01ce15fb21f4.camel@themaw.net>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20201210164423.9084-1-foxhlchen@gmail.com>
         <822f02508d495ee7398450774eb13e5116ec82ac.camel@themaw.net>
         <13e21e4c9a5841243c8d130cf9324f6cfc4dc2e1.camel@themaw.net>
         <bde0b6c32f2b055c1ad1401b45c4adf61aab6876.camel@themaw.net>
         <CAC2o3DJdHuQxY7Rn5uXUprS7i8ri1qB=wOUM2rdZkWt4yJHv1w@mail.gmail.com>
         <3e97846b52a46759c414bff855e49b07f0d908fc.camel@themaw.net>
         <CAC2o3DLGtx15cgra3Y92UBdQRBKGckqOkDmwBV-aV-EpUqO5SQ@mail.gmail.com>
         <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net>
         <da4f730bbbb20c0920599ca5afc316e2c092b7d8.camel@themaw.net>
         <CAC2o3DJsvB6kj=S6D3q+_OBjgez9Q9B5s3-_gjUjaKmb2MkTHQ@mail.gmail.com>
         <c4002127c72c07a00e8ba0fae6b0ebf5ba8e08e7.camel@themaw.net>
         <a39b73a53778094279522f1665be01ce15fb21f4.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-12-17 at 19:09 +0800, Ian Kent wrote:
> On Thu, 2020-12-17 at 18:09 +0800, Ian Kent wrote:
> > On Thu, 2020-12-17 at 16:54 +0800, Fox Chen wrote:
> > > On Thu, Dec 17, 2020 at 12:46 PM Ian Kent <raven@themaw.net>
> > > wrote:
> > > > On Tue, 2020-12-15 at 20:59 +0800, Ian Kent wrote:
> > > > > On Tue, 2020-12-15 at 16:33 +0800, Fox Chen wrote:
> > > > > > On Mon, Dec 14, 2020 at 9:30 PM Ian Kent <raven@themaw.net>
> > > > > > wrote:
> > > > > > > On Mon, 2020-12-14 at 14:14 +0800, Fox Chen wrote:
> > > > > > > > On Sun, Dec 13, 2020 at 11:46 AM Ian Kent <
> > > > > > > > raven@themaw.net
> > > > > > > > wrote:
> > > > > > > > > On Fri, 2020-12-11 at 10:17 +0800, Ian Kent wrote:
> > > > > > > > > > On Fri, 2020-12-11 at 10:01 +0800, Ian Kent wrote:
> > > > > > > > > > > > For the patches, there is a mutex_lock in kn-
> > > > > > > > > > > > > attr_mutex,
> > > > > > > > > > > > as
> > > > > > > > > > > > Tejun
> > > > > > > > > > > > mentioned here
> > > > > > > > > > > > (
> > > > > > > > > > > > https://lore.kernel.org/lkml/X8fe0cmu+aq1gi7O@mtj.duckdns.org/
> > > > > > > > > > > > ),
> > > > > > > > > > > > maybe a global
> > > > > > > > > > > > rwsem for kn->iattr will be better??
> > > > > > > > > > > 
> > > > > > > > > > > I wasn't sure about that, IIRC a spin lock could
> > > > > > > > > > > be
> > > > > > > > > > > used
> > > > > > > > > > > around
> > > > > > > > > > > the
> > > > > > > > > > > initial check and checked again at the end which
> > > > > > > > > > > would
> > > > > > > > > > > probably
> > > > > > > > > > > have
> > > > > > > > > > > been much faster but much less conservative and a
> > > > > > > > > > > bit
> > > > > > > > > > > more
> > > > > > > > > > > ugly
> > > > > > > > > > > so
> > > > > > > > > > > I just went the conservative path since there was
> > > > > > > > > > > so
> > > > > > > > > > > much
> > > > > > > > > > > change
> > > > > > > > > > > already.
> > > > > > > > > > 
> > > > > > > > > > Sorry, I hadn't looked at Tejun's reply yet and TBH
> > > > > > > > > > didn't
> > > > > > > > > > remember
> > > > > > > > > > it.
> > > > > > > > > > 
> > > > > > > > > > Based on what Tejun said it sounds like that needs
> > > > > > > > > > work.
> > > > > > > > > 
> > > > > > > > > Those attribute handling patches were meant to allow
> > > > > > > > > taking
> > > > > > > > > the
> > > > > > > > > rw
> > > > > > > > > sem read lock instead of the write lock for
> > > > > > > > > kernfs_refresh_inode()
> > > > > > > > > updates, with the added locking to protect the inode
> > > > > > > > > attributes
> > > > > > > > > update since it's called from the VFS both with and
> > > > > > > > > without
> > > > > > > > > the
> > > > > > > > > inode lock.
> > > > > > > > 
> > > > > > > > Oh, understood. I was asking also because lock on kn-
> > > > > > > > > attr_mutex
> > > > > > > > drags
> > > > > > > > concurrent performance.
> > > > > > > > 
> > > > > > > > > Looking around it looks like kernfs_iattrs() is
> > > > > > > > > called
> > > > > > > > > from
> > > > > > > > > multiple
> > > > > > > > > places without a node database lock at all.
> > > > > > > > > 
> > > > > > > > > I'm thinking that, to keep my proposed change
> > > > > > > > > straight
> > > > > > > > > forward
> > > > > > > > > and on topic, I should just leave
> > > > > > > > > kernfs_refresh_inode()
> > > > > > > > > taking
> > > > > > > > > the node db write lock for now and consider the
> > > > > > > > > attributes
> > > > > > > > > handling
> > > > > > > > > as a separate change. Once that's done we could
> > > > > > > > > reconsider
> > > > > > > > > what's
> > > > > > > > > needed to use the node db read lock in
> > > > > > > > > kernfs_refresh_inode().
> > > > > > > > 
> > > > > > > > You meant taking write lock of kernfs_rwsem for
> > > > > > > > kernfs_refresh_inode()??
> > > > > > > > It may be a lot slower in my benchmark, let me test it.
> > > > > > > 
> > > > > > > Yes, but make sure the write lock of kernfs_rwsem is
> > > > > > > being
> > > > > > > taken
> > > > > > > not the read lock.
> > > > > > > 
> > > > > > > That's a mistake I had initially?
> > > > > > > 
> > > > > > > Still, that attributes handling is, I think, sufficient
> > > > > > > to
> > > > > > > warrant
> > > > > > > a separate change since it looks like it might need work,
> > > > > > > the
> > > > > > > kernfs
> > > > > > > node db probably should be kept stable for those
> > > > > > > attribute
> > > > > > > updates
> > > > > > > but equally the existence of an instantiated dentry might
> > > > > > > mitigate
> > > > > > > the it.
> > > > > > > 
> > > > > > > Some people might just know whether it's ok or not but I
> > > > > > > would
> > > > > > > like
> > > > > > > to check the callers to work out what's going on.
> > > > > > > 
> > > > > > > In any case it's academic if GCH isn't willing to
> > > > > > > consider
> > > > > > > the
> > > > > > > series
> > > > > > > for review and possible merge.
> > > > > > > 
> > > > > > Hi Ian
> > > > > > 
> > > > > > I removed kn->attr_mutex and changed read lock to write
> > > > > > lock
> > > > > > for
> > > > > > kernfs_refresh_inode
> > > > > > 
> > > > > > down_write(&kernfs_rwsem);
> > > > > > kernfs_refresh_inode(kn, inode);
> > > > > > up_write(&kernfs_rwsem);
> > > > > > 
> > > > > > 
> > > > > > Unfortunate, changes in this way make things worse,  my
> > > > > > benchmark
> > > > > > runs
> > > > > > 100% slower than upstream sysfs.  :(
> > > > > > open+read+close a sysfs file concurrently took 1000us.
> > > > > > (Currently,
> > > > > > sysfs with a big mutex kernfs_mutex only takes ~500us
> > > > > > for one open+read+close operation concurrently)
> > > > > 
> > > > > Right, so it does need attention nowish.
> > > > > 
> > > > > I'll have a look at it in a while, I really need to get a new
> > > > > autofs
> > > > > release out, and there are quite a few changes, and testing
> > > > > is
> > > > > seeing
> > > > > a number of errors, some old, some newly introduced. It's
> > > > > proving
> > > > > difficult.
> > > > 
> > > > I've taken a breather for the autofs testing and had a look at
> > > > this.
> > > 
> > > Thanks. :)
> > > 
> > > > I think my original analysis of this was wrong.
> > > > 
> > > > Could you try this patch please.
> > > > I'm not sure how much difference it will make but, in
> > > > principle,
> > > > it's much the same as the previous approach except it doesn't
> > > > increase the kernfs node struct size or mess with the other
> > > > attribute handling code.
> > > > 
> > > > Note, this is not even compile tested.
> > > 
> > > I failed to apply this patch. So based on the original six
> > > patches,
> > > I
> > > manually removed kn->attr_mutex, and added
> > > inode_lock/inode_unlock to those two functions, they were like:
> > > 
> > > int kernfs_iop_getattr(const struct path *path, struct kstat
> > > *stat,
> > >                        u32 request_mask, unsigned int
> > > query_flags)
> > > {
> > >         struct inode *inode = d_inode(path->dentry);
> > >         struct kernfs_node *kn = inode->i_private;
> > > 
> > >         inode_lock(inode);
> > >         down_read(&kernfs_rwsem);
> > >         kernfs_refresh_inode(kn, inode);
> > >         up_read(&kernfs_rwsem);
> > >         inode_unlock(inode);
> > > 
> > >         generic_fillattr(inode, stat);
> > >         return 0;
> > > }
> > > 
> > > int kernfs_iop_permission(struct inode *inode, int mask)
> > > {
> > >         struct kernfs_node *kn;
> > > 
> > >         if (mask & MAY_NOT_BLOCK)
> > >                 return -ECHILD;
> > > 
> > >         kn = inode->i_private;
> > > 
> > >         inode_lock(inode);
> > >         down_read(&kernfs_rwsem);
> > >         kernfs_refresh_inode(kn, inode);
> > >         up_read(&kernfs_rwsem);
> > >         inode_unlock(inode);
> > > 
> > >         return generic_permission(inode, mask);
> > > }
> > > 
> > > But I couldn't boot the kernel and there was no error on the
> > > screen.
> > > I guess it was deadlocked on /sys creation?? :D
> > 
> > Right, I guess the locking documentation is out of date. I'm
> > guessing
> > the inode lock is taken somewhere over the .permission() call. If
> > that
> > usage is consistent it's easy fixed, if the usage is inconsistent
> > it's
> > hard to deal with and amounts to a bug.
> 
> Yes, it is called, both shared on open, and exclusive on open
> create, and without the inode lock at all at the start of path
> resolution.
> 
> That can't really be called a VFS bug since .permission() is
> meant to check permissions not update the inode.
> 
> This is probably what lead to the attr patches I had.
> 
> If a suitable place to put a local per-object lock can't be
> found for this, other than in the kernfs_node, then it's a
> real problem from a contention POV.
> 
> What could be done is to make the kernfs node attr_mutex
> a pointer and dynamically allocate it but even that is too
> costly a size addition to the kernfs node structure as
> Tejun has said.

I guess the question to ask is, is there really a need to
call kernfs_refresh_inode() from functions that are usually
reading/checking functions.

Would it be sufficient to refresh the inode in the write/set
operations in (if there's any) places where things like
setattr_copy() is not already called?

Perhaps GKH or Tejun could comment on this?

Ian

> 
> Those patches I referred to clearly aren't finished because
> the eighth one is empty, which followed a patch I have titled
> "kernfs: make attr_mutex a local kernfs node lock".
> 
> I obviously gave up on it when the series was rejected.
> But I'll give it some more thought.
> 
> Ian
> 
> > I'll have another look at it.
> > 
> > Also, it sounds like I'm working from a more recent series.
> > 
> > I had 8 patches, dropped the last three and added the one I posted.
> > If I can work out what's going on I'll post the series for you to
> > check.
> > 
> > Ian
> > 
> > > > kernfs: use kernfs read lock in .getattr() and .permission()
> > > > 
> > > > From: Ian Kent <raven@themaw.net>
> > > > 
> > > > From Documenation/filesystems.rst and (slightly outdated)
> > > > comments
> > > > in fs/attr.c the inode i_rwsem is used for attribute handling.
> > > > 
> > > > This lock satisfies the requirememnts needed to reduce lock
> > > > contention,
> > > > namely a per-object lock needs to be used rather than a file
> > > > system
> > > > global lock with the kernfs node db held stable for read
> > > > operations.
> > > > 
> > > > In particular it should reduce lock contention seen when
> > > > calling
> > > > the
> > > > kernfs .permission() method.
> > > > 
> > > > The inode methods .getattr() and .permission() do not hold the
> > > > inode
> > > > i_rwsem lock when called as they are usually read operations.
> > > > Also
> > > > the .permission() method checks for rcu-walk mode and returns
> > > > -ECHILD
> > > > to the VFS if it is set. So the i_rwsem lock can be used in
> > > > kernfs_iop_getattr() and kernfs_iop_permission() to protect the
> > > > inode
> > > > update done by kernfs_refresh_inode(). Using this lock allows
> > > > the
> > > > kernfs node db write lock in these functions to be changed to a
> > > > read
> > > > lock.
> > > > 
> > > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > > ---
> > > >  fs/kernfs/inode.c |   12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> > > > index ddaf18198935..568037e9efe9 100644
> > > > --- a/fs/kernfs/inode.c
> > > > +++ b/fs/kernfs/inode.c
> > > > @@ -189,9 +189,11 @@ int kernfs_iop_getattr(const struct path
> > > > *path, struct kstat *stat,
> > > >         struct inode *inode = d_inode(path->dentry);
> > > >         struct kernfs_node *kn = inode->i_private;
> > > > 
> > > > -       down_write(&kernfs_rwsem);
> > > > +       inode_lock(inode);
> > > > +       down_read(&kernfs_rwsem);
> > > >         kernfs_refresh_inode(kn, inode);
> > > > -       up_write(&kernfs_rwsem);
> > > > +       up_read(&kernfs_rwsem);
> > > > +       inode_unlock(inode);
> > > > 
> > > >         generic_fillattr(inode, stat);
> > > >         return 0;
> > > > @@ -281,9 +283,11 @@ int kernfs_iop_permission(struct inode
> > > > *inode,
> > > > int mask)
> > > > 
> > > >         kn = inode->i_private;
> > > > 
> > > > -       down_write(&kernfs_rwsem);
> > > > +       inode_lock(inode);
> > > > +       down_read(&kernfs_rwsem);
> > > >         kernfs_refresh_inode(kn, inode);
> > > > -       up_write(&kernfs_rwsem);
> > > > +       up_read(&kernfs_rwsem);
> > > > +       inode_unlock(inode);
> > > > 
> > > >         return generic_permission(inode, mask);
> > > >  }
> > > > 
> > > 
> > > thanks,
> > > fox

