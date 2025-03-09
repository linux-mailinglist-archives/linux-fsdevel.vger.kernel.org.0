Return-Path: <linux-fsdevel+bounces-43544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ABBA5843B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 14:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 111F97A5EEC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 13:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D9C1D8A0D;
	Sun,  9 Mar 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="xumxX2HC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4018.protonmail.ch (mail-4018.protonmail.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA61DFE8
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Mar 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741526754; cv=none; b=E5Gtb9yFi5Jr7aSwkKvsSGXWfGYFsj/5CHoxyaEuhTe5mA8gw/OFQFqMdKYpbNv4KzM3bsojF7XK/mRPZaBZKaAe1EvSqwMbSc7HfEAtLuATw2NQlNu+95Eshf3hkInvjP7L23BZ9v5dXPKIYlzaOqiKPyIqfXX5ALuHmQ+01ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741526754; c=relaxed/simple;
	bh=Bn9zaSua+NmWgOK3/hsdLYBouAoNeELkTcMf0Cv6mJo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHCitKPBH4MbKFi3FHuqzTqt7UoKT294ZjQU2oz9YcOufQzck5AhsD6xL2MoGAV3f2nN9muxL2B00gHTbE33lctJQ9hlcGJVrxiBipqW8K2Z71TaiJtDCjC9ey608HinktL8i+f8W60kZN7XmvAe/tPfUlXX7DPZqAoideoMDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=xumxX2HC; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail3; t=1741526748; x=1741785948;
	bh=Bn9zaSua+NmWgOK3/hsdLYBouAoNeELkTcMf0Cv6mJo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=xumxX2HC+hxfwqzfssANPOG5xi/S0isNEocvnE6kkn3OX6aGhW7a2tWn57/eekL1D
	 iUObUegItRmiMqCtjiYV36kJuqP/F1jjHjmZEcryoRhX99N2vxIR/vZNIoaw/1UnaR
	 /6Js08abV35Orjnrb2NPUVPhzSRiP6bwVcZluo2Fpj5zrMsHqJz+0M+/mD50iN6urh
	 9cq7YeKW3Nziu/LctvOWF6jrMjRMYOZ/NYDgthpZf2UrpETR0TeI3fgvfxbLdUhsgM
	 fJr0KkS61lVslD0tXUjm8dUanoYBvOQEuObV5d1Fq95N/OEC4LnrcaNbqNGmeO0qRK
	 Qy+oQTRso+a3Q==
Date: Sun, 09 Mar 2025 13:25:43 +0000
To: Christian Brauner <brauner@kernel.org>
From: Mike Yuan <me@yhndnzj.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH v3 06/16] pidfs: allow to retrieve exit information
Message-ID: <kKKfNxo0ChMYE8Mrln8yIXfzaaqO-hbK1tZSij9E6Oa3I7lTQridz9UN9z01N2EuV8tgqnoRtbIFN04dcmKbRRJtNBrLdnvbcuOWOjp5aDE=@yhndnzj.com>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-6-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org> <20250305-work-pidfs-kill_on_last_close-v3-6-c8c3d8361705@kernel.org>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 2657f597560ce721b775e690423d607fc87389d2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






=E5=9C=A8 2025=E5=B9=B43=E6=9C=885=E6=97=A5 =E6=98=9F=E6=9C=9F=E4=B8=89 11:=
08=EF=BC=8CChristian Brauner <brauner@kernel.org> =E5=AF=AB=E9=81=93=
=EF=BC=9A

