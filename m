Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4DA310AF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 13:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBEMO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 07:14:29 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:45203 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231612AbhBEMMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:12:09 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 18849B5D;
        Fri,  5 Feb 2021 07:10:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 05 Feb 2021 07:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        AvXcq8biKHIIRRZYtLWNOnk71TUfCiXAOEGRbn/XfEk=; b=efK/tpQtG/ziTIAe
        roGGI4OiWdiKxTa6r6TVFJ55df0CN5zCne/kLZAz1Cef64KhLnvaFx/LakosaLgq
        pmHzd7rrGOoGzQPB/aoXnSo5wf8qLl5Va94PwQMJHGpYn7dRUeKoMCYUg4I/OVP7
        3vS824+Ip5dciKKzatTZ37cDKG1/EVgua4A4EgicKQcHm7XgpczadSh1DsKM35Ef
        pNXu67ss5rETBeqqwwoZasmuXbGL0Fcukg5U4aWIu4wtCPQDSpyosr9tA8Fk7VFv
        HXC6VwaAOXQ8wJ4F6HKFUSp5rw1N+hsj1rqqduhjpPmoZUnoZ7Clz5hYujw9E4H0
        Oxr4DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=AvXcq8biKHIIRRZYtLWNOnk71TUfCiXAOEGRbn/Xf
        Ek=; b=FSlbg7w4dne+Gi7e5g0uxdSMYSGECjMA1gpfNVwl4UxtsjUomjAnt7FiJ
        ihr7HKdIat70TeHGrOglCfAFLfOSHIuNASUfmhDh+1vtoVhJR7pGYqSzVPoom3cG
        tc35NFpy2sTZuX5LyVVhAZxIC/K+t/mvsfqUivfM4mbOtTVkozjNlrt9j1589QHn
        neCGVUMRJlsQXFOLxb/sW/C3XK92vJyMKqslioM5VwRT7/3TGLby37ejqrX2mdM5
        8OgBlUhVvUxH9dUVvOs0LU7sVkO9lvu19gbo7t3MyIf0vueLEHLMf+DUL26VldZI
        dL/2Q0HToKH+kLyheDcXeuV+Uj36Q==
X-ME-Sender: <xms:xzUdYFHqO_7IbHk2cQWZXDvT0HdXiu3_vXWIxdHQME1NEc4LDgUY5w>
    <xme:xzUdYB8Da0zh2OksEErJAG8T-xBQIKCuOUxUT0FX0RLxiyNa4fTzEloPS1we5ASFH
    ZHtd9OkG4iT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeeigddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    pedutdeirdeiledrvdegjedrkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:xzUdYHU1u4aA8Frlj7LryWPME8fUOAFPVY3JpfyQH8Zfx4hGUMnnCw>
    <xmx:xzUdYDHGWrTz13wBJeG8cSOeiGr0j8ucL3spOLNWcN0krJZIDMylYQ>
    <xmx:xzUdYL4P9FFwb754a0OiptZpFbPEQ435LlD3iuielOF734TNOCFh4Q>
    <xmx:yDUdYJPaRQbEaSWT5bfUzsAVXI8QloKZFNep4nikQRakR_bzCpkBLw>
Received: from mickey.themaw.net (106-69-247-87.dyn.iinet.net.au [106.69.247.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id A24B724005E;
        Fri,  5 Feb 2021 07:10:44 -0500 (EST)
Message-ID: <5c5875d7f67e1bd6785f30b425e17fd4effb1ae9.camel@themaw.net>
Subject: Re: [PATCH 5/6] kernfs: stay in rcu-walk mode if possible
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Fri, 05 Feb 2021 20:10:39 +0800
In-Reply-To: <CAC2o3DKc0expAJAiNHnU5dY8hpom4z6TdRegQxahRBrZKL+7qg@mail.gmail.com>
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
         <160862330474.291330.11664503360150456908.stgit@mickey.themaw.net>
         <CAC2o3DKc0expAJAiNHnU5dY8hpom4z6TdRegQxahRBrZKL+7qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-02-05 at 16:23 +0800, Fox Chen wrote:
> Hi Ian,
> 
> On Tue, Dec 22, 2020 at 3:48 PM Ian Kent <raven@themaw.net> wrote:
> > During path walks in sysfs (kernfs) needing to take a reference to
> > a mount doesn't happen often since the walk won't be crossing mount
> > point boundaries.
> > 
> > Also while staying in rcu-walk mode where possible wouldn't
> > normally
> > give much improvement.
> > 
> > But when there are many concurrent path walks and there is high
> > d_lock
> > contention dget() will often need to resort to taking a spin lock
> > to
> > get the reference. And that could happen each time the reference is
> > passed from component to component.
> > 
> > So, in the high contention case, it will contribute to the
> > contention.
> > 
> > Therefore staying in rcu-walk mode when possible will reduce
> > contention.
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  fs/kernfs/dir.c |   48
> > +++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 47 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index fdeae2c6e7ba..50c5c8c886af 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -1048,8 +1048,54 @@ static int kernfs_dop_revalidate(struct
> > dentry *dentry, unsigned int flags)
> >         struct kernfs_node *parent;
> >         struct kernfs_node *kn;
> > 
> > -       if (flags & LOOKUP_RCU)
> > +       if (flags & LOOKUP_RCU) {
> > +               parent = kernfs_dentry_node(dentry->d_parent);
> > +
> > +               /* Directory node changed, no, then don't search?
> > */
> > +               if (!kernfs_dir_changed(parent, dentry))
> > +                       return 1;
> > +
> > +               kn = kernfs_dentry_node(dentry);
> > +               if (!kn) {
> > +                       /* Negative hashed dentry, tell the VFS to
> > switch to
> > +                        * ref-walk mode and call us again so that
> > node
> > +                        * existence can be checked.
> > +                        */
> > +                       if (!d_unhashed(dentry))
> > +                               return -ECHILD;
> > +
> > +                       /* Negative unhashed dentry, this shouldn't
> > happen
> > +                        * because this case occurs in ref-walk
> > mode after
> > +                        * dentry allocation which is followed by a
> > call
> > +                        * to ->loopup(). But if it does happen the
> > dentry
> > +                        * is surely invalid.
> > +                        */
> > +                       return 0;
> > +               }
> > +
> > +               /* Since the dentry is positive (we got the kernfs
> > node) a
> > +                * kernfs node reference was held at the time. Now
> > if the
> > +                * dentry reference count is still greater than 0
> > it's still
> > +                * positive so take a reference to the node to
> > perform an
> > +                * active check.
> > +                */
> > +               if (d_count(dentry) <= 0 ||
> > !atomic_inc_not_zero(&kn->count))
> > +                       return -ECHILD;
> > +
> > +               /* The kernfs node reference count was greater than
> > 0, if
> > +                * it's active continue in rcu-walk mode.
> > +                */
> > +               if (kernfs_active_read(kn)) {
> We are in RCU-walk mode, kernfs_rwsem should not be held, however,
> kernfs_active_read will assert the readlock is held. I believe it
> should be kernfs_active(kn) here. Am I wrong??

No I think you are correct.
I'll check it and fix it.

> 
> > +                       kernfs_put(kn);
> > +                       return 1;
> > +               }
> > +
> > +               /* Otherwise, just tell the VFS to switch to ref-
> > walk mode
> > +                * and call us again so the kernfs node can be
> > validated.
> > +                */
> > +               kernfs_put(kn);
> >                 return -ECHILD;
> > +       }
> > 
> >         down_read(&kernfs_rwsem);
> > 
> > 
> > 
> 
> thanks,
> fox

