Return-Path: <linux-fsdevel+bounces-4240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99CC7FDF85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 19:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60BDDB20BB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3535DF0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WDPrYOYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AF0BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 09:22:31 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5cc5988f85eso71986137b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 09:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701278551; x=1701883351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6aGKVyADURyhQk+fo0tbqTCzCtcxOwFDTETgVpc3MM=;
        b=WDPrYOYnkqi+n2W3RwfrDcHeKLTZlPLJKhkfH1akgQLLjgVH1jB0lhsAqDbpBjTYiS
         Ro4RZqxKKaIaS//8aW6iyNPyRlYfWgfz8TWxj1+qmw3YLcm2bdo/jHRZbGf8BE9Ss1RO
         PE4hldwxsQj/EbABvr4zKh8z7vc+uWf8TvhrNavzGClykSz4Kg2vBUYD6A1jAoj7n6Z2
         WxOkavvMcgEZyr3Hp+IPDQ2GtvPXJz82f3KhJExppw84IJ7JTFcxPxe+hthTRB4kdAVu
         mvEBOyGF4rBeVLp/LpUKODlBNSOZnZIG1ndn0rHXlLtLLOJYzgBsy4Hy39Y66KYHj3//
         aNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701278551; x=1701883351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6aGKVyADURyhQk+fo0tbqTCzCtcxOwFDTETgVpc3MM=;
        b=YQwwA+1MlQiIh+HDPK2CzQig6gE4PpkiViMy5/teahJygWov8qD38hCE4SSGmA4mMZ
         2c4m6xWpqCxxX7C8UQAjPNiGOnyrBU5Lqom29S2qIq4pL+1dmArFrTdCzoojI2j4dTI8
         Zlmbbgg1O3t/pxDpWhDMUFIZflClzxnBmgFupUd7Pfilp66eSK/PkMztt9IhnlL+Erpb
         Wo3UVusCSM+9GM9FOCYhDf9KLBRxN1CJuN/3r/jSo7J7WhWc2vqw4pNrIGDWLP11Liqr
         GY27n8Zu5k7yywDdoX3SGqdSDuJPQ8Bdwvn41JJDYAfS8QbZHIlR/xvQc8HVUqP2wCKJ
         w4Aw==
X-Gm-Message-State: AOJu0Yz0LOfm0akP5ZuptQ7bD91B04MrU+3el5QuSW8BtRT2kaM8z2bi
	7Sg69D4AXAJ71Xkb48C5laVA2w10F2GGjVJb8aJj
X-Google-Smtp-Source: AGHT+IHGRmmx7GBTM1/MZTu0EoNq8zyar5kzldOIFNMC0/+UTXv0mixyo55ycDf8ErfmEbeGIOB34bucSYDQTv2Fe9k=
X-Received: by 2002:a25:ac5:0:b0:dae:4b98:16f9 with SMTP id
 188-20020a250ac5000000b00dae4b9816f9mr19710138ybk.0.1701278550968; Wed, 29
 Nov 2023 09:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com> <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com> <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
In-Reply-To: <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Nov 2023 12:22:19 -0500
Message-ID: <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, 
	mic@digikod.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 7:28=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Mon, 2023-11-20 at 16:06 -0500, Paul Moore wrote:
> > On Mon, Nov 20, 2023 at 3:16=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Fri, 2023-11-17 at 15:57 -0500, Paul Moore wrote:
> > > > On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote=
:
> > > > >
> > > > > Before the security field of kernel objects could be shared among=
 LSMs with
> > > > > the LSM stacking feature, IMA and EVM had to rely on an alternati=
ve storage
> > > > > of inode metadata. The association between inode metadata and ino=
de is
> > > > > maintained through an rbtree.
> > > > >
> > > > > Because of this alternative storage mechanism, there was no need =
to use
> > > > > disjoint inode metadata, so IMA and EVM today still share them.
> > > > >
> > > > > With the reservation mechanism offered by the LSM infrastructure,=
 the
> > > > > rbtree is no longer necessary, as each LSM could reserve a space =
in the
> > > > > security blob for each inode. However, since IMA and EVM share th=
e
> > > > > inode metadata, they cannot directly reserve the space for them.
> > > > >
> > > > > Instead, request from the 'integrity' LSM a space in the security=
 blob for
