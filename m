Return-Path: <linux-fsdevel+bounces-6312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C08158D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 12:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D4E286A71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 11:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA71640C;
	Sat, 16 Dec 2023 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWQLYDhC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6A156C1;
	Sat, 16 Dec 2023 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4274fd310c2so2279001cf.3;
        Sat, 16 Dec 2023 03:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702726708; x=1703331508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvDQywBG3iSiVHx6fxnFnxp56GYyoLy/fFame6/sSXk=;
        b=mWQLYDhCrW2S61Eyvv7bx2ZU/PlhamB9VRzBYwykCOzZKc3blL8xuR3Qn3aq1Hqg/4
         qnx1j5v5vib5nkGRIseIfWQbaDS+gz/u/lz18x2tBdgMqSx/PvHtHEGjYQQA8dRpMvKX
         s4hC0UtkSSePRuvBw7l4fxcZwbY/x3O/uRUFy2YBq176/O4R+8gb8kWTSTFdTF10DILI
         0BiI88FMDFAUjp367JnyDMhC6O+vCVWVumooOWOrCk5PTaVtoic19Vw7I/sTWSOOfl+J
         YEpy3YKL5z0xfWhUhQSgQNjNg65AnoWnGe1FwowL0aEN7KOgcwhSybdJ1uid4ICIsvJ9
         k2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702726708; x=1703331508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvDQywBG3iSiVHx6fxnFnxp56GYyoLy/fFame6/sSXk=;
        b=VHuGhqISUh0qsDJS7yzbWsoWOVFwdtivmDB+73xmWPnUu4mEk/z7yO3uTALHoVGHtX
         QqquLJSD9+DAZ7F2CQkLn4/dpH+trA1EhcdS/9Q1JyVWe0/nbVuiZWpQh9+p90IXGYMp
         8vmw6hAn034o7/fB5qN4GKhbrF0VFQjRZVg8BizRok8ZWXC4ly03CRxNusyIkLkG8VXM
         dtAHHO2qyLgGiiH/TvvgHwy/BMf8Zco0Yw0WzBtVVje1tXDyyTjE4faEzmdMzJb50H9D
         p2bTho2Q7s7pnPucbrjWbL5EHayUqPIFUfvoy+21uJc1ihautMpuVmCviqIe9nMwHBO8
         NHWQ==
X-Gm-Message-State: AOJu0Yx+cS46Kdqu3JLitYGvxZBZTvtqMHgH7IFgryYLKK+ruDCYy7ej
	QYZac8Vxs8I0xskwQwba9SAp+r5ZU3rLH+x/BA4=
X-Google-Smtp-Source: AGHT+IHzU7057piruttF92JxTOsEJ0TB2XkN5a+sFJCZa78u11DpA6HM8EAu2c+fTgDMyuR8qiqUm2038ueRPOHFGWg=
X-Received: by 2002:ac8:5d8d:0:b0:425:8b3b:ed63 with SMTP id
 d13-20020ac85d8d000000b004258b3bed63mr18347287qtx.132.1702726707865; Sat, 16
 Dec 2023 03:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxg-WvdcuCrQg7zp03ocNZoT-G2bpi=Y6nVxMTodyFAUbg@mail.gmail.com>
 <20231214220222.348101-1-vinicius.gomes@intel.com> <CAOQ4uxhJmjeSSM5iQyDadbj5UNjPqvh1QPLpSOVEYFbNbsjDQQ@mail.gmail.com>
 <87v88zp76v.fsf@intel.com> <CAOQ4uxiCVv7zbfn2BPrR9kh=DvGxQtXUmRvy2pDJ=G7rxjBrgg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiCVv7zbfn2BPrR9kh=DvGxQtXUmRvy2pDJ=G7rxjBrgg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 16 Dec 2023 13:38:16 +0200
