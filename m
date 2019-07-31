Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66EBF7CA49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 19:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfGaR0d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 13:26:33 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:37390
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727614AbfGaR0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564593984; bh=8dADLPwFCJMAtI7410gUwj9IiuNwqBepJc+K+/dQcgs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=OqZMkMn5Z81Fjfvj7xkrZ5BQBw3qRQEBLGppSq3/+yoPBNnyn1QMhxSfEYlH646MI2lm4CSfhnn3xcuR9bqiVf04KD+nw04WU2Q+5d/TjC48ojdgXlQSOYCsLV5LqefWvlXkMeDqo23WtRttYy76eDzFo4407C+VIOKJBd8cX6NqyKmYfpfXV32YoCavyoNBkEs94KGQqVUE+Jh78ATO61Ab90VDuNVPoPV+sywb6KgxQhLETh5tTp/1GdfXjFq/etdt/j1i/DEhyYnS4N8Tw8wFnIV8tjiyFmoJ/RqU12LA8N8e/qA0Iqe65ojskHWrBuFwShnTJISjrpLUQoeCMQ==
X-YMail-OSG: sfhFGIwVM1mG9Xx7b9P76mR.bDF8JwaiGC.m2lQ6b74TV88mkC705k1wFr3tQAB
 t2lUbStbj46JS60EdC0weF9QqpIvnUAfNZrYdFxYCToIdXovi5_npLWpOBwovRzkvRSgVbjYuo_s
 2haR.hf.G2J82JMLK6PHNrxT9P74qW8Cy5zRss6Tz8gIE.B.Ivg5162S5PnnrVWCwnN_6.ZNolz6
 J6qN_lWngaWuLHf8x15n.gMUfEvkl.CvPZQOJLmJc84LMs8TCEOcWOQFG38lvsyYxsA6RCEKm8XY
 mGA9C_zeeDzMXZiZJq_cJF9sDgImx9pO77ZjNHm_vP8tjri9sJrIgkm_cUOH2IQQj7P.ZrFucqYe
 N.IrZ3ybh9Dd.fQlv9XEVKkNpEvYd_VBVN0cAu2sDmv.Iyi6jW51WWV5P7zcfiRI9k3XCQz4mn.P
 8aYK3cQEkIpqu4Nl6AMk_5GyIH3GG9rk9h4GhqB5F7FUBmLoMGnIUHsjAgkiz8ct7OT_05CcpCN4
 i6QnTlFMRJJkYRKN_97MEoouEurDbsdjj1ds1Zo_DdMvlArd9wLBwffxv.DfcRZmp5BzUsk8SXzZ
 90K.Mn6dGo7DXkupVdBhYmBAQTAXUA8xgqTLAVrnmIRXTnQT9_XEL_1m2h2_E1ai2MK2A_rqtUC0
 gYnRj7Oa.TT1bsxqgkOskxzajdifHg6KuXjM3KQv0K6AbfKazqHUjz.oCaRlHgQiFENTIhm6raJW
 3xCkLlE9wDEYgU0DJQow63WHF1pNLAWpL1H3OcEH3HFlr3sFtBDW2i0JG9ycV4NnARTe1fqRKA2M
 V4usuis8F8EFL6GIem6lBY4wHEttHcrmw7h.tNqnHGsUZTNjSkTVZPadhbDZJIR62RK6Es8.NjXD
 Id4pvKE9xJQiSc1dni1X3jov2XI1PYOLdGv0CsxiM2mO4gcYAC3ocnGKORAFKzWTojVwdTLG3vu.
 CHoD5tNOIPRwRbcRsVO53n_GLiiRk0aMCVCdaGdlFRZtz68oel6i4jpaY6d_y2uTNvMersdiPEEH
 WaDHtCM4TkmX682gQk1ExLnY5TPIKLrqeFWLOaX.19AFl9hqnLdr.JuTr7DcjuD4S9rF7YebGCao
 jBAe.DBgpRQ7YIjO48L8p5LvKuxBoNCCQU4t7abUPRjKvf2bodT9kKyYQ2gF_xgXlA44LxlTZpUm
 Fqa3ZPS8wgsquFTl4o6eOiX2PphiE9NWE1vBDfyeaFmblkZB1gnuUZdeaTLSH6ubsZrxMdjevaiw
 U4OQXWG6KRqNm8LOPsKU6eOXRQzk3WEziqlbwDg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 31 Jul 2019 17:26:24 +0000
