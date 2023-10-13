Return-Path: <linux-fsdevel+bounces-346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAD77C8ED6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 23:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03704281AD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 21:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3497250FA;
	Fri, 13 Oct 2023 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SOFfq/eB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA38241EB
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 21:15:44 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F5F95
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 14:15:38 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7be88e9ccso31508157b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697231738; x=1697836538; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dLQj5ZtRhq6MJlTujO1awDYkdSdBvUj8+lUyHnK/bd4=;
        b=SOFfq/eBOF46t8KmBVttTNwb/Ms9aEFLYPFekKQUyfhV1GEwPF/pi6ecxjZMQpA2/C
         gJ3ylnLqIFiMtTDnIgfza01kRKbnZw2o8hu4U6jfdI60xd9TARK9D2GZwSrpjX+cAVaE
         z01nYYRkKUuUCuixgXjcG8NDzNeUwNLor3lAMO2cJFZVc2LnMohl1erMYoCI2nji7A9D
         kyBsvGVLp/Pf5eDdzzQQIoJTOSjN+Hb8/ObhonKWfLRaUc9Qais+kOWNnUm6zKm8fC9K
         qgl7CoxFr4fgXS63q0oRJfHmL89xx8d/o7VPSF9t7y4OiQXZHwFPt25xcdD0/Z5b+DKt
         f56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231738; x=1697836538;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLQj5ZtRhq6MJlTujO1awDYkdSdBvUj8+lUyHnK/bd4=;
        b=kEU1C0MlTn0/fAgCmfHVjwOQFi+iUI9bVIusY8ZROhAktojaTfg0XdVuLjtK8DtxDM
         FBUOa9CQiGzGCd8DFTxWMWLdmJPa3wDb7M3UnqyjL1rLLHmeGuQIBMIDCAqIrsW5ndCf
         CXwmyG3jWyYhlK+g2r5qauXnqXXXZVSKiEVfl/mgDx/cG93Bc2MSsYFvCuRFK341+rnj
         7dOTpEp29A2tIPv4oMnS2pdTNMWl/2oRpsPsl0E6HrwAcVRKb2KQG3e8qD/F3YMIeULH
         YfMz7knzyHVNedfQPWmGf5ui5Ayds0/KJHQpP8ZrgexbGjRyyC6sT0kFrNlVbISv1I5w
         5HTw==
X-Gm-Message-State: AOJu0Yw2G3O96YFcOppCZcWG+JRLL3comWkcWbh13tB2eYXkDd+l6Rs3
	NV1rXozURAU6FTzeJpgLIXpg
X-Google-Smtp-Source: AGHT+IE9Y/CTy90dFiEu+jR5Pxz9wsQqLKZYtYve5r7Wzy5bzGLDis9NzbyVIICb9r05qqznex/94g==
X-Received: by 2002:a0d:caca:0:b0:5a7:d133:370d with SMTP id m193-20020a0dcaca000000b005a7d133370dmr12555978ywd.16.1697231737932;
        Fri, 13 Oct 2023 14:15:37 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id e5-20020a05620a12c500b007756c8ce8f5sm945199qkl.59.2023.10.13.14.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 14:15:37 -0700 (PDT)
Date: Fri, 13 Oct 2023 17:15:36 -0400
Message-ID: <f739928b1db9a9e45da89249c0389e85.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>, <keescook@chromium.org>, <brauner@kernel.org>, <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: Re: [PATCH v7 6/18] bpf: add BPF token support to BPF_PROG_LOAD  command
References: <20231012222810.4120312-7-andrii@kernel.org>
In-Reply-To: <20231012222810.4120312-7-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Oct 12, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> Add basic support of BPF token to BPF_PROG_LOAD. Wire through a set of
> allowed BPF program types and attach types, derived from BPF FS at BPF
> token creation time. Then make sure we perform bpf_token_capable()
> checks everywhere where it's relevant.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h                           |  6 ++
>  include/uapi/linux/bpf.h                      |  2 +
>  kernel/bpf/core.c                             |  1 +
>  kernel/bpf/inode.c                            |  6 +-
>  kernel/bpf/syscall.c                          | 87 ++++++++++++++-----
>  kernel/bpf/token.c                            | 27 ++++++
>  tools/include/uapi/linux/bpf.h                |  2 +
>  .../selftests/bpf/prog_tests/libbpf_probes.c  |  2 +
>  .../selftests/bpf/prog_tests/libbpf_str.c     |  3 +
>  9 files changed, 110 insertions(+), 26 deletions(-)

...

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a2c9edcbcd77..c6b00aee3b62 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2584,13 +2584,15 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
>  }
>  
>  /* last field in 'union bpf_attr' used by this command */
> -#define	BPF_PROG_LOAD_LAST_FIELD log_true_size
> +#define BPF_PROG_LOAD_LAST_FIELD prog_token_fd
>  
>  static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  {
>  	enum bpf_prog_type type = attr->prog_type;
>  	struct bpf_prog *prog, *dst_prog = NULL;
>  	struct btf *attach_btf = NULL;
> +	struct bpf_token *token = NULL;
> +	bool bpf_cap;
>  	int err;
>  	char license[128];
>  
> @@ -2606,10 +2608,31 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  				 BPF_F_XDP_DEV_BOUND_ONLY))
>  		return -EINVAL;
>  
> +	bpf_prog_load_fixup_attach_type(attr);
> +
> +	if (attr->prog_token_fd) {
> +		token = bpf_token_get_from_fd(attr->prog_token_fd);
> +		if (IS_ERR(token))
> +			return PTR_ERR(token);
> +		/* if current token doesn't grant prog loading permissions,
> +		 * then we can't use this token, so ignore it and rely on
> +		 * system-wide capabilities checks
> +		 */
> +		if (!bpf_token_allow_cmd(token, BPF_PROG_LOAD) ||
> +		    !bpf_token_allow_prog_type(token, attr->prog_type,
> +					       attr->expected_attach_type)) {
> +			bpf_token_put(token);
> +			token = NULL;
> +		}

At the start of this effort I mentioned how we wanted to have LSM
control points when the token is created and when it is used.  It is
for this reason that we still want a hook inside the
bpf_token_allow_cmd() function as it allows us to enable/disable use
of the token when its use is first attempted.  If the LSM decides to
disallow use of the token in this particular case then the token is
disabled (set to NULL) while the operation is still allowed to move
forward, simply without the token.  It's a much cleaner and well
behaved approach as it allows the normal BPF access controls to do
their work.

> +	}
> +
> +	bpf_cap = bpf_token_capable(token, CAP_BPF);