> > > > > the pointer of inode metadata (integrity_iint_cache structure). T=
he other
> > > > > reason for keeping the 'integrity' LSM is to preserve the origina=
l ordering
> > > > > of IMA and EVM functions as when they were hardcoded.
> > > > >
> > > > > Prefer reserving space for a pointer to allocating the integrity_=
iint_cache
> > > > > structure directly, as IMA would require it only for a subset of =
inodes.
> > > > > Always allocating it would cause a waste of memory.
> > > > >
> > > > > Introduce two primitives for getting and setting the pointer of
> > > > > integrity_iint_cache in the security blob, respectively
> > > > > integrity_inode_get_iint() and integrity_inode_set_iint(). This w=
ould make
> > > > > the code more understandable, as they directly replace rbtree ope=
rations.
> > > > >
> > > > > Locking is not needed, as access to inode metadata is not shared,=
 it is per
> > > > > inode.
> > > > >
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > ---
> > > > >  security/integrity/iint.c      | 71 +++++-----------------------=
------
> > > > >  security/integrity/integrity.h | 20 +++++++++-
> > > > >  2 files changed, 29 insertions(+), 62 deletions(-)
> > > > >
> > > > > diff --git a/security/integrity/iint.c b/security/integrity/iint.=
c
> > > > > index 882fde2a2607..a5edd3c70784 100644
> > > > > --- a/security/integrity/iint.c
> > > > > +++ b/security/integrity/iint.c
> > > > > @@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
> > > > >     return 0;
> > > > >  }
> > > > >
> > > > > +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init =3D {
> > > > > +   .lbs_inode =3D sizeof(struct integrity_iint_cache *),
> > > > > +};
> > > >
> > > > I'll admit that I'm likely missing an important detail, but is ther=
e
> > > > a reason why you couldn't stash the integrity_iint_cache struct
> > > > directly in the inode's security blob instead of the pointer?  For
> > > > example:
> > > >
> > > >   struct lsm_blob_sizes ... =3D {
> > > >     .lbs_inode =3D sizeof(struct integrity_iint_cache),
> > > >   };
> > > >
> > > >   struct integrity_iint_cache *integrity_inode_get(inode)
> > > >   {
> > > >     if (unlikely(!inode->isecurity))
> > > >       return NULL;
> > > >     return inode->i_security + integrity_blob_sizes.lbs_inode;
> > > >   }
> > >
> > > It would increase memory occupation. Sometimes the IMA policy
> > > encompasses a small subset of the inodes. Allocating the full
> > > integrity_iint_cache would be a waste of memory, I guess?
> >
> > Perhaps, but if it allows us to remove another layer of dynamic memory
> > I would argue that it may be worth the cost.  It's also worth
> > considering the size of integrity_iint_cache, while it isn't small, it
> > isn't exactly huge either.
> >
> > > On the other hand... (did not think fully about that) if we embed the
> > > full structure in the security blob, we already have a mutex availabl=
e
> > > to use, and we don't need to take the inode lock (?).
> >
> > That would be excellent, getting rid of a layer of locking would be sig=
nificant.
> >
> > > I'm fully convinced that we can improve the implementation
> > > significantly. I just was really hoping to go step by step and not
> > > accumulating improvements as dependency for moving IMA and EVM to the
> > > LSM infrastructure.
> >
> > I understand, and I agree that an iterative approach is a good idea, I
> > just want to make sure we keep things tidy from a user perspective,
> > i.e. not exposing the "integrity" LSM when it isn't required.
>
> Ok, I went back to it again.
>
> I think trying to separate integrity metadata is premature now, too
> many things at the same time.

I'm not bothered by the size of the patchset, it is more important
that we do The Right Thing.  I would like to hear in more detail why
you don't think this will work, I'm not interested in hearing about
difficult it may be, I'm interested in hearing about what challenges
we need to solve to do this properly.

> I started to think, does EVM really need integrity metadata or it can
> work without?
>
> The fact is that CONFIG_IMA=3Dn and CONFIG_EVM=3Dy is allowed, so we have
> the same problem now. What if we make IMA the one that manages
> integrity metadata, so that we can remove the 'integrity' LSM?

I guess we should probably revisit the basic idea of if it even makes
sense to enable EVM without IMA?  Should we update the Kconfig to
require IMA when EVM is enabled?

> Regarding the LSM order, I would take Casey's suggestion of introducing
> LSM_ORDER_REALLY_LAST, for EVM.

Please understand that I really dislike that we have imposed ordering
constraints at the LSM layer, but I do understand the necessity (the
BPF LSM ordering upsets me the most).  I really don't want to see us
make things worse by adding yet another ordering bucket, I would
rather that we document it well and leave it alone ... basically treat
it like the BPF LSM (grrrrrr).

--=20
paul-moore.com

