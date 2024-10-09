Return-Path: <linux-fsdevel+bounces-31441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A77996D49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20CB283097
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCE21993B8;
	Wed,  9 Oct 2024 14:07:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15518E744
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482842; cv=none; b=dw3w1AQ76J8oj+qEzY0GUi3LPYsWMWKMWJetGzy8rbwxuwv9mTuzkGvaaTLYLRdQ3k6ALNVC53RDjZ3J+5zfbyIpX/jurdl0yB3Fwwc09/kBARBwD4/8vMScwRvjJ/sL6qGjOWKDGO22+QedaVMQlvaRsZ8idm/MOo/8eSVdWmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482842; c=relaxed/simple;
	bh=TlxsiZrXb7aTFb68kF1tLgiPFvBrwRVIjNGmdUCxX7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Grsc7NT34xmhKTwGZLRdsczryj3FDioMIWqUP4s/lXPu3CboXG6we07m98rHfnDGf84PLZAnNrYHgwmXnZKM3CPDLqD0dqxOSVafVd7ZGLL+hXW87FArdSvVHdfjUPD6plPXcq7Rl3vGDlbOTUuId01Gf2FyghZ3nfEAWx7zIN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-182-iTq8zAsPPk2hh1udKkCmwQ-5; Wed, 09 Oct 2024 15:07:12 +0100
X-MC-Unique: iTq8zAsPPk2hh1udKkCmwQ-5
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 9 Oct
 2024 15:01:17 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 9 Oct 2024 15:01:17 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'luca.boccassi@gmail.com'" <luca.boccassi@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "christian@brauner.io" <christian@brauner.io>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>
Subject: RE: [PATCH v10] pidfd: add ioctl to retrieve pid info
Thread-Topic: [PATCH v10] pidfd: add ioctl to retrieve pid info
Thread-Index: AQHbGYTgRKh3uESbRU+0eRxIO/BekbJ+bnoQ
Date: Wed, 9 Oct 2024 14:01:17 +0000
Message-ID: <6a45d8bf01c241a9a87c8f71e83a0c79@AcuMS.aculab.com>
References: <20241008132051.1011467-1-luca.boccassi@gmail.com>
In-Reply-To: <20241008132051.1011467-1-luca.boccassi@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: luca.boccassi@gmail.com
> Sent: 08 October 2024 14:20
>=20
> A common pattern when using pid fds is having to get information
> about the process, which currently requires /proc being mounted,
> resolving the fd to a pid, and then do manual string parsing of
> /proc/N/status and friends. This needs to be reimplemented over
> and over in all userspace projects (e.g.: I have reimplemented
> resolving in systemd, dbus, dbus-daemon, polkit so far), and
> requires additional care in checking that the fd is still valid
> after having parsed the data, to avoid races.
>=20
> Having a programmatic API that can be used directly removes all
> these requirements, including having /proc mounted.
>=20
> As discussed at LPC24, add an ioctl with an extensible struct
> so that more parameters can be added later if needed. Start with
> returning pid/tgid/ppid and creds unconditionally, and cgroupid
> optionally.
...
>  fs/pidfs.c                                    | 91 ++++++++++++++++++-
>  include/uapi/linux/pidfd.h                    | 31 +++++++
>  .../testing/selftests/pidfd/pidfd_open_test.c | 78 +++++++++++++++-
>  3 files changed, 196 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 80675b6bf884..3b24124a4f41 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -2,6 +2,7 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/cgroup.h>
>  #include <linux/magic.h>
>  #include <linux/mount.h>
>  #include <linux/pid.h>
> @@ -114,6 +115,86 @@ static __poll_t pidfd_poll(struct file *file, struct=
 poll_table_struct *pts)
>  =09return poll_flags;
>  }
>=20
> +static long pidfd_info(struct task_struct *task, unsigned int cmd, unsig=
ned long arg)
> +{
> +=09struct pidfd_info __user *uinfo =3D (struct pidfd_info __user *)arg;
> +=09size_t usize =3D _IOC_SIZE(cmd);
> +=09struct pidfd_info kinfo =3D {};
> +=09struct user_namespace *user_ns;
> +=09const struct cred *c;
> +=09__u64 request_mask;
> +
> +=09if (!uinfo)
> +=09=09return -EINVAL;
> +=09if (usize < sizeof(struct pidfd_info))
> +=09=09return -EINVAL; /* First version, no smaller struct possible */

That is the wrong test, if/when someone allocates an extra field it will
be wrong.
You could use an explicit 64 (the size of the initial version) or something
that ends up being 8.

> +
> +=09if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(reques=
t_mask)))
> +=09=09return -EFAULT;

