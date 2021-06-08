Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E8139EB56
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 03:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhFHB23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 21:28:29 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:54173 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230209AbhFHB23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:28:29 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 34623580583;
        Mon,  7 Jun 2021 21:26:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Jun 2021 21:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        WH1t09n48tt98CsYrFQhoATRT0+qevpaW5ZsSX8+uss=; b=x5ExHTr/8FY2UUUp
        NpEuvTuhBpj4TfDzVODt3vX7O2lqkiXn577w6P8YD92JvJ31+ZJ52w2crqtZA6gj
        q15MqKlUCmofb/6i5wUDI9kKquSrxIRe4YIzwCdEM6HhYu1tB2vDFOIP5B/vOw4/
        v05oU+yi8qs9sqHpmGJRkii0hAfX6w1y88sJFhDq3G+OHImQYFB0JJ8YE9dKnqIN
        wBOBLw5h8cIWciV1G6HnVkj70a8AFNzl7l41tjPIlf+o4DvnWZh7YLNUuk5nVoOw
        /AuMJKLMmHzi/6erBlSDwBf1gqYty7Ot0QCgBhMMbv4B8Vg7UXtGtU8Dso29RA9V
        CVdUvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=WH1t09n48tt98CsYrFQhoATRT0+qevpaW5ZsSX8+u
        ss=; b=SSMxKToEY4iFxsW7V017XYUYOhIvdeYbo5oG/kGo8HTwH5Rzvlv5Tv86C
        IvtrdU92WbBK25JRaL7Wt5tPzIOOLegc5kEMgLs6/33B9WddZfNR6XyRqqP1+qhA
        MA8TapDsDwgUbxT1UY2yIyXD0a73qfzc/sWJIgemPfbbKSo7HCzuFy00/mllNMd0
        GV9KfCB+F0ob7ZHLH+4ccSdr9+CKCjjxPAABP+baJHVpMXD+DGzKEYWPLwNu9v7b
        l5e6sL2jqzNMJ6DotYcL1Vl1FAp78/ECDDG/BcYdndzr6VV2pJVAWR6W1AMMWMyU
        YrXJVTk63ui6Lm+y25yB0yrh8Mz1w==
X-ME-Sender: <xms:Sce-YAaCS4nD2zGyY-8A0OjaGc0-7f9r8X3hRlAWxBrUUG52fxRU6Q>
    <xme:Sce-YLbcdaUJLXtLeuJ0qd8NyuruDvtG_iBQgYDmaVzvuPEo7GLHLnHs_7alMzaBY
    kaQkjNcD_5d>
X-ME-Received: <xmr:Sce-YK_VopoVvguWZmafKhLYUrLOA4br2zqHFlNRoM6HxYLMQtw4FbqC6_l05-NMjrAmWWClm2usF4j8zLRZkA_fSj0I-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtkedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:Sse-YKqhhyfs3dNu1DkO08bkM_nsPjL6ctJtg-Xzp3SltzTyA7kX2w>
    <xmx:Sse-YLpV-mBgA3WdaTYIi2xE1GqCYIrzxmtYZkIEqZr76gKNGTY0Lw>
    <xmx:Sse-YIQ4-gdIcHNhdLxcABMiEHFfNcItEYi33ct-bggAD3s5FGBT5g>
    <xmx:Tce-YER0X1Xy_ssBGqhya4EOjF1jTbaiGwf-dmc4Q6BalkqQsIKLzw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jun 2021 21:26:28 -0400 (EDT)
Message-ID: <d4a3f3c717e786e8d0d26d044ef3dbe8b913452c.camel@themaw.net>
Subject: Re: [PATCH v5 2/6] kernfs: add a revision to identify directory
 node changes
From:   Ian Kent <raven@themaw.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Jun 2021 09:26:25 +0800
In-Reply-To: <87a6o1k1cu.fsf@disp2133>
References: <162306058093.69474.2367505736322611930.stgit@web.messagingengine.com>
         <162306071065.69474.8064509709844383785.stgit@web.messagingengine.com>
         <87a6o1k1cu.fsf@disp2133>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-06-07 at 12:53 -0500, Eric W. Biederman wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > Add a revision counter to kernfs directory nodes so it can be used
