Return-Path: <linux-fsdevel+bounces-6387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915DE817705
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 17:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0752848F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0464FF74;
	Mon, 18 Dec 2023 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="l/ZmAUWt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681A498B6
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0DB083F2C5
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702915760;
	bh=kNYwHiHA5JKcMtscgMvLBL38WRvjiuLJSkgC6rbFZ7U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type;
	b=l/ZmAUWtkqQ+10ETnBZ274OzaGVzhfP+xPGq7hszTsy/8mWoirYqfEfvHpqPwo6Fl
	 i9xydUjx6M6lPl3TNdNmS2MTJgSTY6P+sCyDNdqhg9ZSFicgKIjyiKR5hOhRuHaC3o
	 BPRKSi/aZApzy+D7ocf9e+kDTADiKlbOKDM/QnFKNzEz7I9JujM8lccahorwKt3PNE
	 L3TRfJ/P5hi3RkLuEUfOkmjG5guZIAyXdtwADqq+ifjudEsy/KbN6JdLPpMABTz/iJ
	 Wgf74hOetM3makk5F8IDQR1lVB9uJAYdjA/CcMJcvmPESjhsmA1v0fQNxv2MqYxo0w
	 8a3S3qs8gy6bA==
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2cc77fdf765so5102141fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Dec 2023 08:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915759; x=1703520559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNYwHiHA5JKcMtscgMvLBL38WRvjiuLJSkgC6rbFZ7U=;
        b=vzqCT/SWg+5J+4Hnte1DuQvQhvGx0zgIKkeSr+SJeYaJu7xY3N+l35KXE9F7+ATkRI
         cz+Nvct55RXS9E11KvnySw82YZOZCoye7MutmfWlOTI/0fOXD0ArM6IVx3+W+jut2xaA
         Yf1KtXjCVRC97dQzfPASP2Maf/uzVn+lCCHLbjLHQsHIFK9ocb5ZzLerzWgXkX6StySC
         P/a8iL9VuXYkwNT8qQAJpkB7ZCM99XPASY0fiNwVPCfpCZpPmbiuc3CTdghTcDkFfYAx
         kxdyAFTr071+1nZD4jsJE3wU9Q85isYadiVD4U3cUN3RUS2HUZNy0kpcL4dnYZbfDmen
         gyOQ==
X-Gm-Message-State: AOJu0Yzodo69pMbnd5gEo8IneUZoi63sIZfjSJl4dCAxgZUkYweTkVCA
	2bJtYdgEbCKWk3Hn4OONJTGiMtdOdnpgRzG8BbXsbId8nieYBOOZADKaJhjk9BNOMvs4n78qJNX
	TCjvma1K+aH6S3/B0ZVgoddDBXpPv0dUrbXyaotdZYhc=
X-Received: by 2002:a05:6512:e9d:b0:50c:e34:aefb with SMTP id bi29-20020a0565120e9d00b0050c0e34aefbmr8832317lfb.28.1702915759316;
        Mon, 18 Dec 2023 08:09:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH138o8H7nauPEk8k8DiVgXeX1uyyz7taOvKkvO/g6Lcsmaba+QT3xQknAbOyCb0brKGEAaXg==
X-Received: by 2002:a05:6512:e9d:b0:50c:e34:aefb with SMTP id bi29-20020a0565120e9d00b0050c0e34aefbmr8832293lfb.28.1702915758798;
        Mon, 18 Dec 2023 08:09:18 -0800 (PST)
Received: from amikhalitsyn (ip5b408b16.dynamic.kabel-deutschland.de. [91.64.139.22])
        by smtp.gmail.com with ESMTPSA id k20-20020a17090646d400b00a23640f7f23sm651738ejs.47.2023.12.18.08.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 08:09:18 -0800 (PST)
