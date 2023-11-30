Return-Path: <linux-fsdevel+bounces-4481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EF97FF9F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEBD28180C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF905917F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VClaQUPo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A952D10EA;
	Thu, 30 Nov 2023 10:35:59 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1882023bbfso140719566b.3;
        Thu, 30 Nov 2023 10:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701369358; x=1701974158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0ZuOjmtVHlX0ubp6onvOS4SnKgdwsygvRAPYLPj5Bk=;
        b=VClaQUPoMm3HrD4O9OjZ+GMdSY65hI0RPDnB5/uv2AJdZ/K6dEpNsbvDkEnJwrdMzx
         R/ZwthoENl1ma5LsRAxS1WZqN3PO1VsQjMJv6PWlXaln02sFFxSE+TYg12k4vbCW5QfL
         VVbfwRBaJ6BNkH6rEz52xtxgrFeFQ9JE+CaVBhG8JLJXDGmUL4fASFTh/WzPvnns9SQw
         dRRlEpGVQYwFawRsaXAlZzkXmkxfUfwzRjwPfp307i/6ucwYwrHFBFt6iFyA+uyA2yTN
         y6LmeJkY8e/tKMFw9BzC8t9ULdg3/KzmFobXz/IwUqcr3gU65Ad//sSN/dva0awB0b8T
         wuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701369358; x=1701974158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0ZuOjmtVHlX0ubp6onvOS4SnKgdwsygvRAPYLPj5Bk=;
        b=J8T3Nf9BrFM18dYiBj8jwGnX8Det9o5kFjeF3Qib14gPowNq7lOE5TdjwGVqpalh48
         Ip1DB0R4ZaIyV3DJeCHQyeBHPuceoHuqwXRnIZszQZaCNQX2tWrOqhqCG8trZs/8M00x
         gnbKqb2Myj5PfgpMXEb3EPHRRUthtkQRdukB7FtRY2PgMqFoCSJGTq+lNro160cM2Fq9
         EUYscLLmdT54vDv1kWPY5BpwXoSkTqdjq8p1bcGRDcQAl00b21NManBgVNXXaG8wdnFu
         GQm4AdDC1mFdJN8qz9cct1ZLRoAXDJrMv5gK11cpYecGpKt/eM4rkIjB5nBlt2LbzSzE
         q7Mg==
X-Gm-Message-State: AOJu0Yyn4vnnqDZcny2qgTENq8G9lhqHC8jG0kxX78Lvw4W4+VwMSXoN
	lLbVO9kk0s3QPGIJQCZnEQZQ07ESZGEGqBUI1kD+xUOy
X-Google-Smtp-Source: AGHT+IGIBH8l0IRBM5I7fwjL4au6/JL5XgUgQma4YCeHzWocvzxDOGysPlgCPKQFgWRiAKTrYRHY2EhCVQJG+08hf58=
X-Received: by 2002:a50:aad8:0:b0:54b:10a8:ad6f with SMTP id
 r24-20020a50aad8000000b0054b10a8ad6fmr1119edc.40.1701367070000; Thu, 30 Nov
 2023 09:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127190409.2344550-1-andrii@kernel.org> <20231127190409.2344550-4-andrii@kernel.org>
 <CAEf4BzauJjmqMdgqBrsvmXjATj4s6Om94BV471LwwdmJpx3PjQ@mail.gmail.com> <20231130-katzen-anhand-7ad530f187da@brauner>
In-Reply-To: <20231130-katzen-anhand-7ad530f187da@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Nov 2023 09:57:37 -0800
Message-ID: <CAEf4BzZA2or352VkAaBsr+fsWAGO1Cs_gonH7Ffm5emXGE+2Ug@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 03/17] bpf: introduce BPF token object
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 6:27=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Nov 28, 2023 at 04:05:36PM -0800, Andrii Nakryiko wrote:
> > On Mon, Nov 27, 2023 at 11:06=E2=80=AFAM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > >
> > > Add new kind of BPF kernel object, BPF token. BPF token is meant to
> > > allow delegating privileged BPF functionality, like loading a BPF
> > > program or creating a BPF map, from privileged process to a *trusted*
> > > unprivileged process, all while having a good amount of control over =
which
> > > privileged operations could be performed using provided BPF token.
> > >
> > > This is achieved through mounting BPF FS instance with extra delegati=
on
> > > mount options, which determine what operations are delegatable, and a=
lso
> > > constraining it to the owning user namespace (as mentioned in the
> > > previous patch).
> > >
> > > BPF token itself is just a derivative from BPF FS and can be created
> > > through a new bpf() syscall command, BPF_TOKEN_CREATE, which accepts =
BPF
> > > FS FD, which can be attained through open() API by opening BPF FS mou=
nt
> > > point. Currently, BPF token "inherits" delegated command, map types,
> > > prog type, and attach type bit sets from BPF FS as is. In the future,
> > > having an BPF token as a separate object with its own FD, we can allo=
w
> > > to further restrict BPF token's allowable set of things either at the
> > > creation time or after the fact, allowing the process to guard itself
> > > further from unintentionally trying to load undesired kind of BPF
> > > programs. But for now we keep things simple and just copy bit sets as=
 is.
