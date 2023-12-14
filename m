Return-Path: <linux-fsdevel+bounces-6081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB4C81341A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 16:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E736CB21A0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECB15C096;
	Thu, 14 Dec 2023 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHtXEUb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1B8115;
	Thu, 14 Dec 2023 07:09:33 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67f040e6722so5865496d6.3;
        Thu, 14 Dec 2023 07:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702566572; x=1703171372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QioPHNhyswGCrfZOs48a2Y+ij3RU3CFU1FCJtG9OFF0=;
        b=UHtXEUb77xPRGKNGRFc2Dw7wex6ag8RwY2q1sfnvQD94GYIGAaoB2BPUOebQR+eQ9I
         S48/HT8//Qj/oG8ZEBkm+Jv5Lxbd1ByUcqlrvPsPcDJOXha4LULK7Fi6nxH3th49CDxv
         n8IccrI5ebbAdM2EN8CoE9mOwR40ibbBza4Orda5ge957haf1w39li9RZgC50WoTzb1q
         xVDfsFmbY/SHP7shRlt1oM2VxEbnPqPwy1fHkW15eE+vsWjiN5OjV8yXjJhwx7Qr19LA
         5xZHvlXFRYD/fJFHVmK9nI6J5HtIVorPnbctaK0iyZvg0Nzj4qvdfVQnM1a0HtXXTqUO
         pkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702566572; x=1703171372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QioPHNhyswGCrfZOs48a2Y+ij3RU3CFU1FCJtG9OFF0=;
        b=jGxyitEZE4e9SSvPrv5JaFv591pK/wTISnkjNv8c429tBkLT4ceNU/GHCMuRtYpbgb
         nK4QWk71UqBUFKI5zT8ZehOD3DbVV18Vzs50JJ0NMd0Ibb5+0J4Q9XuHaj8R3Fd9tO27
         3VNljnM3ht64oHQB4bEDESwYsSh3EhIjo/FjWZcoKZlREA9+qSiJBYNv6stvtLtpvSU2
         RaJkwJ7HF9ax6Bosv+UcQUK8hM0e620r5KaShqTT940Q4dUn/NrFu/sisFjzFuSYlumj
         9MGOMmuQDJu4dfNl09uK12n32vbyzdByEntv9ZvvObD80QZO1p/GoUMegtNuRlgCNCWY
         uspQ==
X-Gm-Message-State: AOJu0YzJrdcsK4xg6qUB57YI2hpvTxdqQzHJ6Vo71pFar5zyBgl0mzyX
	C8bA0DIZEa95S0saovK0/NUyd2lZ9e/T+dj0HNA=
X-Google-Smtp-Source: AGHT+IG0QombIrAY9BThfvUvOVm6Fm4BoFGUhD3QIf70IFvWOunNpgS397dlAhZ9H08NmK0i/bU4nKaeu57i5D2GEt4=
X-Received: by 2002:a05:6214:4109:b0:67a:afde:823 with SMTP id
 kc9-20020a056214410900b0067aafde0823mr8218510qvb.41.1702566572468; Thu, 14
 Dec 2023 07:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner> <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
 <20231211-fortziehen-basen-b8c0639044b8@brauner> <019f134a-6ab4-48ca-991c-5a5c94e042ea@huaweicloud.com>
 <CAOQ4uxgpNt7qKEF_NEJPsKU7-XhM7N_3eP68FrOpMpcRcHt4rQ@mail.gmail.com>
 <59bf3530-2a6e-4caa-ac42-4d0dab9a71d1@huaweicloud.com> <a9297cc1bf23e34aba3c7597681e9e71a03b37f9.camel@linux.ibm.com>
 <d6b43b5780770637a724d129c22d5212860f494a.camel@huaweicloud.com>
In-Reply-To: <d6b43b5780770637a724d129c22d5212860f494a.camel@huaweicloud.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Dec 2023 17:09:20 +0200
Message-ID: <CAOQ4uxhwHgj-bE7N5SNcRZfnVHn9yCdY_=LFuOxEBkVBbrZKiw@mail.gmail.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to security.evm_overlayfs
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, miklos@szeredi.hu, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul@paul-moore.com, stefanb@linux.ibm.com, 
	jlayton@kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Eric Snowberg <eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 3:43=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2023-12-12 at 10:27 -0500, Mimi Zohar wrote:
> > On Tue, 2023-12-12 at 14:13 +0100, Roberto Sassu wrote:
> > > On 12.12.23 11:44, Amir Goldstein wrote:
> > > > On Tue, Dec 12, 2023 at 12:25=E2=80=AFPM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > >
> > > > > On 11.12.23 19:01, Christian Brauner wrote:
> > > > > > > The second problem is that one security.evm is not enough. We=
 need two,
> > > > > > > to store the two different HMACs. And we need both at the sam=
e time,
> > > > > > > since when overlayfs is mounted the lower/upper directories c=
an be
> > > > > > > still accessible.
> > > > > >
> > > > > > "Changes to the underlying filesystems while part of a mounted =
overlay
> > > > > > filesystem are not allowed. If the underlying filesystem is cha=
nged, the
> > > > > > behavior of the overlay is undefined, though it will not result=
 in a
