Return-Path: <linux-fsdevel+bounces-4443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF067FF683
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B97281696
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B059655779
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PZ5jLWuT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97CDD50
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:34:27 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d3aafa1342so4383707b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701362067; x=1701966867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtFno+LwQ2GzDnhBeUDiSKJsjmjd4ts8+ULAaW82MMY=;
        b=PZ5jLWuTODNkPYXVwRoLdgCgs1RiXX0CB+ozc2Zis6xwGi6Avw+oKhPD/zvoxOU5CT
         InOMJrWqPHMWGf9AyKnk822BxpH77SdKVepUZQilsxzmIKeKLKusqgZRBHlB9pwdahCc
         FcwGgvoVMSl172uYRwCmkufUZl1E4tzH2rQbVzH9gHcv3+pNlSczMmFsY+2JnCyZHwkR
         3VK14HibDOdwrVgkvSQ9cytJ+mmOziLMMT5tm/recPgdqTWot++t6Qocds1dstZA0I9F
         0XVm+tV13w6Uq87Lx6N0Prfq85+SVpBM38edUKIdMlPsNxJGTCxR2kUbvqPjL7Iixn46
         2RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701362067; x=1701966867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtFno+LwQ2GzDnhBeUDiSKJsjmjd4ts8+ULAaW82MMY=;
        b=esn40V0LlHWNU/sQqISDI/9rQd20TDmvcWN9xPDTM8n1r+bQpmJcav8dzTQgKgYCNA
         swXF6CjQHhJ3WbUFlaL4MXRbzDLd5i7aIeuOUFbeafgSP1rfFcfs7xIJcoYuam6guaQa
         3WRfKlj43P4sha0Xz6AhobVzQ7i5VJ4M7Gr5CWkCOyXyiOaOM3oKNBTZ/BlKc2XCxOfN
         CGI6QKAQ4UG2RyVuTToy0IVrMK0FgEosO1gBY+KMfCojFTsNRAx96CfIAmhGU/jyTRSg
         5s66Uz4YZc0N/FvIYEkJr/kpvkDs4O1ZlNAvtz8M+ryhUOX61qQactBtzuRJ5L8ObE0l
         SdYA==
X-Gm-Message-State: AOJu0Yw54j6gEdcX4x++dKk2OgFAw9fLHY/WPYgYWsGbRZ6zs+TpBoyN
	pAHSd3BIahtugLOTwz75nD7LvOYb6jBAWIYQ1c1R
X-Google-Smtp-Source: AGHT+IHeHdpK2ZUS6oWXFVUCJZ09doGArKmA7HaDqW1eGm3Lnoqt9TFrtxWh2usWvQXHN2dvVLQzpflDEM/jaG+E5BI=
X-Received: by 2002:a25:8d0b:0:b0:da0:cbff:4e20 with SMTP id
 n11-20020a258d0b000000b00da0cbff4e20mr20087394ybl.56.1701362066812; Thu, 30
 Nov 2023 08:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com> <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
 <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
 <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com> <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
In-Reply-To: <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 30 Nov 2023 11:34:16 -0500
Message-ID: <CAHC9VhROnfBoaOy2MurdSpcE_poo_6Qy9d2U3g6m2NRRHaqz4Q@mail.gmail.com>
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

On Wed, Nov 29, 2023 at 1:47=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On 11/29/2023 6:22 PM, Paul Moore wrote:
> > On Wed, Nov 29, 2023 at 7:28=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> >>
> >> On Mon, 2023-11-20 at 16:06 -0500, Paul Moore wrote:
> >>> On Mon, Nov 20, 2023 at 3:16=E2=80=AFAM Roberto Sassu
> >>> <roberto.sassu@huaweicloud.com> wrote:
> >>>> On Fri, 2023-11-17 at 15:57 -0500, Paul Moore wrote:
> >>>>> On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote=
:
> >>>>>>
> >>>>>> Before the security field of kernel objects could be shared among =
LSMs with
> >>>>>> the LSM stacking feature, IMA and EVM had to rely on an alternativ=
e storage
> >>>>>> of inode metadata. The association between inode metadata and inod=
e is
> >>>>>> maintained through an rbtree.
> >>>>>>
> >>>>>> Because of this alternative storage mechanism, there was no need t=
o use
> >>>>>> disjoint inode metadata, so IMA and EVM today still share them.
> >>>>>>
> >>>>>> With the reservation mechanism offered by the LSM infrastructure, =
the
> >>>>>> rbtree is no longer necessary, as each LSM could reserve a space i=
n the
> >>>>>> security blob for each inode. However, since IMA and EVM share the
> >>>>>> inode metadata, they cannot directly reserve the space for them.
> >>>>>>
> >>>>>> Instead, request from the 'integrity' LSM a space in the security =
blob for
> >>>>>> the pointer of inode metadata (integrity_iint_cache structure). Th=
e other
> >>>>>> reason for keeping the 'integrity' LSM is to preserve the original=
 ordering
