Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 563D664AD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 18:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfGJQiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 12:38:22 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:33609
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727319AbfGJQiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562776697; bh=nkNGRriYOMRLtkV9kEjqzGoMrOh0jcF1yehgXKUnor8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Bybyk+q0A7sm5RrCDknX+kOlaQ3PoICK7CR0yICrtRJ/9zvKUadMOi9GZd8/jhxUxsejLJtWkyD1fYS0OJSDI79qYbwo/o5NnXpVkVDQiZeB13+2061cAW9rgVdA3A6/FnxHLiSDc+kyLxnAiVl6a5gPPxj74Adm0KbAz1M+bVGF5X22ybVLqLwoXvs8H/YvjySRQLAkVUdly7JV9qzHYwWSQoIOftPxY66EWttcsHpj+CdoP6ADggDuBJ9pV/kriCy+dA7QPLTSfXNf51SdZ90jsNKp9hfWvgSa1HYbfCy/x/Or1D60HzxMqsaN0sH5aDcmFydbQrkpCTL82rWrSg==
X-YMail-OSG: 6kd5j9wVM1lT4CvRK6QTLe1KEiEhemG_nBhhBZ13oyve.6tn2LaNn5p8kJb_xph
 r6LanUrI4cUTMlCfRJLig8QElXJJShztS5ybAWhAv7TiM0HLuroDsRFyQy1uKBkKdzJ3RAX464MO
 rnUaXenjDtoU50T6TKOhD_gmrCk.9b5YybfmHK4NXcDNbzoF.zhs2WKeiBJDuizrnG5I0Ds2XizZ
 xviCvQzWOGqkOe3NN0XNdA7gVv3Lk29yyutBEc01HK4N.wZPuvYksoP0HuSPYO45fjJdOnAijWG.
 8sYXwfRyzwnkcL87VXOaK_dUU54pk2fkwYJSyBh8vR4iktv6_BctOZBL_qN03Hu.DX.R0rdId_UI
 G5bs1jQPe8LUhBxqJF4gG3uRFRB8EDXBPT6R2F8bjuAJc3xPIGcwkb9PUdRVwmW4kugEIgExOtD8
 ZVhRGwTvGy9nYCTFACb0Vt3YK8xOJ.S.0n5jj_YgMM2EEevnUigvJnUlrvJcFT7HeEpinJ45IWX9
 j6R2lHhygGU6GieoJufMAR4FyEOnQ8a_yinzGUxaL4hCDiCzm576PTWMKv7_ex1C7zJmxHGVLmnI
 m2JjVxzH2GQCAK1lc9SFkA5LinliHn_2KtwPAbMy_Rz5.cA8W0fgVoZ6eEqxVj.LSOy8TQaxrBC6
 QcWjfPl7BJ2kf9uwxctK6QHicLQ9coAlDCyePmuwfYXzTkz46eQbhHHRiLE1q.xUgtMf_ZzxfFzD
 DlykrUJXmu_FVc647.cbQWfWv0ZSliBiU_blf_ZgXp3jrYe94DfoofJ9jkO2BstPqv5_B.6ZmXkY
 Eu0Gpg9vok3qmWjamsK72L4NkezmKX37MgIJUzZ0YztcxGwHtHK8pqgJNqMm.5cJzoDecDNL76Zc
 ycR6Ra_c8aKRoyINVTqSkMUcv9J_BtF1sNd8baET7FqFctgZ5X3mhzWPmgxCv8xCCfwMOg6gOgNi
 p9NOv62_OzAihUFtCLxpwPmNFUjCHqHWaMk5fyl_khXLQ8FvGpbx3JVQ87pjlEqAfV2we0miv5.o
 iw0gQHuIUUteVguFhv0ZHbMS.qslBoCA_dEJoSweOBn0rLQKNgALTeG9NdtZ5gE_5KCKVwKJ1vSe
 x0OLpJyG.uaohQBv0t2D8tk6VMgdh7sXcTcAJqqkSFvIqwP2MCYMPLwuqXZyR1sadlQ.jI9pJZLu
 ilysoTcc420HgDt.teMsIcSpBLJNls8DUe7.So0AjJFyWcQ2KuaTMnKl0aaWplVySFfOOU98E_zt
 u4wmpe2HG7mwsZ5ZZnQ6Yc.rY0EYZvFXkyUtWeQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jul 2019 16:38:17 +0000
Received: by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9b62d72eb53e9fa55ee4d7373f8817fb;
          Wed, 10 Jul 2019 16:38:14 +0000 (UTC)