> > to detect if a directory node has changed.
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
> >  fs/kernfs/dir.c             |    8 ++++++++
> >  fs/kernfs/kernfs-internal.h |   24 ++++++++++++++++++++++++
> >  include/linux/kernfs.h      |    5 +++++
> >  3 files changed, 37 insertions(+)
> > 
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 33166ec90a112..b88432c48851f 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -372,6 +372,7 @@ static int kernfs_link_sibling(struct
> > kernfs_node *kn)
> >         /* successfully added, account subdir number */
> >         if (kernfs_type(kn) == KERNFS_DIR)
> >                 kn->parent->dir.subdirs++;
> > +       kernfs_inc_rev(kn->parent);
> >  
> >         return 0;
> >  }
> > @@ -394,6 +395,7 @@ static bool kernfs_unlink_sibling(struct
> > kernfs_node *kn)
> >  
> >         if (kernfs_type(kn) == KERNFS_DIR)
> >                 kn->parent->dir.subdirs--;
> > +       kernfs_inc_rev(kn->parent);
> >  
> >         rb_erase(&kn->rb, &kn->parent->dir.children);
> >         RB_CLEAR_NODE(&kn->rb);
> > @@ -1105,6 +1107,12 @@ static struct dentry
> > *kernfs_iop_lookup(struct inode *dir,
> >  
> >         /* instantiate and hash dentry */
> >         ret = d_splice_alias(inode, dentry);
> > +       if (!IS_ERR(ret)) {
> > +               if (unlikely(ret))
> > +                       kernfs_set_rev(parent, ret);
> > +               else
> > +                       kernfs_set_rev(parent, dentry);
> 
> Do we care about d_time on non-NULL dentries?

Would we ever need to use it avoid a search for any other cases?

Probably not ... those export ops mean that some dentries might
not have d_time set.

Maybe it's best to put a comment in about only using it for
negative dentries and set it unconditionally in ->lookup() as
you describe.

> 
> For d_splice_alias to return a different dentry implies
> that the dentry was non-NULL.
> 
> I am wondering if having a guarantee that d_time never changes could
> help simplify the implementation.  For never changing it would see to
> make sense to call kernfs_set_rev before d_splice_alias on dentry,
> and
> simply not worry about it after d_splice_alias.

Yes, I was tempted to do that.

> 
> > +       }
> >   out_unlock:
> >         mutex_unlock(&kernfs_mutex);
> >         return ret;
> > diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-
> > internal.h
> > index ccc3b44f6306f..1536002584fc4 100644
> > --- a/fs/kernfs/kernfs-internal.h
> > +++ b/fs/kernfs/kernfs-internal.h
> > @@ -81,6 +81,30 @@ static inline struct kernfs_node
> > *kernfs_dentry_node(struct dentry *dentry)
> >         return d_inode(dentry)->i_private;
> >  }
> >  
> > +static inline void kernfs_set_rev(struct kernfs_node *kn,
> > +                                 struct dentry *dentry)
> > +{
> > +       if (kernfs_type(kn) == KERNFS_DIR)
> > +               dentry->d_time = kn->dir.rev;
> > +}
> > +
> > +static inline void kernfs_inc_rev(struct kernfs_node *kn)
> > +{
> > +       if (kernfs_type(kn) == KERNFS_DIR)
> > +               kn->dir.rev++;
> > +}
> > +
> > +static inline bool kernfs_dir_changed(struct kernfs_node *kn,
> > +                                     struct dentry *dentry)
> > +{
> > +       if (kernfs_type(kn) == KERNFS_DIR) {
> > +               /* Not really a time bit it does what's needed */
> > +               if (time_after(kn->dir.rev, dentry->d_time))
> > +                       return true;
> 
> Why not simply make this:
>                 if (kn->dir.rev != dentry->d_time)
>                         return true;
> 
> I don't see what is gained by not counting as changed something in
> the
> wrong half of the values.

Yes, it was like that originally and really shouldn't make
any difference. I'll change it back.

Ian
> 
> > +       }
> > +       return false;
> > +}
> > +
> >  extern const struct super_operations kernfs_sops;
> >  extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
> >  
> > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > index 9e8ca8743c268..7947acb1163d7 100644
> > --- a/include/linux/kernfs.h
> > +++ b/include/linux/kernfs.h
> > @@ -98,6 +98,11 @@ struct kernfs_elem_dir {
> >          * better directly in kernfs_node but is here to save
> > space.
> >          */
> >         struct kernfs_root      *root;
> > +       /*
> > +        * Monotonic revision counter, used to identify if a
> > directory
> > +        * node has changed during revalidation.
> > +        */
> > +       unsigned long rev;
> >  };
> >  
> >  struct kernfs_elem_symlink {
> 
> Eric


