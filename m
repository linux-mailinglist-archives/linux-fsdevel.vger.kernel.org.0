Return-Path: <linux-fsdevel+bounces-6808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4800881D0F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 02:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6434B237DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 01:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F5A645;
	Sat, 23 Dec 2023 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AWF1qJFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E678AEC7
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Dec 2023 01:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7811c16ce6cso155076785a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 17:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703294618; x=1703899418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ol6F17s5HBzN1N/Ub4j2HKKOTRquCJcTyGe14n9oFhY=;
        b=AWF1qJFXGGzkHdvxWZs3UNCxyQ760H2q64EQ5LXy8lm/4uvCeDI8eXBqQ2A6si96rq
         K4BwQ3dbTCV3kAc1TGtZBCqgSwJWwBE38uA4vqoCeYYXZAt+k0eia92JI0T20LFPxl4p
         ugJJp0oLi1t2IjCLqmiZuQeIrAOqHuYhq/6ScnM4ifpnh93SDJHreABg4tqqCJPFbQyk
         FHwZGfYRaYioIDCA4Pr2vVbVCmHh2xYXpuDyP8H6Qbix+8nSTKNCXsCPWX5CYhPuFKYS
         omqLfVgvdq4glfDCHflJFvIcEDLeMuZpmTNQ2Rr0IiM9wD6u0JAAzF5fuAYpXdEuhuUW
         mqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703294618; x=1703899418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ol6F17s5HBzN1N/Ub4j2HKKOTRquCJcTyGe14n9oFhY=;
        b=egKDVqYkpaSNb5/TkHdNURqv3DdxsQIcojMaZJdMKRneWUyXHRPb8YOS2RIGDtRtRU
         W2JvDwoTBCIwujirBmCpYqSF+G1Tp+Vd36kjji/5QR2RyvvwqJOr7sg6AGXp+f3wXe32
         18h4fjtZ8Jgaqu60jm68Awf3BqbQbuqf+T0n0bf68bhj6x2/ZwVxU453GdiPprxfsZQY
         oyPDpDuM5ZZMiTiyu7+qCwS/dWeVnXc+yQpum4+Y+Q7mQoAue3iYEBwjTGFZWNRVqdLd
         o9A8p0nM+h/78StGnZUUm0Dv0aU/jc5vY4AnvRt0ChDDK8Q4YjJ9zFNhtrH61wA8HW9P
         Hz4Q==
X-Gm-Message-State: AOJu0YzUCsP/DT9YDkbvaYmEUYq5CeIpx5d9y2N4Wb0gOiwyg5hwkA4U
	VCCBavUGLWE0RJLzQx/Hdx/+R7dDQw14O9cQ9j0k+q3rsANG
X-Google-Smtp-Source: AGHT+IHdoEKOJBo1f1Wlnf+MZivYuOxAH1/fQuZG8OdFTEkDHqeJLkyY9PJXkiAt4IkOyFmswuc5cBn3ygqrr+R6kLI=
X-Received: by 2002:a05:620a:c19:b0:781:27bc:d0b9 with SMTP id
 l25-20020a05620a0c1900b0078127bcd0b9mr2435572qki.41.1703294617781; Fri, 22
 Dec 2023 17:23:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
In-Reply-To: <20231219090909.2827497-1-alpic@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 22 Dec 2023 20:23:26 -0500
Message-ID: <CAHC9VhTpc7SD0t-5AJ49+b-FMTx1svDBQcR7j6c1rmREUNW7gg@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Alfred Piccioni <alpic@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:09=E2=80=AFAM Alfred Piccioni <alpic@google.com> =
wrote:
>
> Some ioctl commands do not require ioctl permission, but are routed to
> other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
> done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
>
> However, if a 32-bit process is running on a 64-bit kernel, it emits
> 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
> being checked erroneously, which leads to these ioctl operations being
> routed to the ioctl permission, rather than the correct file
> permissions.
>
> This was also noted in a RED-PEN finding from a while back -
> "/* RED-PEN how should LSM module know it's handling 32bit? */".
>
> This patch introduces a new hook, security_file_ioctl_compat, that is
> called from the compat ioctl syscall. All current LSMs have been changed
> to support this hook.
>
> Reviewing the three places where we are currently using
> security_file_ioctl, it appears that only SELinux needs a dedicated
> compat change; TOMOYO and SMACK appear to be functional without any
> change.
>
> Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
> Signed-off-by: Alfred Piccioni <alpic@google.com>
> Cc: stable@vger.kernel.org
> ---
>  fs/ioctl.c                    |  3 +--
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 17 +++++++++++++++++
>  security/selinux/hooks.c      | 28 ++++++++++++++++++++++++++++
>  security/smack/smack_lsm.c    |  1 +
>  security/tomoyo/tomoyo.c      |  1 +
>  7 files changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index f5fd99d6b0d4..76cf22ac97d7 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -920,8 +920,7 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsig=
ned int, cmd,
>         if (!f.file)
>                 return -EBADF;
>
> -       /* RED-PEN how should LSM module know it's handling 32bit? */
> -       error =3D security_file_ioctl(f.file, cmd, arg);
> +       error =3D security_file_ioctl_compat(f.file, cmd, arg);
>         if (error)
>                 goto out;