Message-ID: <CAOQ4uxhxvFt3_Wb3BGcjj4pGp=OFTBHNPJ4r4eH8245t-+CW+g@mail.gmail.com>
Subject: Re: [RFC] HACK: overlayfs: Optimize overlay/restore creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: hu1.chen@intel.com, miklos@szeredi.hu, malini.bhandaru@intel.com, 
	tim.c.chen@intel.com, mikko.ylinen@intel.com, lizhen.you@intel.com, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 12:16=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Fri, Dec 15, 2023 at 10:00=E2=80=AFPM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
> >
> > Hi Amir,
> >
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> > > +fsdevel because this may be relevant to any subsystem that
> > > keeps a long live cred copy (e.g. nfsd, ksmbd, cachefiles).
> > >
> > > +linus who wrote
> > > d7852fbd0f04 access: avoid the RCU grace period for the temporary
> > > subjective credentials
> > >
> > >
> > > On Fri, Dec 15, 2023 at 12:02=E2=80=AFAM Vinicius Costa Gomes
> > > <vinicius.gomes@intel.com> wrote:
> > >>
> > >> Permission checks in overlayfs also check against the credentials
> > >> associated with the superblock, which are assigned at mount() time, =
so
> > >> pretty long lived. So, we can omit the reference counting for this
> > >> case.
> > >
> > > You forgot to mention WHY you are proposing this and to link to the
> > > original report with the first optimization attempt:
> > >
> > > https://lore.kernel.org/linux-unionfs/20231018074553.41333-1-hu1.chen=
@intel.com/
> > >
> >
> > I thought that the "in-reply-to" would do that, I should have been more
> > explicit on the context. Sorry.
> >
> > >>
> > >> This (very early) proof of concept does two things:
> > >>
> > >> Add a flag "immutable" (TODO: find a better name) to struct cred to
> > >> indicate that it is long lived, and that refcount can be omitted.
> > >>
> > >
> > > This reminds me of the many discussions about Rust abstractions
> > > that are going on right now.
> > > I think an abstraction like this one is called a "borrowed reference"=
.
> > >
> >
> > Yeah, very similar to a borrow in rust.
> >
> > >> Add "guard" helpers, so we can use automatic cleanup to be sure
> > >> override/restore are always paired. (I didn't like that I have
> > >> 'ovl_cred' to be a container for the credentials, but couldn't think
> > >> of other solutions)
> > >>
> > >
> > > I like the guard but see comments below...
> > >
> > >> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > >> ---
> > >> Hi Amir,
> > >>
> > >> Just to know if I am more or less on right track.
> > >>
> > >> This is a different attempt, instead of the local copy idea, I am
> > >> using the fact that the credentials associated with the mount() will
> > >> be alive for a long time. I think the result is almost the same. But=
 I
