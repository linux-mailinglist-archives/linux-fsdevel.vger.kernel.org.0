Return-Path: <linux-fsdevel+bounces-3646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F57F6D10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0503D1C20DF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741649455;
	Fri, 24 Nov 2023 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgL9570V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6962BD4E;
	Thu, 23 Nov 2023 23:44:42 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso5092255a12.1;
        Thu, 23 Nov 2023 23:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700811880; x=1701416680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ+CFArzGc64/1bRXo4E03raLfvR1J/+7+zixhE0e08=;
        b=HgL9570VDOZKhY4scAh4FFMLZg783njb+k8j0lzy30UiC6m8q8+kibdV0wLBC0rBgX
         TYXi056sz6VBMSN4nxliNC+89ya6CexI8hdqB07mh/G7l3iMCwHRhUaOwmUBzqlfrix2
         seDZCF+CnsNo1mikm+/jHK9tt7yWxn23pPm82SvqSgKpV0UMTsEiAZuosKQNcdFNnzVg
         Eg58+JJuEgrOT6Oj9cNLWIlRZ33/YYmWvwe34uX35NetqnQxI9lrMpCCRCiDOOzX53CI
         PrRA0EkdlVBCwNy/DwwiqHTszL+8sqguVkYj8+xCWdKaNLLrayjEGRlLlvHWVIskEShO
         oSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700811880; x=1701416680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQ+CFArzGc64/1bRXo4E03raLfvR1J/+7+zixhE0e08=;
        b=QBJeU1AhAllt2ol5c1ggGLkCF4Y/2zMIYoyNhmem/N/CPlxm9Yv4k3rj+Nn28vnxEn
         pRWAFuOJasKwh4h03pGZovfI26JDlZLdChU03TiDpPi7Rz4NK5snnab5ujcLkCHApqSN
         /KBIijHzJ9JTt+O0OWa3cAVK8/LaAqu2mB9E6sYDntT89xCkDZkhTIF73UVz06GHZnns
         ewVI2sRWfLar9uHg4cXLUa7z4cL9S3KNzz5az8D8BUD4Iu54Jf2iutzPqSIcHTksOye3
         v9H3l6j+3OgHhRU6ElSW3tO5d9OyayVkpvka04laM+yzH/HAK6YVUIUpv7W0/x28Up/U
         wn7w==
X-Gm-Message-State: AOJu0Yz0vQQx+l9TVrpF7wVw60RlkWcfedhVFrInCUueWy2gUCPqB20s
	etSc3646srOP/Fsd1YCYSDUg/kYafee1XD/Gtx0=
X-Google-Smtp-Source: AGHT+IH6GW6slN32zmPBPWxeHoaRC62L9VrdcART4c2FXiWQ92joD87Wrw7Ui829CGXXm7cx5oUz2/RvCpz6jPj/Mg0=
X-Received: by 2002:a17:906:74d7:b0:9ff:9209:4bde with SMTP id
 z23-20020a17090674d700b009ff92094bdemr4213087ejl.1.1700811880211; Thu, 23 Nov
 2023 23:44:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060200.GR38156@ZenIV> <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-3-viro@zeniv.linux.org.uk>
In-Reply-To: <20231124060422.576198-3-viro@zeniv.linux.org.uk>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Nov 2023 09:44:27 +0200
Message-ID: <CAOQ4uxjyS45FKJORfxpMHeFbZhszNR2QM6nTF46UxT1iz85Gsg@mail.gmail.com>
Subject: Re: [PATCH v3 03/21] dentry: switch the lists of children to hlist
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 8:05=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> Saves a pointer per struct dentry and actually makes the things less
> clumsy.  Cleaned the d_walk() and dcache_readdir() a bit by use
> of hlist_for_... iterators.
>
> A couple of new helpers - d_first_child() and d_next_sibling(),
> to make the expressions less awful.
>
> X-fuck-kABI: gladly

???

> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  Documentation/filesystems/porting.rst     |  9 +++
>  arch/powerpc/platforms/cell/spufs/inode.c |  5 +-
>  fs/afs/dynroot.c                          |  5 +-
>  fs/autofs/expire.c                        |  7 +--
>  fs/ceph/dir.c                             |  2 +-
>  fs/ceph/mds_client.c                      |  2 +-
>  fs/coda/cache.c                           |  2 +-
>  fs/dcache.c                               | 76 +++++++++++------------
>  fs/libfs.c                                | 45 +++++++-------
>  fs/notify/fsnotify.c                      |  2 +-
>  fs/tracefs/inode.c                        | 34 +++++-----
>  include/linux/dcache.h                    | 20 ++++--
>  12 files changed, 108 insertions(+), 101 deletions(-)
>
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index 878e72b2f8b7..331405f4b29f 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1061,3 +1061,12 @@ export_operations ->encode_fh() no longer has a de=
fault implementation to
>  encode FILEID_INO32_GEN* file handles.
>  Filesystems that used the default implementation may use the generic hel=
per
>  generic_encode_ino32_fh() explicitly.
> +
> +---
> +
> +**mandatory**
> +
> +The list of children anchored in parent dentry got turned into hlist now=
.
> +Field names got changed (->d_children/->d_sib instead of ->d_subdirs/->d=
_child
> +for anchor/entries resp.), so any affected places will be immediately ca=
ught
> +by compiler.
> diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/pla=
tforms/cell/spufs/inode.c
> index 10c1320adfd0..030de2b8c145 100644
> --- a/arch/powerpc/platforms/cell/spufs/inode.c
> +++ b/arch/powerpc/platforms/cell/spufs/inode.c
> @@ -145,10 +145,11 @@ spufs_evict_inode(struct inode *inode)
>
>  static void spufs_prune_dir(struct dentry *dir)
>  {
> -       struct dentry *dentry, *tmp;
> +       struct dentry *dentry;
> +       struct hlist_node *n;
>
>         inode_lock(d_inode(dir));
> -       list_for_each_entry_safe(dentry, tmp, &dir->d_subdirs, d_child) {
> +       hlist_for_each_entry_safe(dentry, n, &dir->d_children, d_sib) {
>                 spin_lock(&dentry->d_lock);
>                 if (simple_positive(dentry)) {
>                         dget_dlock(dentry);
> diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
> index 4d04ef2d3ae7..fe45462834cc 100644
> --- a/fs/afs/dynroot.c
> +++ b/fs/afs/dynroot.c
> @@ -370,7 +370,7 @@ int afs_dynroot_populate(struct super_block *sb)
>  void afs_dynroot_depopulate(struct super_block *sb)
>  {
>         struct afs_net *net =3D afs_sb2net(sb);
> -       struct dentry *root =3D sb->s_root, *subdir, *tmp;
> +       struct dentry *root =3D sb->s_root, *subdir;
>
>         /* Prevent more subdirs from being created */
>         mutex_lock(&net->proc_cells_lock);
> @@ -379,10 +379,11 @@ void afs_dynroot_depopulate(struct super_block *sb)
>         mutex_unlock(&net->proc_cells_lock);
>
>         if (root) {
> +               struct hlist_node *n;
>                 inode_lock(root->d_inode);
>
>                 /* Remove all the pins for dirs created for manually adde=
d cells */
> -               list_for_each_entry_safe(subdir, tmp, &root->d_subdirs, d=
_child) {
> +               hlist_for_each_entry_safe(subdir, n, &root->d_children, d=
_sib) {
>                         if (subdir->d_fsdata) {
>                                 subdir->d_fsdata =3D NULL;
>                                 dput(subdir);
> diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
> index 038b3d2d9f57..39d8c84c16f4 100644
> --- a/fs/autofs/expire.c
> +++ b/fs/autofs/expire.c
> @@ -73,12 +73,9 @@ static int autofs_mount_busy(struct vfsmount *mnt,
>  /* p->d_lock held */
>  static struct dentry *positive_after(struct dentry *p, struct dentry *ch=
ild)
>  {
> -       if (child)
> -               child =3D list_next_entry(child, d_child);
> -       else
> -               child =3D list_first_entry(&p->d_subdirs, struct dentry, =
d_child);
> +       child =3D child ? d_next_sibling(child) : d_first_child(p);
>
> -       list_for_each_entry_from(child, &p->d_subdirs, d_child) {
> +       hlist_for_each_entry_from(child, d_sib) {
>                 spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
>                 if (simple_positive(child)) {
>                         dget_dlock(child);
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 91709934c8b1..678596684596 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -174,7 +174,7 @@ __dcache_find_get_entry(struct dentry *parent, u64 id=
x,
>  /*
>   * When possible, we try to satisfy a readdir by peeking at the
>   * dcache.  We make this work by carefully ordering dentries on
> - * d_child when we initially get results back from the MDS, and
> + * d_children when we initially get results back from the MDS, and
>   * falling back to a "normal" sync readdir if any dentries in the dir
>   * are dropped.
>   *
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index d95eb525519a..02ebfabfc8ee 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2128,7 +2128,7 @@ static bool drop_negative_children(struct dentry *d=
entry)
>                 goto out;
>
>         spin_lock(&dentry->d_lock);
> -       list_for_each_entry(child, &dentry->d_subdirs, d_child) {
> +       hlist_for_each_entry(child, &dentry->d_children, d_sib) {
>                 if (d_really_is_positive(child)) {
>                         all_negative =3D false;
>                         break;
> diff --git a/fs/coda/cache.c b/fs/coda/cache.c
> index bfbc03c6b632..f5b71a35f9db 100644
> --- a/fs/coda/cache.c
> +++ b/fs/coda/cache.c
> @@ -94,7 +94,7 @@ static void coda_flag_children(struct dentry *parent, i=
nt flag)
>
>         rcu_read_lock();
>         spin_lock(&parent->d_lock);
> -       list_for_each_entry(de, &parent->d_subdirs, d_child) {
> +       hlist_for_each_entry(de, &parent->d_children, d_sib) {
>                 struct inode *inode =3D d_inode_rcu(de);
>                 /* don't know what to do with negative dentries */
>                 if (inode)
> diff --git a/fs/dcache.c b/fs/dcache.c
> index c82ae731df9a..59f76c9a15d1 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -51,8 +51,8 @@
>   *   - d_lru
>   *   - d_count
>   *   - d_unhashed()
> - *   - d_parent and d_subdirs
> - *   - childrens' d_child and d_parent
> + *   - d_parent and d_chilren
> + *   - childrens' d_sib and d_parent
>   *   - d_u.d_alias, d_inode
>   *
>   * Ordering:
> @@ -537,7 +537,7 @@ void d_drop(struct dentry *dentry)
>  }
>  EXPORT_SYMBOL(d_drop);
>
> -static inline void dentry_unlist(struct dentry *dentry, struct dentry *p=
arent)
> +static inline void dentry_unlist(struct dentry *dentry)
>  {
>         struct dentry *next;
>         /*
> @@ -545,12 +545,12 @@ static inline void dentry_unlist(struct dentry *den=
try, struct dentry *parent)
>          * attached to the dentry tree
>          */
>         dentry->d_flags |=3D DCACHE_DENTRY_KILLED;
> -       if (unlikely(list_empty(&dentry->d_child)))
> +       if (unlikely(hlist_unhashed(&dentry->d_sib)))
>                 return;
> -       __list_del_entry(&dentry->d_child);
> +       __hlist_del(&dentry->d_sib);
>         /*
>          * Cursors can move around the list of children.  While we'd been
> -        * a normal list member, it didn't matter - ->d_child.next would'=
ve
> +        * a normal list member, it didn't matter - ->d_sib.next would've
>          * been updated.  However, from now on it won't be and for the
>          * things like d_walk() it might end up with a nasty surprise.
>          * Normally d_walk() doesn't care about cursors moving around -
> @@ -558,20 +558,20 @@ static inline void dentry_unlist(struct dentry *den=
try, struct dentry *parent)
>          * of its own, we get through it without ever unlocking the paren=
t.
>          * There is one exception, though - if we ascend from a child tha=
t
>          * gets killed as soon as we unlock it, the next sibling is found
> -        * using the value left in its ->d_child.next.  And if _that_
> +        * using the value left in its ->d_sib.next.  And if _that_
>          * pointed to a cursor, and cursor got moved (e.g. by lseek())
>          * before d_walk() regains parent->d_lock, we'll end up skipping
>          * everything the cursor had been moved past.
>          *
> -        * Solution: make sure that the pointer left behind in ->d_child.=
next
> +        * Solution: make sure that the pointer left behind in ->d_sib.ne=
xt
>          * points to something that won't be moving around.  I.e. skip th=
e
>          * cursors.
>          */
> -       while (dentry->d_child.next !=3D &parent->d_subdirs) {
> -               next =3D list_entry(dentry->d_child.next, struct dentry, =
d_child);
> +       while (dentry->d_sib.next) {
> +               next =3D hlist_entry(dentry->d_sib.next, struct dentry, d=
_sib);
>                 if (likely(!(next->d_flags & DCACHE_DENTRY_CURSOR)))
>                         break;
> -               dentry->d_child.next =3D next->d_child.next;
> +               dentry->d_sib.next =3D next->d_sib.next;
>         }
>  }
>
> @@ -600,7 +600,7 @@ static void __dentry_kill(struct dentry *dentry)
>         }
>         /* if it was on the hash then remove it */
>         __d_drop(dentry);
> -       dentry_unlist(dentry, parent);
> +       dentry_unlist(dentry);
>         if (parent)
>                 spin_unlock(&parent->d_lock);
>         if (dentry->d_inode)
> @@ -1348,8 +1348,7 @@ enum d_walk_ret {
>  static void d_walk(struct dentry *parent, void *data,
>                    enum d_walk_ret (*enter)(void *, struct dentry *))
>  {
> -       struct dentry *this_parent;
> -       struct list_head *next;
> +       struct dentry *this_parent, *dentry;
>         unsigned seq =3D 0;
>         enum d_walk_ret ret;
>         bool retry =3D true;
> @@ -1371,13 +1370,9 @@ static void d_walk(struct dentry *parent, void *da=
ta,
>                 break;
>         }
>  repeat:
> -       next =3D this_parent->d_subdirs.next;
> +       dentry =3D d_first_child(this_parent);
>  resume:
> -       while (next !=3D &this_parent->d_subdirs) {
> -               struct list_head *tmp =3D next;
> -               struct dentry *dentry =3D list_entry(tmp, struct dentry, =
d_child);
> -               next =3D tmp->next;
> -
> +       hlist_for_each_entry_from(dentry, d_sib) {
>                 if (unlikely(dentry->d_flags & DCACHE_DENTRY_CURSOR))
>                         continue;
>
> @@ -1398,7 +1393,7 @@ static void d_walk(struct dentry *parent, void *dat=
a,
>                         continue;
>                 }
>
> -               if (!list_empty(&dentry->d_subdirs)) {
> +               if (!hlist_empty(&dentry->d_children)) {
>                         spin_unlock(&this_parent->d_lock);
>                         spin_release(&dentry->d_lock.dep_map, _RET_IP_);
>                         this_parent =3D dentry;
> @@ -1413,24 +1408,23 @@ static void d_walk(struct dentry *parent, void *d=
ata,
>         rcu_read_lock();
>  ascend:
>         if (this_parent !=3D parent) {
> -               struct dentry *child =3D this_parent;
> -               this_parent =3D child->d_parent;
> +               dentry =3D this_parent;
> +               this_parent =3D dentry->d_parent;
>
> -               spin_unlock(&child->d_lock);
> +               spin_unlock(&dentry->d_lock);
>                 spin_lock(&this_parent->d_lock);
>
>                 /* might go back up the wrong parent if we have had a ren=
ame. */
>                 if (need_seqretry(&rename_lock, seq))
>                         goto rename_retry;
>                 /* go into the first sibling still alive */
> -               do {
> -                       next =3D child->d_child.next;
> -                       if (next =3D=3D &this_parent->d_subdirs)
> -                               goto ascend;
> -                       child =3D list_entry(next, struct dentry, d_child=
);
> -               } while (unlikely(child->d_flags & DCACHE_DENTRY_KILLED))=
;
> -               rcu_read_unlock();
> -               goto resume;
> +               hlist_for_each_entry_continue(dentry, d_sib) {
> +                       if (likely(!(dentry->d_flags & DCACHE_DENTRY_KILL=
ED))) {
> +                               rcu_read_unlock();
> +                               goto resume;
> +                       }
> +               }
> +               goto ascend;
>         }
>         if (need_seqretry(&rename_lock, seq))
>                 goto rename_retry;
> @@ -1530,7 +1524,7 @@ int d_set_mounted(struct dentry *dentry)
>   * Search the dentry child list of the specified parent,
>   * and move any unused dentries to the end of the unused
>   * list for prune_dcache(). We descend to the next level
> - * whenever the d_subdirs list is non-empty and continue
> + * whenever the d_children list is non-empty and continue
>   * searching.
>   *
>   * It returns zero iff there are no unused children,
> @@ -1657,7 +1651,7 @@ EXPORT_SYMBOL(shrink_dcache_parent);
>  static enum d_walk_ret umount_check(void *_data, struct dentry *dentry)
>  {
>         /* it has busy descendents; complain about those instead */
> -       if (!list_empty(&dentry->d_subdirs))
> +       if (!hlist_empty(&dentry->d_children))
>                 return D_WALK_CONTINUE;
>
>         /* root with refcount 1 is fine */
> @@ -1814,9 +1808,9 @@ static struct dentry *__d_alloc(struct super_block =
*sb, const struct qstr *name)
>         dentry->d_fsdata =3D NULL;
>         INIT_HLIST_BL_NODE(&dentry->d_hash);
>         INIT_LIST_HEAD(&dentry->d_lru);
> -       INIT_LIST_HEAD(&dentry->d_subdirs);
> +       INIT_HLIST_HEAD(&dentry->d_children);
>         INIT_HLIST_NODE(&dentry->d_u.d_alias);
> -       INIT_LIST_HEAD(&dentry->d_child);
> +       INIT_HLIST_NODE(&dentry->d_sib);
>         d_set_d_op(dentry, dentry->d_sb->s_d_op);
>
>         if (dentry->d_op && dentry->d_op->d_init) {
> @@ -1855,7 +1849,7 @@ struct dentry *d_alloc(struct dentry * parent, cons=
t struct qstr *name)
>          */
>         __dget_dlock(parent);
>         dentry->d_parent =3D parent;
> -       list_add(&dentry->d_child, &parent->d_subdirs);
> +       hlist_add_head(&dentry->d_sib, &parent->d_children);
>         spin_unlock(&parent->d_lock);
>
>         return dentry;
> @@ -2993,11 +2987,15 @@ static void __d_move(struct dentry *dentry, struc=
t dentry *target,
>         } else {
>                 target->d_parent =3D old_parent;
>                 swap_names(dentry, target);
> -               list_move(&target->d_child, &target->d_parent->d_subdirs)=
;
> +               if (!hlist_unhashed(&target->d_sib))
> +                       __hlist_del(&target->d_sib);
> +               hlist_add_head(&target->d_sib, &target->d_parent->d_child=
ren);
>                 __d_rehash(target);
>                 fsnotify_update_flags(target);
>         }
> -       list_move(&dentry->d_child, &dentry->d_parent->d_subdirs);
> +       if (!hlist_unhashed(&dentry->d_sib))
> +               __hlist_del(&dentry->d_sib);
> +       hlist_add_head(&dentry->d_sib, &dentry->d_parent->d_children);
>         __d_rehash(dentry);
>         fsnotify_update_flags(dentry);
>         fscrypt_handle_d_move(dentry);
> diff --git a/fs/libfs.c b/fs/libfs.c
> index e9440d55073c..46c9177769c1 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -104,15 +104,16 @@ EXPORT_SYMBOL(dcache_dir_close);
>   * If no such element exists, NULL is returned.
>   */
>  static struct dentry *scan_positives(struct dentry *cursor,
> -                                       struct list_head *p,
> +                                       struct hlist_node **p,
>                                         loff_t count,
>                                         struct dentry *last)
>  {
>         struct dentry *dentry =3D cursor->d_parent, *found =3D NULL;
>
>         spin_lock(&dentry->d_lock);
> -       while ((p =3D p->next) !=3D &dentry->d_subdirs) {
> -               struct dentry *d =3D list_entry(p, struct dentry, d_child=
);
> +       while (*p) {
> +               struct dentry *d =3D hlist_entry(*p, struct dentry, d_sib=
);
> +               p =3D &d->d_sib.next;
>                 // we must at least skip cursors, to avoid livelocks
>                 if (d->d_flags & DCACHE_DENTRY_CURSOR)
>                         continue;
> @@ -126,8 +127,10 @@ static struct dentry *scan_positives(struct dentry *=
cursor,
>                         count =3D 1;
>                 }
>                 if (need_resched()) {
> -                       list_move(&cursor->d_child, p);
> -                       p =3D &cursor->d_child;
> +                       if (!hlist_unhashed(&cursor->d_sib))
> +                               __hlist_del(&cursor->d_sib);
> +                       hlist_add_behind(&cursor->d_sib, &d->d_sib);
> +                       p =3D &cursor->d_sib.next;
>                         spin_unlock(&dentry->d_lock);
>                         cond_resched();
>                         spin_lock(&dentry->d_lock);
> @@ -159,13 +162,12 @@ loff_t dcache_dir_lseek(struct file *file, loff_t o=
ffset, int whence)
>                 inode_lock_shared(dentry->d_inode);
>
>                 if (offset > 2)
> -                       to =3D scan_positives(cursor, &dentry->d_subdirs,
> +                       to =3D scan_positives(cursor, &dentry->d_children=
.first,
>                                             offset - 2, NULL);
>                 spin_lock(&dentry->d_lock);
> +               hlist_del_init(&cursor->d_sib);
>                 if (to)
> -                       list_move(&cursor->d_child, &to->d_child);
> -               else
> -                       list_del_init(&cursor->d_child);
> +                       hlist_add_behind(&cursor->d_sib, &to->d_sib);
>                 spin_unlock(&dentry->d_lock);
>                 dput(to);
>
> @@ -187,19 +189,16 @@ int dcache_readdir(struct file *file, struct dir_co=
ntext *ctx)
>  {
>         struct dentry *dentry =3D file->f_path.dentry;
>         struct dentry *cursor =3D file->private_data;
> -       struct list_head *anchor =3D &dentry->d_subdirs;
>         struct dentry *next =3D NULL;
> -       struct list_head *p;
> +       struct hlist_node **p;
>
>         if (!dir_emit_dots(file, ctx))
>                 return 0;
>
>         if (ctx->pos =3D=3D 2)
> -               p =3D anchor;
> -       else if (!list_empty(&cursor->d_child))
> -               p =3D &cursor->d_child;
> +               p =3D &dentry->d_children.first;
>         else
> -               return 0;
> +               p =3D &cursor->d_sib.next;
>
>         while ((next =3D scan_positives(cursor, p, 1, next)) !=3D NULL) {
>                 if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
> @@ -207,13 +206,12 @@ int dcache_readdir(struct file *file, struct dir_co=
ntext *ctx)
>                               fs_umode_to_dtype(d_inode(next)->i_mode)))
>                         break;
>                 ctx->pos++;
> -               p =3D &next->d_child;
> +               p =3D &next->d_sib.next;
>         }
>         spin_lock(&dentry->d_lock);
> +       hlist_del_init(&cursor->d_sib);
>         if (next)
> -               list_move_tail(&cursor->d_child, &next->d_child);
> -       else
> -               list_del_init(&cursor->d_child);
> +               hlist_add_before(&cursor->d_sib, &next->d_sib);
>         spin_unlock(&dentry->d_lock);
>         dput(next);
>
> @@ -492,12 +490,11 @@ const struct file_operations simple_offset_dir_oper=
ations =3D {
>
>  static struct dentry *find_next_child(struct dentry *parent, struct dent=
ry *prev)
>  {
> -       struct dentry *child =3D NULL;
> -       struct list_head *p =3D prev ? &prev->d_child : &parent->d_subdir=
s;
> +       struct dentry *child =3D NULL, *d;
>
>         spin_lock(&parent->d_lock);
> -       while ((p =3D p->next) !=3D &parent->d_subdirs) {
> -               struct dentry *d =3D container_of(p, struct dentry, d_chi=
ld);
> +       d =3D prev ? d_next_sibling(prev) : d_first_child(parent);
> +       hlist_for_each_entry_from(d, d_sib) {
>                 if (simple_positive(d)) {
>                         spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED=
);
>                         if (simple_positive(d))
> @@ -658,7 +655,7 @@ int simple_empty(struct dentry *dentry)
>         int ret =3D 0;
>
>         spin_lock(&dentry->d_lock);
> -       list_for_each_entry(child, &dentry->d_subdirs, d_child) {
> +       hlist_for_each_entry(child, &dentry->d_children, d_sib) {
>                 spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
>                 if (simple_positive(child)) {
>                         spin_unlock(&child->d_lock);
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 7974e91ffe13..8bfd690e9f10 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -124,7 +124,7 @@ void __fsnotify_update_child_dentry_flags(struct inod=
e *inode)
>                  * d_flags to indicate parental interest (their parent is=
 the
>                  * original inode) */
>                 spin_lock(&alias->d_lock);
> -               list_for_each_entry(child, &alias->d_subdirs, d_child) {
> +               hlist_for_each_entry(child, &alias->d_children, d_sib) {
>                         if (!child->d_inode)
>                                 continue;
>
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 5b54948514fe..61ca5fcf10f9 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -199,26 +199,21 @@ static void change_gid(struct dentry *dentry, kgid_=
t gid)
>   */
>  static void set_gid(struct dentry *parent, kgid_t gid)
>  {
> -       struct dentry *this_parent;
> -       struct list_head *next;
> +       struct dentry *this_parent, *dentry;
>
>         this_parent =3D parent;
>         spin_lock(&this_parent->d_lock);
>
>         change_gid(this_parent, gid);
>  repeat:
> -       next =3D this_parent->d_subdirs.next;
> +       dentry =3D d_first_child(this_parent);
>  resume:
> -       while (next !=3D &this_parent->d_subdirs) {
> -               struct list_head *tmp =3D next;
> -               struct dentry *dentry =3D list_entry(tmp, struct dentry, =
d_child);
> -               next =3D tmp->next;
> -
> +       hlist_for_each_entry_from(dentry, d_sib) {
>                 spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
>
>                 change_gid(dentry, gid);
>
> -               if (!list_empty(&dentry->d_subdirs)) {
> +               if (!hlist_empty(&dentry->d_children)) {
>                         spin_unlock(&this_parent->d_lock);
>                         spin_release(&dentry->d_lock.dep_map, _RET_IP_);
>                         this_parent =3D dentry;
> @@ -233,21 +228,20 @@ static void set_gid(struct dentry *parent, kgid_t g=
id)
>         rcu_read_lock();
>  ascend:
>         if (this_parent !=3D parent) {
> -               struct dentry *child =3D this_parent;
> -               this_parent =3D child->d_parent;
> +               dentry =3D this_parent;
> +               this_parent =3D dentry->d_parent;
>
> -               spin_unlock(&child->d_lock);
> +               spin_unlock(&dentry->d_lock);
>                 spin_lock(&this_parent->d_lock);
>
>                 /* go into the first sibling still alive */
> -               do {
> -                       next =3D child->d_child.next;
> -                       if (next =3D=3D &this_parent->d_subdirs)
> -                               goto ascend;
> -                       child =3D list_entry(next, struct dentry, d_child=
);
> -               } while (unlikely(child->d_flags & DCACHE_DENTRY_KILLED))=
;
> -               rcu_read_unlock();
> -               goto resume;
> +               hlist_for_each_entry_continue(dentry, d_sib) {
> +                       if (likely(!(dentry->d_flags & DCACHE_DENTRY_KILL=
ED))) {
> +                               rcu_read_unlock();
> +                               goto resume;
> +                       }
> +               }
> +               goto ascend;
>         }
>         rcu_read_unlock();
>         spin_unlock(&this_parent->d_lock);
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 3da2f0545d5d..0e397a0c519c 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -68,12 +68,12 @@ extern const struct qstr dotdot_name;
>   * large memory footprint increase).
>   */
>  #ifdef CONFIG_64BIT
> -# define DNAME_INLINE_LEN 32 /* 192 bytes */
> +# define DNAME_INLINE_LEN 40 /* 192 bytes */
>  #else
>  # ifdef CONFIG_SMP
> -#  define DNAME_INLINE_LEN 36 /* 128 bytes */
> -# else
>  #  define DNAME_INLINE_LEN 40 /* 128 bytes */
> +# else
> +#  define DNAME_INLINE_LEN 44 /* 128 bytes */
>  # endif
>  #endif
>
> @@ -101,8 +101,8 @@ struct dentry {
>                 struct list_head d_lru;         /* LRU list */
>                 wait_queue_head_t *d_wait;      /* in-lookup ones only */
>         };
> -       struct list_head d_child;       /* child of parent list */
> -       struct list_head d_subdirs;     /* our children */
> +       struct hlist_node d_sib;        /* child of parent list */
> +       struct hlist_head d_children;   /* our children */
>         /*
>          * d_alias and d_rcu can share memory
>          */
> @@ -600,4 +600,14 @@ struct name_snapshot {
>  void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
>  void release_dentry_name_snapshot(struct name_snapshot *);
>
> +static inline struct dentry *d_first_child(const struct dentry *dentry)
> +{
> +       return hlist_entry_safe(dentry->d_children.first, struct dentry, =
d_sib);
> +}
> +
> +static inline struct dentry *d_next_sibling(const struct dentry *dentry)
> +{
> +       return hlist_entry_safe(dentry->d_sib.next, struct dentry, d_sib)=
;
> +}
> +
>  #endif /* __LINUX_DCACHE_H */
> --
> 2.39.2
>
>