This is interesting ... if you look at the normal ioctl() syscall
definition in the kernel you see 'ioctl(unsigned int fd, unsigned int
cmd, unsigned long arg)' and if you look at the compat definition you
see 'ioctl(unsigned int fd, unsigned int cmd, compat_ulong_t arg)'.  I
was expecting the second parameter, @cmd, to be a long type in the
normal definition, but it is an int type in both cases.  It looks like
it has been that way long enough that it is correct, but I'm a little
lost ...

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index ac962c4cb44b..626aa8cf930d 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -171,6 +171,8 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *fi=
le)
>  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
>  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
>          unsigned long arg)
> +LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
> +        unsigned long arg)
>  LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
>  LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
>          unsigned long prot, unsigned long flags)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5f16eecde00b..22a82b7c59f1 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -389,6 +389,7 @@ int security_file_permission(struct file *file, int m=
ask);
>  int security_file_alloc(struct file *file);
>  void security_file_free(struct file *file);
>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned lo=
ng arg);
> +int security_file_ioctl_compat(struct file *file, unsigned int cmd, unsi=
gned long arg);
>  int security_mmap_file(struct file *file, unsigned long prot,
>                         unsigned long flags);
>  int security_mmap_addr(unsigned long addr);
> @@ -987,6 +988,12 @@ static inline int security_file_ioctl(struct file *f=
ile, unsigned int cmd,
>         return 0;
>  }
>
> +static inline int security_file_ioctl_compat(struct file *file, unsigned=
 int cmd,
> +                                     unsigned long arg)
> +{
> +       return 0;
> +}
> +
>  static inline int security_mmap_file(struct file *file, unsigned long pr=
ot,
>                                      unsigned long flags)
>  {
> diff --git a/security/security.c b/security/security.c
> index 23b129d482a7..5c16ffc99b1e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2648,6 +2648,23 @@ int security_file_ioctl(struct file *file, unsigne=
d int cmd, unsigned long arg)
>  }
>  EXPORT_SYMBOL_GPL(security_file_ioctl);
>
> +/**
> + * security_file_ioctl_compat() - Check if an ioctl is allowed in 32-bit=
 compat mode
> + * @file: associated file
> + * @cmd: ioctl cmd
> + * @arg: ioctl arguments
> + *
> + * Compat version of security_file_ioctl() that correctly handles 32-bit=
 processes
> + * running on 64-bit kernels.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_file_ioctl_compat(struct file *file, unsigned int cmd, unsi=
gned long arg)
> +{
> +       return call_int_hook(file_ioctl_compat, 0, file, cmd, arg);
> +}
> +EXPORT_SYMBOL_GPL(security_file_ioctl_compat);
> +
>  static inline unsigned long mmap_prot(struct file *file, unsigned long p=
rot)
>  {
>         /*
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2aa0e219d721..c617ae21dba8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3731,6 +3731,33 @@ static int selinux_file_ioctl(struct file *file, u=
nsigned int cmd,
>         return error;
>  }
>
> +static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd=
,
> +                             unsigned long arg)
> +{
> +       /*
> +        * If we are in a 64-bit kernel running 32-bit userspace, we need=
 to make
> +        * sure we don't compare 32-bit flags to 64-bit flags.
> +        */
> +       switch (cmd) {
> +       case FS_IOC32_GETFLAGS:
> +               cmd =3D FS_IOC_GETFLAGS;
> +               break;
> +       case FS_IOC32_SETFLAGS:
> +               cmd =3D FS_IOC_SETFLAGS;
> +               break;
> +       case FS_IOC32_GETVERSION:
> +               cmd =3D FS_IOC_GETVERSION;
> +               break;
> +       case FS_IOC32_SETVERSION:
> +               cmd =3D FS_IOC_SETVERSION;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return selinux_file_ioctl(file, cmd, arg);
> +}

Is it considered valid for a native 64-bit task to use 32-bit
FS_IO32_XXX flags?  If not, do we want to remove the FS_IO32_XXX flag
checks in selinux_file_ioctl()?

>  static int default_noexec __ro_after_init;
>
>  static int file_map_prot_check(struct file *file, unsigned long prot, in=
t shared)
> @@ -7036,6 +7063,7 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>         LSM_HOOK_INIT(file_permission, selinux_file_permission),
>         LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
>         LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
> +       LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
>         LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
>         LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
>         LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 65130a791f57..1f1ea8529421 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4973,6 +4973,7 @@ static struct security_hook_list smack_hooks[] __ro=
_after_init =3D {
>
>         LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
>         LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
> +       LSM_HOOK_INIT(file_ioctl_compat, smack_file_ioctl),
>         LSM_HOOK_INIT(file_lock, smack_file_lock),
>         LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
>         LSM_HOOK_INIT(mmap_file, smack_mmap_file),
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 25006fddc964..298d182759c2 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -568,6 +568,7 @@ static struct security_hook_list tomoyo_hooks[] __ro_=
after_init =3D {
>         LSM_HOOK_INIT(path_rename, tomoyo_path_rename),
>         LSM_HOOK_INIT(inode_getattr, tomoyo_inode_getattr),
>         LSM_HOOK_INIT(file_ioctl, tomoyo_file_ioctl),
> +       LSM_HOOK_INIT(file_ioctl_compat, tomoyo_file_ioctl),
>         LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
>         LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
>         LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),

I agree that it looks like Smack and TOMOYO should be fine, but I
would like to hear from Casey and Tetsuo to confirm.

--=20
paul-moore.com