> > >> could be missing something.
> > >>
> > >> TODO:
> > >>  - Add asserts.
> > >>  - Replace ovl_override_creds()/revert_Creds() by
> > >>    ovl_creator_cred()/guard() everywhere.
> > >>  - Probably more.
> > >>
> > >>
> > >>  fs/overlayfs/inode.c     |  7 ++++---
> > >>  fs/overlayfs/overlayfs.h | 18 ++++++++++++++++++
> > >>  fs/overlayfs/params.c    |  4 +++-
> > >>  fs/overlayfs/super.c     | 10 +++++++---
> > >>  fs/overlayfs/util.c      | 10 ++++++++++
> > >>  include/linux/cred.h     | 12 ++++++++++--
> > >>  6 files changed, 52 insertions(+), 9 deletions(-)
> > >>
> > >> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> > >> index c63b31a460be..2c016a3bbe2d 100644
> > >> --- a/fs/overlayfs/inode.c
> > >> +++ b/fs/overlayfs/inode.c
> > >> @@ -290,9 +290,9 @@ int ovl_permission(struct mnt_idmap *idmap,
> > >>                    struct inode *inode, int mask)
> > >>  {
> > >>         struct inode *upperinode =3D ovl_inode_upper(inode);
> > >> +       struct ovl_cred ovl_cred;
> > >>         struct inode *realinode;
> > >>         struct path realpath;
> > >> -       const struct cred *old_cred;
> > >
> > > Nit: please don't reorder the variable definitions.
> > >
> >
> > Sorry about that. "bad" habits from the networking side :-)
> >
>
> I fully support all forms and shapes of OCD ;-)
>
> > >>         int err;
> > >>
> > >>         /* Careful in RCU walk mode */
> > >> @@ -310,7 +310,9 @@ int ovl_permission(struct mnt_idmap *idmap,
> > >>         if (err)
> > >>                 return err;
> > >>
> > >> -       old_cred =3D ovl_override_creds(inode->i_sb);
> > >> +       ovl_cred =3D ovl_creator_cred(inode->i_sb);
> > >> +       guard(ovl_creds)(&ovl_cred);
> > >> +
> > >>         if (!upperinode &&
> > >>             !special_file(realinode->i_mode) && mask & MAY_WRITE) {
> > >>                 mask &=3D ~(MAY_WRITE | MAY_APPEND);
> > >> @@ -318,7 +320,6 @@ int ovl_permission(struct mnt_idmap *idmap,
> > >>                 mask |=3D MAY_READ;
> > >>         }
> > >>         err =3D inode_permission(mnt_idmap(realpath.mnt), realinode,=
 mask);
> > >> -       revert_creds(old_cred);
> > >>
> > >>         return err;
> > >>  }
> > >> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > >> index 05c3dd597fa8..22ea3066376e 100644
> > >> --- a/fs/overlayfs/overlayfs.h
> > >> +++ b/fs/overlayfs/overlayfs.h
> > >> @@ -416,6 +416,24 @@ static inline int ovl_do_getattr(const struct p=
ath *path, struct kstat *stat,
> > >>         return vfs_getattr(path, stat, request_mask, flags);
> > >>  }
> > >>
> > >> +struct ovl_cred {
> > >> +       const struct cred *cred;
> > >> +};
> > >> +
> > >> +static inline struct ovl_cred ovl_creator_cred(struct super_block *=
sb)
> > >> +{
> > >> +       struct ovl_fs *ofs =3D OVL_FS(sb);
> > >> +
> > >> +       return (struct ovl_cred) { .cred =3D ofs->creator_cred };
> > >> +}
> > >> +
> > >> +void ovl_override_creds_new(struct ovl_cred *creator_cred);
> > >> +void ovl_revert_creds_new(struct ovl_cred *creator_cred);
> > >> +
> > >> +DEFINE_GUARD(ovl_creds, struct ovl_cred *,
> > >> +            ovl_override_creds_new(_T),
> > >> +            ovl_revert_creds_new(_T));
> > >> +
> > >
> > > This pattern is not unique to overlayfs.
> > > It is probably better to define a common container type struct overri=
de_cred
> > > in cred.h/cred.c that other code could also use.
> > >
> >
> > Good idea.
> >
> > >>  /* util.c */
> > >>  int ovl_get_write_access(struct dentry *dentry);
> > >>  void ovl_put_write_access(struct dentry *dentry);
> > >> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> > >> index 3fe2dde1598f..008377b9241a 100644
> > >> --- a/fs/overlayfs/params.c
> > >> +++ b/fs/overlayfs/params.c
> > >> @@ -770,8 +770,10 @@ void ovl_free_fs(struct ovl_fs *ofs)
> > >>         kfree(ofs->config.lowerdirs);
> > >>         kfree(ofs->config.upperdir);
> > >>         kfree(ofs->config.workdir);
> > >> -       if (ofs->creator_cred)
> > >> +       if (ofs->creator_cred) {
> > >> +               cred_set_immutable(ofs->creator_cred, false);
> > >>                 put_cred(ofs->creator_cred);
> > >
> > > Not happy about this API.
> > >
> > > Two solutions I can think of:
> > > 1. (my preference) keep two copies of creator_cred, one refcounted co=
py
> > >     and one non-refcounted that is used for override_creds()
> > > 2. put_cred_ref() which explicitly opts-in to dropping refcount on
> > >     a borrowed reference, same as you do above but hidden behind
> > >     a properly documented helper
> > >
> >
> > Probably because I already have option (2) more or less understood, but
> > I think that having a single creator_cred marked as
> > "non-refcounted/long-lived" is simpler than having two copies, even the
> > the extra copy only exists for the duration of the override.
> >
> > But it could be that I still can't imagine what you have in mind about
> > (1).
> >
>
> (1) is actually quite similar to your first proposal of copying creator_c=
red
> to a local stack variable.
> My only concern about this proposal was that the core code was not aware
> of the fact that it is working with an object that must not be freed.
> And this is where non_refcount comes in to help.
>
> With (2) prepare_creds_ref()/put_cred_ref() can be used to manage the
> lifetime of a long-lived cred object from the cred_jar memory pool.
>
> With (1) the caller is responsible to manage the lifetime of the non-refc=
ounted
> copy, for example, if the object lives on the stack.
>
> For overlayfs this could mean, either create a non-refcounted copy on the
> stack in every operator using ovl_creator_cred() helper as your first pro=
posal
> did, or keep another non-refcounted copy in ofs->override_cred, which get=
s
> allocated/freed by overlayfs (i.e. kmalloc/kfree).
>
> > >> +       }
> > >>         kfree(ofs);
> > >>  }
> > >>
> > >> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > >> index a0967bb25003..1ffb4f0f8186 100644
> > >> --- a/fs/overlayfs/super.c
> > >> +++ b/fs/overlayfs/super.c
> > >> @@ -1304,6 +1304,13 @@ int ovl_fill_super(struct super_block *sb, st=
ruct fs_context *fc)
> > >>         if (!cred)
> > >>                 goto out_err;
> > >>
> > >> +       /* Never override disk quota limits or use reserved space */
> > >> +       cap_lower(cred->cap_effective, CAP_SYS_RESOURCE);
> > >> +       /* The cred that is going to be associated with the super
> > >> +        * block will not change.
> > >> +        */
> > >> +       cred_set_immutable(cred, true);
> > >> +
> > >
> > > Likewise, either:
> > > 1. Create a non-refcounted copy of creator_cred
> >
> > Ah! I think now I see what you meant. Not sure I like, I think it's a
> > bit too error prone, it's hard to enforce that the copies would be kept
> > in sync in general. (even if in practice the only thing that would need
> > to be kept in sync is the destruction of both, at least for now).
> >
>
> I agree that it makes more sense to create the non-refcounted copy
> on the stack.
>
> As a matter of fact, maybe it makes sense to embed a non-refcounted
> copy in the struct used for the guard:
>
> struct override_cred {
>        struct cred copy;
>        const struct cred *cred;
> };
>
> Then override_cred_save() can create the non-refcounted copy:
>
> void override_cred_save(struct override_cred *override)
> {
>        override->copy =3D *override;
>        override->copy.non_refcount =3D 1;
>        override->cred =3D override_creds(&override->copy);
>        override->cred =3D override_creds(override->cred);

This second line is leftover of course...

> }
>
> > > or
> > > 2. Use a documented helper prepare_creds_ref() to hide
> > >     this implementation detail
> >
> > This I like more, having the properties documented in the constructor.
> > And much better than my _set_immutable().
> >
>
> Yes, the important thing is that an object cannot change
> its non_refcount property during its lifetime -

... which means that put_creds_ref() should assert that
there is only a single refcount - the one handed out by
prepare_creds_ref() before removing non_refcount or
directly freeing the cred object.

I must say that the semantics of making a non-refcounted copy
to an object whose lifetime is managed by the caller sounds a lot
less confusing to me.

Thanks,
Amir.

