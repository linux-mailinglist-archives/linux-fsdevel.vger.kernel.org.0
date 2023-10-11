Return-Path: <linux-fsdevel+bounces-24-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D347C47DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 04:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCDE28232F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 02:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46396138;
	Wed, 11 Oct 2023 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B175610D;
	Wed, 11 Oct 2023 02:35:20 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB54F94;
	Tue, 10 Oct 2023 19:35:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S4xh01RqDz4f3lg4;
	Wed, 11 Oct 2023 10:35:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgA3jUzfCSZlasr_CQ--.47802S2;
	Wed, 11 Oct 2023 10:35:14 +0800 (CST)
Subject: Re: [PATCH v6 bpf-next 03/13] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 keescook@chromium.org, brauner@kernel.org, lennart@poettering.net,
 kernel-team@meta.com, sargun@sargun.me
References: <20230927225809.2049655-1-andrii@kernel.org>
 <20230927225809.2049655-4-andrii@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <be371dfe-d297-7de3-0812-eb069232f410@huaweicloud.com>
Date: Wed, 11 Oct 2023 10:35:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230927225809.2049655-4-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgA3jUzfCSZlasr_CQ--.47802S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFyxJrWDXrW5WrWDXFyUAwb_yoWfJFW3pF
	4rJFyjkr48JrW0gFn2qa18ZF1Fkw4DX3yUWrWUWryfArsFq3s2gFyFgFWa9F4ftr1Uu34I
	qFs09398Wr9rZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 9/28/2023 6:57 AM, Andrii Nakryiko wrote:
