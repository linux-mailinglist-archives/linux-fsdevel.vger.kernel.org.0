Return-Path: <linux-fsdevel+bounces-5589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFF580DEAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 23:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541CC28261C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 22:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970256459;
	Mon, 11 Dec 2023 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClXD9SyQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2905CF;
	Mon, 11 Dec 2023 14:56:22 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-286b45c5a8dso5244478a91.1;
        Mon, 11 Dec 2023 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702335382; x=1702940182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leXTzQCLvV+RpBERG2eoVGwxs2sJKUogXL39ofXTQxg=;
        b=ClXD9SyQpdMAN3895Js5LF6OeZ3vIvzs4IXB/rNMF1ppNjv213gJdNxxKMDM7lTFlV
         c93JrHZmLV4gcFLyfIddlOYoOlxBH8vFTsRCzvRm1tOGe3TxWWfIr7ow/s80XlqJRdjl
         4Eyah6Az9/rjwaNbqIWEO49CSkv6eOn/6c+D8URMPskO1h9Cs4WGejS85LyozUfK8pt8
         hTLJ5mr/SjVB1h7ahgZgVM4zlXqxaB8fR6eFULcEH4x1u9GYunV6DHiowjPOcg3M9vU9
         +qdMgxkC4UiX7VrFzXTQz6kQRj2YG6KSwoAKaklXeJnuDThY3PZBOKFhPWQc0vQ+Zgvh
         3pWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335382; x=1702940182;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=leXTzQCLvV+RpBERG2eoVGwxs2sJKUogXL39ofXTQxg=;
        b=tC5mFiEw99sbwOetVPpa4baIPJNsGCnIJstRY9Wfhr3yvg4VFTTBSq6tDAgBxeY370
         tFUZs3//prrc/5VOlFPlC//tdSfWUBZbxALC1dpe5E54gu0u/VOj3JRtpqWlHP1+Wnhe
         3hcCpA3Soc6gMkFcyLhVm19JTEthu0cUkX6npf1vbLg9gYCESMTq2pf4RXdRCxOU8mEe
         l7AN0K5xzRqRLY1DBFPG2QXS72s1K6OuGj67TDwqNsqTvSPyhbse4plNECaAP90eHkdb
         zY814ThJ6EesXS8dbLowMAsxf6nYp7vs8OB0lWpUoWYj2Pod71DDojUec7+S9Gkocu8n
         BibA==
X-Gm-Message-State: AOJu0YwLWI91wSkXHgmdtjHFeUkMDsg6mXQbfQ/q0jy73qmT1GX+OTF1
	afzP2d/Sgj/Ggx3A54n7BBsPLC6p1ZVGaA==
X-Google-Smtp-Source: AGHT+IGmVQX4qmWaSVnMyK5xHqlKA10uWuStZ4XuHzrlJAS1evud263TDlxudlIa4UMf7nrUT2JyeQ==
X-Received: by 2002:a17:90a:4611:b0:286:a93c:5b29 with SMTP id w17-20020a17090a461100b00286a93c5b29mr3878452pjg.12.1702335381984;
        Mon, 11 Dec 2023 14:56:21 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id nv12-20020a17090b1b4c00b00286f63da50asm8971292pjb.53.2023.12.11.14.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:56:21 -0800 (PST)
Date: Mon, 11 Dec 2023 14:56:20 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 paul@paul-moore.com, 
 brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 keescook@chromium.org, 
 kernel-team@meta.com, 
 sargun@sargun.me
Message-ID: <657793942699a_edaa208bc@john.notmuch>
In-Reply-To: <20231207185443.2297160-7-andrii@kernel.org>
References: <20231207185443.2297160-1-andrii@kernel.org>
 <20231207185443.2297160-7-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 6/8] libbpf: wire up BPF token support at BPF
 object level
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> Add BPF token support to BPF object-level functionality.
> 
> BPF token is supported by BPF object logic either as an explicitly
> provided BPF token from outside (through BPF FS path or explicit BPF
> token FD), or implicitly (unless prevented through
> bpf_object_open_opts).
> 
> Implicit mode is assumed to be the most common one for user namespaced
> unprivileged workloads. The assumption is that privileged container
> manager sets up default BPF FS mount point at /sys/fs/bpf with BPF token
> delegation options (delegate_{cmds,maps,progs,attachs} mount options).
> BPF object during loading will attempt to create BPF token from
> /sys/fs/bpf location, and pass it for all relevant operations
> (currently, map creation, BTF load, and program load).
> 
> In this implicit mode, if BPF token creation fails due to whatever
> reason (BPF FS is not mounted, or kernel doesn't support BPF token,
> etc), this is not considered an error. BPF object loading sequence will
> proceed with no BPF token.
> 
> In explicit BPF token mode, user provides explicitly either custom BPF
> FS mount point path or creates BPF token on their own and just passes
> token FD directly. In such case, BPF object will either dup() token FD
> (to not require caller to hold onto it for entire duration of BPF object
> lifetime) or will attempt to create BPF token from provided BPF FS
> location. If BPF token creation fails, that is considered a critical
> error and BPF object load fails with an error.
> 
> Libbpf provides a way to disable implicit BPF token creation, if it
> causes any troubles (BPF token is designed to be completely optional and
> shouldn't cause any problems even if provided, but in the world of BPF
> LSM, custom security logic can be installed that might change outcome
> dependin on the presence of BPF token). To disable libbpf's default BPF
> token creation behavior user should provide either invalid BPF token FD
> (negative), or empty bpf_token_path option.
> 
> BPF token presence can influence libbpf's feature probing, so if BPF
> object has associated BPF token, feature probing is instructed to use
> BPF object-specific feature detection cache and token FD.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/btf.c             |   7 +-
>  tools/lib/bpf/libbpf.c          | 120 ++++++++++++++++++++++++++++++--
>  tools/lib/bpf/libbpf.h          |  28 +++++++-
>  tools/lib/bpf/libbpf_internal.h |  17 ++++-
>  4 files changed, 160 insertions(+), 12 deletions(-)
> 