> > >
> > > When BPF token is created from BPF FS mount, we take reference to the
> > > BPF super block's owning user namespace, and then use that namespace =
for
> > > checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> > > capabilities that are normally only checked against init userns (usin=
g
> > > capable()), but now we check them using ns_capable() instead (if BPF
> > > token is provided). See bpf_token_capable() for details.
> > >
> > > Such setup means that BPF token in itself is not sufficient to grant =
BPF
> > > functionality. User namespaced process has to *also* have necessary
> > > combination of capabilities inside that user namespace. So while
> > > previously CAP_BPF was useless when granted within user namespace, no=
w
> > > it gains a meaning and allows container managers and sys admins to ha=
ve
> > > a flexible control over which processes can and need to use BPF
> > > functionality within the user namespace (i.e., container in practice)=
.
> > > And BPF FS delegation mount options and derived BPF tokens serve as
> > > a per-container "flag" to grant overall ability to use bpf() (plus fu=
rther
> > > restrict on which parts of bpf() syscalls are treated as namespaced).
> > >
> > > Note also, BPF_TOKEN_CREATE command itself requires ns_capable(CAP_BP=
F)
> > > within the BPF FS owning user namespace, rounding up the ns_capable()
> > > story of BPF token.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/bpf.h            |  41 +++++++
> > >  include/uapi/linux/bpf.h       |  37 ++++++
> > >  kernel/bpf/Makefile            |   2 +-
> > >  kernel/bpf/inode.c             |  17 ++-
> > >  kernel/bpf/syscall.c           |  17 +++
> > >  kernel/bpf/token.c             | 209 +++++++++++++++++++++++++++++++=
++
> > >  tools/include/uapi/linux/bpf.h |  37 ++++++
> > >  7 files changed, 350 insertions(+), 10 deletions(-)
> > >  create mode 100644 kernel/bpf/token.c
> > >
> >
> > [...]
> >
> > > +int bpf_token_create(union bpf_attr *attr)
> > > +{
> > > +       struct bpf_mount_opts *mnt_opts;
> > > +       struct bpf_token *token =3D NULL;
> > > +       struct user_namespace *userns;
> > > +       struct inode *inode;
> > > +       struct file *file;
> > > +       struct path path;
> > > +       struct fd f;
> > > +       umode_t mode;
> > > +       int err, fd;
> > > +
> > > +       f =3D fdget(attr->token_create.bpffs_fd);
> > > +       if (!f.file)
> > > +               return -EBADF;
> > > +
> > > +       path =3D f.file->f_path;
> > > +       path_get(&path);
> > > +       fdput(f);
> > > +
> > > +       if (path.dentry !=3D path.mnt->mnt_sb->s_root) {
> > > +               err =3D -EINVAL;
> > > +               goto out_path;
> > > +       }
> > > +       if (path.mnt->mnt_sb->s_op !=3D &bpf_super_ops) {
> > > +               err =3D -EINVAL;
> > > +               goto out_path;
> > > +       }
> > > +       err =3D path_permission(&path, MAY_ACCESS);
> > > +       if (err)
> > > +               goto out_path;
> > > +
> > > +       userns =3D path.dentry->d_sb->s_user_ns;
> > > +       /*
> > > +        * Enforce that creators of BPF tokens are in the same user
> > > +        * namespace as the BPF FS instance. This makes reasoning abo=
ut
> > > +        * permissions a lot easier and we can always relax this late=
r.
> > > +        */
> > > +       if (current_user_ns() !=3D userns) {
> > > +               err =3D -EPERM;
> > > +               goto out_path;
> > > +       }
> >
> > Hey Christian,
> >
> > I've added stricter userns check as discussed on previous revision,
> > and a few lines above fixed BPF FS root check (path.dentry !=3D
> > path.mnt->mnt_sb->s_root). Hopefully that addresses the remaining
> > concerns you've had.
> >
> > I'd appreciate it if you could take another look to double check if
> > I'm not messing anything up, and if it all looks good, can I please
> > get an ack from you? Thank you!
>
> Please enforce that in order to use a token the caller must be in the
> same user namespace as the token as well. IOW, we don't want to yet make
> it possible to use a token created in an ancestor user namespace to load
> or attach bpf programs in a descendant user namespace. Let's be as
> restrictive as we can: tokens are only valid within the user namespace
> they were created in.

Ok, I will add the check to bpf_token_allow_cmd() and bpf_token_capable().

Thanks a lot for the reviews!