> Add new kind of BPF kernel object, BPF token. BPF token is meant to
> allow delegating privileged BPF functionality, like loading a BPF
> program or creating a BPF map, from privileged process to a *trusted*
> unprivileged process, all while have a good amount of control over which
> privileged operations could be performed using provided BPF token.
>
> This is achieved through mounting BPF FS instance with extra delegation
> mount options, which determine what operations are delegatable, and also
> constraining it to the owning user namespace (as mentioned in the
> previous patch).
SNIP
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 70bfa997e896..78692911f4a0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -847,6 +847,37 @@ union bpf_iter_link_info {
>   *		Returns zero on success. On error, -1 is returned and *errno*
>   *		is set appropriately.
>   *
> + * BPF_TOKEN_CREATE
> + *	Description
> + *		Create BPF token with embedded information about what
> + *		BPF-related functionality it allows:
> + *		- a set of allowed bpf() syscall commands;
> + *		- a set of allowed BPF map types to be created with
> + *		BPF_MAP_CREATE command, if BPF_MAP_CREATE itself is allowed;
> + *		- a set of allowed BPF program types and BPF program attach
> + *		types to be loaded with BPF_PROG_LOAD command, if
> + *		BPF_PROG_LOAD itself is allowed.
> + *
> + *		BPF token is created (derived) from an instance of BPF FS,
> + *		assuming it has necessary delegation mount options specified.
> + *		BPF FS mount is specified with openat()-style path FD + string.
> + *		This BPF token can be passed as an extra parameter to various
> + *		bpf() syscall commands to grant BPF subsystem functionality to
> + *		unprivileged processes.
> + *
> + *		When created, BPF token is "associated" with the owning
> + *		user namespace of BPF FS instance (super block) that it was
> + *		derived from, and subsequent BPF operations performed with
> + *		BPF token would be performing capabilities checks (i.e.,
> + *		CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN) within
> + *		that user namespace. Without BPF token, such capabilities
> + *		have to be granted in init user namespace, making bpf()
> + *		syscall incompatible with user namespace, for the most part.
> + *
> + *	Return
> + *		A new file descriptor (a nonnegative integer), or -1 if an
> + *		error occurred (in which case, *errno* is set appropriately).
> + *
>   * NOTES
>   *	eBPF objects (maps and programs) can be shared between processes.
>   *
> @@ -901,6 +932,8 @@ enum bpf_cmd {
>  	BPF_ITER_CREATE,
>  	BPF_LINK_DETACH,
>  	BPF_PROG_BIND_MAP,
> +	BPF_TOKEN_CREATE,
> +	__MAX_BPF_CMD,
>  };
>  
>  enum bpf_map_type {
> @@ -1694,6 +1727,12 @@ union bpf_attr {
>  		__u32		flags;		/* extra flags */
>  	} prog_bind_map;
>  
> +	struct { /* struct used by BPF_TOKEN_CREATE command */
> +		__u32		flags;
> +		__u32		bpffs_path_fd;
> +		__u64		bpffs_pathname;

Because bppfs_pathname is a string pointer, so __aligned_u64 is preferred.
> +	} token_create;
> +
>  } __attribute__((aligned(8)));
>  
>  /* The description below is an attempt at providing documentation to eBPF
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index f526b7573e97..4ce95acfcaa7 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
>  endif
>  CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
>  
> -obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o
> +obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>  obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 24b3faf901f4..de1fdf396521 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -99,9 +99,9 @@ static const struct inode_operations bpf_prog_iops = { };
>  static const struct inode_operations bpf_map_iops  = { };
>  static const struct inode_operations bpf_link_iops  = { };
>  
> -static struct inode *bpf_get_inode(struct super_block *sb,
> -				   const struct inode *dir,
> -				   umode_t mode)
> +struct inode *bpf_get_inode(struct super_block *sb,
> +			    const struct inode *dir,
> +			    umode_t mode)
>  {
>  	struct inode *inode;
>  
> @@ -603,11 +603,13 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
>  {
>  	struct bpf_mount_opts *opts = root->d_sb->s_fs_info;
>  	umode_t mode = d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
> +	u64 mask;
>  
>  	if (mode != S_IRWXUGO)
>  		seq_printf(m, ",mode=%o", mode);
>  
> -	if (opts->delegate_cmds == ~0ULL)
> +	mask = (1ULL << __MAX_BPF_CMD) - 1;
> +	if ((opts->delegate_cmds & mask) == mask)
>  		seq_printf(m, ",delegate_cmds=any");

Should we add a BUILD_BUG_ON assertion to guarantee __MAX_BPF_CMD is
less than sizeof(u64) * 8 ?
>  	else if (opts->delegate_cmds)
>  		seq_printf(m, ",delegate_cmds=0x%llx", opts->delegate_cmds);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7445dad01fb3..b47791a80930 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5304,6 +5304,20 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
>  	return ret;
>  }
>  
> +#define BPF_TOKEN_CREATE_LAST_FIELD token_create.bpffs_pathname
> +
> +static int token_create(union bpf_attr *attr)
> +{
> +	if (CHECK_ATTR(BPF_TOKEN_CREATE))
> +		return -EINVAL;
> +
> +	/* no flags are supported yet */
> +	if (attr->token_create.flags)
> +		return -EINVAL;
> +
> +	return bpf_token_create(attr);
> +}
> +
>  static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
>  {
>  	union bpf_attr attr;
> @@ -5437,6 +5451,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
>  	case BPF_PROG_BIND_MAP:
>  		err = bpf_prog_bind_map(&attr);
>  		break;
> +	case BPF_TOKEN_CREATE:
> +		err = token_create(&attr);
> +		break;
>  	default:
>  		err = -EINVAL;
>  		break;
> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> new file mode 100644
> index 000000000000..779aad5007a3
> --- /dev/null
> +++ b/kernel/bpf/token.c
SNIP
> +#define BPF_TOKEN_INODE_NAME "bpf-token"
> +
> +static const struct inode_operations bpf_token_iops = { };
> +
> +static const struct file_operations bpf_token_fops = {
> +	.release	= bpf_token_release,
> +	.show_fdinfo	= bpf_token_show_fdinfo,
> +};
> +
> +int bpf_token_create(union bpf_attr *attr)
> +{
> +	struct bpf_mount_opts *mnt_opts;
> +	struct bpf_token *token = NULL;
> +	struct inode *inode;
> +	struct file *file;
> +	struct path path;
> +	umode_t mode;
> +	int err, fd;
> +
> +	err = user_path_at(attr->token_create.bpffs_path_fd,
> +			   u64_to_user_ptr(attr->token_create.bpffs_pathname),
> +			   LOOKUP_FOLLOW | LOOKUP_EMPTY, &path);
> +	if (err)
> +		return err;

Need to check the mount is a bpffs mount instead of other filesystem mount.
> +
> +	if (path.mnt->mnt_root != path.dentry) {
> +		err = -EINVAL;
> +		goto out_path;
> +	}
> +	err = path_permission(&path, MAY_ACCESS);
> +	if (err)
> +		goto out_path;
> +
> +	mode = S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
> +	inode = bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
> +	if (IS_ERR(inode)) {
> +		err = PTR_ERR(inode);
> +		goto out_path;
> +	}
> +
> +	inode->i_op = &bpf_token_iops;
> +	inode->i_fop = &bpf_token_fops;
> +	clear_nlink(inode); /* make sure it is unlinked */
> +
> +	file = alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME, O_RDWR, &bpf_token_fops);
> +	if (IS_ERR(file)) {
> +		iput(inode);
> +		err = PTR_ERR(file);
> +		goto out_file;

goto out_path ?
> +	}
> +
> +	token = bpf_token_alloc();
> +	if (!token) {
> +		err = -ENOMEM;
> +		goto out_file;
> +	}
> +
> +	/* remember bpffs owning userns for future ns_capable() checks */
> +	token->userns = get_user_ns(path.dentry->d_sb->s_user_ns);
> +
> +	mnt_opts = path.dentry->d_sb->s_fs_info;
> +	token->allowed_cmds = mnt_opts->delegate_cmds;
> +
> +	fd = get_unused_fd_flags(O_CLOEXEC);
> +	if (fd < 0) {
> +		err = fd;
> +		goto out_token;
> +	}
> +
> +	file->private_data = token;
> +	fd_install(fd, file);
> +
> +	path_put(&path);
> +	return fd;
> +
> +out_token:
> +	bpf_token_free(token);
> +out_file:
> +	fput(file);
> +out_path:
> +	path_put(&path);
> +	return err;
> +}
> +
.