Subject: Re: [RFC PATCH] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
To:     Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, jmorris@namei.org, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <20190710133403.855-1-acgoide@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <4fd98c88-61a6-a155-5028-db22a778d3c1@schaufler-ca.com>
Date:   Wed, 10 Jul 2019 09:38:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710133403.855-1-acgoide@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/10/2019 6:34 AM, Aaron Goidel wrote:
> As of now, setting watches on filesystem objects has, at most, applied =
a
> check for read access to the inode, and in the case of fanotify, requir=
es
> CAP_SYS_ADMIN. No specific security hook or permission check has been
> provided to control the setting of watches. Using any of inotify, dnoti=
fy,
> or fanotify, it is possible to observe, not only write-like operations,=
 but
> even read access to a file. Modeling the watch as being merely a read f=
rom
> the file is insufficient.

That's a very model-specific viewpoint. It is true for
a fine-grained model such as SELinux, but not necessarily
for a model with more traditional object definitions.
I'm not saying you're wrong, I'm saying that stating it
as a given assumes your model. You can do that all you want
within SELinux, but it doesn't hold when you're talking
about the LSM infrastructure.

Have you coordinated this with the work that David Howells
is doing on generic notifications?

> Furthermore, fanotify watches grant more power to
> an application in the form of permission events. While notification eve=
nts
> are solely, unidirectional (i.e. they only pass information to the
> receiving application), permission events are blocking. Permission even=
ts
> make a request to the receiving application which will then reply with =
a
> decision as to whether or not that action may be completed.

You're not saying why this is an issue.

> In order to solve these issues, a new LSM hook is implemented and has b=
een
> placed within the system calls for marking filesystem objects with inot=
ify,
> fanotify, and dnotify watches. These calls to the hook are placed at th=
e
> point at which the target inode has been resolved and are provided with=

> both the inode and the mask of requested notification events. The mask =
has
> already been translated into common FS_* values shared by the entirety =
of
> the fs notification infrastructure.
>
> This only provides a hook at the point of setting a watch, and presumes=

> that permission to set a particular watch implies the ability to receiv=
e
> all notification about that object which match the mask. This is all th=
at
> is required for SELinux. If other security modules require additional h=
ooks
> or infrastructure to control delivery of notification, these can be add=
ed
> by them. It does not make sense for us to propose hooks for which we ha=
ve
> no implementation. The understanding that all notifications received by=
 the
> requesting application are all strictly of a type for which the applica=
tion
> has been granted permission shows that this implementation is sufficien=
t in
> its coverage.

A reasonable approach. It would be *nice* if you had
a look at the other security modules to see what they
might need from such a hook or hook set.

> Fanotify further has the issue that it returns a file descriptor with t=
he
> file mode specified during fanotify_init() to the watching process on
> event. This is already covered by the LSM security_file_open hook if th=
e
> security module implements checking of the requested file mode there.

How is this relevant?

> The selinux_inode_notify hook implementation works by adding three new
> file permissions: watch, watch_reads, and watch_with_perm (descriptions=

> about which will follow). The hook then decides which subset of these
> permissions must be held by the requesting application based on the
> contents of the provided mask. The selinux_file_open hook already check=
s
> the requested file mode and therefore ensures that a watching process
> cannot escalate its access through fanotify.

Thereby increasing the granularity of control available.

> The watch permission is the baseline permission for setting a watch on =
an
> object and is a requirement for any watch to be set whatsoever. It shou=
ld
> be noted that having either of the other two permissions (watch_reads a=
nd
> watch_with_perm) does not imply the watch permission, though this could=
 be
> changed if need be.
>
> The watch_reads permission is required to receive notifications from
> read-exclusive events on filesystem objects. These events include acces=
sing
> a file for the purpose of reading and closing a file which has been ope=
ned
> read-only. This distinction has been drawn in order to provide a direct=

> indication in the policy for this otherwise not obvious capability. Rea=
d
> access to a file should not necessarily imply the ability to observe re=
ad
> events on a file.
>
> Finally, watch_with_perm only applies to fanotify masks since it is the=

> only way to set a mask which allows for the blocking, permission event.=

