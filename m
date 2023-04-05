Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5906D8635
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjDESp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjDESp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:45:27 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F5735B1
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 11:45:25 -0700 (PDT)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B57693F235
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680720323;
        bh=tqSB9iGLLAVi3OwZ7YCk2eYt1+0/QWF9sil0y+vrkBE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=B/xsNSn27tDZmoRs56KzhaBg+JQX4PN6cbeiEC4j/8poIZ4DcSR0hGtYJVo9C5n9g
         zHf6MBUIp4Jz+S+/Zw4tHShQI64bV4af4Wg/luHPjxKXVY65QvgSUWHITy5+WJ441K
         BHF4LsXUc5khcGT30MhD0dcRmlc81FUE/Ik3UQyXwAUosXyItEyNAtaEol8Z6lvsuM
         SGxEQEVRyz47eGsjzSRhZVuMeOkY37BgyBuLc2OVM81b4vqk+W1ZebIlcJAavLo8Cp
         jj8yPEgsimn2FNOGU/MMTDG7uz9fbzQN3aUHZIf0k5Fe8Mq0qHdw1qOce1jzbmhqSL
         Aa6ZPmpWn7rHw==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-545dd1a1e31so315195097b3.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Apr 2023 11:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680720321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqSB9iGLLAVi3OwZ7YCk2eYt1+0/QWF9sil0y+vrkBE=;
        b=P9FnH06oa/Voe4oJY5tOYXGz134iV/+Lh4CNf+FW44l0pCMKlFWC+jvhYZMHEYwRyJ
         7FWtp6Q+BYBHbwDNA81hJgxOdMwdbfM6o1MvLfFOfzBbRnANmquOPJTcdo+auYeitsaL
         f+ertW+NJzIvqmLsAa+R/5zlnSQ++CQaW8HyVSNWRw4VTqCcSU3rQazWiCKLbPtfCgcS
         MPdkT35BmtJ3e5hL8279IuFh0qu2WcWzUKo7hwjIq1OPnhbHp3pQTLEmBZakOWe1isgd
         wcbXM1JJ86rAnVgvnAeXqqq18LQFX34HqqRGlPvPA0I28cMp0uV7A/M/lvdLGkrjU+Zk
         RG7g==
X-Gm-Message-State: AAQBX9cNCVdxyzcQ2Lq7STeNRd8AFPDn0Q9dHJtS3G+G9003owTp1Ber
        LlLyKgwywlH05g0yWKPmF4fh7Ky2OoO5K/Advmpnmpsg9Q8tGmOfRbgxhHP3mW9ctj8J9XHSlkj
        1kdFbnSgrShqRsbIlcXUwPL9OG74CGhcQJMdqi2kJ7MbJPxYpuM5OwGXmVcc=
X-Received: by 2002:a25:d711:0:b0:b7c:1144:a708 with SMTP id o17-20020a25d711000000b00b7c1144a708mr163484ybg.12.1680720321525;
        Wed, 05 Apr 2023 11:45:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350aG0CV/NZ9uTsc1l5AYrXQ+XK1BwZZLN0vExXFClfJKUzwRBNidhwPTo7ktTzFq7EG0lZEB2hSZX9YXZi0kdnk=
X-Received: by 2002:a25:d711:0:b0:b7c:1144:a708 with SMTP id
 o17-20020a25d711000000b00b7c1144a708mr163450ybg.12.1680720321250; Wed, 05 Apr
 2023 11:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
 <20230403144517.347517-9-aleksandr.mikhalitsyn@canonical.com> <20230403-barmaid-smuggling-e70e604aa34f@brauner>
