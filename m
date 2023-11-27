Return-Path: <linux-fsdevel+bounces-3968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C727FA8B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 19:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0A7281816
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 18:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4643D39A;
	Mon, 27 Nov 2023 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqM26W4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6491419A;
	Mon, 27 Nov 2023 10:16:37 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a0b7f793b8aso294530066b.2;
        Mon, 27 Nov 2023 10:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701108996; x=1701713796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0MNmDDFhzNWXW26VVXylDPWdcz0xqBbFSvdCrOddzY=;
        b=VqM26W4NtuSwefOYRYKvUeY8vdxhfWlxsG1LpB46BIYUL1gQEvQcsvyiXY/2K7lB3d
         NeTUc/LkydAgcbLbadFtQzLg+nlk+E7t8XJRVaypCzZWWJ5qlKL1H8bGMB4q0SUfA4pL
         ZXXzjgDFKD+PN93IR1Qzu564eg19vtXxyNeUlUs7/aq68XWLYCCssqLng7ZeEwRIJDzv
         fRRbPliblaQRCF22XpQvWMPWZdAYZvfXp8yfI4oxPfnkjiy4a3rbbEnAQBJDmJtOv2UI
         gdDAPyYEXN5AVveii4ub40Ma3UtWPEbaUQ6xQpusNwEGuqcOQZXBSRYXKp0YfDHHppA5
         bXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701108996; x=1701713796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0MNmDDFhzNWXW26VVXylDPWdcz0xqBbFSvdCrOddzY=;
        b=nmHVrOMu/s1byc7mdrol48Q8f9fglhC2k0SF4cqk6y3mul7vZdWIAoxFDB1E+/U+h6
         ziKnl0vTIYmVoHD3fU6MAStnzL/srhV6s1q63CHWqWvVKrWj0HUp3bymp7zVVNaZSP2H
         RKJe32UNEes5iKwkyZ0DlnFxxx6FC0/uKTiJxcjpbbJcwupncv6K4T4yYCxcYkqomGn0
         dYkEO/ifxFaGOIBjYa5Ndb+QRbvcKy9n5OD8ay2IbZGfyEkpBlq8S0v5h7NxBkIl2fOe
         9a4lJRpd5duDvLfTQAppw417kc0kpwOYL+/gF08z7ygwDacU9jBQzPCxppUg5nL8gBwQ
         3ykA==
X-Gm-Message-State: AOJu0YzZ+Fh/UUjmW6vwBtaU1Lxeh5LDwD6cJuPv7M8Skry2KFJ4PcE3
	2RTGrkVFg8Cqyk1EvPvzymQZETEMSaLloozHTK0=
X-Google-Smtp-Source: AGHT+IGY5E02zY+pbbkEurj61BrlcqNvoTfrqici+wS/fZh7KUazKP1ns9HM1ypCOssNrQIhAoXXT8xLp5ki1SQDJ1o=
X-Received: by 2002:a17:906:b882:b0:9e7:3af8:1fcd with SMTP id
 hb2-20020a170906b88200b009e73af81fcdmr7515414ejb.76.1701108995539; Mon, 27
 Nov 2023 10:16:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110034838.1295764-1-andrii@kernel.org> <20231110034838.1295764-4-andrii@kernel.org>
 <20231127-ansonsten-brotaufstrich-316b2cbba41b@brauner>
In-Reply-To: <20231127-ansonsten-brotaufstrich-316b2cbba41b@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Nov 2023 10:16:23 -0800
Message-ID: <CAEf4BzahXquN0=79inMksTY6no542cOFJyoQgJEH0vJcm4-b5w@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 03/17] bpf: introduce BPF token object
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 6:25=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Nov 09, 2023 at 07:48:24PM -0800, Andrii Nakryiko wrote:
> > Add new kind of BPF kernel object, BPF token. BPF token is meant to
> > allow delegating privileged BPF functionality, like loading a BPF
> > program or creating a BPF map, from privileged process to a *trusted*
> > unprivileged process, all while having a good amount of control over wh=
ich
> > privileged operations could be performed using provided BPF token.
> >
> > This is achieved through mounting BPF FS instance with extra delegation
> > mount options, which determine what operations are delegatable, and als=
o
> > constraining it to the owning user namespace (as mentioned in the
> > previous patch).
> >
> > BPF token itself is just a derivative from BPF FS and can be created
> > through a new bpf() syscall command, BPF_TOKEN_CREATE, which accepts BP=
F
> > FS FD, which can be attained through open() API by opening BPF FS mount
> > point. Currently, BPF token "inherits" delegated command, map types,
> > prog type, and attach type bit sets from BPF FS as is. In the future,
> > having an BPF token as a separate object with its own FD, we can allow
> > to further restrict BPF token's allowable set of things either at the
> > creation time or after the fact, allowing the process to guard itself
> > further from unintentionally trying to load undesired kind of BPF
> > programs. But for now we keep things simple and just copy bit sets as i=
s.
> >
> > When BPF token is created from BPF FS mount, we take reference to the
> > BPF super block's owning user namespace, and then use that namespace fo=
r
> > checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> > capabilities that are normally only checked against init userns (using
> > capable()), but now we check them using ns_capable() instead (if BPF
> > token is provided). See bpf_token_capable() for details.
> >
> > Such setup means that BPF token in itself is not sufficient to grant BP=
F
> > functionality. User namespaced process has to *also* have necessary
> > combination of capabilities inside that user namespace. So while
> > previously CAP_BPF was useless when granted within user namespace, now
> > it gains a meaning and allows container managers and sys admins to have
> > a flexible control over which processes can and need to use BPF
> > functionality within the user namespace (i.e., container in practice).
> > And BPF FS delegation mount options and derived BPF tokens serve as
> > a per-container "flag" to grant overall ability to use bpf() (plus furt=
her
> > restrict on which parts of bpf() syscalls are treated as namespaced).
> >
> > Note also, BPF_TOKEN_CREATE command itself requires ns_capable(CAP_BPF)
> > within the BPF FS owning user namespace, rounding up the ns_capable()
> > story of BPF token.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h            |  41 +++++++
> >  include/uapi/linux/bpf.h       |  37 ++++++
> >  kernel/bpf/Makefile            |   2 +-
> >  kernel/bpf/inode.c             |  17 ++-
> >  kernel/bpf/syscall.c           |  17 +++
> >  kernel/bpf/token.c             | 200 +++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  37 ++++++
> >  7 files changed, 341 insertions(+), 10 deletions(-)
> >  create mode 100644 kernel/bpf/token.c
> >

