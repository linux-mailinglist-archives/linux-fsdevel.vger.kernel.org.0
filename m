Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAE1397FA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 05:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhFBDqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 23:46:04 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:52465 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229625AbhFBDqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 23:46:03 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3019D580B6E;
        Tue,  1 Jun 2021 23:44:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 01 Jun 2021 23:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        h6CAQ4U3UmjwV6x7TBW3x6NBZKeRChUikwJYs4cBk3U=; b=rECIaP9RMyXMdjHx
        b9zns6Z+yJIUGS9aV7RLQ29QE7+yFIWqzU0G9a8hHFTIHpmEUJnIwYrV0wBotXcZ
        EpVr9qHg1DDC056Dzj7XYzKjmj49LoxGFgiHxR+loGQGrPeX98PXtAFKe23hg7Rs
        gGFPdm5bfY7PTYPJesOyTdfHzXdRLINxw62BfDt67Du0lzJay5KTB/4yw5K921cW
        t/YF0aiyd2I5XG1NgMHadfGZQ3KmR2SokyrW+My80PMzhhXCTeLU5M9h4jcBcZly
        oaRLKxxF8F4Yq638TItpzZ/ZlaAQHrqBt/Z4+T2sW8uc+BD6k9tXdCqqkT/w/ddk
        p0daEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=h6CAQ4U3UmjwV6x7TBW3x6NBZKeRChUikwJYs4cBk
        3U=; b=pHoEnoL/phjJe/UWTzQ5hplqpdYDMxfvCu62O/w23+CIMYFLxZhExtmwK
        Njzf6RLPAAHx/OqCySkTb+8JgF0m8e905mBG/spZvlaLazoIR/5mKYiQ6yIjKTcr
        BpGBug/qK7AD4wQeriUVvY59j1i872A3mvPS7o4ASEUoZz2UbvlLrHteZ0ar3UxF
        i0dk9B23/5kY0mwdL8ld8KXLmI81IU1godffBk589vATcrHUJ2jV3JEDGLzrcXom
        e9Uo57tqc+li6l+eWupR/nhJKXO5jB5s87OsjQyDXnlJ8Taty60a32n9YCU0PBLp
        zMtNMEWNiNEu46rqqIfQJdEpxUOww==
X-ME-Sender: <xms:k_62YP8D5TOgZf6eynCgB-zde7RbIMKXnZcc80hk5kBXnsKNtgt44Q>
    <xme:k_62YLvpI_PD5ukaY5Z7m_XXxktEyhWeILM9Fgj54UV_nOm8FEFy2wgdItDGgrS4f
    n17s5H4WgtZ>
X-ME-Received: <xmr:k_62YNDeDGR7n8IFBHmcwL545cBc71kGhvHrij6imw-rLDqzOscRUwraJ52lvMGPr343cTPh0NV7wnTrRrdTbZkjD-LVyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeliedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:k_62YLcqTTYQv2TSBc2iNsClxLQP1OQLIe3QPy7zDcT4uGlwJpx6XA>
    <xmx:k_62YENeM8IERFebAQGlaxvOlMM5M7evjhJF7LMErOxuT88mtCkVvA>
    <xmx:k_62YNnwOVf2Ljm_3A29ezdswTVWARRGmc5aqKf_B2kpw5l4VF9JQQ>
    <xmx:lf62YDpn7ntPcxh6ADgZVRYdZM-KWG-LJkz-yhntokOYq2fAB4_Ejg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jun 2021 23:44:15 -0400 (EDT)
Message-ID: <972701826ebb1b3b3e00b12cde821b85eebc9749.camel@themaw.net>
Subject: Re: [REPOST PATCH v4 2/5] kernfs: use VFS negative dentry caching
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 02 Jun 2021 11:44:12 +0800
In-Reply-To: <CAJfpeguUj5WKtKZsn_tZZNpiL17ggAPcPBXdpA03aAnjaexWug@mail.gmail.com>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
         <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
         <CAJfpeguUj5WKtKZsn_tZZNpiL17ggAPcPBXdpA03aAnjaexWug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-06-01 at 14:41 +0200, Miklos Szeredi wrote:
> On Fri, 28 May 2021 at 08:34, Ian Kent <raven@themaw.net> wrote:
> > 
> > If there are many lookups for non-existent paths these negative
> > lookups
> > can lead to a lot of overhead during path walks.
> > 
> > The VFS allows dentries to be created as negative and hashed, and
> > caches
> > them so they can be used to reduce the fairly high overhead
> > alloc/free
> > cycle that occurs during these lookups.
> 
> Obviously there's a cost associated with negative caching too.  For
> normal filesystems it's trivially worth that cost, but in case of
> kernfs, not sure...
> 
> Can "fairly high" be somewhat substantiated with a microbenchmark for
> negative lookups?

Well, maybe, but anything we do for a benchmark would be totally
artificial.