Date: Mon, 18 Dec 2023 17:09:16 +0100
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Michael =?ISO-8859-1?Q?Wei=DF?= <michael.weiss@aisec.fraunhofer.de>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, Alexei Starovoitov
 <ast@kernel.org>, Paul Moore <paul@paul-moore.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Quentin Monnet
 <quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Miklos
 Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, gyroidos@aisec.fraunhofer.de
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
Message-Id: <20231218170916.cd319dbcf83f2dd7da24e48f@canonical.com>
In-Reply-To: <20231215-eiern-drucken-69cf4780d942@brauner>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
	<20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
	<20231215-golfanlage-beirren-f304f9dafaca@brauner>
	<61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
	<20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner>
	<20231215-eiern-drucken-69cf4780d942@brauner>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Dec 2023 17:36:12 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Fri, Dec 15, 2023 at 03:15:33PM +0100, Christian Brauner wrote:
> > On Fri, Dec 15, 2023 at 02:26:53PM +0100, Michael Wei=DF wrote:
> > > On 15.12.23 13:31, Christian Brauner wrote:
> > > > On Wed, Dec 13, 2023 at 03:38:13PM +0100, Michael Wei=DF wrote:
> > > >> devguard is a simple LSM to allow CAP_MKNOD in non-initial user
> > > >> namespace in cooperation of an attached cgroup device program. We
> > > >> just need to implement the security_inode_mknod() hook for this.
> > > >> In the hook, we check if the current task is guarded by a device
> > > >> cgroup using the lately introduced cgroup_bpf_current_enabled()
> > > >> helper. If so, we strip out SB_I_NODEV from the super block.
> > > >>
> > > >> Access decisions to those device nodes are then guarded by existing
> > > >> device cgroups mechanism.
> > > >>
> > > >> Signed-off-by: Michael Wei=DF <michael.weiss@aisec.fraunhofer.de>
> > > >> ---
> > > >=20
> > > > I think you misunderstood me... My point was that I believe you don=
't
> > > > need an additional LSM at all and no additional LSM hook. But I mig=
ht be
> > > > wrong. Only a POC would show.
> > >=20
> > > Yeah sorry, I got your point now.
> >=20
> > I think I might have had a misconception about how this works.
> > A bpf LSM program can't easily alter a kernel object such as struct
> > super_block I've been told.
>=20
> Which is why you need that new hook in there. I get it now. In any case,
> I think we can do this slightly nicer (for some definition of nice)...
>=20
> So the thing below moves the capability check for mknod into the
> security_inode_mknod() hook (This should be a separate patch.).
>=20
> It moves raising SB_I_NODEV into security_sb_device_access() and the old
> semantics are retained if no LSM claims device management. If an LSM
> claims device management we raise the new flag and don't even raise
> SB_I_NODEV. The capability check is namespace aware if device management
> is claimed by an LSM. That's backward compatible. And we don't need any
> sysctl.
>=20
> What's missing is that all devcgroup_*() calls should be moved into a
> new, unified security_device_access() hook that's called consistently in
> all places where that matters such as blkdev_get_by_dev() and so on. Let
> the bpf lsm implement that new hook.
>=20
> Then write a sample BPF LSM as POC that this works. This would also
> all other LSMs to do device management if they wanted to.
>=20
> Thoughts?

Dear colleagues,
Dear Christian,

As far as I understand Christian's idea is to remain mknod capability check=
s decoupled from the device cgroups checks.
It looks sane and less error prone.

So we want to:
- use BPF LSM sb_device_access hook to disable SB_I_NODEV raising for non-r=
oot-userns superblocks
- use BPF LSM inode_permission hook to actually filter if we want this devi=
ce to be permitted or not (alternatively we can use device cgroup).

The only thing that is not clear to me about the sb_device_access hook is, =
what we can check inside it practically?
Yes, we have an access to struct super_block, but at this point this struct=
ure is not filled with anything useful. We only
can determine a filesystem type and that's all. It means that we can use th=
is hook as a flag that says "ok, we do care about device permissions,
kernel, please do not set SB_I_NODEV for us". Am I correct?

Kind regards,
Alex

