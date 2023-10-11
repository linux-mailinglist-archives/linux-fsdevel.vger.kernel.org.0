Return-Path: <linux-fsdevel+bounces-16-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A16227C4721
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 03:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8A02823E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 01:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9180C4693;
	Wed, 11 Oct 2023 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OAUXHE/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629C80D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 01:17:42 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB7393
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 18:17:40 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-418201cb9e9so39472961cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 18:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696987059; x=1697591859; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4ep+PbhzeVnduVbr8z7Z0gjmvyPHTzKccOH0jUMZNmY=;
        b=OAUXHE/6ZcgknQqG07z/YhahYjRHlxl53D/jYG2UejCWb/znVOcm6P3YkuPj9/3mHg
         cyVonT+e+50xYTO8NU1t0H/boSXis4ZIX3dTkBDAqrDgSxppiRLXpUn6gWXRFKZlksWj
         1BUAq6+uv6yXcYncRnx+GGFNgJYzAPCkYK+2weYUjXF4/eyoiUvCiBvIPv7jcmyUwVVx
         JqsSiMd4Qsa85p/2CH2Hd/8kGFvRHriGbS2k//A4iBhyuDcX5xBhxyt0Bsc1EKHiASvm
         gFXr5G8LqCXiIHfkzHlsoD39yQLP57sB+IO0dJupR/iRNblZsSoOlz2qdDcVLXbQF00h
         H+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696987059; x=1697591859;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ep+PbhzeVnduVbr8z7Z0gjmvyPHTzKccOH0jUMZNmY=;
        b=gLipKTZfoNYgvDqZzKhDfaKkOaIsxjLdvtZ3o4736mjmSb6xCNHc7C8NLy9Mfx3j63
         BI935YBmVgBr+FWn7IOg92BnJZzsDGOxlmO0SRB+wRgVBYSo/dnMULHdnsDvdrn3BHD8
         Cjw8bOVqVcgC3vp/p94GePZIL2j1tNWynhqofAB0FaTdAfLnIonOs1mmSR3D1GPqEZfP
         kvHgpOmvvUufgwezxBmhoqXNF0PgSEJrb9VDhHRinMWeTPh6Hnhcoz0TEIyUQeQuMZfm
         hpW0eivXBcg7Yll08MxpwdV6Q4eZYuW/N+KCivronKJH26ayxnLgvUmSvoxWVHDKmz89
         qHew==
X-Gm-Message-State: AOJu0YwagnEr+5gv98/3MlUBApQ42gQAXhpW75TL+1yu+i7r900YvyUD
	ycfuKXzaeJpRHG/PoWeC37PN
X-Google-Smtp-Source: AGHT+IFEPga2wl4YyoyjcHVXcerxmLH8y2GeEtL2ebmMOvdmmj4u34H1LxUdZva9EdLHFPfZ5NsbcQ==
X-Received: by 2002:ac8:5813:0:b0:405:47ef:8164 with SMTP id g19-20020ac85813000000b0040547ef8164mr23916719qtg.39.1696987059269;
        Tue, 10 Oct 2023 18:17:39 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g2-20020ac80702000000b0041818df8a0dsm4931602qth.36.2023.10.10.18.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 18:17:38 -0700 (PDT)