> >>>>>> of IMA and EVM functions as when they were hardcoded.
> >>>>>>
> >>>>>> Prefer reserving space for a pointer to allocating the integrity_i=
int_cache
> >>>>>> structure directly, as IMA would require it only for a subset of i=
nodes.
> >>>>>> Always allocating it would cause a waste of memory.
> >>>>>>
> >>>>>> Introduce two primitives for getting and setting the pointer of
> >>>>>> integrity_iint_cache in the security blob, respectively
> >>>>>> integrity_inode_get_iint() and integrity_inode_set_iint(). This wo=
uld make
> >>>>>> the code more understandable, as they directly replace rbtree oper=
ations.
> >>>>>>
> >>>>>> Locking is not needed, as access to inode metadata is not shared, =
it is per
> >>>>>> inode.
> >>>>>>
> >>>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> >>>>>> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> >>>>>> ---
> >>>>>>   security/integrity/iint.c      | 71 +++++-----------------------=
------
> >>>>>>   security/integrity/integrity.h | 20 +++++++++-
> >>>>>>   2 files changed, 29 insertions(+), 62 deletions(-)
> >>>>>>
> >>>>>> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> >>>>>> index 882fde2a2607..a5edd3c70784 100644
> >>>>>> --- a/security/integrity/iint.c
> >>>>>> +++ b/security/integrity/iint.c
> >>>>>> @@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
> >>>>>>      return 0;
> >>>>>>   }
> >>>>>>
> >>>>>> +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init =3D {
> >>>>>> +   .lbs_inode =3D sizeof(struct integrity_iint_cache *),
> >>>>>> +};
> >>>>>
> >>>>> I'll admit that I'm likely missing an important detail, but is ther=
e
> >>>>> a reason why you couldn't stash the integrity_iint_cache struct
> >>>>> directly in the inode's security blob instead of the pointer?  For
> >>>>> example:
> >>>>>
> >>>>>    struct lsm_blob_sizes ... =3D {
> >>>>>      .lbs_inode =3D sizeof(struct integrity_iint_cache),
> >>>>>    };
> >>>>>
> >>>>>    struct integrity_iint_cache *integrity_inode_get(inode)
> >>>>>    {
> >>>>>      if (unlikely(!inode->isecurity))
> >>>>>        return NULL;
> >>>>>      return inode->i_security + integrity_blob_sizes.lbs_inode;
> >>>>>    }
> >>>>
> >>>> It would increase memory occupation. Sometimes the IMA policy
> >>>> encompasses a small subset of the inodes. Allocating the full
> >>>> integrity_iint_cache would be a waste of memory, I guess?
> >>>
> >>> Perhaps, but if it allows us to remove another layer of dynamic memor=
y
> >>> I would argue that it may be worth the cost.  It's also worth
> >>> considering the size of integrity_iint_cache, while it isn't small, i=
t
> >>> isn't exactly huge either.
> >>>
> >>>> On the other hand... (did not think fully about that) if we embed th=
e
> >>>> full structure in the security blob, we already have a mutex availab=
le
> >>>> to use, and we don't need to take the inode lock (?).
> >>>
> >>> That would be excellent, getting rid of a layer of locking would be s=
ignificant.
> >>>
> >>>> I'm fully convinced that we can improve the implementation
> >>>> significantly. I just was really hoping to go step by step and not
> >>>> accumulating improvements as dependency for moving IMA and EVM to th=
e
> >>>> LSM infrastructure.
> >>>
> >>> I understand, and I agree that an iterative approach is a good idea, =
I
> >>> just want to make sure we keep things tidy from a user perspective,
> >>> i.e. not exposing the "integrity" LSM when it isn't required.
> >>
> >> Ok, I went back to it again.
> >>
> >> I think trying to separate integrity metadata is premature now, too
> >> many things at the same time.
> >
> > I'm not bothered by the size of the patchset, it is more important
> > that we do The Right Thing.  I would like to hear in more detail why
> > you don't think this will work, I'm not interested in hearing about
> > difficult it may be, I'm interested in hearing about what challenges
> > we need to solve to do this properly.
>
> The right thing in my opinion is to achieve the goal with the minimal
> set of changes, in the most intuitive way.

