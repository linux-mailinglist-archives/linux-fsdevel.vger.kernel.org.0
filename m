Return-Path: <linux-fsdevel+bounces-751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 616B17CF925
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17252281FD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8D4225B7;
	Thu, 19 Oct 2023 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjEE+3Wo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD767225B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:39:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C1F91
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697719188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wajlyLgkFhoViHX5JghcqO7IxybGxLAVgdga1pit+WU=;
	b=UjEE+3Wo1fo80rw1q4joChn/Uq+d5RIhseYmflzDxhqnw0nI1FOnA+RpSA2zRkLTmMADo6
	Y10DqVNpagRNmw5bCKmtUmoC85yR82MOspbk2AqT5auTmz1qPqb7BBsFW15BdvoCnvEw/3
	lE8HekZ8vkuieHMiObAULlqJQQ5bfsA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-p2UE6JJMPsKZaeqE-hb5uA-1; Thu, 19 Oct 2023 08:39:47 -0400
X-MC-Unique: p2UE6JJMPsKZaeqE-hb5uA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-27d3c14b1a5so6217642a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697719186; x=1698323986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wajlyLgkFhoViHX5JghcqO7IxybGxLAVgdga1pit+WU=;
        b=EjhRHR4aru+fuqyIEh0VF6WA8ocqzr3u7K6xufu6mfwKSWC/sedZV2pcuAEQ8fYGXf
         HFoLLA4cpL+i2THZwwGpk4721I8zEwHKZHJBlKlqW+kJ8Zje8udQFm7iJwe5hvnG52/4
         zqJ37StPjI1eMwtwSR6Pnjexgrqon4Ii1CmCAUOStm2DALLBa/IUbeitdGYVjndwZPEd
         BDv6rTwP/46PppEoC9Z5zoLagMtvizV8ijOCi9YvFQ1MODjBSyLj9hW9AAhsFK1AkFL/
         Gy4YgBZs45cjs9IJC1mHXE1FK9qYbuzzzg0E4pu1Jjhv3trbP3hCBgbKWMFtVc4k4SI2
         MeAw==
X-Gm-Message-State: AOJu0YxKTLJ46G0NTowi5i6h5uGyNzrquKjFJ5FVp1K7FszR2Dtf6oh3
	J2zqBol7fW7dyY86+bOU5Sb/kOJnRGP5kopPidOOcQyBJ9iNoOxOLFQ+OHDrHmdeGfPIGM/z2mn
	5o13nzlzmziAV9nIRP6tGet6bb4qD1tSinww3mOOf2A==
X-Received: by 2002:a17:90a:fb94:b0:27d:273:93ba with SMTP id cp20-20020a17090afb9400b0027d027393bamr1868218pjb.30.1697719186294;
        Thu, 19 Oct 2023 05:39:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVdGDMGhkg4ynXhmdI3cD0qA35dihSow/Nh0jr1avoEi3bp5OG4QQKS3CZciO164PRncmuRsk5cbTwNOQFt4A=
X-Received: by 2002:a17:90a:fb94:b0:27d:273:93ba with SMTP id
 cp20-20020a17090afb9400b0027d027393bamr1868194pjb.30.1697719185860; Thu, 19
 Oct 2023 05:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtzyUhcVbYrLG5Uhdur9fPxtdvxyYhFzCBf9Q8v6fK3Ow@mail.gmail.com>
 <20231018013359.GB3902@templeofstupid.com>
In-Reply-To: <20231018013359.GB3902@templeofstupid.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 19 Oct 2023 14:39:34 +0200
Message-ID: <CAOssrKdH5x7YAnK4P8+5O8V934XtbH9JBSvctyM-pSmDMCq8yQ@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: share lookup state between submount and its parent
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, German Maglione <gmaglione@redhat.com>, 
	Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 3:34=E2=80=AFAM Krister Johansen
