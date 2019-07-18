Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E746D223
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 18:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbfGRQjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 12:39:37 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:41915
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728120AbfGRQjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563467969; bh=7SSZMQKpGUTTNpXKuglmi06KrxXwRKoqkWP9SXK8xM0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=EcBYuP/RiI20k2dA/kHNyJKV8UbMu/C0IY4EJ04iHp2viJdTDIUBii85HTSaCYFhfP9z6iP/EReFRmVJopuN0NUW+TVQ3qQ0I+N7YpCfGP++WPSLaka4JtbI7jODmH+MSmrrHbCO0Ldf4oy/SGFvbmuX/C/NLvAaeOuWzlHlHxX5c29qerHU/CZ734HfaztGxvlLKhOpZoahH6g9eBPPYavQIhysRJmSOOYXOxyTMMGxdF/VN+4DXqsChzSWgSxh6s1d01ZB/RD8/5yuHj8OGah5eY8J/kgeTW8KJmKfzuCT6Wg9edR4NuGPTCQGi+ZQ1J4GB5rYoC7WThv/O83zpg==
X-YMail-OSG: AITczq4VM1lOns9X0jb6nFWJIi5NYaaYEuVwoUjGLxwjabRR7ZrRO9IGKpw7I7P
 QQ2uZMZIcnclC_LEaM3UlvtP7yAhQ0wipdJinoMhHmpI7DS2ZEFUW9IGv4V9i9MbKBozmkEco7mb
 Hh8HVImdbOShqYrLvVbCwuey.EubZwZYClo3myioLwqJnloeXP7cLDIeetIyrnPsifa5qM0P1CGb
 b7Ga.ca6MyFNAyaLrAYCgQgdhS8WHA5Km0VaBm2sNb82mbsZ4V2zoKcuwA.RbEAwDhGgvi8l36A7
 XszFDUkgYLsFf2WH6fxxwd5qegDchbhD4g.EyeBxs11kytjLdi_ngy5QOX2wBdFHbPgPH93HZokp
 iNotiXe5ifCFMmap_UcWHTBZwaEBj_tvEP6ssqN7xEIawV1NK6gUumY9jC1qd0SGHhiRRWaqFU_x
 TqhMNxvPIYkSPMIbrZZl.9jj2inZEPRkGkn0BL_wgqUoLMEmVt4iSc0Zzc1ZRiaKclfrENHamp7u
 e5oGWTiUtxN88kjFR4ODPCNhMKERo47kby72cKVBhkaFjmPFZYe5_IsQL1Kh7UPtgBRMexyW8GSt
 vucEb2NwprRQ0wxMtGQItaLTa0eOT8THARg0GUESw_VESP0rXcViVVkh7jf7q_fZpzLrW3zu.y10
 VP7dxlpeIEMJwl_P49lR3NoH7mlfIdv87qACJF7W7wGPsDg4LzTbMIPMsLynxPFkJ6xOMIUxU5Sp
 yyEnbWC2WGkg2_tyUytZxJV1fy0tsZSXhayWEVzsbEDdb6VwENab59NHWJHUa.GqhaKCrMxorog1
 m_Edr_5WApJ_UKpGFGN69.B6F0djAQ1S_.P8cNRfdq3xFsFmZVibW9jB9fYfT6RKCFz28xo_SfF1
 MfTBJLCSCnnXtberUi6N2zcieETokt5OERroA8SiTetVO2GFp36ici9tT0hauB9e.UqcqR0ME8Bp
 JOSmeqlx23svhmXt4lFDVpd66XrbU.N1arb3hcrRe6cMPaxrFGVGJ_Pte5RcFFZdxZhVlHMUDI6H
 GbAorWuHyRFctGI54wByYIsKCSl_AhkGVR84NHuqW4vJDFF7G3k25zr5Li6rqH4Bg2Qani7C5OwW
 ZCMAWV9K4xA8p1GC43pZfH0ca9gfVMKADPNePsLm.MyKlXuBfOmzDqDMmHIDVDDJ_ubem3ymTG.M
 5BbQMsEj2z8hsEkjPYtqphhsV8EXwW6K4vsY6XRcTnxkeRAmggI.XrhfuXlE.Pq3VVQadSsJWy10
 Vdkt6bYNf1vNoJbWgWD69
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Thu, 18 Jul 2019 16:39:29 +0000
Received: by smtp420.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f6bbed20d336be589ed1fe8621955fc3;
          Thu, 18 Jul 2019 16:39:27 +0000 (UTC)
Subject: Re: [RFC PATCH v2] fanotify, inotify, dnotify, security: add security
 hook for fs notifications
