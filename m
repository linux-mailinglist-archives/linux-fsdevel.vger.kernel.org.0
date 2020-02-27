Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBBD171176
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 08:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgB0H2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 02:28:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46125 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgB0H2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 02:28:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so763178pll.13;
        Wed, 26 Feb 2020 23:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=+zGRKeshGQVlukDljqkxIhhlnNK1OHi6NOTC6bZRBxo=;
        b=JP8igOlvXFF2xXwFwX+mRVJiEE0HmlLHlKW8JEb9cytUu7VTngW2naempp5+JdSg0/
         NjVVpHCqKlKD9XRnPH04dKw7Rzx8T10ltZuOwIQU4cMSrpt56cFsG4nut+YmSFjqRzuj
         to0SWE+umdk+sKkiz8UdoaoAHTN3UtOxJ3pA/jfs7cYCmGvHWVaVlJ+BEsGiQGiZjTPw
         ITQ7CnoyhlplFgcqebyXAA4r8invMgaA1YyfHxTWQPiXw9J9k9DRiAl5jWUX/NQUqIwO
         WLk+hW0TNe9r8d3Lg3lPn5G/jJd+U1REbyNLmps1sX6+jn6qrt6Zd9pKt5p8UrLi7eMN
         4ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:message-id:subject:from:to:cc:date
         :in-reply-to:references:user-agent:mime-version;
        bh=+zGRKeshGQVlukDljqkxIhhlnNK1OHi6NOTC6bZRBxo=;
        b=JxalxasN6xAJ0YXpl9/PxUDmQPMnDuoFP4IFzVeSwfaRI2YKwK1JznSoXtZJz+283u
         wOKKRE3k5MtV5nB5DuwNuTSLFpdzjt2KPYTMBOEfUDVQV7UfpBSz02h/G+UiFGdeRy+1
         WoHWb2JPupOwKLCP6bTt5+Da1HLRhpL89hKxW56RAb4/hjgCa5zUwB3LHBqXOBqmt9cq
         YJ+Co0Qkx3qdC+foxOuE847P79YdBiykzkyliTvhxFG4ffm7aqivQIdM+QLrk1hHq1lv
         VGA4reIO6z8EN92LysjUVJ7Plt3RJIZS7rkB0Z0iwSu8HbSu4qEtioo/BhutiI6FOpTL
         1pLQ==
X-Gm-Message-State: APjAAAU13nZZujZ0VGSKfUh/XiNBT3t1/uQTI6iTSNr8I2EFJcqH44AD
        xX4uLfGBwSo8t0kDNCVhhOUSplYGHKA=
X-Google-Smtp-Source: APXvYqy8C3dfbOK2+toq1qT1z8gRW1E2cC05j1CEnvqbG5oF1+ox2Uh17JXJtOjvITXurKlGPn5r7w==
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr3147029pln.225.1582788479986;
        Wed, 26 Feb 2020 23:27:59 -0800 (PST)
Received: from xps ([103.125.232.133])
        by smtp.gmail.com with ESMTPSA id r66sm6061240pfc.74.2020.02.26.23.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 23:27:59 -0800 (PST)
Message-ID: <cf946303ac8e2e79ea560ae6d2edeec7e4622946.camel@debian.org>
Subject: Re: [PATCH v3] binfmt_misc: pass binfmt_misc flags to the
 interpreter
From:   YunQiang Su <syq@debian.org>
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        libc-alpha@sourceware.org
Date:   Thu, 27 Feb 2020 15:27:43 +0800
In-Reply-To: <20200128132539.782286-1-laurent@vivier.eu>
References: <20200128132539.782286-1-laurent@vivier.eu>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-zE24wshRpe0xR3T9LNGS"
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-zE24wshRpe0xR3T9LNGS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2020-01-28=E4=BA=8C=E7=9A=84 14:25 +0100=EF=BC=8CLaurent Vivier=
=E5=86=99=E9=81=93=EF=BC=9A
> It can be useful to the interpreter to know which flags are in use.
>=20
> For instance, knowing if the preserve-argv[0] is in use would
> allow to skip the pathname argument.
>=20
> This patch uses an unused auxiliary vector, AT_FLAGS, to add a
> flag to inform interpreter if the preserve-argv[0] is enabled.

CC: libc-alpha.
I guess we need some review from libc people.

