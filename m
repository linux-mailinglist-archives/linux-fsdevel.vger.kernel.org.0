Return-Path: <linux-fsdevel+bounces-3748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C387F7A15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80C1281BD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02394364D4;
	Fri, 24 Nov 2023 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHfGx7AA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365331730;
	Fri, 24 Nov 2023 17:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DA1C433CD;
	Fri, 24 Nov 2023 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700845667;
	bh=cnsIeUB3QWfjt+PPATu/fFPdUe8LeGe+3jxHVgdEdwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EHfGx7AAatARRcfU+6WWe8TQOVA8irrUSOs22TkTQH/kmu19FcFePN+Ek2j0sZIS8
	 UUkb1qY599ngUgnlMi22YIwIQB7MFPYXg+Z5XI8MmUQBCS8JwDbUWK0pDhGt5YivMv
	 Fpap6EqQcQclwIV/3kfssgNkeaiTOZJ20WollKWi8g34UYBH3d5iryBEdDSXlBJqrU
	 2Ezu5t8Y+m9gXpu3mHB6mlcdS7/BMUUSQErYQYD0/QdulGLVQ0xiC8jefm0q27NLMA
	 a7cemUXEV1gloCekfJQkstXmDQlqAw/vDfIJJXFWz/vn52MlGnvtBUkY5CXpt5/ZHN
	 f3tki/A3CGh3A==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c871890c12so27745121fa.2;
        Fri, 24 Nov 2023 09:07:47 -0800 (PST)
X-Gm-Message-State: AOJu0Yw74c+/jlJmLMeJN8W1Wq70mllyO/bJxqemulNFvRjXspz3AY/Z
	CQJx+s7lBTJIRSfe4rwjkZDvrQUoU8OhozraqGU=
X-Google-Smtp-Source: AGHT+IEnxzHxnp7pO7/lcj86dKEOjoxyqJGpnUjkhlmbDBvY9baA9RBd0DTJkLfmgVjbeQl4yVF9iIJsodkqcgX+fFg=
X-Received: by 2002:a2e:93cf:0:b0:2c5:6e01:58b8 with SMTP id
 p15-20020a2e93cf000000b002c56e0158b8mr2491614ljh.37.1700845666059; Fri, 24
 Nov 2023 09:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123233936.3079687-1-song@kernel.org> <20231123233936.3079687-2-song@kernel.org>
 <20231124-heilung-wohnumfeld-6b7797c4d41a@brauner>
In-Reply-To: <20231124-heilung-wohnumfeld-6b7797c4d41a@brauner>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Nov 2023 09:07:33 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7BFzsBv48xgbY4-2xhG1-GazBuQq_pnaUrJqY1q_H27w@mail.gmail.com>
Message-ID: <CAPhsuW7BFzsBv48xgbY4-2xhG1-GazBuQq_pnaUrJqY1q_H27w@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 1/6] bpf: Add kfunc bpf_get_file_xattr
To: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev, ebiggers@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, casey@schaufler-ca.com, amir73il@gmail.com, 
	kpsingh@kernel.org, roberto.sassu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 12:44=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Nov 23, 2023 at 03:39:31PM -0800, Song Liu wrote:
> > It is common practice for security solutions to store tags/labels in
> > xattrs. To implement similar functionalities in BPF LSM, add new kfunc
> > bpf_get_file_xattr().
> >
> > The first use case of bpf_get_file_xattr() is to implement file
> > verifications with asymmetric keys. Specificially, security application=
s
> > could use fsverity for file hashes and use xattr to store file signatur=
es.
> > (kfunc for fsverity hash will be added in a separate commit.)
> >
> > Currently, only xattrs with "user." prefix can be read with kfunc
> > bpf_get_file_xattr(). As use cases evolve, we may add a dedicated prefi=
x
> > for bpf_get_file_xattr().
> >
> > To avoid recursion, bpf_get_file_xattr can be only called from LSM hook=
s.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
>
> Looks ok to me. But see below for a question.
>
> If you ever allow the retrieval of additional extended attributes
> through bfs_get_file_xattr() or other bpf interfaces we would like to be
> Cced, please. The xattr stuff is (/me looks for suitable words)...
>
> Over the last months we've moved POSIX_ACL retrieval out of these
> low-level functions. They now have a dedicated api. The same is going to
> happen for fscaps as well.
>
> But even with these out of the way we would want the bpf helpers to
> always maintain an allowlist of retrievable attributes.

Agreed. We will be very specific which attributes are available to bpf
helpers/kfuncs.

>
> >  kernel/trace/bpf_trace.c | 63 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index f0b8b7c29126..55758a6fbe90 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/key.h>
> >  #include <linux/verification.h>
> >  #include <linux/namei.h>
> > +#include <linux/fileattr.h>
> >
> >  #include <net/bpf_sk_storage.h>
> >
> > @@ -1431,6 +1432,68 @@ static int __init bpf_key_sig_kfuncs_init(void)
> >  late_initcall(bpf_key_sig_kfuncs_init);
> >  #endif /* CONFIG_KEYS */
> >
> > +/* filesystem kfuncs */
> > +__bpf_kfunc_start_defs();
> > +
> > +/**
> > + * bpf_get_file_xattr - get xattr of a file
> > + * @file: file to get xattr from
> > + * @name__str: name of the xattr
> > + * @value_ptr: output buffer of the xattr value
> > + *
> > + * Get xattr *name__str* of *file* and store the output in *value_ptr*=
.
> > + *
> > + * For security reasons, only *name__str* with prefix "user." is allow=
ed.
> > + *
> > + * Return: 0 on success, a negative value on error.
> > + */
> > +__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name=
__str,
> > +                                struct bpf_dynptr_kern *value_ptr)
> > +{
> > +     struct dentry *dentry;
> > +     u32 value_len;
> > +     void *value;
> > +
> > +     if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> > +             return -EPERM;
> > +
> > +     value_len =3D __bpf_dynptr_size(value_ptr);
> > +     value =3D __bpf_dynptr_data_rw(value_ptr, value_len);
> > +     if (!value)
> > +             return -EINVAL;
> > +
> > +     dentry =3D file_dentry(file);
> > +     return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, =
value_len);
>
> By calling __vfs_getxattr() from bpf_get_file_xattr() you're skipping at
> least inode_permission() from xattr_permission(). I'm probably just
> missing or forgot the context. But why is that ok?

AFAICT, the XATTR_USER_PREFIX above is equivalent to the prefix
check in xattr_permission().

For inode_permission(), I think it is not required because we already
have the "struct file" of  the target file. Did I misunderstand something
here?

Thanks,
Song

> > +}
> > +

[...]