> This permission is needed for any watch which is of this type. Though
> fanotify requires CAP_SYS_ADMIN, this is insufficient as it gives impli=
cit
> trust to root, which we do not do, and does not support least privilege=
=2E
>
> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> ---
>  fs/notify/dnotify/dnotify.c         | 14 +++++++++++---
>  fs/notify/fanotify/fanotify_user.c  | 11 +++++++++--
>  fs/notify/inotify/inotify_user.c    | 12 ++++++++++--
>  include/linux/lsm_hooks.h           |  2 ++
>  include/linux/security.h            |  7 +++++++
>  security/security.c                 |  5 +++++
>  security/selinux/hooks.c            | 22 ++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 +-
>  8 files changed, 67 insertions(+), 8 deletions(-)
>
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 250369d6901d..e91ce092efb1 100644
> --- a/fs/notify/dnotify/dnotify.c
> +++ b/fs/notify/dnotify/dnotify.c
> @@ -22,6 +22,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/dnotify.h>
>  #include <linux/init.h>
> +#include <linux/security.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
>  #include <linux/fdtable.h>
> @@ -288,6 +289,16 @@ int fcntl_dirnotify(int fd, struct file *filp, uns=
igned long arg)
>  		goto out_err;
>  	}
> =20
> +	/*
> +	 * convert the userspace DN_* "arg" to the internal FS_*
> +	 * defined in fsnotify
> +	 */
> +	mask =3D convert_arg(arg);
> +
> +	error =3D security_inode_notify(inode, mask);
> +	if (error)
> +		goto out_err;
> +
>  	/* expect most fcntl to add new rather than augment old */
>  	dn =3D kmem_cache_alloc(dnotify_struct_cache, GFP_KERNEL);
>  	if (!dn) {
> @@ -302,9 +313,6 @@ int fcntl_dirnotify(int fd, struct file *filp, unsi=
gned long arg)
>  		goto out_err;
>  	}
> =20
> -	/* convert the userspace DN_* "arg" to the internal FS_* defines in f=
snotify */
> -	mask =3D convert_arg(arg);
> -
>  	/* set up the new_fsn_mark and new_dn_mark */
>  	new_fsn_mark =3D &new_dn_mark->fsn_mark;
>  	fsnotify_init_mark(new_fsn_mark, dnotify_group);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> index a90bb19dcfa2..c0d9fa998377 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -528,7 +528,7 @@ static const struct file_operations fanotify_fops =3D=
 {
>  };
> =20
>  static int fanotify_find_path(int dfd, const char __user *filename,
> -			      struct path *path, unsigned int flags)
> +			      struct path *path, unsigned int flags, __u64 mask)
>  {
>  	int ret;
> =20
> @@ -567,8 +567,15 @@ static int fanotify_find_path(int dfd, const char =
__user *filename,
> =20
>  	/* you can only watch an inode if you have read permissions on it */
>  	ret =3D inode_permission(path->dentry->d_inode, MAY_READ);
> +	if (ret) {
> +		path_put(path);
> +		goto out;
> +	}
> +
> +	ret =3D security_inode_notify(path->dentry->d_inode, mask);
>  	if (ret)
>  		path_put(path);
> +
>  out:
>  	return ret;
>  }
> @@ -1014,7 +1021,7 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
>  		goto fput_and_out;
>  	}
> =20
> -	ret =3D fanotify_find_path(dfd, pathname, &path, flags);
> +	ret =3D fanotify_find_path(dfd, pathname, &path, flags, mask);
>  	if (ret)
>  		goto fput_and_out;
> =20
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inoti=
fy_user.c
> index 7b53598c8804..47b079f20aad 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -39,6 +39,7 @@
>  #include <linux/poll.h>
>  #include <linux/wait.h>
>  #include <linux/memcontrol.h>
> +#include <linux/security.h>
> =20
>  #include "inotify.h"
>  #include "../fdinfo.h"
> @@ -342,7 +343,8 @@ static const struct file_operations inotify_fops =3D=
 {
>  /*
>   * find_inode - resolve a user-given path to a specific inode
>   */
> -static int inotify_find_inode(const char __user *dirname, struct path =
*path, unsigned flags)
> +static int inotify_find_inode(const char __user *dirname, struct path =
*path,
> +						unsigned int flags, __u64 mask)
>  {
>  	int error;
> =20
> @@ -351,8 +353,14 @@ static int inotify_find_inode(const char __user *d=
irname, struct path *path, uns
>  		return error;
>  	/* you can only watch an inode if you have read permissions on it */
>  	error =3D inode_permission(path->dentry->d_inode, MAY_READ);
> +	if (error) {
> +		path_put(path);
> +		return error;
> +	}
> +	error =3D security_inode_notify(path->dentry->d_inode, mask);
>  	if (error)
>  		path_put(path);
> +
>  	return error;
>  }
> =20
> @@ -744,7 +752,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const c=
har __user *, pathname,
>  	if (mask & IN_ONLYDIR)
>  		flags |=3D LOOKUP_DIRECTORY;
> =20
> -	ret =3D inotify_find_inode(pathname, &path, flags);
> +	ret =3D inotify_find_inode(pathname, &path, flags, mask);
>  	if (ret)
>  		goto fput_and_out;
> =20
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 47f58cfb6a19..ef6b74938dd8 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h

Hook description comment is missing.

> @@ -1571,6 +1571,7 @@ union security_list_options {
>  	int (*inode_getxattr)(struct dentry *dentry, const char *name);
>  	int (*inode_listxattr)(struct dentry *dentry);
>  	int (*inode_removexattr)(struct dentry *dentry, const char *name);
> +	int (*inode_notify)(struct inode *inode, u64 mask);
>  	int (*inode_need_killpriv)(struct dentry *dentry);
>  	int (*inode_killpriv)(struct dentry *dentry);
>  	int (*inode_getsecurity)(struct inode *inode, const char *name,
> @@ -1881,6 +1882,7 @@ struct security_hook_heads {
>  	struct hlist_head inode_getxattr;
>  	struct hlist_head inode_listxattr;
>  	struct hlist_head inode_removexattr;
> +	struct hlist_head inode_notify;
>  	struct hlist_head inode_need_killpriv;
>  	struct hlist_head inode_killpriv;
>  	struct hlist_head inode_getsecurity;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 659071c2e57c..50106fb9eef9 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -301,6 +301,7 @@ int security_inode_listsecurity(struct inode *inode=
, char *buffer, size_t buffer
>  void security_inode_getsecid(struct inode *inode, u32 *secid);
>  int security_inode_copy_up(struct dentry *src, struct cred **new);
>  int security_inode_copy_up_xattr(const char *name);
> +int security_inode_notify(struct inode *inode, u64 mask);
>  int security_kernfs_init_security(struct kernfs_node *kn_dir,
>  				  struct kernfs_node *kn);
>  int security_file_permission(struct file *file, int mask);
> @@ -392,6 +393,7 @@ void security_inode_invalidate_secctx(struct inode =
*inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ct=
xlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctx=
len);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctx=
len);
> +

Please don't change whitespace unless it's directly adjacent to your code=
=2E

>  #else /* CONFIG_SECURITY */
> =20
>  static inline int call_lsm_notifier(enum lsm_event event, void *data)
> @@ -776,6 +778,11 @@ static inline int security_inode_removexattr(struc=
t dentry *dentry,
>  	return cap_inode_removexattr(dentry, name);
>  }
> =20
> +static inline int security_inode_notify(struct inode *inode, u64 mask)=

> +{
> +	return 0;
> +}
> +
>  static inline int security_inode_need_killpriv(struct dentry *dentry)
>  {
>  	return cap_inode_need_killpriv(dentry);
> diff --git a/security/security.c b/security/security.c
> index 613a5c00e602..57b2a96c1991 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1251,6 +1251,11 @@ int security_inode_removexattr(struct dentry *de=
ntry, const char *name)
>  	return evm_inode_removexattr(dentry, name);
>  }
> =20
> +int security_inode_notify(struct inode *inode, u64 mask)
> +{
> +	return call_int_hook(inode_notify, 0, inode, mask);
> +}
> +
>  int security_inode_need_killpriv(struct dentry *dentry)
>  {
>  	return call_int_hook(inode_need_killpriv, 0, dentry);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c61787b15f27..1a37966c2978 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -92,6 +92,7 @@
>  #include <linux/kernfs.h>
>  #include <linux/stringhash.h>	/* for hashlen_string() */
>  #include <uapi/linux/mount.h>
> +#include <linux/fsnotify.h>
> =20
>  #include "avc.h"
>  #include "objsec.h"
> @@ -3261,6 +3262,26 @@ static int selinux_inode_removexattr(struct dent=
ry *dentry, const char *name)
>  	return -EACCES;
>  }
> =20
> +static int selinux_inode_notify(struct inode *inode, u64 mask)
> +{
> +	u32 perm =3D FILE__WATCH; // basic permission, can a watch be set?

We don't use // comments in the Linux kernel.

> +
> +	struct common_audit_data ad;
> +
> +	ad.type =3D LSM_AUDIT_DATA_INODE;
> +	ad.u.inode =3D inode;
> +
> +	// check if the mask is requesting ability to set a blocking watch
> +	if (mask & (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | FS_ACCESS_PERM))
> +		perm |=3D FILE__WATCH_WITH_PERM; // if so, check that permission
> +
> +	// is the mask asking to watch file reads?
> +	if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE_NOWRITE))
> +		perm |=3D FILE__WATCH_READS; // check that permission as well
> +
> +	return inode_has_perm(current_cred(), inode, perm, &ad);
> +}
> +
>  /*
>   * Copy the inode security context value to the user.
>   *
> @@ -6797,6 +6818,7 @@ static struct security_hook_list selinux_hooks[] =
__lsm_ro_after_init =3D {
>  	LSM_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
>  	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
>  	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
> +	LSM_HOOK_INIT(inode_notify, selinux_inode_notify),
> =20
>  	LSM_HOOK_INIT(kernfs_init_security, selinux_kernfs_init_security),
> =20
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> index 201f7e588a29..0654dd2fbebf 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -7,7 +7,7 @@
> =20
>  #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
>      "rename", "execute", "quotaon", "mounton", "audit_access", \
> -    "open", "execmod"
> +	"open", "execmod", "watch", "watch_with_perm", "watch_reads"
> =20
>  #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \=

>      "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \=