Similar to the above comment, we want to a LSM control point in
bpf_token_capable() so that the LSM can control the token's
ability to delegate capability privileges when they are used.  Having
to delay this access control point to security_bpf_prog_load() is not
only awkward but it requires either manual synchronization between
all of the different LSMs and the the capability checks in the
bpf_prog_load() function or a completely different set of LSM
permissions for a token-based BPF program load over a normal BPF
program load.

We really need these hooks Andrii, I wouldn't have suggested them if
I didn't believe they were important.

> +	err = -EPERM;
> +
>  	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
>  	    (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
> -	    !bpf_capable())
> -		return -EPERM;
> +	    !bpf_cap)
> +		goto put_token;
>  
>  	/* Intent here is for unprivileged_bpf_disabled to block BPF program
>  	 * creation for unprivileged users; other actions depend
> @@ -2618,21 +2641,23 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  	 * capability checks are still carried out for these
>  	 * and other operations.
>  	 */
> -	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
> -		return -EPERM;
> +	if (sysctl_unprivileged_bpf_disabled && !bpf_cap)
> +		goto put_token;
>  
>  	if (attr->insn_cnt == 0 ||
> -	    attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
> -		return -E2BIG;
> +	    attr->insn_cnt > (bpf_cap ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS)) {
> +		err = -E2BIG;
> +		goto put_token;
> +	}
>  	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
>  	    type != BPF_PROG_TYPE_CGROUP_SKB &&
> -	    !bpf_capable())
> -		return -EPERM;
> +	    !bpf_cap)
> +		goto put_token;
>  
> -	if (is_net_admin_prog_type(type) && !bpf_net_capable())
> -		return -EPERM;
> -	if (is_perfmon_prog_type(type) && !perfmon_capable())
> -		return -EPERM;
> +	if (is_net_admin_prog_type(type) && !bpf_token_capable(token, CAP_NET_ADMIN))
> +		goto put_token;
> +	if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_PERFMON))
> +		goto put_token;
>  
>  	/* attach_prog_fd/attach_btf_obj_fd can specify fd of either bpf_prog
>  	 * or btf, we need to check which one it is
> @@ -2642,27 +2667,33 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  		if (IS_ERR(dst_prog)) {
>  			dst_prog = NULL;
>  			attach_btf = btf_get_by_fd(attr->attach_btf_obj_fd);
> -			if (IS_ERR(attach_btf))
> -				return -EINVAL;
> +			if (IS_ERR(attach_btf)) {
> +				err = -EINVAL;
> +				goto put_token;
> +			}
>  			if (!btf_is_kernel(attach_btf)) {
>  				/* attaching through specifying bpf_prog's BTF
>  				 * objects directly might be supported eventually
>  				 */
>  				btf_put(attach_btf);
> -				return -ENOTSUPP;
> +				err = -ENOTSUPP;
> +				goto put_token;
>  			}
>  		}
>  	} else if (attr->attach_btf_id) {
>  		/* fall back to vmlinux BTF, if BTF type ID is specified */
>  		attach_btf = bpf_get_btf_vmlinux();
> -		if (IS_ERR(attach_btf))
> -			return PTR_ERR(attach_btf);
> -		if (!attach_btf)
> -			return -EINVAL;
> +		if (IS_ERR(attach_btf)) {
> +			err = PTR_ERR(attach_btf);
> +			goto put_token;
> +		}
> +		if (!attach_btf) {
> +			err = -EINVAL;
> +			goto put_token;
> +		}
>  		btf_get(attach_btf);
>  	}
>  
> -	bpf_prog_load_fixup_attach_type(attr);
>  	if (bpf_prog_load_check_attach(type, attr->expected_attach_type,
>  				       attach_btf, attr->attach_btf_id,
>  				       dst_prog)) {
> @@ -2670,7 +2701,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  			bpf_prog_put(dst_prog);
>  		if (attach_btf)
>  			btf_put(attach_btf);
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto put_token;
>  	}
>  
>  	/* plain bpf_prog allocation */
> @@ -2680,7 +2712,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  			bpf_prog_put(dst_prog);
>  		if (attach_btf)
>  			btf_put(attach_btf);
> -		return -ENOMEM;
> +		err = -EINVAL;
> +		goto put_token;
>  	}
>  
>  	prog->expected_attach_type = attr->expected_attach_type;
> @@ -2691,6 +2724,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  	prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
>  	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
>  
> +	/* move token into prog->aux, reuse taken refcnt */
> +	prog->aux->token = token;
> +	token = NULL;
> +
>  	err = security_bpf_prog_alloc(prog->aux);
>  	if (err)
>  		goto free_prog;
> @@ -2792,6 +2829,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  	if (prog->aux->attach_btf)
>  		btf_put(prog->aux->attach_btf);
>  	bpf_prog_free(prog);
> +put_token:
> +	bpf_token_put(token);
>  	return err;
>  }

--
paul-moore.com

