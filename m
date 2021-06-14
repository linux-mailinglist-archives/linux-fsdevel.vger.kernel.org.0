Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5EC3A5B57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 03:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhFNBeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Jun 2021 21:34:36 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:60161 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232076AbhFNBef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Jun 2021 21:34:35 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 9EF2719F0;
        Sun, 13 Jun 2021 21:32:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 13 Jun 2021 21:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        qGkGzluDZKwa6XNj5xwftgaTKUt7kFu8R2chJvRiqtA=; b=kSEVafMle+mzaEWA
        E+shbM5uq2ESPTlJ4jVr37M2oOiAFvmb6c3sObYI+/CUj5kqebj6RDWOynPMOFlQ
        0zK6s2Bqw4UNeRsEIeWvHQMqiknV7+Zelvju2OZ+/emhbmmKqREe50LCkDJJMG97
        0Sge0X5NSY4aknqkJdpUCdHvQh9qLmOnq4KCbGQHAxNETkJHqCMhuwtsK/EDTU5Q
        aE/xlI9PBA9EDqk9J8WK8Z2R5NBY6mZJUbY8DxOkEZ3EZCEVzDdOdnlTtGqw5nQZ
        /OwJE4Vh8FumCAbGL7uQtnmLPXWte/IxYO+GqHSZKz5sUIGaWeyIGMtl39LjtNOw
        2JRwvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=qGkGzluDZKwa6XNj5xwftgaTKUt7kFu8R2chJvRiq
        tA=; b=dsoboGMSUo9hLvBGc5pxH9hvyrpgzV88QtaPavpkt2NQPJUJ+gHpooUrB
        XqvPV3YTMEt6mUtflbJ9XgV1YXP4INjgAHbKbrIF5779azRRYEOb5w6rzv+maIlA
        nUo8JB3CkBD3SAg3ve0ycsS0HmDJqQd7efE9dl0FdW+dN0sz1jhfykXRU70Ohq5d
        ldthLqDxH0u0+o8fcJDBUwnzBMSFfyz371uT1vbKAHit6W13P53HBVIY08uzqL6j
        z2wT3JE/B16VjHdkKua+d2oGfXsdOQRIcLVx5O7Vt09CKM5eWI7ZxSKbd7pJIgUX
        XqmAuBsRdGxWrllymYtrtImxQp0CQ==
X-ME-Sender: <xms:r7HGYIKRwvgtran1mwE6TSgThbdlfEMkAYKYa2vezHtWBRuCyUQ1kA>
    <xme:r7HGYILcYOFs8et1lyDVKgYLGLfpfZTfy16mw2QaEqtKP12IBUkmajDnW_MBhrrGC
    _t46D-0Tfw9>
X-ME-Received: <xmr:r7HGYIsHk_dQjwhnAgGNO5JvieXmD16WNVcFJ1DbEYT8IQExaZgjiMJpj7Z-SLpV2QSm0CDLn6RW1qKm1vDAxGGhK0E2vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:r7HGYFaEaEWdqWuej5wGIw7CRSMN-lTp_IIleVPccaCmXRok-oEX4A>
    <xmx:r7HGYPZg8UM8rrsWsL9i8ef4YxaPG37AaPv4nbGVtI7g_jWh_RBWMQ>
    <xmx:r7HGYBDpkQJ0LZLTEXLC7344BZtec4IMSUE9zelWa9_AYAhmVaGv7g>
    <xmx:sLHGYNBftKTmWUXQiO6d0GngIXaqw0jOOiDAiMFYiFvX1tXBrkEIbLekQG4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Jun 2021 21:32:26 -0400 (EDT)
Message-ID: <43fe46a18bdc2e46f62a07f1e4a9b3d042ef3c01.camel@themaw.net>
Subject: Re: [PATCH v6 5/7] kernfs: use i_lock to protect concurrent inode
 updates
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 14 Jun 2021 09:32:22 +0800
In-Reply-To: <YMQRzl4guvQQJwG0@zeniv-ca.linux.org.uk>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
         <162322868275.361452.17585267026652222121.stgit@web.messagingengine.com>
         <YMQRzl4guvQQJwG0@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2021-06-12 at 01:45 +0000, Al Viro wrote:
> On Wed, Jun 09, 2021 at 04:51:22PM +0800, Ian Kent wrote:
> > The inode operations .permission() and .getattr() use the kernfs
> > node
> > write lock but all that's needed is to keep the rb tree stable
> > while
> > updating the inode attributes as well as protecting the update
> > itself
> > against concurrent changes.
> 
> Huh?  Where does it access the rbtree at all?  Confused...
> 
> > diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> > index 3b01e9e61f14e..6728ecd81eb37 100644
> > --- a/fs/kernfs/inode.c
> > +++ b/fs/kernfs/inode.c
> > @@ -172,6 +172,7 @@ static void kernfs_refresh_inode(struct
> > kernfs_node *kn, struct inode *inode)
> >  {
> >         struct kernfs_iattrs *attrs = kn->iattr;
> >  
> > +       spin_lock(&inode->i_lock);
> >         inode->i_mode = kn->mode;
> >         if (attrs)
> >                 /*
> > @@ -182,6 +183,7 @@ static void kernfs_refresh_inode(struct
> > kernfs_node *kn, struct inode *inode)
> >  
> >         if (kernfs_type(kn) == KERNFS_DIR)
> >                 set_nlink(inode, kn->dir.subdirs + 2);
> > +       spin_unlock(&inode->i_lock);
> >  }
> 
> Even more so - just what are you serializing here?  That code
> synchronizes inode
> metadata with those in kernfs_node.  Suppose you've got two threads
> doing
> ->permission(); the first one gets through kernfs_refresh_inode() and
> goes into
> generic_permission().  No locks are held, so kernfs_refresh_inode()
> from another
> thread can run in parallel with generic_permission().
> 
> If that's not a problem, why two kernfs_refresh_inode() done in
> parallel would
> be a problem?
> 
> Thread 1:
>         permission
>                 done refresh, all locks released now
> Thread 2:
>         change metadata in kernfs_node
> Thread 2:
>         permission
>                 goes into refresh, copying metadata into inode
> Thread 1:
>                 generic_permission()
> No locks in common between the last two operations, so
> we generic_permission() might see partially updated metadata.
> Either we don't give a fuck (in which case I don't understand
> what purpose does that ->i_lock serve) *or* we need the exclusion
> to cover a wider area.

This didn't occur to me, obviously.

It seems to me this can happen with the original code too although
using a mutex might reduce the likelihood of it happening.

Still ->permission() is meant to be a read-only function so the VFS
shouldn't need to care about it.

Do you have any suggestions on how to handle this.
Perhaps the only way is to ensure the inode is updated only in
functions that are expected to do this.

Ian