<kjlx@templeofstupid.com> wrote:
>
> Fuse submounts do not perform a lookup for the nodeid that they inherit
> from their parent.  Instead, the code decrements the nlookup on the
> submount's fuse_inode when it is instantiated, and no forget is
> performed when a submount root is evicted.
>
> Trouble arises when the submount's parent is evicted despite the
> submount itself being in use.  In this author's case, the submount was
> in a container and deatched from the initial mount namespace via a
> MNT_DEATCH operation.  When memory pressure triggered the shrinker, the
> inode from the parent was evicted, which triggered enough forgets to
> render the submount's nodeid invalid.
>
> Since submounts should still function, even if their parent goes away,
> solve this problem by sharing refcounted state between the parent and
> its submount.  When all of the references on this shared state reach
> zero, it's safe to forget the final lookup of the fuse nodeid.
>
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> Cc: stable@vger.kernel.org
> Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts"=
)
> ---
>  fs/fuse/fuse_i.h | 20 +++++++++++
>  fs/fuse/inode.c  | 88 ++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 105 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 405252bb51f2..0d1659c5016b 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -63,6 +63,24 @@ struct fuse_forget_link {
>         struct fuse_forget_link *next;
>  };
>
> +/* Submount lookup tracking */
> +struct fuse_submount_lookup {
> +       /** Refcount */
> +       refcount_t count;
> +
> +       /** Unique ID, which identifies the inode between userspace
> +        * and kernel */
> +       u64 nodeid;
> +
> +       /** Number of lookups on this inode */
> +       u64 nlookup;

sl->nlookup will always be one.  So that can just be implicit and this
field can just go away.

> +
> +       /** The request used for sending the FORGET message */
> +       struct fuse_forget_link *forget;
> +
> +       struct rcu_head rcu;

RCU would be needed if any fields could be accessed from RCU protected
code.  But AFAICS there's no such access, so this shouldn't be needed.
  Am I missing something?

> +};
> +
>  /** FUSE inode */
>  struct fuse_inode {
>         /** Inode data */
> @@ -158,6 +176,8 @@ struct fuse_inode {
>          */
>         struct fuse_inode_dax *dax;
>  #endif
> +       /** Submount specific lookup tracking */
> +       struct fuse_submount_lookup *submount_lookup;
>  };
>
>  /** FUSE inode state bits */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 444418e240c8..dc1499e2074f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -68,6 +68,24 @@ struct fuse_forget_link *fuse_alloc_forget(void)
>         return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL_ACCOUN=
T);
>  }
>
> +static struct fuse_submount_lookup *fuse_alloc_submount_lookup(void)
> +{
> +       struct fuse_submount_lookup *sl;
> +
> +       sl =3D kzalloc(sizeof(struct fuse_submount_lookup), GFP_KERNEL_AC=
COUNT);
> +       if (!sl)
> +               return NULL;
> +       sl->forget =3D fuse_alloc_forget();
> +       if (!sl->forget)
> +               goto out_free;
> +
> +       return sl;
> +
> +out_free:
> +       kfree(sl);
> +       return NULL;
> +}
> +
>  static struct inode *fuse_alloc_inode(struct super_block *sb)
>  {
>         struct fuse_inode *fi;
> @@ -113,9 +131,24 @@ static void fuse_free_inode(struct inode *inode)
>         kmem_cache_free(fuse_inode_cachep, fi);
>  }
>
> +static void fuse_cleanup_submount_lookup(struct fuse_conn *fc,
> +                                        struct fuse_submount_lookup *sl)
> +{
> +       if (!refcount_dec_and_test(&sl->count))
> +               return;
> +
> +       if (sl->nlookup) {
> +               fuse_queue_forget(fc, sl->forget, sl->nodeid, sl->nlookup=
);
> +               sl->forget =3D NULL;
> +       }
> +       kfree(sl->forget);
> +       kfree_rcu(sl, rcu);
> +}
> +
>  static void fuse_evict_inode(struct inode *inode)
>  {
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct fuse_submount_lookup *sl =3D NULL;
>
>         /* Will write inode on close/munmap and in all other dirtiers */
>         WARN_ON(inode->i_state & I_DIRTY_INODE);
> @@ -132,6 +165,15 @@ static void fuse_evict_inode(struct inode *inode)
>                                           fi->nlookup);
>                         fi->forget =3D NULL;
>                 }
> +
> +               spin_lock(&fi->lock);
> +               if (fi->submount_lookup) {
> +                       sl =3D fi->submount_lookup;
> +                       fi->submount_lookup =3D NULL;
> +               }
> +               spin_unlock(&fi->lock);

