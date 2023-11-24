Return-Path: <linux-fsdevel+bounces-3578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FD57F6AC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 03:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06EC1C20B2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 02:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E647015AE;
	Fri, 24 Nov 2023 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iynmg/72"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AAE7F7;
	Fri, 24 Nov 2023 02:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB37C43391;
	Fri, 24 Nov 2023 02:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700794399;
	bh=5M3+92F0iChKVoQ1twE8+XXhAzcqbgOUEwMilpjwqyo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iynmg/72Ug17efHiljMHOv8nZNs4Jb+PdE30s6S5pEq4HVwh7Bnq9/X3KykVjfvgE
	 ZCfLk7qFFWVTq6Ut9Ns0B+xTB2osn+X4+ahehzNcz9Xxfv2yFc42xVWm4QYrey1YGl
	 8zTah/uYcOov3JURz2m82+fhtv/AlNrHf6dcIHGXSzHDpcy0I+Uc4udn+FAdLvTjXY
	 DXJmox6McF08lzaufo67xpueI4kNUSECtORBop5zoyQqleeXtwzhTRNAh0K6Am0Mas
	 NpOEdYHoHzoxI5l89C8ZCKETbnZJmLXosbh0wvqmsFAb3lq40PdPuqAaMoVWcjeG7Y
	 ihcGBGTW948uQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-507a62d4788so2076130e87.0;
        Thu, 23 Nov 2023 18:53:19 -0800 (PST)
X-Gm-Message-State: AOJu0YyDDGvFENfHNgL7/SY7wbFzsRsWYo7Yfn2MLtNBfHykWc744P0F
	AfME26Tjk1aSzzzNfm1j9JlBOq/w9JpQO2EPWI0=
X-Google-Smtp-Source: AGHT+IEzKjUfshYTK3HnsJOzq3hrs1jTxii2+mmJjlmBQi9TmLWj3IY1DYbGu5j9tiqYXNIELQThSElyZWg+vq2KsqA=
X-Received: by 2002:a05:6512:3e7:b0:509:8e3f:a443 with SMTP id
 n7-20020a05651203e700b005098e3fa443mr572729lfq.52.1700794397895; Thu, 23 Nov
 2023 18:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123233936.3079687-1-song@kernel.org> <20231123233936.3079687-2-song@kernel.org>
In-Reply-To: <20231123233936.3079687-2-song@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 23 Nov 2023 18:53:05 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6NLk-x1CxEHMzPZ9Rmved4GeSX_K2Syp8YPQ4A-NdsbQ@mail.gmail.com>
Message-ID: <CAPhsuW6NLk-x1CxEHMzPZ9Rmved4GeSX_K2Syp8YPQ4A-NdsbQ@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 1/6] bpf: Add kfunc bpf_get_file_xattr
To: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Cc: ebiggers@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, casey@schaufler-ca.com, amir73il@gmail.com, 
	kpsingh@kernel.org, roberto.sassu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 3:40=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> It is common practice for security solutions to store tags/labels in
> xattrs. To implement similar functionalities in BPF LSM, add new kfunc
> bpf_get_file_xattr().
>
> The first use case of bpf_get_file_xattr() is to implement file
> verifications with asymmetric keys. Specificially, security applications
> could use fsverity for file hashes and use xattr to store file signatures=
.
> (kfunc for fsverity hash will be added in a separate commit.)
>
> Currently, only xattrs with "user." prefix can be read with kfunc
> bpf_get_file_xattr(). As use cases evolve, we may add a dedicated prefix
> for bpf_get_file_xattr().
>
> To avoid recursion, bpf_get_file_xattr can be only called from LSM hooks.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 63 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index f0b8b7c29126..55758a6fbe90 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -24,6 +24,7 @@
>  #include <linux/key.h>
>  #include <linux/verification.h>
>  #include <linux/namei.h>
> +#include <linux/fileattr.h>
>
>  #include <net/bpf_sk_storage.h>
>
> @@ -1431,6 +1432,68 @@ static int __init bpf_key_sig_kfuncs_init(void)
>  late_initcall(bpf_key_sig_kfuncs_init);
>  #endif /* CONFIG_KEYS */
>
> +/* filesystem kfuncs */
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_get_file_xattr - get xattr of a file
> + * @file: file to get xattr from
> + * @name__str: name of the xattr
> + * @value_ptr: output buffer of the xattr value
> + *
> + * Get xattr *name__str* of *file* and store the output in *value_ptr*.
> + *
> + * For security reasons, only *name__str* with prefix "user." is allowed=
.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__=
str,
> +                                  struct bpf_dynptr_kern *value_ptr)
> +{
> +       struct dentry *dentry;
> +       u32 value_len;
> +       void *value;
> +
> +       if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> +               return -EPERM;
> +
> +       value_len =3D __bpf_dynptr_size(value_ptr);
> +       value =3D __bpf_dynptr_data_rw(value_ptr, value_len);
> +       if (!value)
> +               return -EINVAL;
> +
> +       dentry =3D file_dentry(file);
> +       return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, =
value_len);
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_SET8_START(fs_kfunc_set_ids)
> +BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_SET8_END(fs_kfunc_set_ids)
> +
> +static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kf=
unc_id)
> +{
> +       if (!btf_id_set8_contains(&fs_kfunc_set_ids, kfunc_id))
> +               return 0;
> +
> +       /* Only allow to attach from LSM hooks, to avoid recursion */
> +       return prog->type !=3D BPF_PROG_TYPE_LSM ? -EACCES : 0;
> +}
> +
> +const struct btf_kfunc_id_set bpf_fs_kfunc_set =3D {

Missed static here. If there will be v14, I will fix it here.

Thanks,
Song

> +       .owner =3D THIS_MODULE,
> +       .set =3D &fs_kfunc_set_ids,
> +       .filter =3D bpf_get_file_xattr_filter,
> +};
> +
> +static int __init bpf_fs_kfuncs_init(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc=
_set);
> +}
> +
> +late_initcall(bpf_fs_kfuncs_init);
> +
>  static const struct bpf_func_proto *
>  bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
>  {
> --
> 2.34.1
>

