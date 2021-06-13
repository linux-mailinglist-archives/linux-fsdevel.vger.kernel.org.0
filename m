Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917423A55FB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jun 2021 03:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhFMBdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Jun 2021 21:33:38 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:60375 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229753AbhFMBdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Jun 2021 21:33:37 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 7E07A10D2;
        Sat, 12 Jun 2021 21:31:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 12 Jun 2021 21:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        b3t8hZRfSlI/Y+tiwVm5+qLUp7/kF3OUNDPX0rpg0OU=; b=MiGQ5fKSbeUntkY1
        BqYrvQwca864HsTIeGdrzvMe06t4A9aGjI2yenNWmcwgZpmGutMsg+TJ6LOvy3er
        Ixwqxjb62KmKvmwaAM1lq3LV4hc017odWeLRhi3a2yjPCNc3WyBo56h12bGAa8DV
        w3gvAdSLjjrAdjS1o+Gg8znQQ9bLvN/F20XMl2VuRiOcQVyJ+nwhBM0qmkG7YTdy
        BC3rAwbz1JW0s1qA7gyNekCWs+SwchgXWNpCyp+D9tFR6z25Gn/bbCjk0RQPPiPy
        S9Fkpi4HBuGI7p7pP+urm/4JK+EjKRueimvluXLYk2sThXYU9tL62OvwlB6HO+mt
        AyHdow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=b3t8hZRfSlI/Y+tiwVm5+qLUp7/kF3OUNDPX0rpg0
        OU=; b=eOZ0el+P2R1qoPaam9vQWrtqgEHXyVhLkpwPnLDO4N3o6PH9X3q5/7jJ+
        U9iqDrxTf2dXItDAn/hOY7GL0rUZzh/flFDI1yuS82WOhaykBfpVnuvDZG2LR5Dr
        FyF1z4teMFYCD2TKjJTEXZs0UI0AT5fcIKacbKWwbXW1NUtx2GZBCGebc6iCgmbF
        kYd5E6C2E6H6hC2d3L2mR9Peytk03Va+CrbY5h9Nc/2qaM/UJYrwXlsxqCqp7lLb
        AKJJDT6J+jEnQjq7whiYdn4ipMXlXOvTFxRzssZUb6gNHRsmqFxgRVMkwnKZnYoK
        saj9u0uhDON8GZWKjOYGaYzJJEvhw==
X-ME-Sender: <xms:91_FYDLVp-VEw0iap08j3xfFVBkykZd8KVgYt2hLnBjw3yEHqrV5VQ>
    <xme:91_FYHLODsC972ICfG33_6CLEMbAHExrFEJ698pmb8Z7ZeqYt4nwZNo3JCoFP9iMr
    uKJhPaenoTO>
X-ME-Received: <xmr:91_FYLuqQDh9g9Z_vN-p1b-nBry6SNcCjvgfyo4MEjqwhk5cNeIIrzf8U4HgSNh4nKW08RNQrYmSp70VI6VxvsaB6sG-UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvuddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:91_FYMYfNOD3V1Dm7hhTxkmX_KjKk7iC8HsCIyUyOMeZUueLIvF0Pw>
    <xmx:91_FYKYviYX9iYcJhokV_rCGiWxCfkXlu0je054XYlY_q6kHPKG2uA>
    <xmx:91_FYAAKJ34aDHZRayBBoC0ja4qMB5FZpFsj5-070KEUXldineA-Eg>
    <xmx:91_FYMCckxzlNPUE_fv0g7hl2x5kcE3Gif5CxOLnh_QrXtBGWnA5owX5I7A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Jun 2021 21:31:30 -0400 (EDT)
Message-ID: <1d6b99854f6c3d7948882d745b3fef9a3116ab73.camel@themaw.net>
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
Date:   Sun, 13 Jun 2021 09:31:26 +0800
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

That description's wrong, I'll fix that.
 
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