I don't think locking is needed.  Eviction happens only once and at
that point nobody else should be touching the inode.

> +               if (sl)
> +                       fuse_cleanup_submount_lookup(fc, sl);
>         }
>         if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
>                 WARN_ON(!list_empty(&fi->write_files));
> @@ -332,6 +374,14 @@ void fuse_change_attributes(struct inode *inode, str=
uct fuse_attr *attr,
>                 fuse_dax_dontcache(inode, attr->flags);
>  }
>
> +static void fuse_init_submount_lookup(struct fuse_submount_lookup *sl,
> +                                     u64 nodeid)
> +{
> +       sl->nodeid =3D nodeid;
> +       sl->nlookup =3D 1;
> +       refcount_set(&sl->count, 1);
> +}
> +
>  static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
>                             struct fuse_conn *fc)
>  {
> @@ -395,12 +445,22 @@ struct inode *fuse_iget(struct super_block *sb, u64=
 nodeid,
>          */
>         if (fc->auto_submounts && (attr->flags & FUSE_ATTR_SUBMOUNT) &&
>             S_ISDIR(attr->mode)) {
> +               struct fuse_inode *fi;
> +
>                 inode =3D new_inode(sb);
>                 if (!inode)
>                         return NULL;
>
>                 fuse_init_inode(inode, attr, fc);
> -               get_fuse_inode(inode)->nodeid =3D nodeid;
> +               fi =3D get_fuse_inode(inode);
> +               fi->nodeid =3D nodeid;
> +               fi->submount_lookup =3D fuse_alloc_submount_lookup();
> +               if (!fi->submount_lookup) {
> +                       iput(inode);
> +                       return NULL;
> +               }
> +               /* Sets nlookup =3D 1 on fi->submount_lookup->nlookup */
> +               fuse_init_submount_lookup(fi->submount_lookup, nodeid);
>                 inode->i_flags |=3D S_AUTOMOUNT;
>                 goto done;
>         }
> @@ -423,11 +483,11 @@ struct inode *fuse_iget(struct super_block *sb, u64=
 nodeid,
>                 iput(inode);
>                 goto retry;
>         }
> -done:
>         fi =3D get_fuse_inode(inode);
>         spin_lock(&fi->lock);
>         fi->nlookup++;
>         spin_unlock(&fi->lock);
> +done:
>         fuse_change_attributes(inode, attr, NULL, attr_valid, attr_versio=
n);
>
>         return inode;
> @@ -1465,6 +1525,8 @@ static int fuse_fill_super_submount(struct super_bl=
ock *sb,
>         struct super_block *parent_sb =3D parent_fi->inode.i_sb;
>         struct fuse_attr root_attr;
>         struct inode *root;
> +       struct fuse_submount_lookup *sl;
> +       struct fuse_inode *fi;
>
>         fuse_sb_defaults(sb);
>         fm->sb =3D sb;
> @@ -1487,12 +1549,32 @@ static int fuse_fill_super_submount(struct super_=
block *sb,
>          * its nlookup should not be incremented.  fuse_iget() does
>          * that, though, so undo it here.
>          */
> -       get_fuse_inode(root)->nlookup--;
> +       fi =3D get_fuse_inode(root);
> +       fi->nlookup--;
> +
>         sb->s_d_op =3D &fuse_dentry_operations;
>         sb->s_root =3D d_make_root(root);
>         if (!sb->s_root)
>                 return -ENOMEM;
>
> +       /*
> +        * Grab the parent's submount_lookup pointer and take a
> +        * reference on the shared nlookup from the parent.  This is to
> +        * prevent the last forget for this nodeid from getting
> +        * triggered until all users have finished with it.
> +        */
> +       spin_lock(&parent_fi->lock);

Root has just been allocated, no locking needed.

> +       sl =3D parent_fi->submount_lookup;
> +       if (sl) {

WARN_ON(!sl);

Thanks,
Miklos


