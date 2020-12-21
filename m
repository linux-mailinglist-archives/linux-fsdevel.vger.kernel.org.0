Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E492DFAC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 11:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgLUKHT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 05:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgLUKHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 05:07:18 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA47C0611CD;
        Mon, 21 Dec 2020 02:05:53 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m25so22203950lfc.11;
        Mon, 21 Dec 2020 02:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oG74XAx4XojfZk2a1r/Ra66PREeEQkKGwNuDPYNej4=;
        b=Fa0t/OrxLJ+8WUTs96s35pXqoLoS5DjIxSg7Wt+rucKCVsupixS2eyf4xqgOwOqM1H
         KBLfQMjzp5blHW77UAFBRuvLOi2fuchE1GD+3bU6NoxBeTtoCUV13zs8z59DTC465VOW
         O6DmZ8mMa7deNf03VC+Ho4jzj8d7UzBNKXCQCuIZ+ySWJJKB/Asooy9vZhg6IKEPteN+
         klx15LkdbC6bxUqTY2Rrxe8IQeI9ZS727enQN/XLcL6p2ZVw7FdDytIrHHnbJT8hqGKN
         6GK36cV76CyuK+QkvxRRB17P8UR2kXwBpvGVbJOmEYIQHUQ8DNfEPrSPZpO/nStVul9h
         EyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oG74XAx4XojfZk2a1r/Ra66PREeEQkKGwNuDPYNej4=;
        b=aITstgLJOOC6Zb+kMbDd2vB2TysmYqCuq048vGTxBF8i/cKUatzuPh+FDKfvRSO01T
         G/BdFnfgUuL3vBJKSo0kbCSFC0oZ9x3Kx9iulwYMObsFf3vKr+WwBHbKz3wu/rBGS0us
         e5OB6K4FRFOxvZmdLtIOATP1tt63GVAl57GsVR85blUOaDYTbxVjsfsFnJCEyB6plX4s
         JjPQyZl9K9qo9qFG2bow5rkunqc5CO9f+MIu6qvanT0n08v64DDegs+oGMbHSr8g2PC4
         5Y2/k9hRlmU72UoRoFfLE8vVpeoy4YktXS9kZ73xHWuBmIcgUVbKCGHIfjvYDAWpxpOr
         Y3Fw==
X-Gm-Message-State: AOAM531pKCVH1mRIbonbdwORtyILlF9GdwJaqbDG7rH1Lw9s7FTMbzCY
        3GQcPx22EnkEFr8o7QlE6trGD8qWjIIAtWpl9QU7MhmLseoJJtsw
X-Google-Smtp-Source: ABdhPJzu9SoVchnadMFn0iVTzdU0Iqogb+Z4OqLTFi5owtjNA5ED/5h3nSovS/XqdLE1WO8gSqawfGGnk7K4rfaSvzA=
X-Received: by 2002:a05:6512:320d:: with SMTP id d13mr5888406lfe.376.1608542930206;
 Mon, 21 Dec 2020 01:28:50 -0800 (PST)
MIME-Version: 1.0
References: <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net>
 <da4f730bbbb20c0920599ca5afc316e2c092b7d8.camel@themaw.net>
 <CAC2o3DJsvB6kj=S6D3q+_OBjgez9Q9B5s3-_gjUjaKmb2MkTHQ@mail.gmail.com>
 <c4002127c72c07a00e8ba0fae6b0ebf5ba8e08e7.camel@themaw.net>
 <a39b73a53778094279522f1665be01ce15fb21f4.camel@themaw.net>
 <c8a6c9adc3651e64cf694f580a8cb3d87d7cb893.camel@themaw.net>
 <X9t1xVTZ/ApIvPMg@mtj.duckdns.org> <67a3012a6a215001c8be9344aee1c99897ff8b7e.camel@themaw.net>
 <X9zDu15MvJP3NU8K@mtj.duckdns.org> <37c339831d4e7f3c6db88fbca80c6c2bd835dff2.camel@themaw.net>
 <X94pE6IrziQCd4ra@mtj.duckdns.org> <f1c9b0e6699582e69c0fb2e8afb40ddaf17bdf76.camel@themaw.net>