>=20
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>=20
> Notes:
>     This can be tested with QEMU from my branch:
>    =20
>       https://github.com/vivier/qemu/commits/binfmt-argv0
>    =20
>     With something like:
>    =20
>       # cp ..../qemu-ppc /chroot/powerpc/jessie
>    =20
>       # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential
> yes \
>                             --persistent no --preserve-argv0 yes
>       # systemctl restart systemd-binfmt.service
>       # cat /proc/sys/fs/binfmt_misc/qemu-ppc
>       enabled
>       interpreter //qemu-ppc
>       flags: POC
>       offset 0
>       magic 7f454c4601020100000000000000000000020014
>       mask ffffffffffffff00fffffffffffffffffffeffff
>       # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
>       sh
>    =20
>       # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential
> yes \
>                             --persistent no --preserve-argv0 no
>       # systemctl restart systemd-binfmt.service
>       # cat /proc/sys/fs/binfmt_misc/qemu-ppc
>       enabled
>       interpreter //qemu-ppc
>       flags: OC
>       offset 0
>       magic 7f454c4601020100000000000000000000020014
>       mask ffffffffffffff00fffffffffffffffffffeffff
>       # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
>       /bin/sh
>    =20
>     v3: mix my patch with one from YunQiang Su and my comments on it
>         introduce a new flag in the uabi for the AT_FLAGS
>     v2: only pass special flags (remove Magic and Enabled flags)
>=20
>  fs/binfmt_elf.c              | 5 ++++-
>  fs/binfmt_elf_fdpic.c        | 5 ++++-
>  fs/binfmt_misc.c             | 4 +++-
>  include/linux/binfmts.h      | 4 ++++
>  include/uapi/linux/binfmts.h | 4 ++++
>  5 files changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index ecd8d2698515..ff918042ceed 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -176,6 +176,7 @@ create_elf_tables(struct linux_binprm *bprm,
> struct elfhdr *exec,
>  	unsigned char k_rand_bytes[16];
>  	int items;
>  	elf_addr_t *elf_info;
> +	elf_addr_t flags =3D 0;
>  	int ei_index =3D 0;
>  	const struct cred *cred =3D current_cred();
>  	struct vm_area_struct *vma;
> @@ -250,7 +251,9 @@ create_elf_tables(struct linux_binprm *bprm,
> struct elfhdr *exec,
>  	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
>  	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>  	NEW_AUX_ENT(AT_BASE, interp_load_addr);
> -	NEW_AUX_ENT(AT_FLAGS, 0);
> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> +		flags |=3D AT_FLAGS_PRESERVE_ARGV0;
> +	NEW_AUX_ENT(AT_FLAGS, flags);
>  	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
>  	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred-
> >uid));
>  	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred-
> >euid));
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 240f66663543..abb90d82aa58 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -507,6 +507,7 @@ static int create_elf_fdpic_tables(struct
> linux_binprm *bprm,
>  	char __user *u_platform, *u_base_platform, *p;
>  	int loop;
>  	int nr;	/* reset for each csp adjustment */
> +	unsigned long flags =3D 0;
> =20
>  #ifdef CONFIG_MMU
>  	/* In some cases (e.g. Hyper-Threading), we want to avoid L1
> evictions
> @@ -647,7 +648,9 @@ static int create_elf_fdpic_tables(struct
> linux_binprm *bprm,
>  	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
>  	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
>  	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
> -	NEW_AUX_ENT(AT_FLAGS,	0);
> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> +		flags |=3D AT_FLAGS_PRESERVE_ARGV0;
> +	NEW_AUX_ENT(AT_FLAGS,	flags);
>  	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
>  	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred-
> >user_ns, cred->uid));
>  	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred-
> >user_ns, cred->euid));
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index cdb45829354d..b9acdd26a654 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -154,7 +154,9 @@ static int load_misc_binary(struct linux_binprm
> *bprm)
>  	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
>  		goto ret;
> =20
> -	if (!(fmt->flags & MISC_FMT_PRESERVE_ARGV0)) {
> +	if (fmt->flags & MISC_FMT_PRESERVE_ARGV0) {
> +		bprm->interp_flags |=3D BINPRM_FLAGS_PRESERVE_ARGV0;
> +	} else {
>  		retval =3D remove_arg_zero(bprm);
>  		if (retval)
>  			goto ret;
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index b40fc633f3be..265b80d5fd6f 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -78,6 +78,10 @@ struct linux_binprm {
>  #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
>  #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 <<
> BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)
> =20
> +/* if preserve the argv0 for the interpreter  */
> +#define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
> +#define BINPRM_FLAGS_PRESERVE_ARGV0 (1 <<
> BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
> +
>  /* Function parameter for binfmt->coredump */
>  struct coredump_params {
>  	const kernel_siginfo_t *siginfo;
> diff --git a/include/uapi/linux/binfmts.h
> b/include/uapi/linux/binfmts.h
> index 689025d9c185..a70747416130 100644
> --- a/include/uapi/linux/binfmts.h
> +++ b/include/uapi/linux/binfmts.h
> @@ -18,4 +18,8 @@ struct pt_regs;
>  /* sizeof(linux_binprm->buf) */
>  #define BINPRM_BUF_SIZE 256
> =20
> +/* if preserve the argv0 for the interpreter  */
> +#define AT_FLAGS_PRESERVE_ARGV0_BIT 0
> +#define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
> +
>  #endif /* _UAPI_LINUX_BINFMTS_H */

--=-zE24wshRpe0xR3T9LNGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEET3MbhxKET+7/a6zdW0gHVdEZ6o4FAl5Xb28ACgkQW0gHVdEZ
6o5PCgf+IhNRA4aou8ifw13gYlx/VqRW+7x1bIxFdRzNhhpSKkCGMvzKrZdq5rUA
S+9PUa+MHBGrMwO8n+izBDF9Sj9G1p/9rJp7MoYbBHceZxeXWdFrDNMQ+dXIWiJQ
IN8EGIOhRco+Gzf59zZZhB9WjHRBK7R23sk9h57esS6+KQiomREc3UoeioXSmYoZ
sYDt+ooTDFl2QlmJC7CKzXNk7EPIQYnzGrO1DpN1icCcSSvMNYzCfG2+AIfmyJOc
Lz+GVXAWne/T6yJKFa3wzsqwkkJ0qg6792vLP9ieMkbQMjD/T/eTGPfhFHqIbQUA
uQhaIxAErGmi2/1KFAVTYiEerUG9Sw==
=qjWv
-----END PGP SIGNATURE-----

--=-zE24wshRpe0xR3T9LNGS--