> > > > > > crash or deadlock."
> > > > > >
> > > > > > https://docs.kernel.org/filesystems/overlayfs.html#changes-to-u=
nderlying-filesystems
> > > > > >
> > > > > > So I don't know why this would be a problem.
> > > > >
> > > > > + Eric Snowberg
> > > > >
> > > > > Ok, that would reduce the surface of attack. However, when lookin=
g at:
> > > > >
> > > > >        ovl: Always reevaluate the file signature for IMA
> > > > >
> > > > >        Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get th=
e
> > > > > i_version")
> > > > >        partially closed an IMA integrity issue when directly modi=
fying a file
> > > > >        on the lower filesystem.  If the overlay file is first ope=
ned by a
> > > > > user
> > > > >        and later the lower backing file is modified by root, but =
the extended
> > > > >        attribute is NOT updated, the signature validation succeed=
s with
> > > > > the old
> > > > >        original signature.
> > > > >
> > > > > Ok, so if the behavior of overlayfs is undefined if the lower bac=
king
> > > > > file is modified by root, do we need to reevaluate? Or instead wo=
uld be
> > > > > better to forbid the write from IMA (legitimate, I think, since t=
he
> > > > > behavior is documented)? I just saw that we have d_real_inode(), =
we can
> > > > > use it to determine if the write should be denied.
> > > > >
> > > >
> > > > There may be several possible legitimate actions in this case, but =
the
> > > > overall concept IMO should be the same as I said about EVM -
> > > > overlayfs does not need an IMA signature of its own, because it
> > > > can use the IMA signature of the underlying file.
> > > >
> > > > Whether overlayfs reads a file from lower fs or upper fs, it does n=
ot
> > > > matter, the only thing that matters is that the underlying file con=
tent
> > > > is attested when needed.
> > > >
> > > > The only incident that requires special attention is copy-up.
> > > > This is what the security hooks security_inode_copy_up() and
> > > > security_inode_copy_up_xattr() are for.
> > > >
> > > > When a file starts in state "lower" and has security.ima,evm xattrs
> > > > then before a user changes the file, it is copied up to upper fs
> > > > and suppose that security.ima,evm xattrs are copied as is?
> >
> > For IMA copying up security.ima is fine.  Other than EVM portable
> > signatures, security.evm contains filesystem specific metadata.
> > Copying security.evm up only works if the metadata is the same on both
> > filesystems.  Currently the i_generation and i_sb->s_uuid are
> > different.
> >
> > > > When later the overlayfs file content is read from the upper copy
> > > > the security.ima signature should be enough to attest that file con=
tent
> > > > was not tampered with between going from "lower" to "upper".
> > > >
> > > > security.evm may need to be fixed on copy up, but that should be
> > > > easy to do with the security_inode_copy_up_xattr() hook. No?
> >
> > Writing security.evm requires the existing security.evm to be valid.
> > After each security xattr in the protected list is modified,
> > security.evm HMAC needs to be updated.  Perhaps calculating and writing
> > security.evm could be triggered by security_inode_copy_up_xattr().
> > Just copying a non-portable EVM signature wouldn't work, or for that
> > matter copying an EVM HMAC with different filesystem metadata.
>
> There is another problem, when delayed copy is used. The content comes
> from one source, metadata from another.
>
> I initially created test-file-lower on the lower directory
> (overlayfs/data), before mounting overlayfs. After mount on
> overlayfs/mnt:
>
> # getfattr -m - -e hex -d overlayfs/mnt/test-file-lower
> # file: overlayfs/mnt/test-file-lower
> security.evm=3D0x02c86ec91a4c0cf024537fd24347b780b90973402e
> security.ima=3D0x0404f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da=
52e6ccc26fd2
> security.selinux=3D0x73797374656d5f753a6f626a6563745f723a756e6c6162656c65=
645f743a733000
>
> # chcon -t unconfined_t overlayfs/mnt/test-file-lower
>
> After this, IMA creates an empty file in the upper directory
> (overlayfs/root/data), and writes security.ima at file close.
> Unfortunately, this is what is presented from overlayfs, which is not
> in sync with the content.
>
> # getfattr -m - -e hex -d overlayfs/mnt/test-file-lower
> # file: overlayfs/mnt/test-file-lower
> security.evm=3D0x021d71e7df78c36745e3b651ce29cb9f47dc301248
> security.ima=3D0x04048855508aade16ec573d21e6a485dfd0a7624085c1a14b5ecdd64=
85de0c6839a4
> security.selinux=3D0x73797374656d5f753a6f626a6563745f723a756e636f6e66696e=
65645f743a733000
>
> # sha256sum overlayfs/mnt/test-file-lower
> f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2  overlay=
fs/mnt/test-file-lower
>
> # sha256sum overlayfs/root/data/test-file-lower
> 8855508aade16ec573d21e6a485dfd0a7624085c1a14b5ecdd6485de0c6839a4  overlay=
fs/root/data/test-file-lower (upperdir)
>
> We would need to use the lower security.ima until the copy is made, but
> at the same time we need to keep the upper valid (with all xattrs) so
> that IMA can update the next time overlayfs requests that.
>

Yap.

As Seth wrote, overlayfs is a combination of upper and lower.
The information that IMA needs should be accessible from either lower
or upper, but sometimes we will need to make the right choice.

The case of security.ima is similar to that of st_blocks -
it is a data-related metadata, so it needs to be taken from the lowerdata i=
node
(not even the lower inode). See example of getting STATX_BLOCKS
in ovl_getattr().

I would accept a patch that special cases security.ima in ovl_xattr_get()
and gets it from ovl_i_path_lowerdata(), which would need to be
factored out of ovl_path_lowerdata().

I would also accept filtering out security.{ima,evm} from

But I would only accept it if I know that IMA is not trying to write the
security.ima xattr when closing an overlayfs file, only when closing the
real underlying upper file.

I would also expect IMA to filter out security.{ima,evm} xattrs in
security_inode_copy_up_xattr() (i.e. return 1).
and most importantly, a documentation of the model of IMA/EVM
and overlayfs.

Thanks,
Amir.