>=20
>=20
> Some tools like systemd's jounral need to retrieve the exit and cgroup
> information after a process has already been reaped. This can e.g.,
> happen when retrieving a pidfd via SCM_PIDFD or SCM_PEERPIDFD.
>=20
> Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2=
-6-44fdacfaa7b7@kernel.org
> Reviewed-by: Jeff Layton jlayton@kernel.org
>=20
> Signed-off-by: Christian Brauner brauner@kernel.org
>=20
> ---
> fs/pidfs.c | 86 ++++++++++++++++++++++++++++++++++++----------
> include/uapi/linux/pidfd.h | 3 +-
> 2 files changed, 70 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index c4e6527013e7..3c630e9d4a62 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -36,7 +36,8 @@ struct pidfs_exit_info {
> };
>=20
> struct pidfs_inode {
> - struct pidfs_exit_info exit_info;
> + struct pidfs_exit_info __pei;
> + struct pidfs_exit_info *exit_info;
> struct inode vfs_inode;
> };
>=20
> @@ -228,17 +229,28 @@ static __poll_t pidfd_poll(struct file *file, struc=
t poll_table_struct *pts)
> return poll_flags;
> }
>=20
> -static long pidfd_info(struct task_struct *task, unsigned int cmd, unsig=
ned long arg)
> +static inline bool pid_in_current_pidns(const struct pid *pid)
> +{
> + const struct pid_namespace *ns =3D task_active_pid_ns(current);
> +
> + if (ns->level <=3D pid->level)
>=20
> + return pid->numbers[ns->level].ns =3D=3D ns;
>=20
> +
> + return false;
> +}
> +
> +static long pidfd_info(struct file *file, unsigned int cmd, unsigned lon=
g arg)
> {
> struct pidfd_info __user *uinfo =3D (struct pidfd_info __user *)arg;
> + struct inode *inode =3D file_inode(file);
> + struct pid *pid =3D pidfd_pid(file);
> size_t usize =3D _IOC_SIZE(cmd);
> struct pidfd_info kinfo =3D {};
> + struct pidfs_exit_info *exit_info;
> struct user_namespace *user_ns;
> + struct task_struct *task;
> const struct cred *c;
> __u64 mask;
> -#ifdef CONFIG_CGROUPS
> - struct cgroup *cgrp;
> -#endif
>=20
> if (!uinfo)
> return -EINVAL;
> @@ -248,6 +260,37 @@ static long pidfd_info(struct task_struct *task, uns=
igned int cmd, unsigned long
> if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
>=20
> return -EFAULT;
>=20
> + /*
> + * Restrict information retrieval to tasks within the caller's pid
> + * namespace hierarchy.
> + */
> + if (!pid_in_current_pidns(pid))
> + return -ESRCH;
> +
> + if (mask & PIDFD_INFO_EXIT) {
> + exit_info =3D READ_ONCE(pidfs_i(inode)->exit_info);
>=20
> + if (exit_info) {
> + kinfo.mask |=3D PIDFD_INFO_EXIT;
> +#ifdef CONFIG_CGROUPS
> + kinfo.cgroupid =3D exit_info->cgroupid;
>=20
> + kinfo.mask |=3D PIDFD_INFO_CGROUPID;
> +#endif
> + kinfo.exit_code =3D exit_info->exit_code;
>=20
> + }
> + }
> +
> + task =3D get_pid_task(pid, PIDTYPE_PID);
> + if (!task) {
> + /*
> + * If the task has already been reaped, only exit
> + * information is available
> + */
> + if (!(mask & PIDFD_INFO_EXIT))
> + return -ESRCH;
> +
> + goto copy_out;
> + }
> +
> c =3D get_task_cred(task);
> if (!c)
> return -ESRCH;
> @@ -267,11 +310,15 @@ static long pidfd_info(struct task_struct *task, un=
signed int cmd, unsigned long
> put_cred(c);
>=20
> #ifdef CONFIG_CGROUPS
> - rcu_read_lock();
> - cgrp =3D task_dfl_cgroup(task);
> - kinfo.cgroupid =3D cgroup_id(cgrp);
> - kinfo.mask |=3D PIDFD_INFO_CGROUPID;
> - rcu_read_unlock();
> + if (!kinfo.cgroupid) {
> + struct cgroup cgrp;
> +
> + rcu_read_lock();
> + cgrp =3D task_dfl_cgroup(task);
> + kinfo.cgroupid =3D cgroup_id(cgrp);
> + kinfo.mask |=3D PIDFD_INFO_CGROUPID;
> + rcu_read_unlock();
> + }
> #endif
>=20
> /
> @@ -291,6 +338,7 @@ static long pidfd_info(struct task_struct task, unsig=
ned int cmd, unsigned long
> if (kinfo.pid =3D=3D 0 || kinfo.tgid =3D=3D 0 || (kinfo.ppid =3D=3D 0 && =
kinfo.pid !=3D 1))
> return -ESRCH;
>=20
> +copy_out:
> /
> * If userspace and the kernel have the same struct size it can just
> * be copied. If userspace provides an older struct, only the bits that
> @@ -325,7 +373,6 @@ static long pidfd_ioctl(struct file *file, unsigned i=
nt cmd, unsigned long arg)
> {
> struct task_struct *task __free(put_task) =3D NULL;
> struct nsproxy *nsp __free(put_nsproxy) =3D NULL;
> - struct pid *pid =3D pidfd_pid(file);
> struct ns_common *ns_common =3D NULL;
> struct pid_namespace *pid_ns;
>=20
> @@ -340,13 +387,13 @@ static long pidfd_ioctl(struct file *file, unsigned=
 int cmd, unsigned long arg)
> return put_user(file_inode(file)->i_generation, argp);
>=20
> }
>=20
> - task =3D get_pid_task(pid, PIDTYPE_PID);
> - if (!task)
> - return -ESRCH;
> -
> /* Extensible IOCTL that does not open namespace FDs, take a shortcut */
> if (_IOC_NR(cmd) =3D=3D _IOC_NR(PIDFD_GET_INFO))
> - return pidfd_info(task, cmd, arg);
> + return pidfd_info(file, cmd, arg);
> +
> + task =3D get_pid_task(pidfd_pid(file), PIDTYPE_PID);
> + if (!task)
> + return -ESRCH;
>=20
> if (arg)
> return -EINVAL;
> @@ -484,7 +531,7 @@ void pidfs_exit(struct task_struct *tsk)
> dentry =3D stashed_dentry_get(&task_pid(tsk)->stashed);
>=20
> if (dentry) {
> struct inode *inode =3D d_inode(dentry);
> - struct pidfs_exit_info *exit_info =3D &pidfs_i(inode)->exit_info;
>=20
> + struct pidfs_exit_info *exit_info =3D &pidfs_i(inode)->__pei;
>=20
> #ifdef CONFIG_CGROUPS
> struct cgroup *cgrp;
>=20
> @@ -495,6 +542,8 @@ void pidfs_exit(struct task_struct *tsk)
> #endif
> exit_info->exit_code =3D tsk->exit_code;
>=20
>=20
> + /* Ensure that PIDFD_GET_INFO sees either all or nothing. */
> + smp_store_release(&pidfs_i(inode)->exit_info, &pidfs_i(inode)->__pei);
>=20
> dput(dentry);
> }
> }
> @@ -562,7 +611,8 @@ static struct inode *pidfs_alloc_inode(struct super_b=
lock *sb)
> if (!pi)
> return NULL;
>=20
> - memset(&pi->exit_info, 0, sizeof(pi->exit_info));
>=20
> + memset(&pi->__pei, 0, sizeof(pi->__pei));
>=20
> + pi->exit_info =3D NULL;
>=20
>=20
> return &pi->vfs_inode;
>=20
> }
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index e0abd0b18841..5cd5dcbfe884 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -20,6 +20,7 @@
> #define PIDFD_INFO_PID (1UL << 0) /* Always returned, even if not request=
ed /
> #define PIDFD_INFO_CREDS (1UL << 1) / Always returned, even if not reques=
ted /
> #define PIDFD_INFO_CGROUPID (1UL << 2) / Always returned if available, ev=
en if not requested /
> +#define PIDFD_INFO_EXIT (1UL << 3) / Only returned if requested. /
>=20
> #define PIDFD_INFO_SIZE_VER0 64 / sizeof first published struct */
>=20
> @@ -86,7 +87,7 @@ struct pidfd_info {
> __u32 sgid;
> __u32 fsuid;
> __u32 fsgid;
> - __u32 spare0[1];
> + __s32 exit_code;
> };
>=20
> #define PIDFS_IOCTL_MAGIC 0xFF
>=20
> --
> 2.47.2

Acked-by: Mike Yuan <me@yhndnzj.com>