In-Reply-To: <f1c9b0e6699582e69c0fb2e8afb40ddaf17bdf76.camel@themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 21 Dec 2020 17:28:37 +0800
Message-ID: <CAC2o3DLUjeJwoFT7sRLJ_LPveHsX55VbLPBdNPCmdqkrqo1ymA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency improvement
To:     Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 20, 2020 at 7:52 AM Ian Kent <raven@themaw.net> wrote:
>
> On Sat, 2020-12-19 at 11:23 -0500, Tejun Heo wrote:
> > Hello,
> >
> > On Sat, Dec 19, 2020 at 03:08:13PM +0800, Ian Kent wrote:
> > > And looking further I see there's a race that kernfs can't do
> > > anything
> > > about between kernfs_refresh_inode() and fs/inode.c:update_times().
> >
> > Do kernfs files end up calling into that path tho? Doesn't look like
> > it to
> > me but if so yeah we'd need to override the update_time for kernfs.
>
> Sorry, the below was very hastily done and not what I would actually
> propose.
>
> The main point of it was the question
>
> +       /* Which kernfs node attributes should be updated from
> +        * time?
> +        */
>
> but looking at it again this morning I think the node iattr fields
> that might need to be updated would be atime, ctime and mtime only,
> maybe not ctime ... not sure.
>
> What do you think?
>
> Also, if kn->attr == NULL it should fall back to what the VFS
> currently does.
>
> The update_times() function is one of the few places where the
> VFS updates the inode times.
>
> The idea is that the reason kernfs needs to overwrite the inode
> attributes is to reset what the VFS might have done but if kernfs
> has this inode operation they won't need to be overwritten since
> they won't have changed.
>
> There may be other places where the attributes (or an attribute)
> are set by the VFS, I haven't finished checking that yet so my
> suggestion might not be entirely valid.
>
> What I need to do is work out what kernfs node attributes, if any,
> should be updated by .update_times(). If I go by what
> kernfs_refresh_inode() does now then that would be none but shouldn't
> atime at least be updated in the node iattr.
>
> > > +static int kernfs_iop_update_time(struct inode *inode, struct
> > > timespec64 *time, int flags)
> > >  {
> > > -   struct inode *inode = d_inode(path->dentry);
> > >     struct kernfs_node *kn = inode->i_private;
> > > +   struct kernfs_iattrs *attrs;
> > >
> > >     mutex_lock(&kernfs_mutex);
> > > +   attrs = kernfs_iattrs(kn);
> > > +   if (!attrs) {
> > > +           mutex_unlock(&kernfs_mutex);
> > > +           return -ENOMEM;
> > > +   }
> > > +
> > > +   /* Which kernfs node attributes should be updated from
> > > +    * time?
> > > +    */
> > > +
> > >     kernfs_refresh_inode(kn, inode);
> > >     mutex_unlock(&kernfs_mutex);
> >
> > I don't see how this would reflect the changes from kernfs_setattr()
> > into
> > the attached inode. This would actually make the attr updates
> > obviously racy
> > - the userland visible attrs would be stale until the inode gets
> > reclaimed
> > and then when it gets reinstantiated it'd show the latest
> > information.
>
> Right, I will have to think about that, but as I say above this
> isn't really what I would propose.
>
> If .update_times() sticks strictly to what kernfs_refresh_inode()
> does now then it would set the inode attributes from the node iattr
> only.
>
> >
> > That said, if you wanna take the direction where attr updates are
> > reflected
> > to the associated inode when the change occurs, which makes sense,
> > the right
> > thing to do would be making kernfs_setattr() update the associated
> > inode if
> > existent.
>
> Mmm, that's a good point but it looks like the inode isn't available
> there.
>
Is it possible to embed super block somewhere, then we can call
kernfs_get_inode to get inode in kernfs_setattr???


thanks,
fox