...

>  
> +static int bpf_object_prepare_token(struct bpf_object *obj)
> +{
> +	const char *bpffs_path;
> +	int bpffs_fd = -1, token_fd, err;
> +	bool mandatory;
> +	enum libbpf_print_level level = LIBBPF_DEBUG;

redundant set on level?

> +
> +	/* token is already set up */
> +	if (obj->token_fd > 0)
> +		return 0;
> +	/* token is explicitly prevented */
> +	if (obj->token_fd < 0) {
> +		pr_debug("object '%s': token is prevented, skipping...\n", obj->name);
> +		/* reset to zero to avoid extra checks during map_create and prog_load steps */
> +		obj->token_fd = 0;
> +		return 0;
> +	}
> +
> +	mandatory = obj->token_path != NULL;
> +	level = mandatory ? LIBBPF_WARN : LIBBPF_DEBUG;
> +
> +	bpffs_path = obj->token_path ?: BPF_FS_DEFAULT_PATH;
> +	bpffs_fd = open(bpffs_path, O_DIRECTORY, O_RDWR);
> +	if (bpffs_fd < 0) {
> +		err = -errno;
> +		__pr(level, "object '%s': failed (%d) to open BPF FS mount at '%s'%s\n",
> +		     obj->name, err, bpffs_path,
> +		     mandatory ? "" : ", skipping optional step...");
> +		return mandatory ? err : 0;
> +	}
> +
> +	token_fd = bpf_token_create(bpffs_fd, 0);

Did this get tested on older kernels? In that case TOKEN_CREATE will
fail with -EINVAL.

> +	close(bpffs_fd);
> +	if (token_fd < 0) {
> +		if (!mandatory && token_fd == -ENOENT) {
> +			pr_debug("object '%s': BPF FS at '%s' doesn't have BPF token delegation set up, skipping...\n",
> +				 obj->name, bpffs_path);
> +			return 0;
> +		}

Isn't there a case here we should give a warning about?  If BPF_TOKEN_CREATE
exists and !mandatory, but default BPFFS failed for enomem, or eperm reasons?
If the user reall/y doesn't want tokens here they should maybe override with
-1 token? My thought is if you have delegations set up then something on the
system is trying to configure this and an error might be ok? I'm asking just
because I paused on it for a bit not sure either way at the moment. I might
imagine a lazy program not specifying the default bpffs, but also really
thinking its going to get a valid token.


> +		__pr(level, "object '%s': failed (%d) to create BPF token from '%s'%s\n",
> +		     obj->name, token_fd, bpffs_path,
> +		     mandatory ? "" : ", skipping optional step...");
> +		return mandatory ? token_fd : 0;
> +	}
> +
> +	obj->feat_cache = calloc(1, sizeof(*obj->feat_cache));
> +	if (!obj->feat_cache) {
> +		close(token_fd);
> +		return -ENOMEM;
> +	}
> +
> +	obj->token_fd = token_fd;
> +	obj->feat_cache->token_fd = token_fd;
> +
> +	return 0;
> +}
> +
>  static int
>  bpf_object__probe_loading(struct bpf_object *obj)
>  {
> @@ -4601,6 +4664,7 @@ bpf_object__probe_loading(struct bpf_object *obj)
>  		BPF_EXIT_INSN(),
>  	};
>  	int ret, insn_cnt = ARRAY_SIZE(insns);
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts, .token_fd = obj->token_fd);
>  
>  	if (obj->gen_loader)
>  		return 0;
> @@ -4610,9 +4674,9 @@ bpf_object__probe_loading(struct bpf_object *obj)
>  		pr_warn("Failed to bump RLIMIT_MEMLOCK (err = %d), you might need to do it explicitly!\n", ret);
>  
>  	/* make sure basic loading works */
> -	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
> +	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &opts);
>  	if (ret < 0)
> -		ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, NULL);
> +		ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
>  	if (ret < 0) {
>  		ret = errno;
>  		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
> @@ -4635,6 +4699,9 @@ bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
>  		 */
>  		return true;
>  
> +	if (obj->token_fd)
> +		return feat_supported(obj->feat_cache, feat_id);

OK that answers feat_supported() non null from earlier patch. Just
was reading in order.

> +
>  	return feat_supported(NULL, feat_id);
>  }