Received: by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a5fbc22588e3f4cbc370ef80f320f5cf;
          Wed, 31 Jul 2019 17:26:23 +0000 (UTC)
Subject: Re: [PATCH] fanotify, inotify, dnotify, security: add security hook
 for fs notifications
To:     Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, jmorris@namei.org, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <1c62c931-9441-4264-c119-d038b2d0c9b9@schaufler-ca.com>
Date:   Wed, 31 Jul 2019 10:26:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731153443.4984-1-acgoide@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/31/2019 8:34 AM, Aaron Goidel wrote:
> As of now, setting watches on filesystem objects has, at most, applied a
> check for read access to the inode, and in the case of fanotify, requires
> CAP_SYS_ADMIN. No specific security hook or permission check has been
> provided to control the setting of watches. Using any of inotify, dnotify,
> or fanotify, it is possible to observe, not only write-like operations, but
> even read access to a file. Modeling the watch as being merely a read from
> the file is insufficient for the needs of SELinux. This is due to the fact
> that read access should not necessarily imply access to information about
> when another process reads from a file. Furthermore, fanotify watches grant
> more power to an application in the form of permission events. While
> notification events are solely, unidirectional (i.e. they only pass
> information to the receiving application), permission events are blocking.
> Permission events make a request to the receiving application which will
> then reply with a decision as to whether or not that action may be
> completed. This causes the issue of the watching application having the
> ability to exercise control over the triggering process. Without drawing a
> distinction within the permission check, the ability to read would imply
> the greater ability to control an application. Additionally, mount and
> superblock watches apply to all files within the same mount or superblock.
> Read access to one file should not necessarily imply the ability to watch
> all files accessed within a given mount or superblock.
>
> In order to solve these issues, a new LSM hook is implemented and has been
> placed within the system calls for marking filesystem objects with inotify,
> fanotify, and dnotify watches. These calls to the hook are placed at the
> point at which the target path has been resolved and are provided with the
> path struct, the mask of requested notification events, and the type of
> object on which the mark is being set (inode, superblock, or mount). The
> mask and obj_type have already been translated into common FS_* values
> shared by the entirety of the fs notification infrastructure. The path
> struct is passed rather than just the inode so that the mount is available,
> particularly for mount watches. This also allows for use of the hook by
> pathname-based security modules. However, since the hook is intended for
> use even by inode based security modules, it is not placed under the
> CONFIG_SECURITY_PATH conditional. Otherwise, the inode-based security
> modules would need to enable all of the path hooks, even though they do not
> use any of them.
>
> This only provides a hook at the point of setting a watch, and presumes
> that permission to set a particular watch implies the ability to receive
> all notification about that object which match the mask. This is all that
> is required for SELinux. If other security modules require additional hooks
> or infrastructure to control delivery of notification, these can be added
> by them. It does not make sense for us to propose hooks for which we have
> no implementation. The understanding that all notifications received by the
> requesting application are all strictly of a type for which the application
> has been granted permission shows that this implementation is sufficient in
> its coverage.
>
> Security modules wishing to provide complete control over fanotify must
> also implement a security_file_open hook that validates that the access
> requested by the watching application is authorized. Fanotify has the issue
> that it returns a file descriptor with the file mode specified during
> fanotify_init() to the watching process on event. This is already covered
> by the LSM security_file_open hook if the security module implements
> checking of the requested file mode there. Otherwise, a watching process
> can obtain escalated access to a file for which it has not been authorized.
>
> The selinux_path_notify hook implementation works by adding five new file
> permissions: watch, watch_mount, watch_sb, watch_reads, and watch_with_perm
> (descriptions about which will follow), and one new filesystem permission:
> watch (which is applied to superblock checks). The hook then decides which
> subset of these permissions must be held by the requesting application
> based on the contents of the provided mask and the obj_type. The
> selinux_file_open hook already checks the requested file mode and therefore
> ensures that a watching process cannot escalate its access through
> fanotify.
>
> The watch, watch_mount, and watch_sb permissions are the baseline
> permissions for setting a watch on an object and each are a requirement for
> any watch to be set on a file, mount, or superblock respectively. It should
> be noted that having either of the other two permissions (watch_reads and
> watch_with_perm) does not imply the watch, watch_mount, or watch_sb
> permission. Superblock watches further require the filesystem watch
> permission to the superblock. As there is no labeled object in view for
> mounts, there is no specific check for mount watches beyond watch_mount to
> the inode. Such a check could be added in the future, if a suitable labeled
> object existed representing the mount.
>
> The watch_reads permission is required to receive notifications from
> read-exclusive events on filesystem objects. These events include accessing
> a file for the purpose of reading and closing a file which has been opened
> read-only. This distinction has been drawn in order to provide a direct
> indication in the policy for this otherwise not obvious capability. Read
> access to a file should not necessarily imply the ability to observe read
> events on a file.
>
> Finally, watch_with_perm only applies to fanotify masks since it is the
> only way to set a mask which allows for the blocking, permission event.
> This permission is needed for any watch which is of this type. Though
> fanotify requires CAP_SYS_ADMIN, this is insufficient as it gives implicit
> trust to root, which we do not do, and does not support least privilege.
>
> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>

