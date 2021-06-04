Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAAA39B05E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 04:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFDCbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 22:31:18 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:39409 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFDCbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 22:31:18 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 83BE5F7A;
        Thu,  3 Jun 2021 22:29:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 03 Jun 2021 22:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        uSbsM2sGub8+mXBbRbSpOG1v+1uGXicBs4jdLnclrfg=; b=JlVNoijH04T9uy+p
        8BEsOU8FjSKVY4qL68acfOXzvSmu4D4FeUfc+WZHVUanqLhlAmXU1RtUe/UR7uw1
        9eK5XsX2E2bJ+dh/pFne//+xbziyiut2w6jzUw8z7kjbLTsdcbt73L1IWyZaEDsv
        ycm/47aqP2FYhqOwm6EUhmce0DTwCVvJTN4MJeseABWf+fEtIFfLExicmOkkoPM6
        x6dl4JokmdLF78UBoKkvWxNH/wZfvGsmaR1MMMbr8vLCWIKKH5Wq6kCp1ppk5um7
        K4Iq6sTUKF74n6ASGybsV0x57EJuObLYnB00OZwhPN6IyaHOmSKV4nFuQqKxVxuL
        eXI2PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=uSbsM2sGub8+mXBbRbSpOG1v+1uGXicBs4jdLnclr
        fg=; b=YpMi/vJ/F1XHz6qvciIwgnpNW5EISHR59n7TUER91WSB9ir9ucINlVaaN
        owyRemefJd8TTGG/ITFTPNe26ZQ1GQKkBH3OTS+YXerl2Ys66/EhpKkAE15OpGf8
        XBqQPlx5JWLg0e5Wc8alMLWnR+gxnVioYmRxjK4zy8Zlx4QeWd4SXAXDsHRg5OOP
        yfQ3o4bm95zlvP2jZhEf/aThs7CwFed8Fyvu41ZoYRpMSBMdedLvg8MFUrXAJ6un
        dwUptvvVLIWPrdW6gan4EphaNXfIlVNzSsptw9nKSO0vJg5YGUnC43m4WnQ+zTTH
        Kk6+6ZWd2CPOaB9z4eIu7Rz2e72fw==
X-ME-Sender: <xms:CpC5YEElIid6N2XFtxU4UCzfEJUKD4_8qztvkx4-U2anQZSJn_C79Q>
    <xme:CpC5YNVe5FSmRoxiaFupCv2KytOWRMu8K62nGkRZLF7pW18rQCRNy-ErLLAcKiodz
    fbRD2qlYHb7>
X-ME-Received: <xmr:CpC5YOIWLGzPimUM-kFPwmruuwrEOgo9qCP2655GA40BEUBG3yOAts6eq9fPKNvcg0-iD51VTWOwi0YpIfREaFswCCkqdGEVmv_I4fndFXXUZ3f0F-eB9QsNcu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedttddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthekredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fgleelkeetheelgeehueejueduhfeufffgleehgfevtdehhffhhffhtddugfefheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:CpC5YGE2kATxZvhoMOtjXrjr5MShjD7GWykLpz0Q1jkXilap1o98YA>
    <xmx:CpC5YKUR8v2VrABc-n1Zmz0Fds5YE7hcip8DGNOXwnDF5sXLK9KHCA>
    <xmx:CpC5YJNd7nbMQKGXcyS8LBODfBeor7pHEjTnA9RpueS4wmRpxVUb2g>
    <xmx:C5C5YDNXxM15mPJNp1tCApcDN_RoFwcMXuSKjaKtR81Hh5ewZKbQTWjz7bA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jun 2021 22:29:25 -0400 (EDT)
Message-ID: <bcbb928cda44551c8587f4967289f4d060f03646.camel@themaw.net>
Subject: Re: [REPOST PATCH v4 1/5] kernfs: move revalidate to be near lookup
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Jun 2021 10:29:21 +0800
In-Reply-To: <87im2vq9xh.fsf@disp2133>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
         <162218363530.34379.16741129191900256265.stgit@web.messagingengine.com>
         <87im2vq9xh.fsf@disp2133>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-06-03 at 09:50 -0500, Eric W. Biederman wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > While the dentry operation kernfs_dop_revalidate() is grouped with
> > dentry type functions it also has a strong affinity to the inode
> > operation ->lookup().
> > 
> > In order to take advantage of the VFS negative dentry caching that
> > can be used to reduce path lookup overhead on non-existent paths it
> > will need to call kernfs_find_ns(). So, to avoid a forward
> > declaration,
> > move it to be near kernfs_iop_lookup().
> > 
> > There's no functional change from this patch.
> 
> Does this patch compile independently?

