Return-Path: <linux-fsdevel+bounces-4119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B48A7FCB89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF0D1C20D3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2CE185B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rkbiy3dP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221A919A7;
	Tue, 28 Nov 2023 16:05:51 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9afe6e21fso16732391fa.0;
        Tue, 28 Nov 2023 16:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701216349; x=1701821149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsd0s3jMeAGACsJl9qYGz083KYgsYB8UvIyb0b38k2k=;
        b=Rkbiy3dPjjWNiblhSwyq1HAUnwSLPF4UE8XHWk3JP06dcvTmaVyq/XcqNkunYQu0qT
         sb5Zrsn3lYFbzn3rZmmyDr3T8D2d0P0kco+8Db+w/srQ8ERnz8xeqQkx/OMZAp1+dpCe
         L6SsvV6Sc59QKYLt6fgkAqDoghsMPzdtJhJT/jPGIjTEiXSKlmCtQ/peZ1HGHuyst7CO
         HkjqHY4eE7jt+rimIs73GIORuVuYlPMOPsyqTd/ZcuQmlmX5cWCMKIjbWInIS7HlaOYC
         Ckab/lgKw/h991KVxZYIla7sw3zQgjzzPyVm9+ipRWXxjeC9Y/2SArzwbO1lTVtcWbKW
         xoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701216349; x=1701821149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsd0s3jMeAGACsJl9qYGz083KYgsYB8UvIyb0b38k2k=;
        b=X+4Cxr0artKWWh9q9CrkzMfgj71W8K+etGTH35R7Dgk0w5HRdbQSIg1qhZ4Qkav2uk
         YhqkiCh+w1H0dIa2Q8b/ueakChqZkq2WLvHwO9g7Kkmwtu8KD72WZsB7IZ5rpKdG4LHr
         ELtevmWWQcsPOzUEOABgnmvy448qPkgXgx3Tsk0ld8pIyobY97X9nGppf45dZoNsKQHf
         pBYppDnniufxo/e9HtVj4tRa3Eft4LiBslh4cDb94kSjvQ4Ie3tzXDnH6BXkmMRmnIml
         PSoxVTqe7JhfNTwNVxMGdLlPA5aVzuRh7slECIWaz9rwaeXdzXd2czFFnOtGgkUEdBnx
         U5iw==
X-Gm-Message-State: AOJu0YwPmYQ6njk7Z0BHLs/84BldZCekih3LX2xgHf0033uT+cgkVrjI
	1n9lugDT6xXNYMEQRnsuYdyaV/iohkpmkJ0ZukU=
X-Google-Smtp-Source: AGHT+IFRMzMzFvNO70nN65fyMPXK3NAGA4D1NYwBjlXlJ/MrsA73NHXGGLj90vaj4oka43uGqixVK6iv7nl8y0TyLtM=
X-Received: by 2002:a2e:a703:0:b0:2c9:a124:fe64 with SMTP id
 s3-20020a2ea703000000b002c9a124fe64mr5890114lje.9.1701216349026; Tue, 28 Nov
 2023 16:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127190409.2344550-1-andrii@kernel.org> <20231127190409.2344550-4-andrii@kernel.org>
