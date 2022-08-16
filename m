Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933595952A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 08:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiHPGjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 02:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiHPGjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:39:17 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6077329F1A9
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 20:25:56 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id c17-20020a4a8ed1000000b004452faec26dso1633213ool.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 20:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zaeaXOVhK8m3M+XNtVCsn3FcDPtm1Tez2CwtXwPcxOY=;
        b=ARpEypITrGuMgsrdF/wN/8bNfpLSXuim/YQsP6UIexuLvx9eah8yn7l0kXMXTyjwRE
         8qEhtjeKt2qs0E1Bh8Eo4E50vhNsHzDuxXjsy8Vj9b9wOEz7F0cKQq91DTLmhFa8ZmzR
         ZSRerEin4ZzObLPGAcdjLG4Oct5E0rKGX6n6LyKNvFmuGYb+0/8nwNP9weHRw7JRtPG5
         gDR5e0wMYm2WtchMcwKiu6iURzB2Z2tlaVfJsciS3HYKxa4MxLUHIx30a6b/OAROicQN
         6sijuR8Y27JwEPCvlIQ3zLMZyP7xl11JHJDUrGgbcAyEL0jSsQP3GnvvVETSqzGeMEgX
         tVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zaeaXOVhK8m3M+XNtVCsn3FcDPtm1Tez2CwtXwPcxOY=;
        b=vIyGPUPd5Un648xKVS9sgnYZ5DsJroezmQWfdHR0YqI78Zlg4SC4I9PWL484KE738F
         q4/4+/FfCqtI3j5wETo3RVYGsI5USLnT9IemFtP8rhVa4SM89PZ0HnZkuereR8mi+r5H
         v3HWUvv+jrbWOmKQK8qUEzQeg2hqdpMqcFGa80GITFH40G7TqmsAI48MI3JyGDS3Te84
         hMThn0H51iHllox1X9ss2oSnl8/mcpeBpME64Bpq/FiCuBpbr7EyS/InL3SE7c1dQoot
         6j3FTnalTnsvbOEEbMNCprrg2tZ5sh90BH9FiEuIdNOXqWGnKY4e5hcUlj85usNFSQQv
         F5hg==
X-Gm-Message-State: ACgBeo3qSSrDN7f8QNzSnJPHSTBxshyGXIJPQYIHjuAs7OhNZL54v7uW
        QhRLA0C8a8afDEpMvzZHXMm6V3/O67G1L7uCIcJo
X-Google-Smtp-Source: AA6agR5jcjvLLnXLLTG9WPjI04CMRso162GWkwQVn+kAtpYa5HfLpsgdVT8wApsA1aQLcKFgfc03rLsSBvXINeCUPls=
X-Received: by 2002:a4a:1103:0:b0:435:4c6c:6f92 with SMTP id
 3-20020a4a1103000000b004354c6c6f92mr5750472ooc.26.1660620355452; Mon, 15 Aug
 2022 20:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk>
 <CAFqZXNv+ahpN3Hdv54ixa4u-LKaqTtCyjtkpzKGbv7x4dzwc0Q@mail.gmail.com>
In-Reply-To: <CAFqZXNv+ahpN3Hdv54ixa4u-LKaqTtCyjtkpzKGbv7x4dzwc0Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Aug 2022 23:25:44 -0400
Message-ID: <CAHC9VhTpqvFbjKG5FMKGRBRHavOUrsCSFgayh+BNgSrry8bWLg@mail.gmail.com>
Subject: Re: [PATCH v3] nfs: Fix automount superblock LSM init problem,
 preventing sb sharing
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        dwysocha@redhat.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 11, 2022 at 8:28 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Aug 5, 2022 at 3:36 PM David Howells <dhowells@redhat.com> wrote:
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
> > ver #2)
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
> > cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> > cc: Anna Schumaker <anna@kernel.org>
> > cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > cc: Scott Mayhew <smayhew@redhat.com>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: Paul Moore <paul@paul-moore.com>
> > cc: Casey Schaufler <casey@schaufler-ca.com>
> > cc: linux-nfs@vger.kernel.org
> > cc: selinux@vger.kernel.org
> > cc: linux-security-module@vger.kernel.org
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >
> >  fs/fs_context.c               |    4 +++
> >  fs/nfs/getroot.c              |    1 +
> >  fs/super.c                    |   10 ++++---
> >  include/linux/fs_context.h    |    1 +
> >  include/linux/lsm_hook_defs.h |    1 +
> >  include/linux/lsm_hooks.h     |    6 +++-
> >  include/linux/security.h      |    6 ++++
> >  security/security.c           |    5 +++
> >  security/selinux/hooks.c      |   29 +++++++++++++++++++
> >  security/smack/smack_lsm.c    |   61 +++++++++++++++++++++++++++++++++++++++++
> >  10 files changed, 119 insertions(+), 5 deletions(-)
>
> <snip>
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 1bbd53321d13..ddeaff4f3bb1 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2768,6 +2768,34 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
> >                                    FILESYSTEM__UNMOUNT, NULL);
> >  }
> >
> > +static int selinux_fs_context_init(struct fs_context *fc,
> > +                                  struct dentry *reference)
> > +{
> > +       const struct superblock_security_struct *sbsec;
> > +       const struct inode_security_struct *root_isec;
> > +       struct selinux_mnt_opts *opts;
> > +
> > +       if (fc->purpose == FS_CONTEXT_FOR_SUBMOUNT) {
> > +               opts = kzalloc(sizeof(*opts), GFP_KERNEL);
> > +               if (!opts)
> > +                       return -ENOMEM;
> > +
> > +               root_isec = backing_inode_security(reference->d_sb->s_root);
> > +               sbsec = selinux_superblock(reference->d_sb);
> > +               if (sbsec->flags & FSCONTEXT_MNT)
> > +                       opts->fscontext_sid     = sbsec->sid;
> > +               if (sbsec->flags & CONTEXT_MNT)
> > +                       opts->context_sid       = sbsec->mntpoint_sid;
> > +               if (sbsec->flags & ROOTCONTEXT_MNT)
> > +                       opts->rootcontext_sid   = root_isec->sid;
>
> I wonder if this part is correct... The rootcontext=... mount option
> relates to the root inode of the mount where it is specified - i.e. in
> case of NFS only to the toplevel inode of the initial mount. Setting
> the same context on the root inode of submounts, which AFAIK are
> supposed to be transparent to the user, doesn't seem correct to me -
> i.e. it should just be left unset for the automatically created
> submounts.

Like Ondrej, I'm not going to say I'm very comfortable with some of
the VFS corner cases, but this is an interesting case ... as far as I
can tell, the submount has a superblock and is treated like a normal
filesystem mount with the one exception that it is mounted
automatically so that users might not be aware it is a separate mount.

I guess my question is this: for inodes inside the superblock, does
their superblock pointer point to the submount's superblock, or the
parent filesystem's superblock?

-- 
paul-moore.com
