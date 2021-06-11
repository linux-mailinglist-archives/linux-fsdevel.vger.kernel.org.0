Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959603A430F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 15:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFKNdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 09:33:49 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:45497 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhFKNdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:33:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id BD81E1816;
        Fri, 11 Jun 2021 09:31:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 11 Jun 2021 09:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        GjwKU+XZBhFKHVYjmgKYWRtYYLdEXkmDES0gwDYX30Q=; b=fhcjG8GypyqILujd
        EPOcZy7DYVUEpQWom/9zlOtQbeLfCs1dJSG2Dfj+L8yit84TYWIw50Qf3zXkZtpr
        6eUljJ7Lvxq8p7OmM3h5crpLVSzYF/kZKwaxio4u1ycJ5/Xw5O3GtBQtAgmQcTh9
        eFDCRd3bGZEOCdhibijxJYq1afIQCadK0P5F1t8nzR9gz/f3q+nJWiXwsyZiQDNP
        TLAg6YBlww9UlSnH09vnVTLzipmoP9foA1Am+q9aFEzX2yTBskGS3prs3GVoE2Be
        2yEf6O59cXQ+XyYYrDtEwEIfYw8vr8gAaDk2R6aSn0N1pnBavqrqgDAS8BhI6Yo3
        N0n5ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=GjwKU+XZBhFKHVYjmgKYWRtYYLdEXkmDES0gwDYX3
        0Q=; b=n7ECLgSU9qMLk3N9lE01xFnzZ+Ry1bSMJkXbltIuU+GD7Rf+GO4mzNPg3
        oIh6hDPOfxfl13r+gw1XTYt2M/MqJt9DsNAiy5KcdcoSL45kDqDHUFFugnNKKi0F
        l8uBYG48RxtpxrJ/wva2dJphJ7c/N956d4Kf9ig3M9G8mKJNulVe8brYvfnmEKN2
        BqNaZyibWxvivCyZwHefHwmkBHale1GoOkKCjIXXshJGPDbvzTtLR1WFrtApkSth
        Sw2jcUG7OdGugIyADw/79aNEQ0djdjbugWocdKtGz0/8Mog9XDaIg7hcLGyNMTd3
        8nj4oO+zH0vDu6T6Z/309fmb811Ng==
X-ME-Sender: <xms:wmXDYKrxd6H-a1eXnPVt2M_xnUPcH_LF1B77oKZEZapbSDqtCAamYQ>
    <xme:wmXDYIq93v9KV55Kfkg_whDmrzbMEY9OjVu80oD2ijjerjW8l8Tl7Q4EAyGK1W0LN
    7s-X_qJjSmi>
X-ME-Received: <xmr:wmXDYPMHuW5U8vp2ahL3VCfv_aBtuszxl5JkcyxkLl2UQ9YP5ONJlFZKue7rVM9RIvt5SspqkFged4N0LRg0scqT1f2Nnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedujedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:wmXDYJ4g1LTVCs0AREsXM8vgaCjMr0N-PpqExu_SNuKuM-D0bTSRZw>
    <xmx:wmXDYJ6bi-UYYcvEOXl1m_PjCdYOCMcVr2MBH_xm3Q5JLm0SDFHwKg>
    <xmx:wmXDYJjSzyTUidsazldgbdXJyHhR_RzptijyYYIoAycWlY5HtAOqxQ>
    <xmx:xGXDYFi736NK3ENy5tVHRo6oCxYHx5F7gVskpFq3yKUdjwsvAGqVzUoRKYg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jun 2021 09:31:40 -0400 (EDT)
Message-ID: <21ec3ad11c4d0d74f9b51df3c3e43ab9f62c32b4.camel@themaw.net>
Subject: Re: [PATCH v6 2/7] kernfs: add a revision to identify directory
 node changes
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
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
Date:   Fri, 11 Jun 2021 21:31:36 +0800
In-Reply-To: <YMNg8VD8XlUJGSK9@kroah.com>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
         <162322859985.361452.14110524195807923374.stgit@web.messagingengine.com>
         <CAJfpeguzPEy+UAcyT4tcpvYxeTwB+64yxRw8Sh7UBROBuafYdw@mail.gmail.com>
         <03f6e366fb4ebb56b15541d53eda461a55d3d38e.camel@themaw.net>
         <YMNg8VD8XlUJGSK9@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-06-11 at 15:11 +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 11, 2021 at 08:56:18PM +0800, Ian Kent wrote:
> > On Fri, 2021-06-11 at 14:49 +0200, Miklos Szeredi wrote:
> > > On Wed, 9 Jun 2021 at 10:50, Ian Kent <raven@themaw.net> wrote:
> > > > 
> > > > Add a revision counter to kernfs directory nodes so it can be
> > > > used
> > > > to detect if a directory node has changed during negative
> > > > dentry
> > > > revalidation.
> > > > 
> > > > There's an assumption that sizeof(unsigned long) <=
> > > > sizeof(pointer)
> > > > on all architectures and as far as I know that assumption
> > > > holds.
> > > > 
> > > > So adding a revision counter to the struct kernfs_elem_dir
> > > > variant
> > > > of
> > > > the kernfs_node type union won't increase the size of the
> > > > kernfs_node
> > > > struct. This is because struct kernfs_elem_dir is at least
> > > > sizeof(pointer) smaller than the largest union variant. It's
> > > > tempting
> > > > to make the revision counter a u64 but that would increase the
> > > > size
> > > > of
> > > > kernfs_node on archs where sizeof(pointer) is smaller than the
> > > > revision
> > > > counter.
> > > > 
> > > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > > ---
> > > >  fs/kernfs/dir.c             |    2 ++
> > > >  fs/kernfs/kernfs-internal.h |   23 +++++++++++++++++++++++
> > > >  include/linux/kernfs.h      |    5 +++++
> > > >  3 files changed, 30 insertions(+)
> > > > 
> > > > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > > > index 33166ec90a112..b3d1bc0f317d0 100644
> > > > --- a/fs/kernfs/dir.c
> > > > +++ b/fs/kernfs/dir.c
> > > > @@ -372,6 +372,7 @@ static int kernfs_link_sibling(struct
> > > > kernfs_node *kn)
> > > >         /* successfully added, account subdir number */
> > > >         if (kernfs_type(kn) == KERNFS_DIR)
> > > >                 kn->parent->dir.subdirs++;
> > > > +       kernfs_inc_rev(kn->parent);
> > > > 
> > > >         return 0;
> > > >  }
> > > > @@ -394,6 +395,7 @@ static bool kernfs_unlink_sibling(struct
> > > > kernfs_node *kn)
> > > > 
> > > >         if (kernfs_type(kn) == KERNFS_DIR)
> > > >                 kn->parent->dir.subdirs--;
> > > > +       kernfs_inc_rev(kn->parent);
> > > > 
> > > >         rb_erase(&kn->rb, &kn->parent->dir.children);
> > > >         RB_CLEAR_NODE(&kn->rb);
> > > > diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-
> > > > internal.h
> > > > index ccc3b44f6306f..b4e7579e04799 100644
> > > > --- a/fs/kernfs/kernfs-internal.h
> > > > +++ b/fs/kernfs/kernfs-internal.h
> > > > @@ -81,6 +81,29 @@ static inline struct kernfs_node
> > > > *kernfs_dentry_node(struct dentry *dentry)
> > > >         return d_inode(dentry)->i_private;
> > > >  }
> > > > 
> > > > +static inline void kernfs_set_rev(struct kernfs_node *kn,
> > > > +                                 struct dentry *dentry)
> > > > +{
> > > > +       if (kernfs_type(kn) == KERNFS_DIR)
> > > > +               dentry->d_time = kn->dir.rev;
> > > > +}
> > > > +
> > > > +static inline void kernfs_inc_rev(struct kernfs_node *kn)
> > > > +{
> > > > +       if (kernfs_type(kn) == KERNFS_DIR)
> > > > +               kn->dir.rev++;
> > > > +}
> > > > +
> > > > +static inline bool kernfs_dir_changed(struct kernfs_node *kn,
> > > > +                                     struct dentry *dentry)
> > > > +{
> > > > +       if (kernfs_type(kn) == KERNFS_DIR) {
> > > 
> > > Aren't these always be called on a KERNFS_DIR node?
> > 
> > Yes they are.
> > 
> > > 
> > > You could just reduce that to a WARN_ON, or remove the conditions
> > > altogether then.
> > 
> > I was tempted to not use the check, a WARN_ON sounds better than
> > removing the check, I'll do that in a v7.
> 
> No, WARN_ON is not ok, as systems will crash if panic-on-warn is set.

Thanks Greg, understood.

> 
> If these are impossible to hit, great, let's not check this and we
> can
> just drop the code.  If they can be hit, then the above code is
> correct
> and it should stay.

It's a programming mistake to call these on a non-directory node.

I can remove the check but do you think there's any value in passing
the node and updating it's parent to avoid possible misuse?

Ian