In-Reply-To: <20230403-barmaid-smuggling-e70e604aa34f@brauner>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 5 Apr 2023 20:45:10 +0200
Message-ID: <CAEivzxfme8rmSu2BiWCGTM3sXfqinHDdMNDhn5Z5fNFAEMBhMA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 8/9] namespace: add sb_revalidate_bindmounts helper
To:     Christian Brauner <brauner@kernel.org>
Cc:     mszeredi@redhat.com, flyingpeng@tencent.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org, safinaskar@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 3, 2023 at 11:14=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Apr 03, 2023 at 04:45:16PM +0200, Alexander Mikhalitsyn wrote:
> > Useful if for some reason bindmounts root dentries get invalidated
> > but it's needed to revalidate existing bindmounts without remounting.
> >
> > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: St=C3=A9phane Graber <stgraber@ubuntu.com>
> > Cc: Seth Forshee <sforshee@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Andrei Vagin <avagin@gmail.com>
> > Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> > Cc: Bernd Schubert <bschubert@ddn.com>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: criu@openvz.org
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  fs/namespace.c                | 90 +++++++++++++++++++++++++++++++++++
> >  include/linux/mnt_namespace.h |  3 ++
> >  2 files changed, 93 insertions(+)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index bc0f15257b49..b74d00d6abb0 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -568,6 +568,96 @@ static int mnt_make_readonly(struct mount *mnt)
> >       return ret;
> >  }
> >
> > +struct bind_mount_list_item {
> > +     struct list_head list;
> > +     struct vfsmount *mnt;
> > +};
> > +
> > +/*
> > + * sb_revalidate_bindmounts - Relookup/reset bindmounts root dentries
> > + *
> > + * Useful if for some reason bindmount root dentries get invalidated
> > + * but it's needed to revalidate existing bindmounts without remountin=
g.
> > + */
> > +int sb_revalidate_bindmounts(struct super_block *sb)

Hi Christian!

>
> It's difficult to not strongly dislike this patchset on the basis of the
> need for a function like this alone. And I just have to say it even if I
> normally try not to do this: This whole function is bonkers in my opinion=
.

This function is the main pain point in this patchset, I believe :)
I thought a lot about other ways (without this helper) and all of them
have their pros and cons.

And that's the reason why this patchset is RFC. I wanted to hear from
you and other folks
about your point of view on the problem. As far as I can see there is
some interest to that problem,
and implementation question is important, but if there is no
objections against the concept of
FUSE mounts healing (and Checkpoint/Restore too as a more complex
case) then I think we will
be able to agree on some approach to the problem. I'm ready to rework
that in the way it is supposed to be done.

>
> But leaving that aside for a second. This really needs detailed
> explanations on locking, assumptions, and an explanation what you're
> doing here. This looks crazy to me and definitely isn't fit to be a
> generic helper in this form.

Of course.

>
> > +{
> > +     struct mount *mnt;
> > +     struct bind_mount_list_item *bmnt, *next;
> > +     int err =3D 0;
> > +     struct vfsmount *root_mnt =3D NULL;
> > +     LIST_HEAD(mnt_to_update);
> > +     char *buf;
> > +
> > +     buf =3D (char *) __get_free_page(GFP_KERNEL);
> > +     if (!buf)
> > +             return -ENOMEM;
> > +
> > +     lock_mount_hash();
> > +     list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
> > +             /* we only want to touch bindmounts */
> > +             if (mnt->mnt.mnt_root =3D=3D sb->s_root) {
> > +                     if (!root_mnt)
> > +                             root_mnt =3D mntget(&mnt->mnt);
> > +
> > +                     continue;
> > +             }
> > +
> > +             bmnt =3D kzalloc(sizeof(struct bind_mount_list_item), GFP=
_NOWAIT | __GFP_NOWARN);
>
> Allocating under lock_mount_hash() even if doable with this flag
> combination should be avoided at all costs imho. That just seems hacky.

got it

>
> > +             if (!bmnt) {
> > +                     err =3D -ENOMEM;
> > +                     goto exit;
>
> You're exiting the function with lock_mount_hash() held...

+

>
> > +             }
> > +
> > +             bmnt->mnt =3D mntget(&mnt->mnt);
> > +             list_add_tail(&bmnt->list, &mnt_to_update);
> > +     }
> > +     unlock_mount_hash();
>
> You've dropped unlock_mount_hash() and the function doesn't hold
> namespace_lock() and isn't documented as requiring the caller to hold
> it. And the later patch that uses this doesn't afaict (although I
> haven't looked at any of the fuse specific stuff). So this is open to
> all sorts of races with mount and unmount now. This needs an explanation
> why that doesn't matter.