To:     Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, jmorris@namei.org, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <20190718143042.11059-1-acgoide@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <3ad44e23-979e-6e1c-88e7-36e43fe32a73@schaufler-ca.com>
Date:   Thu, 18 Jul 2019 09:39:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718143042.11059-1-acgoide@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/18/2019 7:30 AM, Aaron Goidel wrote:
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
> the file is insufficient for the needs of SELinux. This is due to the f=
act
> that read access should not necessarily imply access to information abo=
ut
> when another process reads from a file. Furthermore, fanotify watches g=
rant
> more power to an application in the form of permission events. While
> notification events are solely, unidirectional (i.e. they only pass
> information to the receiving application), permission events are blocki=
ng.
> Permission events make a request to the receiving application which wil=
l
> then reply with a decision as to whether or not that action may be
> completed. This causes the issue of the watching application having the=

> ability to exercise control over the triggering process. Without drawin=
g a
> distinction within the permission check, the ability to read would impl=
y
> the greater ability to control an application. Additionally, mount and
> superblock watches apply to all files within the same mount or superblo=
ck.
> Read access to one file should not necessarily imply the ability to wat=
ch
> all files accessed within a given mount or superblock.
>
> In order to solve these issues, a new LSM hook is implemented and has b=
een
> placed within the system calls for marking filesystem objects with inot=
ify,
> fanotify, and dnotify watches. These calls to the hook are placed at th=
e
> point at which the target inode has been resolved and are provided with=
 the
> inode, the mask of requested notification events, and the type of objec=
t on
> which the mark is being set (inode, superblock, or mount). The mask and=

> mark_type have already been translated into common FS_* values shared b=
y
> the entirety of the fs notification infrastructure.
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
>
> Security modules wishing to provide complete control over fanotify must=

> also implement a security_file_open hook that validates that the access=

> requested by the watching application is authorized. Fanotify has the i=
ssue
> that it returns a file descriptor with the file mode specified during
> fanotify_init() to the watching process on event. This is already cover=
ed
> by the LSM security_file_open hook if the security module implements
> checking of the requested file mode there. Otherwise, a watching proces=
s
> can obtain escalated access to a file for which it has not been authori=
zed.
>
> The selinux_inode_notify hook implementation works by adding five new f=
ile
> permissions: watch, watch_mount, watch_sb, watch_reads, and watch_with_=
perm
> (descriptions about which will follow), and one new filesystem permissi=
on:
> watch (which is applied to superblock checks). The hook then decides wh=
ich
> subset of these permissions must be held by the requesting application
> based on the contents of the provided mask and the mark_type. The
> selinux_file_open hook already checks the requested file mode and there=
fore
> ensures that a watching process cannot escalate its access through
> fanotify.
>
> The watch, watch_mount, and watch_sb permissions are the baseline
> permissions for setting a watch on an object and each are a requirement=
 for
> any watch to be set on a file, mount, or superblock respectively. It sh=
ould
> be noted that having either of the other two permissions (watch_reads a=
nd
> watch_with_perm) does not imply the watch, watch_mount, or watch_sb
> permission. Superblock watches further require the filesystem watch
> permission to the superblock. As there is no labeled object in view for=

> mounts, there is no specific check for mount watches beyond watch_mount=
 to
> the inode. Such a check could be added in the future, if a suitable lab=
eled
> object existed representing the mount.
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

It looks as if there may be overlap between this work and
[RFC PATCH] security, capability: pass object information to security_cap=
able
https://www.spinics.net/lists/selinux/msg28312.html

I say this because your patch looks an awful lot like what I suggested as=

the alternative to passing object information to security_capable().
It's possible that I've muddled the discussions in my brain, and that the=
re
isn't any way to use either to do both jobs. But it would be worth a look=
,
and a single new hook or change to existing hook would be a Good Thing.

>
> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> ---
> v2:
>   - Adds support for mark_type
>     - Adds watch_sb and watch_mount file permissions
>     - Adds watch as new filesystem permission
>     - LSM hook now recieves mark_type argument
>     - Changed LSM hook logic to implement checks for corresponding mark=
_types
>   - Adds missing hook description comment
>   - Fixes extrainous whitespace
>   - Updates patch description based on feedback
>
>  fs/notify/dnotify/dnotify.c         | 14 +++++++--
>  fs/notify/fanotify/fanotify_user.c  | 27 +++++++++++++++--
>  fs/notify/inotify/inotify_user.c    | 13 ++++++--
>  include/linux/lsm_hooks.h           |  6 ++++
>  include/linux/security.h            |  9 +++++-
>  security/security.c                 |  5 +++
>  security/selinux/hooks.c            | 47 +++++++++++++++++++++++++++++=