Doubt it.

> 
> During the code movement  kernfs_active is replaced
> by kernfs_active_read which does not exist yet.

Oops, that was a consequence of reordering the series which I
didn't catch.

I'll fix that when I post a v5 which I'm going to have to do.

Thanks for looking at this Eric,
Ian
> 
> Eric
> 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/kernfs/dir.c |   86 ++++++++++++++++++++++++++++---------------
> > ------------
> >  1 file changed, 43 insertions(+), 43 deletions(-)
> > 
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 7e0e62deab53c..4c69e2af82dac 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -548,49 +548,6 @@ void kernfs_put(struct kernfs_node *kn)
> >  }
> >  EXPORT_SYMBOL_GPL(kernfs_put);
> >  
> > -static int kernfs_dop_revalidate(struct dentry *dentry, unsigned
> > int flags)
> > -{
> > -       struct kernfs_node *kn;
> > -
> > -       if (flags & LOOKUP_RCU)
> > -               return -ECHILD;
> > -
> > -       /* Always perform fresh lookup for negatives */
> > -       if (d_really_is_negative(dentry))
> > -               goto out_bad_unlocked;
> > -
> > -       kn = kernfs_dentry_node(dentry);
> > -       mutex_lock(&kernfs_mutex);
> > -
> > -       /* The kernfs node has been deactivated */
> > -       if (!kernfs_active(kn))
> > -               goto out_bad;
> > -
> > -       /* The kernfs node has been moved? */
> > -       if (kernfs_dentry_node(dentry->d_parent) != kn->parent)
> > -               goto out_bad;
> > -
> > -       /* The kernfs node has been renamed */
> > -       if (strcmp(dentry->d_name.name, kn->name) != 0)
> > -               goto out_bad;
> > -
> > -       /* The kernfs node has been moved to a different namespace
> > */
> > -       if (kn->parent && kernfs_ns_enabled(kn->parent) &&
> > -           kernfs_info(dentry->d_sb)->ns != kn->ns)
> > -               goto out_bad;
> > -
> > -       mutex_unlock(&kernfs_mutex);
> > -       return 1;
> > -out_bad:
> > -       mutex_unlock(&kernfs_mutex);
> > -out_bad_unlocked:
> > -       return 0;
> > -}
> > -
> > -const struct dentry_operations kernfs_dops = {
> > -       .d_revalidate   = kernfs_dop_revalidate,
> > -};
> > -
> >  /**
> >   * kernfs_node_from_dentry - determine kernfs_node associated with
> > a dentry
> >   * @dentry: the dentry in question
> > @@ -1073,6 +1030,49 @@ struct kernfs_node
> > *kernfs_create_empty_dir(struct kernfs_node *parent,
> >         return ERR_PTR(rc);
> >  }
> >  
> > +static int kernfs_dop_revalidate(struct dentry *dentry, unsigned
> > int flags)
> > +{
> > +       struct kernfs_node *kn;
> > +
> > +       if (flags & LOOKUP_RCU)
> > +               return -ECHILD;
> > +
> > +       /* Always perform fresh lookup for negatives */
> > +       if (d_really_is_negative(dentry))
> > +               goto out_bad_unlocked;
> > +
> > +       kn = kernfs_dentry_node(dentry);
> > +       mutex_lock(&kernfs_mutex);
> > +
> > +       /* The kernfs node has been deactivated */
> > +       if (!kernfs_active_read(kn))
> > +               goto out_bad;
> > +
> > +       /* The kernfs node has been moved? */
> > +       if (kernfs_dentry_node(dentry->d_parent) != kn->parent)
> > +               goto out_bad;
> > +
> > +       /* The kernfs node has been renamed */
> > +       if (strcmp(dentry->d_name.name, kn->name) != 0)
> > +               goto out_bad;
> > +
> > +       /* The kernfs node has been moved to a different namespace
> > */
> > +       if (kn->parent && kernfs_ns_enabled(kn->parent) &&
> > +           kernfs_info(dentry->d_sb)->ns != kn->ns)
> > +               goto out_bad;
> > +
> > +       mutex_unlock(&kernfs_mutex);
> > +       return 1;
> > +out_bad:
> > +       mutex_unlock(&kernfs_mutex);
> > +out_bad_unlocked:
> > +       return 0;
> > +}
> > +
> > +const struct dentry_operations kernfs_dops = {
> > +       .d_revalidate   = kernfs_dop_revalidate,
> > +};
> > +
> >  static struct dentry *kernfs_iop_lookup(struct inode *dir,
> >                                         struct dentry *dentry,
> >                                         unsigned int flags)