You should probably use get_user() here.

> +
> +=09c =3D get_task_cred(task);
> +=09if (!c)
> +=09=09return -ESRCH;
> +
> +=09/* Unconditionally return identifiers and credentials, the rest only =
on request */
> +
> +=09user_ns =3D current_user_ns();
> +=09kinfo.ruid =3D from_kuid_munged(user_ns, c->uid);
> +=09kinfo.rgid =3D from_kgid_munged(user_ns, c->gid);
> +=09kinfo.euid =3D from_kuid_munged(user_ns, c->euid);
> +=09kinfo.egid =3D from_kgid_munged(user_ns, c->egid);
> +=09kinfo.suid =3D from_kuid_munged(user_ns, c->suid);
> +=09kinfo.sgid =3D from_kgid_munged(user_ns, c->sgid);
> +=09kinfo.fsuid =3D from_kuid_munged(user_ns, c->fsuid);
> +=09kinfo.fsgid =3D from_kgid_munged(user_ns, c->fsgid);
> +=09put_cred(c);
> +
> +#ifdef CONFIG_CGROUPS
> +=09if (request_mask & PIDFD_INFO_CGROUPID) {
> +=09=09/*
> +=09=09 * The cgroup id cannot be retrieved anymore after the task has ex=
ited
> +=09=09 * (even if it has not been reaped yet), contrary to other fields.=
 Set
> +=09=09 * the flag only if we can still access it. */
> +=09=09struct cgroup *cgrp;
> +
> +=09=09guard(rcu)();
> +=09=09cgrp =3D task_cgroup(task, pids_cgrp_id);
> +=09=09if (cgrp) {
> +=09=09=09kinfo.cgroupid =3D cgroup_id(cgrp);
> +=09=09=09kinfo.request_mask |=3D PIDFD_INFO_CGROUPID;
> +=09=09}
> +=09}
> +#endif
> +
> +=09/*
> +=09 * Copy pid/tgid last, to reduce the chances the information might be
> +=09 * stale. Note that it is not possible to ensure it will be valid as =
the
> +=09 * task might return as soon as the copy_to_user finishes, but that's=
 ok
> +=09 * and userspace expects that might happen and can act accordingly, s=
o
> +=09 * this is just best-effort. What we can do however is checking that =
all
> +=09 * the fields are set correctly, or return ESRCH to avoid providing
> +=09 * incomplete information. */
> +
> +=09kinfo.ppid =3D task_ppid_nr_ns(task, NULL);
> +=09kinfo.tgid =3D task_tgid_vnr(task);
> +=09kinfo.pid =3D task_pid_vnr(task);
> +
> +=09if (kinfo.pid =3D=3D 0 || kinfo.tgid =3D=3D 0 || (kinfo.ppid =3D=3D 0=
 && kinfo.pid !=3D 1))
