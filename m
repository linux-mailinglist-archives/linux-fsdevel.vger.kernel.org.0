Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DA83A4285
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 14:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhFKM6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 08:58:31 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:43523 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231482AbhFKM6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:58:30 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 61F6C1980;
        Fri, 11 Jun 2021 08:56:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 11 Jun 2021 08:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        iW4ZE/BB6PBmS5q7Ee0NyNuhpgtw/+D17L4kdaX9rXU=; b=QJxIZIC4SBtkNphu
        PvayLa5vSlo4/BTtnda6Z6oE10JTUXdyRr19mj9eNy45JzLdvLnAi5nozX0VzIBl
        KmuAqf30pHP9s/EbtrxsFmzGcMBAIoBwV0lIB9mwOV4suhr25ulqHs7ZMyhovcNF
        ShuLnovIefDF6+50uzy9yzsOWYYkA40OkxetniAJFrKWluvxIRVd/OYCBkKvShiC
        slPqPG2DQboOVmoWwTx6tS/Z/O+KGeJFNbUso4n2q0gRZ3NELYtIAq8J4ai3n/H2
        XFjbOvfS/D06b29sof5jzfaN26IiUchwx9lmOBv4BeC4cyk7HFbx2UyeEAHHImHS
        ZNpfQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=iW4ZE/BB6PBmS5q7Ee0NyNuhpgtw/+D17L4kdaX9r
        XU=; b=NAWmrgbh+gyOGzG9gi/2WGKBjC84htMyoaPIfhKjRqomhdeErfWGpOA80
        w5dO2ieyUusayl9SpUlyI20cseCzf19XdHnEAjy3gTrNGsWZX+xbPv9yUoFWPO9a
        1xsy6rA2k1yKLIx9/gyzc2yylyiEPxclFv6dhOCjnZFO3iwBQdJtCOGrBuH7yXbi
        0Ba6bxiyAoSIXNIeuZIC1uMVyjFAbUPTc6iJLcRsREhtcWAC1JxVnbv0rw5xo6Mi
        BJTCzo3Cj0Ay0+w+CcRxnPMr2a/oC75SZZf82024ZdtwqPQCQ/j0+ngUi1GOl27A
        rnaIMwcoB2DIVzzR2Y/rXlehiUMNw==
X-ME-Sender: <xms:e13DYKuwDD6Q6-4eNTQ-APOt3lLPoMGw2dZRnK4WEfT7yug_O1uP0Q>
    <xme:e13DYPf2ukHZJ0ELAwhRI87Ul_8UwRHD3cSxaVzY-6NhBt3lMLtoyY1MT_6lSmdRA
    -hWroML357A>
X-ME-Received: <xmr:e13DYFxpkctvLlMZIabZcp5qqiRaej2meDi3gxd2C47MaeAmOYfDK1xyj2i12_sAr24qPo_82Q1Ouqjt7j0vQVNxaf5Fjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedujedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:e13DYFPwRX98fLbhBGC5_Cb7z-sNwfZlqYBVBrIZZnxERuGONHOtgg>
    <xmx:e13DYK-pecl6MnB0qNnhrzO6qzl-guqBxtbY6_5ih6pqEg0KDPjyzQ>
    <xmx:e13DYNUVe8en9cpB1IerjMlqUNn_DhqqWeGPcYDllxTe8pV1nG_UvQ>
    <xmx:e13DYNVHhp8kvrh9klp-38h_HUnfn_aRr8QLfTotM4JgdB6WknQBiLUK0y8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jun 2021 08:56:22 -0400 (EDT)
Message-ID: <03f6e366fb4ebb56b15541d53eda461a55d3d38e.camel@themaw.net>
Subject: Re: [PATCH v6 2/7] kernfs: add a revision to identify directory
 node changes
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 11 Jun 2021 20:56:18 +0800
In-Reply-To: <CAJfpeguzPEy+UAcyT4tcpvYxeTwB+64yxRw8Sh7UBROBuafYdw@mail.gmail.com>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
         <162322859985.361452.14110524195807923374.stgit@web.messagingengine.com>
         <CAJfpeguzPEy+UAcyT4tcpvYxeTwB+64yxRw8Sh7UBROBuafYdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-06-11 at 14:49 +0200, Miklos Szeredi wrote:
> On Wed, 9 Jun 2021 at 10:50, Ian Kent <raven@themaw.net> wrote:
> > 
> > Add a revision counter to kernfs directory nodes so it can be used
> > to detect if a directory node has changed during negative dentry
> > revalidation.
> > 
> > There's an assumption that sizeof(unsigned long) <= sizeof(pointer)
> > on all architectures and as far as I know that assumption holds.
> > 
> > So adding a revision counter to the struct kernfs_elem_dir variant
> > of
> > the kernfs_node type union won't increase the size of the
> > kernfs_node
> > struct. This is because struct kernfs_elem_dir is at least
> > sizeof(pointer) smaller than the largest union variant. It's
> > tempting
> > to make the revision counter a u64 but that would increase the size
> > of
> > kernfs_node on archs where sizeof(pointer) is smaller than the
> > revision
> > counter.
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/kernfs/dir.c             |    2 ++
> >  fs/kernfs/kernfs-internal.h |   23 +++++++++++++++++++++++
> >  include/linux/kernfs.h      |    5 +++++
> >  3 files changed, 30 insertions(+)
> > 
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 33166ec90a112..b3d1bc0f317d0 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -372,6 +372,7 @@ static int kernfs_link_sibling(struct
> > kernfs_node *kn)
> >         /* successfully added, account subdir number */
> >         if (kernfs_type(kn) == KERNFS_DIR)
> >                 kn->parent->dir.subdirs++;
> > +       kernfs_inc_rev(kn->parent);
> > 
> >         return 0;
> >  }
> > @@ -394,6 +395,7 @@ static bool kernfs_unlink_sibling(struct
> > kernfs_node *kn)
> > 
> >         if (kernfs_type(kn) == KERNFS_DIR)
> >                 kn->parent->dir.subdirs--;
> > +       kernfs_inc_rev(kn->parent);
> > 
> >         rb_erase(&kn->rb, &kn->parent->dir.children);
> >         RB_CLEAR_NODE(&kn->rb);
> > diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-
> > internal.h
> > index ccc3b44f6306f..b4e7579e04799 100644
> > --- a/fs/kernfs/kernfs-internal.h
> > +++ b/fs/kernfs/kernfs-internal.h
> > @@ -81,6 +81,29 @@ static inline struct kernfs_node
> > *kernfs_dentry_node(struct dentry *dentry)
> >         return d_inode(dentry)->i_private;
> >  }
> > 
> > +static inline void kernfs_set_rev(struct kernfs_node *kn,
> > +                                 struct dentry *dentry)
> > +{
> > +       if (kernfs_type(kn) == KERNFS_DIR)
> > +               dentry->d_time = kn->dir.rev;
> > +}
> > +
> > +static inline void kernfs_inc_rev(struct kernfs_node *kn)
> > +{
> > +       if (kernfs_type(kn) == KERNFS_DIR)
> > +               kn->dir.rev++;
> > +}
> > +
> > +static inline bool kernfs_dir_changed(struct kernfs_node *kn,
> > +                                     struct dentry *dentry)
> > +{
> > +       if (kernfs_type(kn) == KERNFS_DIR) {
> 
> Aren't these always be called on a KERNFS_DIR node?

Yes they are.

> 
> You could just reduce that to a WARN_ON, or remove the conditions
> altogether then.

I was tempted to not use the check, a WARN_ON sounds better than
removing the check, I'll do that in a v7.

Thanks
Ian