>=20
> From 7f4177e4f87e0b0182022f114c0287a0f0985752 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <brauner@kernel.org>
> Date: Fri, 15 Dec 2023 17:22:26 +0100
> Subject: [PATCH] UNTESTED, UNCOMPILED, PROBABLY BUGGY
>=20
> Signed-off-and-definitely-neither-compiled-nor-tested-by: Christian Braun=
er <brauner@kernel.org>
> ---
>  fs/namei.c                    |  5 -----
>  fs/namespace.c                | 11 +++++++----
>  fs/super.c                    |  6 ++++--
>  include/linux/fs.h            |  1 +
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      | 15 ++++++++++++---
>  security/commoncap.c          | 19 +++++++++++++++++++
>  security/security.c           | 22 ++++++++++++++++++++++
>  8 files changed, 66 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 71c13b2990b4..da481e6a696c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3959,16 +3959,11 @@ EXPORT_SYMBOL(user_path_create);
>  int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	      struct dentry *dentry, umode_t mode, dev_t dev)
>  {
> -	bool is_whiteout =3D S_ISCHR(mode) && dev =3D=3D WHITEOUT_DEV;
>  	int error =3D may_create(idmap, dir, dentry);
> =20
>  	if (error)
>  		return error;
> =20
> -	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
> -	    !capable(CAP_MKNOD))
> -		return -EPERM;
> -
>  	if (!dir->i_op->mknod)
>  		return -EPERM;
> =20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index fbf0e596fcd3..e87cc0320091 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4887,7 +4887,6 @@ static bool mnt_already_visible(struct mnt_namespac=
e *ns,
> =20
>  static bool mount_too_revealing(const struct super_block *sb, int *new_m=
nt_flags)
>  {
> -	const unsigned long required_iflags =3D SB_I_NOEXEC | SB_I_NODEV;
>  	struct mnt_namespace *ns =3D current->nsproxy->mnt_ns;
>  	unsigned long s_iflags;
> =20
> @@ -4899,9 +4898,13 @@ static bool mount_too_revealing(const struct super=
_block *sb, int *new_mnt_flags
>  	if (!(s_iflags & SB_I_USERNS_VISIBLE))
>  		return false;
> =20
> -	if ((s_iflags & required_iflags) !=3D required_iflags) {
> -		WARN_ONCE(1, "Expected s_iflags to contain 0x%lx\n",
> -			  required_iflags);
> +	if (!(s_iflags & SB_I_NOEXEC)) {
> +		WARN_ONCE(1, "Expected s_iflags to contain SB_I_NOEXEC\n");
> +		return true;
> +	}
> +
> +	if (!(s_iflags & (SB_I_NODEV | SB_I_MANAGED_DEVICES))) {
> +		WARN_ONCE(1, "Expected s_iflags to contain device access mask\n");
>  		return true;
>  	}
> =20
> diff --git a/fs/super.c b/fs/super.c
> index 076392396e72..7b8098db17c9 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -362,8 +362,10 @@ static struct super_block *alloc_super(struct file_s=
ystem_type *type, int flags,
>  	}
>  	s->s_bdi =3D &noop_backing_dev_info;
>  	s->s_flags =3D flags;
> -	if (s->s_user_ns !=3D &init_user_ns)
> -		s->s_iflags |=3D SB_I_NODEV;
> +
> +	if (security_sb_device_access(s))
> +		goto fail;
> +
>  	INIT_HLIST_NODE(&s->s_instances);
>  	INIT_HLIST_BL_HEAD(&s->s_roots);
>  	mutex_init(&s->s_sync_lock);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 98b7a7a8c42e..6ca0fe922478 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1164,6 +1164,7 @@ extern int send_sigurg(struct fown_struct *fown);
>  #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
>  #define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
>  #define SB_I_UNTRUSTED_MOUNTER		0x00000040
> +#define SB_I_MANAGED_DEVICES		0x00000080
> =20
>  #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
>  #define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 3fdd00b452ac..8c8a0d8aa71d 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -60,6 +60,7 @@ LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
>  LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
>  	 struct fs_parameter *param)
>  LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
> +LSM_HOOK(int, 0, sb_device_access, struct super_block *sb)
>  LSM_HOOK(void, LSM_RET_VOID, sb_delete, struct super_block *sb)
>  LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
>  LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 00809d2d5c38..a174f8c09594 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -155,6 +155,8 @@ extern int cap_capset(struct cred *new, const struct =
cred *old,
>  extern int cap_bprm_creds_from_file(struct linux_binprm *bprm, const str=
uct file *file);
>  int cap_inode_setxattr(struct dentry *dentry, const char *name,
>  		       const void *value, size_t size, int flags);
> +int cap_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mo=
de,
> +		    dev_t dev);
>  int cap_inode_removexattr(struct mnt_idmap *idmap,
>  			  struct dentry *dentry, const char *name);
>  int cap_inode_need_killpriv(struct dentry *dentry);
> @@ -348,6 +350,7 @@ int security_inode_symlink(struct inode *dir, struct =
dentry *dentry,
>  int security_inode_mkdir(struct inode *dir, struct dentry *dentry, umode=
_t mode);
>  int security_inode_rmdir(struct inode *dir, struct dentry *dentry);
>  int security_inode_mknod(struct inode *dir, struct dentry *dentry, umode=
_t mode, dev_t dev);
> +int security_sb_device_access(struct super_block *sb);
>  int security_inode_rename(struct inode *old_dir, struct dentry *old_dent=
ry,
>  			  struct inode *new_dir, struct dentry *new_dentry,
>  			  unsigned int flags);
> @@ -823,10 +826,16 @@ static inline int security_inode_rmdir(struct inode=
 *dir,
>  	return 0;
>  }
> =20
> -static inline int security_inode_mknod(struct inode *dir,
> -					struct dentry *dentry,
> -					int mode, dev_t dev)
> +static inline int security_inode_mknod(struct inode *dir, struct dentry =
*dentry,
> +				       int mode, dev_t dev)
> +{
> +	return cap_inode_mknod(dir, dentry, mode, dev);
> +}
> +
> +static inline int security_sb_device_access(struct super_block *sb)
>  {
> +	if (s->s_user_ns !=3D &init_user_ns)
> +		sb->s_iflags |=3D SB_I_NODEV;
>  	return 0;
>  }
> =20
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 8e8c630ce204..f4a208fdf939 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1438,6 +1438,24 @@ int cap_mmap_file(struct file *file, unsigned long=
 reqprot,
>  	return 0;
>  }
> =20
> +int cap_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mo=
de,
> +		    dev_t dev)
> +{
> +	bool is_whiteout =3D S_ISCHR(mode) && dev =3D=3D WHITEOUT_DEV;
> +	struct super_block *sb =3D dir->i_sb;
> +	struct user_namespace *userns;
> +
> +	if (dir->i_sb->s_iflags & SB_I_MANAGED_DEVICES)
> +		userns =3D sb->s_user_ns;
> +	else
> +		userns =3D &init_user_ns;
> +	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
> +	    !ns_capable(userns, CAP_MKNOD))
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_SECURITY
> =20
>  static struct security_hook_list capability_hooks[] __ro_after_init =3D {
> @@ -1448,6 +1466,7 @@ static struct security_hook_list capability_hooks[]=
 __ro_after_init =3D {
>  	LSM_HOOK_INIT(capget, cap_capget),
>  	LSM_HOOK_INIT(capset, cap_capset),
>  	LSM_HOOK_INIT(bprm_creds_from_file, cap_bprm_creds_from_file),
> +	LSM_HOOK_INIT(inode_mknod, cap_inode_mknod),
>  	LSM_HOOK_INIT(inode_need_killpriv, cap_inode_need_killpriv),
>  	LSM_HOOK_INIT(inode_killpriv, cap_inode_killpriv),
>  	LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
> diff --git a/security/security.c b/security/security.c
> index 088a79c35c26..192b992f1a34 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1221,6 +1221,28 @@ int security_sb_alloc(struct super_block *sb)
>  	return rc;
>  }
> =20
> +int security_sb_device_access(struct super_block *sb)
> +{
> +	int rc;
> +
> +	rc =3D call_int_hook(sb_device_access, 0, sb);
> +	switch (rc) {
> +	case 0:
> +		/*
> +		 * LSM doesn't do device access management and this is an
> +		 * untrusted mount so block all device access.
> +		 */
> +		if (sb->s_user_ns !=3D &init_user_ns)
> +			sb->s_iflags |=3D SB_I_NODEV;
> +		return 0;
> +	case 1:
> +		sb->s_iflags |=3D SB_I_MANAGED_DEVICES;
> +		return 0;
> +	}
> +
> +	return rc;
> +}
> +
>  /**
>   * security_sb_delete() - Release super_block LSM associated objects
>   * @sb: filesystem superblock
> --=20
> 2.42.0
>=20
>=20