The reason I added this is because I saw appreciable contention
on the dentry alloc path in one case I saw. It was a while ago
now but IIRC it was systemd coldplug using at least one path
that didn't exist. I thought that this was done because of some
special case requirement so VFS negative dentry caching was a
sensible countermeasure. I guess there could be lookups for
non-existent paths from other than deterministic programmatic
sources but I still felt it was a sensible thing to do.

> 
> More comments inline.
> 
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/kernfs/dir.c |   55 +++++++++++++++++++++++++++++++++----------
> > ------------
> >  1 file changed, 33 insertions(+), 22 deletions(-)
> > 
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 4c69e2af82dac..5151c712f06f5 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -1037,12 +1037,33 @@ static int kernfs_dop_revalidate(struct
> > dentry *dentry, unsigned int flags)
> >         if (flags & LOOKUP_RCU)
> >                 return -ECHILD;
> > 
> > -       /* Always perform fresh lookup for negatives */
> > -       if (d_really_is_negative(dentry))
> > -               goto out_bad_unlocked;
> > +       mutex_lock(&kernfs_mutex);
> > 
> >         kn = kernfs_dentry_node(dentry);
> > -       mutex_lock(&kernfs_mutex);
> > +
> > +       /* Negative hashed dentry? */
> > +       if (!kn) {
> > +               struct kernfs_node *parent;
> > +
> > +               /* If the kernfs node can be found this is a stale
> > negative
> > +                * hashed dentry so it must be discarded and the
> > lookup redone.
> > +                */
> > +               parent = kernfs_dentry_node(dentry->d_parent);
> 
> This doesn't look safe WRT a racing sys_rename().  In this case
> d_move() is called only with parent inode locked, but not with
> kernfs_mutex while ->d_revalidate() may not have parent inode locked.
> After d_move() the old parent dentry can be freed, resulting in use
> after free.  Easily fixed by dget_parent().

Umm ... I'll need some more explanation here ... 

We are in ref-walk mode so the parent dentry isn't going away.
And this is a negative dentry so rename is going to bail out
with ENOENT way early.

Are you talking about a racing parent rename requiring a
READ_ONCE() and dget_parent() being the safest way to do
that?

> 
> > +               if (parent) {
> > +                       const void *ns = NULL;
> > +
> > +                       if (kernfs_ns_enabled(parent))
> > +                               ns = kernfs_info(dentry->d_sb)->ns;
> > +                       kn = kernfs_find_ns(parent, dentry-
> > >d_name.name, ns);
> 
> Same thing with d_name.  There's
> take_dentry_name_snapshot()/release_dentry_name_snapshot() to
> properly
> take care of that.

I don't see that problem either, due to the dentry being negative,
but please explain what your seeing here.

> 
> 
> > +                       if (kn)
> > +                               goto out_bad;
> > +               }
> > +
> > +               /* The kernfs node doesn't exist, leave the dentry
> > negative
> > +                * and return success.
> > +                */
> > +               goto out;
> > +       }
> > 
> >         /* The kernfs node has been deactivated */
> >         if (!kernfs_active_read(kn))
> > @@ -1060,12 +1081,11 @@ static int kernfs_dop_revalidate(struct
> > dentry *dentry, unsigned int flags)
> >         if (kn->parent && kernfs_ns_enabled(kn->parent) &&
> >             kernfs_info(dentry->d_sb)->ns != kn->ns)
> >                 goto out_bad;
> > -
> > +out:
> >         mutex_unlock(&kernfs_mutex);
> >         return 1;
> >  out_bad:
> >         mutex_unlock(&kernfs_mutex);
> > -out_bad_unlocked:
> >         return 0;
> >  }
> > 
> > @@ -1080,33 +1100,24 @@ static struct dentry
> > *kernfs_iop_lookup(struct inode *dir,
> >         struct dentry *ret;
> >         struct kernfs_node *parent = dir->i_private;
> >         struct kernfs_node *kn;
> > -       struct inode *inode;
> > +       struct inode *inode = NULL;
> >         const void *ns = NULL;
> > 
> >         mutex_lock(&kernfs_mutex);
> > -
> >         if (kernfs_ns_enabled(parent))
> >                 ns = kernfs_info(dir->i_sb)->ns;
> > 
> >         kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
> > -
> > -       /* no such entry */
> > -       if (!kn || !kernfs_active(kn)) {
> > -               ret = NULL;
> > -               goto out_unlock;
> > -       }
> > -
> >         /* attach dentry and inode */
> > -       inode = kernfs_get_inode(dir->i_sb, kn);
> > -       if (!inode) {
> > -               ret = ERR_PTR(-ENOMEM);
> > -               goto out_unlock;
> > +       if (kn && kernfs_active(kn)) {
> > +               inode = kernfs_get_inode(dir->i_sb, kn);
> > +               if (!inode)
> > +                       inode = ERR_PTR(-ENOMEM);
> >         }
> > -
> > -       /* instantiate and hash dentry */
> > +       /* instantiate and hash (possibly negative) dentry */
> >         ret = d_splice_alias(inode, dentry);
> > - out_unlock:
> >         mutex_unlock(&kernfs_mutex);
> > +
> >         return ret;
> >  }
> > 
> > 
> > 