Once again, I want to stress that I don't care about the size of the
change, the number of patches in a patchset, etc.  While it's always
nice to be able to minimize the number of changes in a patch/patchset,
that is secondary to making sure we are doing the right thing over the
long term.  This is especially important when we are talking about
things that are user visible.

> Until now, there was no solution that could achieve the primary goal of
> this patch set (moving IMA and EVM to the LSM infrastructure) and, at
> the same time, achieve the additional goal you set of removing the
> 'integrity' LSM.

We need to stop thinking about the "integrity" code as a LSM, it isn't
a LSM.  It's a vestigial implementation detail that was necessary back
when there could only be one LSM active at a time and there was a
desire to have IMA/EVM active in conjunction with one of the LSMs,
i.e. Smack, SELinux, etc.

IMA and EVM are (or will be) LSMs, "integrity" is not.  I recognize
that eliminating the need for the "integrity" code is a relatively new
addition to this effort, but that is only because I didn't properly
understand the relationship between IMA, EVM, and the "integrity" code
until recently.  The elimination of the shared "integrity" code is
consistent with promoting IMA and EVM as full LSMs, if there is core
functionality that cannot be split up into the IMA and/or EVM LSMs
then we need to look at how to support that without exposing that
implementation detail/hack to userspace.  Maybe that means direct
calls between IMA and EVM, maybe that means preserving some of the
common integrity code hidden from userspace, maybe that means adding
functionality to the LSM layer, maybe that means something else?
Let's think on this to come up with something that we can all accept
as a long term solution instead of just doing the quick and easy
option.

> If you see the diff, the changes compared to v5 that was already
> accepted by Mimi are very straightforward. If the assumption I made that
> in the end the 'ima' LSM could take over the role of the 'integrity'
> LSM, that for me is the preferable option.

I looked at it quickly, but my workflow isn't well suited for patches
as attachments; inline patches (the kernel standard) is preferable.

> Given that the patch set is not doing any design change, but merely
> moving calls and storing pointers elsewhere, that leaves us with the
> option of thinking better what to do next, including like you suggested
> to make IMA and EVM use disjoint metadata.
>
> >> I started to think, does EVM really need integrity metadata or it can
> >> work without?
> >>
> >> The fact is that CONFIG_IMA=3Dn and CONFIG_EVM=3Dy is allowed, so we h=
ave
> >> the same problem now. What if we make IMA the one that manages
> >> integrity metadata, so that we can remove the 'integrity' LSM?
> >
> > I guess we should probably revisit the basic idea of if it even makes
> > sense to enable EVM without IMA?  Should we update the Kconfig to
> > require IMA when EVM is enabled?
>
> That would be up to Mimi. Also this does not seem the main focus of the
> patch set.

Yes, it is not part of the original main focus, but it is definitely
relevant to the discussion we are having now.  Once again, the most
important thing to me is that we do The Right Thing for the long term
maintenance of the code base; if that means scope creep, I've got no
problem with that.

> >> Regarding the LSM order, I would take Casey's suggestion of introducin=
g
> >> LSM_ORDER_REALLY_LAST, for EVM.
> >
> > Please understand that I really dislike that we have imposed ordering
> > constraints at the LSM layer, but I do understand the necessity (the
> > BPF LSM ordering upsets me the most).  I really don't want to see us
> > make things worse by adding yet another ordering bucket, I would
> > rather that we document it well and leave it alone ... basically treat
> > it like the BPF LSM (grrrrrr).
>
> Uhm, that would not be possible right away (the BPF LSM is mutable),
> remember that we defined LSM_ORDER_LAST so that an LSM can be always
> enable and placed as last (requested by Mimi)?

To be clear, I can both dislike the bpf-always-last and LSM_ORDER_LAST
concepts while accepting them as necessary evils.  I'm willing to
tolerate LSM_ORDER_LAST, but I'm not currently willing to tolerate
LSM_ORDER_REALLY_LAST; that is one step too far right now.  I brought
up the BPF LSM simply as an example of ordering that is not enforced
by code, but rather by documentation and convention.

--=20
paul-moore.com