[...]

> > +int bpf_token_create(union bpf_attr *attr)
> > +{
> > +     struct bpf_mount_opts *mnt_opts;
> > +     struct bpf_token *token =3D NULL;
> > +     struct user_namespace *userns;
> > +     struct inode *inode;
> > +     struct file *file;
> > +     struct path path;
> > +     struct fd f;
> > +     umode_t mode;
> > +     int err, fd;
> > +
> > +     f =3D fdget(attr->token_create.bpffs_fd);
> > +     if (!f.file)
> > +             return -EBADF;
> > +
> > +     path =3D f.file->f_path;
> > +     path_get(&path);
> > +     fdput(f);
> > +
> > +     if (path.mnt->mnt_root !=3D path.dentry) {
> > +             err =3D -EINVAL;
> > +             goto out_path;
> > +     }
> > +     if (path.mnt->mnt_sb->s_op !=3D &bpf_super_ops) {
> > +             err =3D -EINVAL;
> > +             goto out_path;
> > +     }
> > +     err =3D path_permission(&path, MAY_ACCESS);
> > +     if (err)
> > +             goto out_path;
> > +
> > +     userns =3D path.dentry->d_sb->s_user_ns;
>
> I would add one more restriction in here:
>
> @@ -136,6 +136,16 @@ int bpf_token_create(union bpf_attr *attr)
>                 goto out_path;
>
>         userns =3D path.dentry->d_sb->s_user_ns;
> +
> +       /*
> +        * Enforce that creators of bpf tokens are in the same user
> +        * namespace as the bpffs instance. This makes reasoning about
> +        * permissions a lot easier and we can always relax this later.
> +        */
> +       if (current_user_ns() !=3D userns) {
> +               err =3D -EINVAL;
> +               goto out_path;
> +       }

I was relying on ns_capable() to prevent unexpected abuse, but I guess
starting out stricter makes sense as well. I don't currently have use
cases requiring this to be relaxed, so I'll add this check, no
problem.

>         if (!ns_capable(userns, CAP_BPF)) {
>                 err =3D -EPERM;
>                 goto out_path;
>
> > +     if (!ns_capable(userns, CAP_BPF)) {
> > +             err =3D -EPERM;
> > +             goto out_path;
> > +     }
> > +
> > +     mode =3D S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
> > +     inode =3D bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
> > +     if (IS_ERR(inode)) {
> > +             err =3D PTR_ERR(inode);
> > +             goto out_path;
> > +     }
> > +
> > +     inode->i_op =3D &bpf_token_iops;
> > +     inode->i_fop =3D &bpf_token_fops;
> > +     clear_nlink(inode); /* make sure it is unlinked */
> > +
> > +     file =3D alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME,=
 O_RDWR, &bpf_token_fops);
> > +     if (IS_ERR(file)) {
> > +             iput(inode);
> > +             err =3D PTR_ERR(file);
> > +             goto out_path;
> > +     }
> > +
> > +     token =3D kvzalloc(sizeof(*token), GFP_USER);
> > +     if (!token) {
> > +             err =3D -ENOMEM;
> > +             goto out_file;
> > +     }
> > +
> > +     atomic64_set(&token->refcnt, 1);
> > +
> > +     /* remember bpffs owning userns for future ns_capable() checks */
> > +     token->userns =3D get_user_ns(userns);
>
> Now that you made the changes I suggested in an earlier review such that
> a bpf token thingy is a bpffs fd and not an anonymous inode fd, it
> carries the user namespace with it so this is really not necessary. I
> would've just used the file and passed that to bpf_token_capable() and
> then also passed that file to the security hooks. But this way is fine
> too I guess.
>

I'd like to have a dedicated struct bpf_token to represent the token
and any associated information for it (e.g., I suspect we'll add the
ability to drop delegated permission for individual token, compared to
what it inherits from bpffs instance, among other things). So it feels
better and cleaner to pass around explicit `struct bpf_token` rather
than generic file.

So if it's ok with you and isn't really breaking anything, I'd rather
keep all this as is.

> > +
> > +     mnt_opts =3D path.dentry->d_sb->s_fs_info;
> > +     token->allowed_cmds =3D mnt_opts->delegate_cmds;
> > +
> > +     fd =3D get_unused_fd_flags(O_CLOEXEC);
> > +     if (fd < 0) {
> > +             err =3D fd;
> > +             goto out_token;
> > +     }
> > +

[...]