I can't say that I accept your arguments that this is sufficient,
but as you point out, the SELinux team does, and if I want more
for Smack that's my fish to fry.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  fs/notify/dnotify/dnotify.c         | 15 +++++++--
>  fs/notify/fanotify/fanotify_user.c  | 27 +++++++++++++++--
>  fs/notify/inotify/inotify_user.c    | 13 ++++++--
>  include/linux/lsm_hooks.h           |  9 +++++-
>  include/linux/security.h            | 10 ++++--
>  security/security.c                 |  6 ++++
>  security/selinux/hooks.c            | 47 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  5 +--
>  8 files changed, 120 insertions(+), 12 deletions(-)
>
> diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
> index 250369d6901d..87a7f61bc91c 100644
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
> @@ -288,6 +289,17 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
>  		goto out_err;
>  	}
>  
> +	/*
> +	 * convert the userspace DN_* "arg" to the internal FS_*
> +	 * defined in fsnotify
> +	 */
> +	mask = convert_arg(arg);
> +
> +	error = security_path_notify(&filp->f_path, mask,
> +			FSNOTIFY_OBJ_TYPE_INODE);
> +	if (error)
> +		goto out_err;
> +
>  	/* expect most fcntl to add new rather than augment old */
>  	dn = kmem_cache_alloc(dnotify_struct_cache, GFP_KERNEL);
>  	if (!dn) {
> @@ -302,9 +314,6 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
>  		goto out_err;
>  	}
>  
> -	/* convert the userspace DN_* "arg" to the internal FS_* defines in fsnotify */
> -	mask = convert_arg(arg);
> -
>  	/* set up the new_fsn_mark and new_dn_mark */
>  	new_fsn_mark = &new_dn_mark->fsn_mark;
>  	fsnotify_init_mark(new_fsn_mark, dnotify_group);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index a90bb19dcfa2..b83f27021f54 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -528,9 +528,10 @@ static const struct file_operations fanotify_fops = {
>  };
>  
>  static int fanotify_find_path(int dfd, const char __user *filename,
> -			      struct path *path, unsigned int flags)
> +			      struct path *path, unsigned int flags, __u64 mask)
>  {
>  	int ret;
> +	unsigned int obj_type;
>  
>  	pr_debug("%s: dfd=%d filename=%p flags=%x\n", __func__,
>  		 dfd, filename, flags);
> @@ -567,8 +568,30 @@ static int fanotify_find_path(int dfd, const char __user *filename,
>  
>  	/* you can only watch an inode if you have read permissions on it */
>  	ret = inode_permission(path->dentry->d_inode, MAY_READ);
> +	if (ret) {
> +		path_put(path);
> +		goto out;
> +	}
> +
> +	switch (flags & FANOTIFY_MARK_TYPE_BITS) {
> +	case FAN_MARK_MOUNT:
> +		obj_type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
> +		break;
> +	case FAN_MARK_FILESYSTEM:
> +		obj_type = FSNOTIFY_OBJ_TYPE_SB;
> +		break;
> +	case FAN_MARK_INODE:
> +		obj_type = FSNOTIFY_OBJ_TYPE_INODE;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = security_path_notify(path, mask, obj_type);
>  	if (ret)
>  		path_put(path);
> +
>  out:
>  	return ret;
>  }
> @@ -1014,7 +1037,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		goto fput_and_out;
>  	}
>  
> -	ret = fanotify_find_path(dfd, pathname, &path, flags);
> +	ret = fanotify_find_path(dfd, pathname, &path, flags, mask);
>  	if (ret)
>  		goto fput_and_out;
>  
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 7b53598c8804..e0d593c2d437 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -39,6 +39,7 @@
>  #include <linux/poll.h>
>  #include <linux/wait.h>
>  #include <linux/memcontrol.h>
> +#include <linux/security.h>
>  
>  #include "inotify.h"
>  #include "../fdinfo.h"
> @@ -342,7 +343,8 @@ static const struct file_operations inotify_fops = {
>  /*
>   * find_inode - resolve a user-given path to a specific inode
>   */
> -static int inotify_find_inode(const char __user *dirname, struct path *path, unsigned flags)
> +static int inotify_find_inode(const char __user *dirname, struct path *path,
> +						unsigned int flags, __u64 mask)
>  {
>  	int error;
>  
> @@ -351,8 +353,15 @@ static int inotify_find_inode(const char __user *dirname, struct path *path, uns
>  		return error;
>  	/* you can only watch an inode if you have read permissions on it */
>  	error = inode_permission(path->dentry->d_inode, MAY_READ);
> +	if (error) {
> +		path_put(path);
> +		return error;
> +	}
> +	error = security_path_notify(path, mask,
> +				FSNOTIFY_OBJ_TYPE_INODE);
>  	if (error)
>  		path_put(path);
> +
>  	return error;
>  }
>  
> @@ -744,7 +753,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
>  	if (mask & IN_ONLYDIR)
>  		flags |= LOOKUP_DIRECTORY;
>  
> -	ret = inotify_find_inode(pathname, &path, flags);
> +	ret = inotify_find_inode(pathname, &path, flags, mask);
>  	if (ret)
>  		goto fput_and_out;
>  
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 47f58cfb6a19..ead98af9c602 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -339,6 +339,9 @@
>   *	Check for permission to change root directory.
>   *	@path contains the path structure.
>   *	Return 0 if permission is granted.
> + * @path_notify:
> + *	Check permissions before setting a watch on events as defined by @mask,
> + *	on an object at @path, whose type is defined by @obj_type.
>   * @inode_readlink:
>   *	Check the permission to read the symbolic link.
>   *	@dentry contains the dentry structure for the file link.
> @@ -1535,7 +1538,9 @@ union security_list_options {
>  	int (*path_chown)(const struct path *path, kuid_t uid, kgid_t gid);
>  	int (*path_chroot)(const struct path *path);
>  #endif
> -
> +	/* Needed for inode based security check */
> +	int (*path_notify)(const struct path *path, u64 mask,
> +				unsigned int obj_type);
>  	int (*inode_alloc_security)(struct inode *inode);
>  	void (*inode_free_security)(struct inode *inode);
>  	int (*inode_init_security)(struct inode *inode, struct inode *dir,
> @@ -1860,6 +1865,8 @@ struct security_hook_heads {
>  	struct hlist_head path_chown;
>  	struct hlist_head path_chroot;
>  #endif
> +	/* Needed for inode based modules as well */
> +	struct hlist_head path_notify;
>  	struct hlist_head inode_alloc_security;
>  	struct hlist_head inode_free_security;
>  	struct hlist_head inode_init_security;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 659071c2e57c..7d9c1da1f659 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -259,7 +259,8 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
>  					struct qstr *name,
>  					const struct cred *old,
>  					struct cred *new);
> -
> +int security_path_notify(const struct path *path, u64 mask,
> +					unsigned int obj_type);
>  int security_inode_alloc(struct inode *inode);
>  void security_inode_free(struct inode *inode);
>  int security_inode_init_security(struct inode *inode, struct inode *dir,
> @@ -387,7 +388,6 @@ int security_ismaclabel(const char *name);
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
>  int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
>  void security_release_secctx(char *secdata, u32 seclen);
> -
>  void security_inode_invalidate_secctx(struct inode *inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
> @@ -621,6 +621,12 @@ static inline int security_move_mount(const struct path *from_path,
>  	return 0;
>  }
>  
> +static inline int security_path_notify(const struct path *path, u64 mask,
> +				unsigned int obj_type)
> +{
> +	return 0;
> +}
> +
>  static inline int security_inode_alloc(struct inode *inode)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 613a5c00e602..30687e1366b7 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -871,6 +871,12 @@ int security_move_mount(const struct path *from_path, const struct path *to_path
>  	return call_int_hook(move_mount, 0, from_path, to_path);
>  }
>  
> +int security_path_notify(const struct path *path, u64 mask,
> +				unsigned int obj_type)
> +{
> +	return call_int_hook(path_notify, 0, path, mask, obj_type);
> +}
> +
>  int security_inode_alloc(struct inode *inode)
>  {
>  	int rc = lsm_inode_alloc(inode);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c61787b15f27..a1aaf79421df 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -92,6 +92,8 @@
>  #include <linux/kernfs.h>
>  #include <linux/stringhash.h>	/* for hashlen_string() */
>  #include <uapi/linux/mount.h>
> +#include <linux/fsnotify.h>
> +#include <linux/fanotify.h>
>  
>  #include "avc.h"
>  #include "objsec.h"
> @@ -3261,6 +3263,50 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
>  	return -EACCES;
>  }
>  
> +static int selinux_path_notify(const struct path *path, u64 mask,
> +						unsigned int obj_type)
> +{
> +	int ret;
> +	u32 perm;
> +
> +	struct common_audit_data ad;
> +
> +	ad.type = LSM_AUDIT_DATA_PATH;
> +	ad.u.path = *path;
> +
> +	/*
> +	 * Set permission needed based on the type of mark being set.
> +	 * Performs an additional check for sb watches.
> +	 */
> +	switch (obj_type) {
> +	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
> +		perm = FILE__WATCH_MOUNT;
> +		break;
> +	case FSNOTIFY_OBJ_TYPE_SB:
> +		perm = FILE__WATCH_SB;
> +		ret = superblock_has_perm(current_cred(), path->dentry->d_sb,
> +						FILESYSTEM__WATCH, &ad);
> +		if (ret)
> +			return ret;
> +		break;
> +	case FSNOTIFY_OBJ_TYPE_INODE:
> +		perm = FILE__WATCH;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	// check if the mask is requesting ability to set a blocking watch
> +	if (mask & (ALL_FSNOTIFY_PERM_EVENTS))
> +		perm |= FILE__WATCH_WITH_PERM; // if so, check that permission
> +
> +	// is the mask asking to watch file reads?
> +	if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE_NOWRITE))
> +		perm |= FILE__WATCH_READS; // check that permission as well
> +
> +	return path_has_perm(current_cred(), path, perm);
> +}
> +
>  /*
>   * Copy the inode security context value to the user.
>   *
> @@ -6797,6 +6843,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
>  	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
>  	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
> +	LSM_HOOK_INIT(path_notify, selinux_path_notify),
>  
>  	LSM_HOOK_INIT(kernfs_init_security, selinux_kernfs_init_security),
>  
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 201f7e588a29..32e9b03be3dd 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -7,7 +7,8 @@
>  
>  #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
>      "rename", "execute", "quotaon", "mounton", "audit_access", \
> -    "open", "execmod"
> +	"open", "execmod", "watch", "watch_mount", "watch_sb", \
> +	"watch_with_perm", "watch_reads"
>  
>  #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
>      "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
> @@ -60,7 +61,7 @@ struct security_class_mapping secclass_map[] = {
>  	{ "filesystem",
>  	  { "mount", "remount", "unmount", "getattr",
>  	    "relabelfrom", "relabelto", "associate", "quotamod",
> -	    "quotaget", NULL } },
> +	    "quotaget", "watch", NULL } },
>  	{ "file",
>  	  { COMMON_FILE_PERMS,
>  	    "execute_no_trans", "entrypoint", NULL } },