>  security/selinux/include/classmap.h |  5 +--
>  8 files changed, 116 insertions(+), 10 deletions(-)
>
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 250369d6901d..4690d8a66035 100644
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
> +	error =3D security_inode_notify(inode, mask, FSNOTIFY_OBJ_TYPE_INODE)=
;
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
> index a90bb19dcfa2..9e3137badb6b 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -528,9 +528,10 @@ static const struct file_operations fanotify_fops =
=3D {
>  };
> =20
>  static int fanotify_find_path(int dfd, const char __user *filename,
> -			      struct path *path, unsigned int flags)
> +			      struct path *path, unsigned int flags, __u64 mask)
>  {
>  	int ret;
> +	unsigned int mark_type;
> =20
>  	pr_debug("%s: dfd=3D%d filename=3D%p flags=3D%x\n", __func__,
>  		 dfd, filename, flags);
> @@ -567,8 +568,30 @@ static int fanotify_find_path(int dfd, const char =
__user *filename,
> =20
>  	/* you can only watch an inode if you have read permissions on it */
>  	ret =3D inode_permission(path->dentry->d_inode, MAY_READ);
> +	if (ret) {
> +		path_put(path);
> +		goto out;
> +	}
> +
> +	switch (flags & FANOTIFY_MARK_TYPE_BITS) {
> +	case FAN_MARK_MOUNT:
> +		mark_type =3D FSNOTIFY_OBJ_TYPE_VFSMOUNT;
> +		break;
> +	case FAN_MARK_FILESYSTEM:
> +		mark_type =3D FSNOTIFY_OBJ_TYPE_SB;
> +		break;
> +	case FAN_MARK_INODE:
> +		mark_type =3D FSNOTIFY_OBJ_TYPE_INODE;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	ret =3D security_inode_notify(path->dentry->d_inode, mask, mark_type)=
;
>  	if (ret)
>  		path_put(path);
> +
>  out:
>  	return ret;
>  }
> @@ -1014,7 +1037,7 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
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
> index 7b53598c8804..73b321a30bbc 100644
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
> @@ -351,8 +353,15 @@ static int inotify_find_inode(const char __user *d=
irname, struct path *path, uns
>  		return error;
>  	/* you can only watch an inode if you have read permissions on it */
>  	error =3D inode_permission(path->dentry->d_inode, MAY_READ);
> +	if (error) {
> +		path_put(path);
> +		return error;
> +	}
> +	error =3D security_inode_notify(path->dentry->d_inode, mask,
> +				FSNOTIFY_OBJ_TYPE_INODE);
>  	if (error)
>  		path_put(path);
> +
>  	return error;
>  }
> =20
> @@ -744,7 +753,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const c=
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
> index 47f58cfb6a19..9b3f5a5f3246 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -394,6 +394,9 @@
>   *	Check permission before removing the extended attribute
>   *	identified by @name for @dentry.
>   *	Return 0 if permission is granted.
> + * @inode_notify:
> + *	Check permissions before setting a watch on events as defined by @m=
ask,
> + *	on an object @inode, whose type is defined by @mark_type.
>   * @inode_getsecurity:
>   *	Retrieve a copy of the extended attribute representation of the
>   *	security label associated with @name for @inode via @buffer.  Note =
that
> @@ -1571,6 +1574,8 @@ union security_list_options {
>  	int (*inode_getxattr)(struct dentry *dentry, const char *name);
>  	int (*inode_listxattr)(struct dentry *dentry);
>  	int (*inode_removexattr)(struct dentry *dentry, const char *name);
> +	int (*inode_notify)(struct inode *inode, u64 mask,
> +				unsigned int mark_type);
>  	int (*inode_need_killpriv)(struct dentry *dentry);
>  	int (*inode_killpriv)(struct dentry *dentry);
>  	int (*inode_getsecurity)(struct inode *inode, const char *name,
> @@ -1881,6 +1886,7 @@ struct security_hook_heads {
>  	struct hlist_head inode_getxattr;
>  	struct hlist_head inode_listxattr;
>  	struct hlist_head inode_removexattr;
> +	struct hlist_head inode_notify;
>  	struct hlist_head inode_need_killpriv;
>  	struct hlist_head inode_killpriv;
>  	struct hlist_head inode_getsecurity;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 659071c2e57c..b12666513138 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -301,6 +301,8 @@ int security_inode_listsecurity(struct inode *inode=
, char *buffer, size_t buffer
>  void security_inode_getsecid(struct inode *inode, u32 *secid);
>  int security_inode_copy_up(struct dentry *src, struct cred **new);
>  int security_inode_copy_up_xattr(const char *name);
> +int security_inode_notify(struct inode *inode, u64 mask,
> +					unsigned int mark_type);
>  int security_kernfs_init_security(struct kernfs_node *kn_dir,
>  				  struct kernfs_node *kn);
>  int security_file_permission(struct file *file, int mask);
> @@ -387,7 +389,6 @@ int security_ismaclabel(const char *name);
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
>  int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *sec=
id);
>  void security_release_secctx(char *secdata, u32 seclen);
> -
>  void security_inode_invalidate_secctx(struct inode *inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ct=
xlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctx=
len);
> @@ -776,6 +777,12 @@ static inline int security_inode_removexattr(struc=
t dentry *dentry,
>  	return cap_inode_removexattr(dentry, name);
>  }
> =20
> +static inline int security_inode_notify(struct inode *inode, u64 mask,=

> +				unsigned int mark_type)
> +{
> +	return 0;
> +}
> +
>  static inline int security_inode_need_killpriv(struct dentry *dentry)
>  {
>  	return cap_inode_need_killpriv(dentry);
> diff --git a/security/security.c b/security/security.c
> index 613a5c00e602..bc30e201c137 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1251,6 +1251,11 @@ int security_inode_removexattr(struct dentry *de=
ntry, const char *name)
>  	return evm_inode_removexattr(dentry, name);
>  }
> =20
> +int security_inode_notify(struct inode *inode, u64 mask, unsigned int =
mark_type)
> +{
> +	return call_int_hook(inode_notify, 0, inode, mask, mark_type);
> +}
> +
>  int security_inode_need_killpriv(struct dentry *dentry)
>  {
>  	return call_int_hook(inode_need_killpriv, 0, dentry);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c61787b15f27..c967e46a34ea 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -92,6 +92,8 @@
>  #include <linux/kernfs.h>
>  #include <linux/stringhash.h>	/* for hashlen_string() */
>  #include <uapi/linux/mount.h>
> +#include <linux/fsnotify.h>
> +#include <linux/fanotify.h>
> =20
>  #include "avc.h"
>  #include "objsec.h"
> @@ -3261,6 +3263,50 @@ static int selinux_inode_removexattr(struct dent=
ry *dentry, const char *name)
>  	return -EACCES;
>  }
> =20
> +static int selinux_inode_notify(struct inode *inode, u64 mask,
> +						unsigned int mark_type)
> +{
> +	int ret;
> +	u32 perm;
> +
> +	struct common_audit_data ad;
> +
> +	ad.type =3D LSM_AUDIT_DATA_INODE;
> +	ad.u.inode =3D inode;
> +
> +	/*
> +	 * Set permission needed based on the type of mark being set.
> +	 * Performs an additional check for sb watches.
> +	 */
> +	switch (mark_type) {
> +	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
> +		perm =3D FILE__WATCH_MOUNT;
> +		break;
> +	case FSNOTIFY_OBJ_TYPE_SB:
> +		perm =3D FILE__WATCH_SB;
> +		ret =3D superblock_has_perm(current_cred(), inode->i_sb,
> +						FILESYSTEM__WATCH, &ad);
> +		if (ret)
> +			return ret;
> +		break;
> +	case FSNOTIFY_OBJ_TYPE_INODE:
> +		perm =3D FILE__WATCH;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	// check if the mask is requesting ability to set a blocking watch
> +	if (mask & (ALL_FSNOTIFY_PERM_EVENTS))
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
> @@ -6797,6 +6843,7 @@ static struct security_hook_list selinux_hooks[] =
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
> index 201f7e588a29..32e9b03be3dd 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -7,7 +7,8 @@
> =20
>  #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
>      "rename", "execute", "quotaon", "mounton", "audit_access", \
> -    "open", "execmod"
> +	"open", "execmod", "watch", "watch_mount", "watch_sb", \
> +	"watch_with_perm", "watch_reads"
> =20
>  #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \=

>      "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \=

> @@ -60,7 +61,7 @@ struct security_class_mapping secclass_map[] =3D {
>  	{ "filesystem",
>  	  { "mount", "remount", "unmount", "getattr",
>  	    "relabelfrom", "relabelto", "associate", "quotamod",
> -	    "quotaget", NULL } },
> +	    "quotaget", "watch", NULL } },
>  	{ "file",
>  	  { COMMON_FILE_PERMS,
>  	    "execute_no_trans", "entrypoint", NULL } },