> +=09=09return -ESRCH;
> +
> +=09/*
> +=09 * If userspace and the kernel have the same struct size it can just
> +=09 * be copied. If userspace provides an older struct, only the bits th=
at
> +=09 * userspace knows about will be copied. If userspace provides a new
> +=09 * struct, only the bits that the kernel knows about will be copied a=
nd
> +=09 * the size value will be set to the size the kernel knows about.

There is no 'size value'.
I'm not 100% sure but I think you should zero the rest of the user structur=
e.

Also if more 'unconditional' fields are added the application won't be
able to easily tell if they are unsupported or just happen to be zero.
So maybe for consistency there should be PIDFD_INFO_xxx bits for the uids
and pids that indicate that the values are valid - even if they are always
set in the response.

> +=09 */
> +=09if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
> +=09=09return -EFAULT;
> +
> +=09return 0;
> +}
> +
>  static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned lo=
ng arg)
>  {
>  =09struct task_struct *task __free(put_task) =3D NULL;
> @@ -122,13 +203,17 @@ static long pidfd_ioctl(struct file *file, unsigned=
 int cmd, unsigned long arg)
>  =09struct ns_common *ns_common =3D NULL;
>  =09struct pid_namespace *pid_ns;
>=20
> -=09if (arg)
> -=09=09return -EINVAL;
> -
>  =09task =3D get_pid_task(pid, PIDTYPE_PID);
>  =09if (!task)
>  =09=09return -ESRCH;
>=20
> +=09/* Extensible IOCTL that does not open namespace FDs, take a shortcut=
 */
> +=09if (_IOC_NR(cmd) =3D=3D _IOC_NR(PIDFD_GET_INFO))
> +=09=09return pidfd_info(task, cmd, arg);
> +
> +=09if (arg)
> +=09=09return -EINVAL;
> +
>  =09scoped_guard(task_lock, task) {
>  =09=09nsp =3D task->nsproxy;
>  =09=09if (nsp)
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index 565fc0629fff..5501cd808517 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -16,6 +16,36 @@
>  #define PIDFD_SIGNAL_THREAD_GROUP=09(1UL << 1)
>  #define PIDFD_SIGNAL_PROCESS_GROUP=09(1UL << 2)
>=20
> +/* Flags for pidfd_info. */
> +#define PIDFD_INFO_CGROUPID=09=09(1UL << 0)
> +
> +struct pidfd_info {
> +=09/* Let userspace request expensive stuff explictly, and let the kerne=
l
> +=09 * indicate whether it knows about it, and/or whether it can still re=
trieve
> +=09 * it (e.g.: the cgroup id is not available after the task has exited=
). */
> +=09__u64 request_mask;
> +=09/*
> +=09 * The information contained in the following fields might be stale a=
t the
> +=09 * time it is received, as the target process might have exited as so=
on as
> +=09 * the IOCTL was processed, and there is no way to avoid that. Howeve=
r, it
> +=09 * is guaranteed that if the call was successful, then the informatio=
n was
> +=09 * correct and referred to the intended process at the time the work =
was
> +=09 * performed. */
> +=09__u64 cgroupid;
> +=09__u32 pid;
> +=09__u32 tgid;
> +=09__u32 ppid;
> +=09__u32 ruid;
> +=09__u32 rgid;
> +=09__u32 euid;
> +=09__u32 egid;
> +=09__u32 suid;
> +=09__u32 sgid;
> +=09__u32 fsuid;
> +=09__u32 fsgid;
> +=09__u32 spare0[1];

That should be __u32 pad;
Although it may not even be needed.
It shouldn't matter if the ioctl from a 32bit app is 4 bytes short.
Any extension can safely add extra fields at the end.

=09David

> +};
> +
>  #define PIDFS_IOCTL_MAGIC 0xFF
>=20
>  #define PIDFD_GET_CGROUP_NAMESPACE            _IO(PIDFS_IOCTL_MAGIC, 1)
> @@ -28,5 +58,6 @@
>  #define PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE _IO(PIDFS_IOCTL_MAGIC, 8)
>  #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
>  #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
> +#define PIDFD_GET_INFO                        _IOWR(PIDFS_IOCTL_MAGIC, 1=
1, struct pidfd_info)
>=20
>  #endif /* _UAPI_LINUX_PIDFD_H */
> diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c
> b/tools/testing/selftests/pidfd/pidfd_open_test.c
> index c62564c264b1..036e517246a3 100644
> --- a/tools/testing/selftests/pidfd/pidfd_open_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
> @@ -13,6 +13,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <syscall.h>
> +#include <sys/ioctl.h>
>  #include <sys/mount.h>
>  #include <sys/prctl.h>
>  #include <sys/wait.h>
> @@ -21,6 +22,32 @@
>  #include "pidfd.h"
>  #include "../kselftest.h"
>=20

I'd comment that the definitions below are needed to compile
with old userspace.
(Do the selftests actually need that?)

=09David

> +#ifndef PIDFS_IOCTL_MAGIC
> +#define PIDFS_IOCTL_MAGIC 0xFF
> +#endif
> +
> +#ifndef PIDFD_GET_INFO
> +#define PIDFD_GET_INFO _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
> +#define PIDFD_INFO_CGROUPID=09=09(1UL << 0)
> +
> +struct pidfd_info {
> +=09__u64 request_mask;
> +=09__u64 cgroupid;
> +=09__u32 pid;
> +=09__u32 tgid;
> +=09__u32 ppid;
> +=09__u32 ruid;
> +=09__u32 rgid;
> +=09__u32 euid;
> +=09__u32 egid;
> +=09__u32 suid;
> +=09__u32 sgid;
> +=09__u32 fsuid;
> +=09__u32 fsgid;
> +=09__u32 spare0[1];
> +};
> +#endif
> +
>  static int safe_int(const char *numstr, int *converted)
>  {
>  =09char *err =3D NULL;
> @@ -120,10 +147,13 @@ static pid_t get_pid_from_fdinfo_file(int pidfd, co=
nst char *key, size_t keylen)
>=20
>  int main(int argc, char **argv)
>  {
> +=09struct pidfd_info info =3D {
> +=09=09.request_mask =3D PIDFD_INFO_CGROUPID,
> +=09};
>  =09int pidfd =3D -1, ret =3D 1;
>  =09pid_t pid;
>=20
> -=09ksft_set_plan(3);
> +=09ksft_set_plan(4);
>=20
>  =09pidfd =3D sys_pidfd_open(-1, 0);
>  =09if (pidfd >=3D 0) {
> @@ -153,6 +183,52 @@ int main(int argc, char **argv)
>  =09pid =3D get_pid_from_fdinfo_file(pidfd, "Pid:", sizeof("Pid:") - 1);
>  =09ksft_print_msg("pidfd %d refers to process with pid %d\n", pidfd, pid=
);
>=20
> +=09if (ioctl(pidfd, PIDFD_GET_INFO, &info) < 0) {
> +=09=09ksft_print_msg("%s - failed to get info from pidfd\n", strerror(er=
rno));
> +=09=09goto on_error;
> +=09}
> +=09if (info.pid !=3D pid) {
> +=09=09ksft_print_msg("pid from fdinfo file %d does not match pid from io=
ctl %d\n",
> +=09=09=09       pid, info.pid);
> +=09=09goto on_error;
> +=09}
> +=09if (info.ppid !=3D getppid()) {
> +=09=09ksft_print_msg("ppid %d does not match ppid from ioctl %d\n",
> +=09=09=09       pid, info.pid);
> +=09=09goto on_error;
> +=09}
> +=09if (info.ruid !=3D getuid()) {
> +=09=09ksft_print_msg("uid %d does not match uid from ioctl %d\n",
> +=09=09=09       getuid(), info.ruid);
> +=09=09goto on_error;
> +=09}
> +=09if (info.rgid !=3D getgid()) {
> +=09=09ksft_print_msg("gid %d does not match gid from ioctl %d\n",
> +=09=09=09       getgid(), info.rgid);
> +=09=09goto on_error;
> +=09}
> +=09if (info.euid !=3D geteuid()) {
> +=09=09ksft_print_msg("euid %d does not match euid from ioctl %d\n",
> +=09=09=09       geteuid(), info.euid);
> +=09=09goto on_error;
> +=09}
> +=09if (info.egid !=3D getegid()) {
> +=09=09ksft_print_msg("egid %d does not match egid from ioctl %d\n",
> +=09=09=09       getegid(), info.egid);
> +=09=09goto on_error;
> +=09}
> +=09if (info.suid !=3D geteuid()) {
> +=09=09ksft_print_msg("suid %d does not match suid from ioctl %d\n",
> +=09=09=09       geteuid(), info.suid);
> +=09=09goto on_error;
> +=09}
> +=09if (info.sgid !=3D getegid()) {
> +=09=09ksft_print_msg("sgid %d does not match sgid from ioctl %d\n",
> +=09=09=09       getegid(), info.sgid);
> +=09=09goto on_error;
> +=09}
> +=09ksft_test_result_pass("get info from pidfd test: passed\n");
> +
>  =09ret =3D 0;
>=20
>  on_error:
>=20
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> --
> 2.45.2
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


