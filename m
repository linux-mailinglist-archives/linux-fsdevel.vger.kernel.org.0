Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09696260A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 18:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiKKRno (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 12:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiKKRnj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:43:39 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07CA389D
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 09:43:36 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-13c2cfd1126so6106633fac.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Nov 2022 09:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=maqLOf7YpMFEzynaRDsHxbX3MuJ4bRYzP6aDRTy1ABg=;
        b=IYIhJKsZSVoD/GLDOrZMeaMiBIfAvMJw/A7ugWdKzVyQDZ41dYRVizXFELCwN1kcsR
         6euyqu/nZDWhNYYZNXDhwQjeWTWxU0BZNayZ5hgzz0MGAqsWWZ8P9HO7c93CTBVEYn+K
         Dl4JgJcQswYbgb5RtgAqlsFns9c5zs/My3/LqBnVn0uV1k1ln/MPIWwsI4Z5VofbMtDv
         +DSfngg3rAnowI+ttvaHGe+oPgPkpOWx+r++j+IkWmFl6UHjvFiI8aYBX5v06nCSIshA
         VKHSo8AFoBHSFKEZiJmky//E1SdfcoGp6dVzIn9Odmk3XgnE/nusEu7n4eFAEMLWQZdO
         5b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maqLOf7YpMFEzynaRDsHxbX3MuJ4bRYzP6aDRTy1ABg=;
        b=tjv61t5mJmopkaSgOCpJl6rdWfGks8JSFbCJ1+uS88Fsrtxwtn5/eH+GuIKMgmu/Qw
         FEgLa+VX1T2RqXOYpBxDIt0UUfbtIOr7mglISb+WMDGWaKaB/7+i/HmLsEGnalWmU9Tf
         F5VWMfuReUnTiCG0hp7YA/hps8p8CztanWt5pAGTD/d4sjhP2WEcwdSCrGsAUCi057eV
         77rPVDjj4HOJ8WqEItj8CNLUrN2I9T6I7orXHVqEKi9X1i9Y6afzN8EradoM+t9SS/7A
         6WoPRVqNXa8/ESGF2vwvK+TOmmxQrkVdiedi1JJ3R/o7rquuklj4Wm94E4Z0wIGJCtb/
         IZAw==
X-Gm-Message-State: ANoB5pnV1QQSfYybKGy85jktspvcFxJ4+ZSClRVW44lG2lTs5jwVTqiM
        bZgxpj2FpIZ0YU+vSCXRRsa+3fep1ZajXRHI3F7I
X-Google-Smtp-Source: AA0mqf5EWcLBYgk2h8vefAXExBzKCxOMg+hmScmmQZLxWBThNR1qc98TWGhzZP+A1fM5ucA3GYKXfLrQgdx1L+p0bxE=
X-Received: by 2002:a05:6870:4304:b0:13b:d015:f1b5 with SMTP id
 w4-20020a056870430400b0013bd015f1b5mr1596997oah.51.1668188615875; Fri, 11 Nov
 2022 09:43:35 -0800 (PST)
MIME-Version: 1.0
References: <166807856758.2972602.14175912201162072721.stgit@warthog.procyon.org.uk>
 <CAHC9VhTJh2tFbvOMzpGw7VSnHHb=boNhL5c7a1Ed+iHNFwWwqg@mail.gmail.com>
In-Reply-To: <CAHC9VhTJh2tFbvOMzpGw7VSnHHb=boNhL5c7a1Ed+iHNFwWwqg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Nov 2022 12:43:25 -0500
Message-ID: <CAHC9VhQE08HOKKbfU6sh2u0i5Ab=Ah9_0H+EU72wuMSLELi+ww@mail.gmail.com>
Subject: Re: [PATCH v5] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Jeff Layton <jlayton@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>, linux-nfs@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 11, 2022 at 12:40 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Nov 10, 2022 at 6:09 AM David Howells <dhowells@redhat.com> wrote:
> >
> > When NFS superblocks are created by automounting, their LSM parameters
> > aren't set in the fs_context struct prior to sget_fc() being called,
> > leading to failure to match existing superblocks.
> >
> > Fix this by adding a new LSM hook to load fc->security for submount
> > creation when alloc_fs_context() is creating the fs_context for it.
> >
> > However, this uncovers a further bug: nfs_get_root() initialises the
> > superblock security manually by calling security_sb_set_mnt_opts() or
> > security_sb_clone_mnt_opts() - but then vfs_get_tree() calls
> > security_sb_set_mnt_opts(), which can lead to SELinux, at least,
> > complaining.
> >
> > Fix that by adding a flag to the fs_context that suppresses the
> > security_sb_set_mnt_opts() call in vfs_get_tree().  This can be set by NFS
> > when it sets the LSM context on the new superblock.
> >
> > The first bug leads to messages like the following appearing in dmesg:
> >
> >         NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,100000,2ee,3a98,1d4c,3a98,1)
> >
> > Changes
> > =======
> > ver #5)
> >  - Removed unused variable.
> >  - Only allocate smack_mnt_opts if we're dealing with a submount.
> >
> > ver #4)
> >  - When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux or
> >    Smack.
> >
> > ver #3)
> >  - Made LSM parameter extraction dependent on fc->purpose ==
> >    FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.
> >
> > ver #2)
> >  - Added Smack support
> >  - Made LSM parameter extraction dependent on reference != NULL.
> >
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() to it.")
> > Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
> > Tested-by: Jeff Layton <jlayton@kernel.org>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> > cc: Anna Schumaker <anna@kernel.org>
> > cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > cc: Scott Mayhew <smayhew@redhat.com>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: Paul Moore <paul@paul-moore.com>
> > cc: linux-nfs@vger.kernel.org
> > cc: selinux@vger.kernel.org
> > cc: linux-security-module@vger.kernel.org
> > cc: linux-fsdevel@vger.kernel.org
> > Link: https://lore.kernel.org/r/165962680944.3334508.6610023900349142034.stgit@warthog.procyon.org.uk/ # v1
> > Link: https://lore.kernel.org/r/165962729225.3357250.14350728846471527137.stgit@warthog.procyon.org.uk/ # v2
> > Link: https://lore.kernel.org/r/165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk/ # v3
> > Link: https://lore.kernel.org/r/166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk/ # v4
> > Link: https://lore.kernel.org/r/217595.1662033775@warthog.procyon.org.uk/ # v5
> > ---
> >
> >  fs/fs_context.c               |    4 +++
> >  fs/nfs/getroot.c              |    1 +
> >  fs/super.c                    |   10 +++++---
> >  include/linux/fs_context.h    |    1 +
> >  include/linux/lsm_hook_defs.h |    1 +
> >  include/linux/lsm_hooks.h     |    6 ++++-
> >  include/linux/security.h      |    6 +++++
> >  security/security.c           |    5 ++++
> >  security/selinux/hooks.c      |   25 +++++++++++++++++++
> >  security/smack/smack_lsm.c    |   54 +++++++++++++++++++++++++++++++++++++++++
> >  10 files changed, 108 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/fs_context.c b/fs/fs_context.c
> > index 24ce12f0db32..22248b8a88a8 100644
> > --- a/fs/fs_context.c
> > +++ b/fs/fs_context.c
> > @@ -282,6 +282,10 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
> >                 break;
> >         }
> >
> > +       ret = security_fs_context_init(fc, reference);
> > +       if (ret < 0)
> > +               goto err_fc;
> > +
> >         /* TODO: Make all filesystems support this unconditionally */
> >         init_fs_context = fc->fs_type->init_fs_context;
> >         if (!init_fs_context)
> > diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
> > index 11ff2b2e060f..651bffb0067e 100644
> > --- a/fs/nfs/getroot.c
> > +++ b/fs/nfs/getroot.c
> > @@ -144,6 +144,7 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
> >         }
> >         if (error)
> >                 goto error_splat_root;
> > +       fc->lsm_set = true;
> >         if (server->caps & NFS_CAP_SECURITY_LABEL &&
> >                 !(kflags_out & SECURITY_LSM_NATIVE_LABELS))
> >                 server->caps &= ~NFS_CAP_SECURITY_LABEL;
> > diff --git a/fs/super.c b/fs/super.c
> > index 8d39e4f11cfa..f200ae0549ca 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -1553,10 +1553,12 @@ int vfs_get_tree(struct fs_context *fc)
> >         smp_wmb();
> >         sb->s_flags |= SB_BORN;
> >
> > -       error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> > -       if (unlikely(error)) {
> > -               fc_drop_locked(fc);
> > -               return error;
> > +       if (!(fc->lsm_set)) {
> > +               error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> > +               if (unlikely(error)) {
> > +                       fc_drop_locked(fc);
> > +                       return error;
> > +               }
> >         }
>
> Thinking about all the different things that an LSM could do, would it
> ever be possible that a LSM would want the security_sb_set_mnt_opts()
> call to happen here?  I'm wondering if we are better off leaving it up
> to the LSM by passing the fs_context in the security_sb_set_mnt_opts()
> hook; those that want to effectively skip this call due to a submount
> setup already done in security_fs_context_init() can check the
> fs_context::purpose value in the security_sb_set_mnt_opts() hook.

Actually, we could probably also create a LSM specific flag in
fs_context::security to indicate that the setup has already been done.
That's probably a little safer than relying on fs_context::purpose in
the security_sb_set_mnt_opts() hook.

> Thoughts?

-- 
paul-moore.com
