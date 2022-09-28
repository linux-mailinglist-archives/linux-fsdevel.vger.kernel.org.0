Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCE85EDF62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiI1O6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 10:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiI1O6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:58:46 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DABB5D133
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 07:58:45 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id cm7-20020a056830650700b006587fe87d1aso8333017otb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FU8ziA0g8XrzVDSvcikVC1+/T8gAGC6I89UFNsvMyRw=;
        b=SD8gGDzFeAJF+BNu4wnyQ8rq6w4aZJEVIDoxRe0R4PEy27p6+UcoRqAYlGvWQY76YF
         S56MAWbNQz72hVdlV5+b3Lgmg/IBY4jsBjAFXZQjKEjMf2Ckouz7QKydF4dRtMETxGtl
         o89FaLLJgOGMK5jHvYfbLVBBsUSqWjMfSAw1Bc3Q0depZpU5QTmzipWrN0ZeQo88U23E
         BpftRlSZg5I98nLHccFnoDwPlEl01X5AH/2cIfGqttqKt+tSdHGZfFRkOEen3hliA3dD
         4mydKBokymQ8B6h8OhpgI6JEbZ7GMArvSZEQwD/RvUp3va1Rr6Uunxf+0IyqObK4YBbj
         pLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FU8ziA0g8XrzVDSvcikVC1+/T8gAGC6I89UFNsvMyRw=;
        b=1JmnW2Xad+SJa+mxqIy11xpQ2Mlii5XohgHCNvwEL1Flyb26tCAi2FC/XUn0tK7Kit
         /7/RPcuIe6RzldVmfC2/TjtU0jfOyKG9HAGUhMkpWp50Yx6cQGQNUXIQmoXup4221fs6
         mcstsL1e2Smkvs5MagovINjRKBTJeZRXG0U6yX8M88Fbr35isxdquaPcfDdKaPmcXHfq
         SL+i8Er4mGDvofBVhtjg5nT/S3wewLSWvGHvWTMJXVBIna9MzIwLRBujg48cEq5220Jx
         JYZkCNi9zBzUtfs/aTiqC03E/YZNmKoqSSuUwp80HsGnS4rZO3/QQ4043xTAEE3WZ9YL
         do0A==
X-Gm-Message-State: ACrzQf2pKTeqz+bmLXol6nDyZb8OhvvIgVNzj1LFG1CSb/y/PUPLqW92
        /0Pn8TyINxDJEj94iL6OhorONUgbKTYiU7hHv7Go
X-Google-Smtp-Source: AMsMyM4lfEyXcCXVlmwqXi8FGDLuhIsotfzEODmD8vZptfgn/5e7sEZOyPKZUYRfOeao+Dj4KUJuyHRKdaefPPJTMKY=
X-Received: by 2002:a05:6830:114f:b0:655:bd97:7a9b with SMTP id
 x15-20020a056830114f00b00655bd977a9bmr14812942otq.287.1664377124378; Wed, 28
 Sep 2022 07:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140827.142806-1-brauner@kernel.org> <20220926140827.142806-17-brauner@kernel.org>
 <CAHC9VhSyf9c-EtD_V856ZGTbFamwWh=bxPh7aPdarkqhdE7WZw@mail.gmail.com> <20220928074030.3dnytkvt7fibytlu@wittgenstein>
In-Reply-To: <20220928074030.3dnytkvt7fibytlu@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Sep 2022 10:58:33 -0400
Message-ID: <CAHC9VhSNOPCOjZ3ucqzrTd01a_o54xfnA137893TkHQMpQXoPw@mail.gmail.com>
Subject: Re: [PATCH v2 16/30] acl: add vfs_get_acl()
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 28, 2022 at 3:40 AM Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Sep 27, 2022 at 06:55:25PM -0400, Paul Moore wrote:
> > On Mon, Sep 26, 2022 at 11:24 AM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > In previous patches we implemented get and set inode operations for all
> > > non-stacking filesystems that support posix acls but didn't yet
> > > implement get and/or set acl inode operations. This specifically
> > > affected cifs and 9p.
> > >
> > > Now we can build a posix acl api based solely on get and set inode
> > > operations. We add a new vfs_get_acl() api that can be used to get posix
> > > acls. This finally removes all type unsafety and type conversion issues
> > > explained in detail in [1] that we aim to get rid of.
> > >
> > > After we finished building the vfs api we can switch stacking
> > > filesystems to rely on the new posix api and then finally switch the
> > > xattr system calls themselves to rely on the posix acl api.
> > >
> > > Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> > > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > > ---
> > >
> > > Notes:
> > >     /* v2 */
> > >     unchanged
> > >
> > >  fs/posix_acl.c                  | 131 ++++++++++++++++++++++++++++++--
> > >  include/linux/posix_acl.h       |   9 +++
> > >  include/linux/posix_acl_xattr.h |  10 +++
> > >  3 files changed, 142 insertions(+), 8 deletions(-)
> >
> > ...
> >
> > > diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> > > index ef0908a4bc46..18873be583a9 100644
> > > --- a/fs/posix_acl.c
> > > +++ b/fs/posix_acl.c
> > > @@ -1369,3 +1439,48 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> > >         return error;
> > >  }
> > >  EXPORT_SYMBOL(vfs_set_acl);
> > > +
> > > +/**
> > > + * vfs_get_acl - get posix acls
> > > + * @mnt_userns: user namespace of the mount
> > > + * @dentry: the dentry based on which to retrieve the posix acls
> > > + * @acl_name: the name of the posix acl
> > > + *
> > > + * This function retrieves @kacl from the filesystem. The caller must all
> > > + * posix_acl_release() on @kacl.
> > > + *
> > > + * Return: On success POSIX ACLs in VFS format, on error negative errno.
> > > + */
> > > +struct posix_acl *vfs_get_acl(struct user_namespace *mnt_userns,
> > > +                             struct dentry *dentry, const char *acl_name)
> > > +{
> > > +       struct inode *inode = d_inode(dentry);
> > > +       struct posix_acl *acl;
> > > +       int acl_type, error;
> > > +
> > > +       acl_type = posix_acl_type(acl_name);
> > > +       if (acl_type < 0)
> > > +               return ERR_PTR(-EINVAL);
> > > +
> > > +       /*
> > > +        * The VFS has no restrictions on reading POSIX ACLs so calling
> > > +        * something like xattr_permission() isn't needed. Only LSMs get a say.
> > > +        */
> > > +       error = security_inode_getxattr(dentry, acl_name);
> > > +       if (error)
> > > +               return ERR_PTR(error);
> >
> > I understand the desire to reuse the security_inode_getxattr() hook
> > here, it makes perfect sense, but given that this patchset introduces
> > an ACL specific setter hook I think it makes sense to have a matching
> > getter hook.  It's arguably a little silly given the current crop of
> > LSMs and their approach to ACLs, but if we are going to differentiate
> > on the write side I think we might as well be consistent and
> > differentiate on the read side as well.
>
> Sure, I don't mind doing that. I'll add the infrastructure and then the
> individual LSMs can add their own hooks.

Adding the ACL hook infrastructure, including the call in
vfs_get_acl(), without the LSM implementations would result in an
access control regression for both SELinux and Smack.  Similar issues
with the removexattr hook, although that looks to have IMA/EVM calls
too (which may be noops in the case of an ACL, I haven't checked).

The good news is that the individual LSM implementations should be
trivial, and if you wanted to just have the new ACL hook
implementations call into the existing xattr implementations inside
each LSM I think that would be okay to start.

-- 
paul-moore.com