Date: Tue, 10 Oct 2023 21:17:38 -0400
Message-ID: <53183ab045f8154ef94070039d53bbab.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>, <keescook@chromium.org>, <brauner@kernel.org>, <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>, selinux@vger.kernel.org
Subject: Re: [PATCH v6 3/13] bpf: introduce BPF token object
References: <20230927225809.2049655-4-andrii@kernel.org>
In-Reply-To: <20230927225809.2049655-4-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Sep 27, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> 
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
> 
> BPF token itself is just a derivative from BPF FS and can be created
> through a new bpf() syscall command, BPF_TOKEN_CREAT, which accepts
> a path specification (using the usual fd + string path combo) to a BPF
> FS mount. Currently, BPF token "inherits" delegated command, map types,
> prog type, and attach type bit sets from BPF FS as is. In the future,
> having an BPF token as a separate object with its own FD, we can allow
> to further restrict BPF token's allowable set of things either at the creation
> time or after the fact, allowing the process to guard itself further
> from, e.g., unintentionally trying to load undesired kind of BPF
> programs. But for now we keep things simple and just copy bit sets as is.
> 
> When BPF token is created from BPF FS mount, we take reference to the
> BPF super block's owning user namespace, and then use that namespace for
> checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> capabilities that are normally only checked against init userns (using
> capable()), but now we check them using ns_capable() instead (if BPF
> token is provided). See bpf_token_capable() for details.
> 
> Such setup means that BPF token in itself is not sufficient to grant BPF
> functionality. User namespaced process has to *also* have necessary
> combination of capabilities inside that user namespace. So while
> previously CAP_BPF was useless when granted within user namespace, now
> it gains a meaning and allows container managers and sys admins to have
> a flexible control over which processes can and need to use BPF
> functionality within the user namespace (i.e., container in practice).
> And BPF FS delegation mount options and derived BPF tokens serve as
> a per-container "flag" to grant overall ability to use bpf() (plus further
> restrict on which parts of bpf() syscalls are treated as namespaced).
> 
> The alternative to creating BPF token object was:
>   a) not having any extra object and just pasing BPF FS path to each
>      relevant bpf() command. This seems suboptimal as it's racy (mount
>      under the same path might change in between checking it and using it
>      for bpf() command). And also less flexible if we'd like to further
>      restrict ourselves compared to all the delegated functionality
>      allowed on BPF FS.
>   b) use non-bpf() interface, e.g., ioctl(), but otherwise also create
>      a dedicated FD that would represent a token-like functionality. This
>      doesn't seem superior to having a proper bpf() command, so
>      BPF_TOKEN_CREATE was chosen.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h            |  40 +++++++
>  include/uapi/linux/bpf.h       |  39 +++++++
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/inode.c             |  10 +-
>  kernel/bpf/syscall.c           |  17 +++
>  kernel/bpf/token.c             | 197 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  39 +++++++
>  7 files changed, 339 insertions(+), 5 deletions(-)
>  create mode 100644 kernel/bpf/token.c
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a5bd40f71fd0..c43131a24579 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1572,6 +1576,13 @@ struct bpf_mount_opts {
>  	u64 delegate_attachs;
>  };
>  
> +struct bpf_token {
> +	struct work_struct work;
> +	atomic64_t refcnt;
> +	struct user_namespace *userns;
> +	u64 allowed_cmds;

We'll also need a 'void *security' field to go along with the BPF token
allocation/creation/free hooks, see my comments below.  This is similar
to what we do for other kernel objects.

> +};
> +

...

> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> new file mode 100644
> index 000000000000..779aad5007a3
> --- /dev/null
> +++ b/kernel/bpf/token.c
> @@ -0,0 +1,197 @@
> +#include <linux/bpf.h>
> +#include <linux/vmalloc.h>
> +#include <linux/anon_inodes.h>

Probably don't need the anon_inode.h include anymore.

> +#include <linux/fdtable.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/idr.h>
> +#include <linux/namei.h>
> +#include <linux/user_namespace.h>
> +
> +bool bpf_token_capable(const struct bpf_token *token, int cap)
> +{
> +	/* BPF token allows ns_capable() level of capabilities */
> +	if (token) {

I think we want a LSM hook here before the token is used in the
capability check.  The LSM will see the capability check, but it will
not be able to distinguish it from the process which created the
delegation token.  This is arguably the purpose of the delegation, but
with the LSM we want to be able to control who can use the delegated
privilege.  How about something like this:

  if (security_bpf_token_capable(token, cap))
     return false;

> +		if (ns_capable(token->userns, cap))
> +			return true;
> +		if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))
> +			return true;
> +	}
> +	/* otherwise fallback to capable() checks */
> +	return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> +}
> +
> +void bpf_token_inc(struct bpf_token *token)
> +{
> +	atomic64_inc(&token->refcnt);
> +}
> +
> +static void bpf_token_free(struct bpf_token *token)
> +{

We should have a LSM hook here to handle freeing the LSM state
associated with the token.

  security_bpf_token_free(token);

> +	put_user_ns(token->userns);
> +	kvfree(token);
> +}

...

> +static struct bpf_token *bpf_token_alloc(void)
> +{
> +	struct bpf_token *token;
> +
> +	token = kvzalloc(sizeof(*token), GFP_USER);
> +	if (!token)
> +		return NULL;
> +
> +	atomic64_set(&token->refcnt, 1);

We should have a LSM hook here to allocate the LSM state associated
with the token.

  if (security_bpf_token_alloc(token)) {
    kvfree(token);
    return NULL;
  }

> +	return token;
> +}

...

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

I think we would want a LSM hook here, both to control the creation
of the token and mark it with the security attributes of the creating
process.  How about something like this:

  err = security_bpf_token_create(token);
  if (err)
    goto out_token;

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

...

> +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
> +{
> +	if (!token)
> +		return false;
> +
> +	return token->allowed_cmds & (1ULL << cmd);

Similar to bpf_token_capable(), I believe we want a LSM hook here to
control who is allowed to use the delegated privilege.

  bool bpf_token_allow_cmd(...)
  {
    if (token && (token->allowed_cmds & (1ULL << cmd))
      return security_bpf_token_cmd(token, cmd);
    return false;
  }

> +}

--
paul-moore.com

