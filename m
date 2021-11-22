Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C2D459648
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 21:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhKVUxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 15:53:35 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:35780 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhKVUxf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 15:53:35 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:52326)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mpGGh-002sSf-2w; Mon, 22 Nov 2021 13:50:27 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:35732 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mpGGe-002ZLc-6q; Mon, 22 Nov 2021 13:50:26 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
References: <YZvuN0Wqmn7XB4dX@localhost.localdomain>
Date:   Mon, 22 Nov 2021 14:50:17 -0600
In-Reply-To: <YZvuN0Wqmn7XB4dX@localhost.localdomain> (Alexey Dobriyan's
        message of "Mon, 22 Nov 2021 22:23:35 +0300")
Message-ID: <87r1b7lxti.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mpGGe-002ZLc-6q;;;mid=<87r1b7lxti.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Zvgdf6ITMnZl0Kra///3lkdTizoODoiU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Dobriyan <adobriyan@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2101 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 15 (0.7%), b_tie_ro: 12 (0.6%), parse: 1.85
        (0.1%), extract_message_metadata: 9 (0.4%), get_uri_detail_list: 6
        (0.3%), tests_pri_-1000: 3.7 (0.2%), tests_pri_-950: 1.47 (0.1%),
        tests_pri_-900: 1.24 (0.1%), tests_pri_-90: 152 (7.2%), check_bayes:
        150 (7.1%), b_tokenize: 29 (1.4%), b_tok_get_all: 18 (0.8%),
        b_comp_prob: 6 (0.3%), b_tok_touch_all: 90 (4.3%), b_finish: 1.60
        (0.1%), tests_pri_0: 1891 (90.0%), check_dkim_signature: 0.67 (0.0%),
        check_dkim_adsp: 3.8 (0.2%), poll_dns_idle: 1.86 (0.1%), tests_pri_10:
        5 (0.2%), tests_pri_500: 11 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] proc: "mount -o lookup=..." support
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> writes:

> Docker implements MaskedPaths configuration option
>
> 	https://github.com/estesp/docker/blob/9c15e82f19b0ad3c5fe8617a8ec2dddc6639f40a/oci/defaults.go#L97
>
> to disable certain /proc files. It does overmount with /dev/null per
> masked file.
>
> Give them proper mount option which selectively disables lookup/readdir
> so that MaskedPaths doesn't need to be updated as time goes on.
>
> Syntax is
>
> 	mount -t proc proc -o lookup=cpuinfo/uptime /proc
>
> 	# ls /proc
> 				...
> 	dr-xr-xr-x   8 root       root          0 Nov 22 21:12 995
> 	-r--r--r--   1 root       root          0 Nov 22 21:12 cpuinfo
> 	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 self -> 1163
> 	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 thread-self -> 1163/task/1163
> 	-r--r--r--   1 root       root          0 Nov 22 21:12 uptime
>
> Works at top level only (1 lookup list per superblock)
> Trailing slash is optional but saves 1 allocation.
>
> TODO:
> 	think what to do with dcache entries across "mount -o remount,lookup=".

I think it would be fine, and in fact even a good idea to limit the
masking of proc entries to the first mount and not allow them
to be changed with remount.  Especially as this hiding these entries
is to improve security.

If you do allow changes during remount it should not be any different
from creation deletion of a file.  Which I think comes down to
revalidate would need to check to see if the file is still visible.

That is the proc filesystem uses the distributed filesystem mechanisms
for file availability.

A great big question is what can be usefully enabled (not overmounted)
other then the subset of proc that are the pid files?

I suspect defining and validating useful and safe subsets of proc
is both easier and more maintainable than providing a general mechanism
for the files.


I have not read your code in detail but I see some things that look
wrong.  There is masking of the root directory lookup method, but not
the root directory readdir.   In proc generic there is masking of
readdir but not lookup.  Given that all you are looking at is the
dentry name that seems like it has some very noticable limitations.


If you do want a high performance masking implementation than I suspect
the way to build it is to build a set of overlay directories that
are rb_trees.  One set of directories for each proc super block.

Those directories could then point to appropriate struct proc_dir_entry.

All of the dcache operations could work on those overlay directory trees,
and the operations that add/remove masked entries could manipulate those
directory trees from the other side.

As it is I very much worry about what the singly linked lists will do to
the performance of proc.

Eric


> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
>  fs/proc/generic.c       |   19 +++++--
>  fs/proc/internal.h      |   23 +++++++++
>  fs/proc/proc_net.c      |    2 
>  fs/proc/root.c          |  115 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/proc_fs.h |    2 
>  5 files changed, 152 insertions(+), 9 deletions(-)
>
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -282,7 +282,7 @@ struct dentry *proc_lookup(struct inode *dir, struct dentry *dentry,
>   * for success..
>   */
>  int proc_readdir_de(struct file *file, struct dir_context *ctx,
> -		    struct proc_dir_entry *de)
> +		    struct proc_dir_entry *de, const struct proc_lookup_list *ll)
>  {
>  	int i;
>  
> @@ -305,14 +305,18 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
>  
>  	do {
>  		struct proc_dir_entry *next;
> +
>  		pde_get(de);
>  		read_unlock(&proc_subdir_lock);
> -		if (!dir_emit(ctx, de->name, de->namelen,
> -			    de->low_ino, de->mode >> 12)) {
> -			pde_put(de);
> -			return 0;
> +
> +		if (ll ? in_lookup_list(ll, de->name, de->namelen) : true) {
> +			if (!dir_emit(ctx, de->name, de->namelen, de->low_ino, de->mode >> 12)) {
> +				pde_put(de);
> +				return 0;
> +			}
> +			ctx->pos++;
>  		}
> -		ctx->pos++;
> +
>  		read_lock(&proc_subdir_lock);
>  		next = pde_subdir_next(de);
>  		pde_put(de);
> @@ -330,7 +334,8 @@ int proc_readdir(struct file *file, struct dir_context *ctx)
>  	if (fs_info->pidonly == PROC_PIDONLY_ON)
>  		return 1;
>  
> -	return proc_readdir_de(file, ctx, PDE(inode));
> +	return proc_readdir_de(file, ctx, PDE(inode),
> +				PDE(inode) == &proc_root ? fs_info->lookup_list : NULL);
>  }
>  
>  /*
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -190,7 +190,7 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>  extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int);
>  struct dentry *proc_lookup_de(struct inode *, struct dentry *, struct proc_dir_entry *);
>  extern int proc_readdir(struct file *, struct dir_context *);
> -int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *);
> +int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *, const struct proc_lookup_list *);
>  
>  static inline void pde_get(struct proc_dir_entry *pde)
>  {
> @@ -318,3 +318,24 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
>  	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
>  	pde->proc_dops = &proc_net_dentry_ops;
>  }
> +
> +/*
> + * "cpuinfo", "uptime" is represented as
> + *
> + *	(u8[]){
> + *		7, 'c', 'p', 'u', 'i', 'n', 'f', 'o',
> + *		6, 'u', 'p', 't', 'i', 'm', 'e',
> + *		0
> + *	}
> + */
> +struct proc_lookup_list {
> +	u8 len;
> +	char str[];
> +};
> +
> +static inline struct proc_lookup_list *lookup_list_next(const struct proc_lookup_list *ll)
> +{
> +	return (struct proc_lookup_list *)((void *)ll + 1 + ll->len);
> +}
> +
> +bool in_lookup_list(const struct proc_lookup_list *ll, const char *str, unsigned int len);
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -321,7 +321,7 @@ static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)
>  	ret = -EINVAL;
>  	net = get_proc_task_net(file_inode(file));
>  	if (net != NULL) {
> -		ret = proc_readdir_de(file, ctx, net->proc_net);
> +		ret = proc_readdir_de(file, ctx, net->proc_net, NULL);
>  		put_net(net);
>  	}
>  	return ret;
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -35,18 +35,22 @@ struct proc_fs_context {
>  	enum proc_hidepid	hidepid;
>  	int			gid;
>  	enum proc_pidonly	pidonly;
> +	struct proc_lookup_list	*lookup_list;
> +	unsigned int		lookup_list_len;
>  };
>  
>  enum proc_param {
>  	Opt_gid,
>  	Opt_hidepid,
>  	Opt_subset,
> +	Opt_lookup,
>  };
>  
>  static const struct fs_parameter_spec proc_fs_parameters[] = {
>  	fsparam_u32("gid",	Opt_gid),
>  	fsparam_string("hidepid",	Opt_hidepid),
>  	fsparam_string("subset",	Opt_subset),
> +	fsparam_string("lookup",	Opt_lookup),
>  	{}
>  };
>  
> @@ -112,6 +116,65 @@ static int proc_parse_subset_param(struct fs_context *fc, char *value)
>  	return 0;
>  }
>  
> +static int proc_parse_lookup_param(struct fs_context *fc, char *str0)
> +{
> +	struct proc_fs_context *ctx = fc->fs_private;
> +	struct proc_lookup_list *ll;
> +	char *str;
> +	const char *slash;
> +	const char *src;
> +	unsigned int len;
> +	int rv;
> +
> +	/* Force trailing slash, simplify loops below. */
> +	len = strlen(str0);
> +	if (len > 0 && str0[len - 1] == '/') {
> +		str = str0;
> +	} else {
> +		str = kmalloc(len + 2, GFP_KERNEL);
> +		if (!str) {
> +			rv = -ENOMEM;
> +			goto out;
> +		}
> +		memcpy(str, str0, len);
> +		str[len] = '/';
> +		str[len + 1] = '\0';
> +	}
> +
> +	len = 0;
> +	for (src = str; (slash = strchr(src, '/')); src = slash + 1) {
> +		if (slash - src >= 256) {
> +			rv = -EINVAL;
> +			goto out_free_str;
> +		}
> +		len += 1 + (slash - src);
> +	}
> +	len += 1;
> +
> +	ctx->lookup_list = ll = kmalloc(len, GFP_KERNEL);
> +	ctx->lookup_list_len = len;
> +	if (!ll) {
> +		rv = -ENOMEM;
> +		goto out_free_str;
> +	}
> +
> +	for (src = str; (slash = strchr(src, '/')); src = slash + 1) {
> +		ll->len = slash - src;
> +		memcpy(ll->str, src, ll->len);
> +		ll = lookup_list_next(ll);
> +	}
> +	ll->len = 0;
> +
> +	rv = 0;
> +
> +out_free_str:
> +	if (str != str0) {
> +		kfree(str);
> +	}
> +out:
> +	return rv;
> +}
> +
>  static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
>  	struct proc_fs_context *ctx = fc->fs_private;
> @@ -137,6 +200,11 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  			return -EINVAL;
>  		break;
>  
> +	case Opt_lookup:
> +		if (proc_parse_lookup_param(fc, param->string) < 0)
> +			return -EINVAL;
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -157,6 +225,10 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
>  		fs_info->hide_pid = ctx->hidepid;
>  	if (ctx->mask & (1 << Opt_subset))
>  		fs_info->pidonly = ctx->pidonly;
> +	if (ctx->mask & (1 << Opt_lookup)) {
> +		fs_info->lookup_list = ctx->lookup_list;
> +		ctx->lookup_list = NULL;
> +	}
>  }
>  
>  static int proc_fill_super(struct super_block *s, struct fs_context *fc)
> @@ -234,11 +306,34 @@ static void proc_fs_context_free(struct fs_context *fc)
>  	struct proc_fs_context *ctx = fc->fs_private;
>  
>  	put_pid_ns(ctx->pid_ns);
> +	kfree(ctx->lookup_list);
>  	kfree(ctx);
>  }
>  
> +static int proc_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
> +{
> +	struct proc_fs_context *src = fc->fs_private;
> +	struct proc_fs_context *dst;
> +
> +	dst = kmemdup(src, sizeof(struct proc_fs_context), GFP_KERNEL);
> +	if (!dst) {
> +		return -ENOMEM;
> +	}
> +
> +	get_pid_ns(dst->pid_ns);
> +	dst->lookup_list = kmemdup(dst->lookup_list, dst->lookup_list_len, GFP_KERNEL);
> +	if (!dst->lookup_list) {
> +		kfree(dst);
> +		return -ENOMEM;
> +	}
> +
> +	fc->fs_private = dst;
> +	return 0;
> +}
> +
>  static const struct fs_context_operations proc_fs_context_ops = {
>  	.free		= proc_fs_context_free,
> +	.dup		= proc_fs_context_dup,
>  	.parse_param	= proc_parse_param,
>  	.get_tree	= proc_get_tree,
>  	.reconfigure	= proc_reconfigure,
> @@ -274,6 +369,7 @@ static void proc_kill_sb(struct super_block *sb)
>  
>  	kill_anon_super(sb);
>  	put_pid_ns(fs_info->pid_ns);
> +	kfree(fs_info->lookup_list);
>  	kfree(fs_info);
>  }
>  
> @@ -317,11 +413,30 @@ static int proc_root_getattr(struct user_namespace *mnt_userns,
>  	return 0;
>  }
>  
> +bool in_lookup_list(const struct proc_lookup_list *ll, const char *str, unsigned int len)
> +{
> +	while (ll->len > 0) {
> +		if (ll->len == len && strncmp(ll->str, str, len) == 0) {
> +			return true;
> +		}
> +		ll = lookup_list_next(ll);
> +	}
> +	return false;
> +}
> +
>  static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, unsigned int flags)
>  {
> +	struct proc_fs_info *proc_sb = proc_sb_info(dir->i_sb);
> +
>  	if (!proc_pid_lookup(dentry, flags))
>  		return NULL;
>  
> +	/* Top level only for now */
> +	if (proc_sb->lookup_list &&
> +	    !in_lookup_list(proc_sb->lookup_list, dentry->d_name.name, dentry->d_name.len)) {
> +		    return NULL;
> +	}
> +
>  	return proc_lookup(dir, dentry, flags);
>  }
>  
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -10,6 +10,7 @@
>  #include <linux/fs.h>
>  
>  struct proc_dir_entry;
> +struct proc_lookup_list;
>  struct seq_file;
>  struct seq_operations;
>  
> @@ -65,6 +66,7 @@ struct proc_fs_info {
>  	kgid_t pid_gid;
>  	enum proc_hidepid hide_pid;
>  	enum proc_pidonly pidonly;
> +	const struct proc_lookup_list *lookup_list;
>  };
>  
>  static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