yes, it doesn't matter, my idea was that this helper should
"actualize" roots for the bind mounts
at the point of call, but it seems no problem if we skip some new
mounts, because
This helper can be called again. I didn't want to take a namespace_lock() t=
here
because we don't want to have such guarantees for this interface.

Of course, this has to be documented. Thanks!

>
> > +
> > +     /* TODO: get rid of this limitation */
>
> Confused about this comment.

Sorry.

This comment means that current implementation relies on the fact that
each fuse superblock has some
root mount in the list (mnt->mnt.mnt_root =3D=3D sb->s_root). And that's
not always the case, because user
can do something like this:
fusermount ... /mnt/my_fuse_mount
mount --bind /mnt/my_fuse_mount/subtree /mnt/my_fuse_mount_subtree
umount /mnt/my_fuse_mount

In this case, root_mnt =3D=3D NULL. But we need to have root_mnt, to pass
it in vfs_path_lookup(..) later.

>
> > +     if (!root_mnt) {
> > +             err =3D -ENOENT;
> > +             goto exit;
> > +     }
> > +
> > +     list_for_each_entry_safe(bmnt, next, &mnt_to_update, list) {
>
> No one else can access that list so list_for_each_entry_safe() seems
> pointless.

+

>
> > +             struct vfsmount *cur_mnt =3D bmnt->mnt;
> > +             struct path path;
> > +             struct dentry *old_root;
> > +             char *p;
> > +
> > +             p =3D dentry_path(cur_mnt->mnt_root, buf, PAGE_SIZE);
> > +             if (IS_ERR(p))
> > +                     goto exit;
> > +
> > +             /* TODO: are these lookup flags fully safe and correct? *=
/
> > +             err =3D vfs_path_lookup(root_mnt->mnt_root, root_mnt,
> > +                             p, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT|LOOKUP_=
REVAL, &path);
> > +             if (err)
> > +                     goto exit;
> > +
> > +             /* replace bindmount root dentry */
> > +             lock_mount_hash();
> > +             old_root =3D cur_mnt->mnt_root;
> > +             cur_mnt->mnt_root =3D dget(path.dentry);
>
> mnt->mnt_root isn't protected by lock_mount_hash(). It's invariant after
> it has been set and a lot of code just assumes that it's stable.
>
> Top of my hat, since you're not holding namespace_lock() mount
> propagation can be going on concurrently so propagate_one() can check if
> (!is_subdir(mp->m_dentry, m->mnt.mnt_root)) while you're happily
> updating it. A lot of code could actually be touching mnt->mnt_root
> while you're updating it.
>
> There's probably a lot more issues with this I'm just not seeing without
> spending more time on this. But NAK on this as it stands. Sorry.

Thanks for looking into it, Christian!

Kind regards,
Alex

>
> > +             dput(old_root);
> > +             unlock_mount_hash();
> > +
> > +             path_put(&path);
> > +     }
> > +
> > +exit:
> > +     free_page((unsigned long) buf);
> > +     mntput(root_mnt);
> > +     list_for_each_entry_safe(bmnt, next, &mnt_to_update, list) {
> > +             list_del(&bmnt->list);
> > +             mntput(bmnt->mnt);
> > +             kfree(bmnt);
> > +     }
> > +
> > +     return err;
> > +}
> > +EXPORT_SYMBOL_GPL(sb_revalidate_bindmounts);