...

>  	btf_fd = bpf_object__btf_fd(obj);
> @@ -7050,10 +7119,10 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
>  static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf, size_t obj_buf_sz,
>  					  const struct bpf_object_open_opts *opts)
>  {
> -	const char *obj_name, *kconfig, *btf_tmp_path;
> +	const char *obj_name, *kconfig, *btf_tmp_path, *token_path;
>  	struct bpf_object *obj;
>  	char tmp_name[64];
> -	int err;
> +	int err, token_fd;
>  	char *log_buf;
>  	size_t log_size;
>  	__u32 log_level;
> @@ -7087,6 +7156,20 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
>  	if (log_size && !log_buf)
>  		return ERR_PTR(-EINVAL);
>  
> +	token_path = OPTS_GET(opts, bpf_token_path, NULL);
> +	token_fd = OPTS_GET(opts, bpf_token_fd, -1);
> +	/* non-empty token path can't be combined with invalid token FD */
> +	if (token_path && token_path[0] != '\0' && token_fd < 0)
> +		return ERR_PTR(-EINVAL);
> +	if (token_path && token_path[0] == '\0') {
> +		/* empty token path can't be combined with valid token FD */
> +		if (token_fd > 0)
> +			return ERR_PTR(-EINVAL);
> +		/* empty token_path is equivalent to invalid token_fd */
> +		token_path = NULL;
> +		token_fd = -1;
> +	}
> +
>  	obj = bpf_object__new(path, obj_buf, obj_buf_sz, obj_name);
>  	if (IS_ERR(obj))
>  		return obj;
> @@ -7095,6 +7178,23 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
>  	obj->log_size = log_size;
>  	obj->log_level = log_level;
>  
> +	obj->token_fd = token_fd <= 0 ? token_fd : dup_good_fd(token_fd);
> +	if (token_fd > 0 && obj->token_fd < 0) {
> +		err = -errno;
> +		goto out;
> +	}
> +	if (token_path) {
> +		if (strlen(token_path) >= PATH_MAX) {

small nit, might be cleaner to just have this up where the other sanity
checks are done? e.g.

   `token_path[0] !=` `\0` && token_path(token_path) < PATH_MAX`

just to abort earlier. But not sure I care much.

> +			err = -ENAMETOOLONG;
> +			goto out;
> +		}
> +		obj->token_path = strdup(token_path);
> +		if (!obj->token_path) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +	}
> +
>  	btf_tmp_path = OPTS_GET(opts, btf_custom_path, NULL);
>  	if (btf_tmp_path) {
>  		if (strlen(btf_tmp_path) >= PATH_MAX) {
> @@ -7605,7 +7705,8 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
>  	if (obj->gen_loader)
>  		bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_programs, obj->nr_maps);
>  
> -	err = bpf_object__probe_loading(obj);
> +	err = bpf_object_prepare_token(obj);
> +	err = err ? : bpf_object__probe_loading(obj);
>  	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
>  	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
>  	err = err ? : bpf_object__sanitize_and_load_btf(obj);
> @@ -8142,6 +8243,11 @@ void bpf_object__close(struct bpf_object *obj)
>  	}
>  	zfree(&obj->programs);
>  
> +	zfree(&obj->feat_cache);
> +	zfree(&obj->token_path);
> +	if (obj->token_fd > 0)
> +		close(obj->token_fd);
> +
>  	free(obj);
>  }
>  
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 6cd9c501624f..d3de39b537f3 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -177,10 +177,36 @@ struct bpf_object_open_opts {
>  	 * logs through its print callback.
>  	 */
>  	__u32 kernel_log_level;
> +	/* FD of a BPF token instantiated by user through bpf_token_create()
> +	 * API. BPF object will keep dup()'ed FD internally, so passed token
> +	 * FD can be closed after BPF object/skeleton open step.
> +	 *
> +	 * Setting bpf_token_fd to negative value disables libbpf's automatic
> +	 * attempt to create BPF token from default BPF FS mount point
> +	 * (/sys/fs/bpf), in case this default behavior is undesirable.
> +	 *
> +	 * bpf_token_path and bpf_token_fd are mutually exclusive and only one
> +	 * of those options should be set.
> +	 */
> +	int bpf_token_fd;
> +	/* Path to BPF FS mount point to derive BPF token from.
> +	 *
> +	 * Created BPF token will be used for all bpf() syscall operations
> +	 * that accept BPF token (e.g., map creation, BTF and program loads,
> +	 * etc) automatically within instantiated BPF object.
> +	 *
> +	 * Setting bpf_token_path option to empty string disables libbpf's
> +	 * automatic attempt to create BPF token from default BPF FS mount
> +	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
> +	 *
> +	 * bpf_token_path and bpf_token_fd are mutually exclusive and only one
> +	 * of those options should be set.
> +	 */
> +	const char *bpf_token_path;
>  