In-Reply-To: <20231127190409.2344550-4-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Nov 2023 16:05:36 -0800
Message-ID: <CAEf4BzauJjmqMdgqBrsvmXjATj4s6Om94BV471LwwdmJpx3PjQ@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 03/17] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 11:06=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Add new kind of BPF kernel object, BPF token. BPF token is meant to
> allow delegating privileged BPF functionality, like loading a BPF
> program or creating a BPF map, from privileged process to a *trusted*
> unprivileged process, all while having a good amount of control over whic=
h
> privileged operations could be performed using provided BPF token.
>
> This is achieved through mounting BPF FS instance with extra delegation
> mount options, which determine what operations are delegatable, and also
> constraining it to the owning user namespace (as mentioned in the
> previous patch).
>
> BPF token itself is just a derivative from BPF FS and can be created
> through a new bpf() syscall command, BPF_TOKEN_CREATE, which accepts BPF
> FS FD, which can be attained through open() API by opening BPF FS mount
> point. Currently, BPF token "inherits" delegated command, map types,
> prog type, and attach type bit sets from BPF FS as is. In the future,
> having an BPF token as a separate object with its own FD, we can allow
> to further restrict BPF token's allowable set of things either at the
> creation time or after the fact, allowing the process to guard itself
> further from unintentionally trying to load undesired kind of BPF
> programs. But for now we keep things simple and just copy bit sets as is.
>
> When BPF token is created from BPF FS mount, we take reference to the
> BPF super block's owning user namespace, and then use that namespace for
> checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> capabilities that are normally only checked against init userns (using
> capable()), but now we check them using ns_capable() instead (if BPF
> token is provided). See bpf_token_capable() for details.
>
> Such setup means that BPF token in itself is not sufficient to grant BPF
> functionality. User namespaced process has to *also* have necessary
> combination of capabilities inside that user namespace. So while
> previously CAP_BPF was useless when granted within user namespace, now
> it gains a meaning and allows container managers and sys admins to have
> a flexible control over which processes can and need to use BPF
> functionality within the user namespace (i.e., container in practice).
> And BPF FS delegation mount options and derived BPF tokens serve as
> a per-container "flag" to grant overall ability to use bpf() (plus furthe=
r
> restrict on which parts of bpf() syscalls are treated as namespaced).
>
> Note also, BPF_TOKEN_CREATE command itself requires ns_capable(CAP_BPF)
> within the BPF FS owning user namespace, rounding up the ns_capable()
> story of BPF token.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h            |  41 +++++++
>  include/uapi/linux/bpf.h       |  37 ++++++
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/inode.c             |  17 ++-
>  kernel/bpf/syscall.c           |  17 +++
>  kernel/bpf/token.c             | 209 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  37 ++++++
>  7 files changed, 350 insertions(+), 10 deletions(-)
>  create mode 100644 kernel/bpf/token.c
>

[...]

> +int bpf_token_create(union bpf_attr *attr)
> +{
> +       struct bpf_mount_opts *mnt_opts;
> +       struct bpf_token *token =3D NULL;
> +       struct user_namespace *userns;
> +       struct inode *inode;
> +       struct file *file;
> +       struct path path;
> +       struct fd f;
> +       umode_t mode;
> +       int err, fd;
> +
> +       f =3D fdget(attr->token_create.bpffs_fd);
> +       if (!f.file)
> +               return -EBADF;
> +
> +       path =3D f.file->f_path;
> +       path_get(&path);
> +       fdput(f);
> +
> +       if (path.dentry !=3D path.mnt->mnt_sb->s_root) {
> +               err =3D -EINVAL;
> +               goto out_path;
> +       }
> +       if (path.mnt->mnt_sb->s_op !=3D &bpf_super_ops) {
> +               err =3D -EINVAL;
> +               goto out_path;
> +       }
> +       err =3D path_permission(&path, MAY_ACCESS);
> +       if (err)
> +               goto out_path;
> +
> +       userns =3D path.dentry->d_sb->s_user_ns;
> +       /*
> +        * Enforce that creators of BPF tokens are in the same user
> +        * namespace as the BPF FS instance. This makes reasoning about
> +        * permissions a lot easier and we can always relax this later.
> +        */
> +       if (current_user_ns() !=3D userns) {
> +               err =3D -EPERM;
> +               goto out_path;
> +       }

Hey Christian,

I've added stricter userns check as discussed on previous revision,
and a few lines above fixed BPF FS root check (path.dentry !=3D
path.mnt->mnt_sb->s_root). Hopefully that addresses the remaining
concerns you've had.

I'd appreciate it if you could take another look to double check if
I'm not messing anything up, and if it all looks good, can I please
get an ack from you? Thank you!

> +       if (!ns_capable(userns, CAP_BPF)) {
> +               err =3D -EPERM;
> +               goto out_path;
> +       }
> +
> +       mode =3D S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
> +       inode =3D bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
> +       if (IS_ERR(inode)) {
> +               err =3D PTR_ERR(inode);
> +               goto out_path;
> +       }
> +

[...]

