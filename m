Return-Path: <linux-fsdevel+bounces-2037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F18A7E198B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 06:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925EB1C20A7A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 05:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5298CC143;
	Mon,  6 Nov 2023 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="V18Q8KCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4848F75
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 05:01:28 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4F9136
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 21:01:23 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67131800219so28993776d6.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Nov 2023 21:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699246883; x=1699851683; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tbHR8WiThMrSSEzjgwKOgCTUSRHttXJGBLul6Ddj8P4=;
        b=V18Q8KCSE17RnAwjyXAF8rYwGczTuRBrpzekpmxaIXYXjIkkL7k73Fm7350nSU5jzt
         Ev+E44mtyQn7ueuLsFlLwq3sEfdBN4sAdrjsNiLGMP6hUh/3dEIDxlGN+ETi29clPayX
         XhSCpBPO/YaZZvAdOFWVKECn+CghcdS04D0CpdRf7pf5v1mbpanIdYLlxoQKKXJDSIj7
         gxjHouyVCy65aGSU3L2p5fIXproWMfFcEnAS26RN2jTfd8StEKkgE1KyoA0BgQcN/JGJ
         2oYT0/IUwhKNp/PICA1nEfh7eclRRCm2UOKzbOb9KaFWxfBFWNcNolegmvoii7ij/LfL
         UuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699246883; x=1699851683;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbHR8WiThMrSSEzjgwKOgCTUSRHttXJGBLul6Ddj8P4=;
        b=COMX4v6wQrWVKsqF+l56rh+WTu6OVEutx1ViubjebMPhYmO7jSDZk7SEAROxYpa5TV
         OzAazgUmVlRLgZedfxsuykj55lk/DZm+Nu3krE/kfAcbw8yLd7DrX8/TTLLVhomlTv05
         vcUs5H8UCVoXdrVSHlS+al4SnZoeFEwRWHFBBt7ecQcR7tCf+BBtW+vZZTHvYi3ZK319
         q404gYbYRxbPndqk7PZJEzWDRdDMkK6O3VK5do5SEH3moIS6FNhq6RzfbAQ+Qumctixo
         7Vs8k0Z+W43GMUQ3sXK6Pf1QvQs1D8ABEV7APfKoCRDG+QPrdg52EpboXOuIYTqJph12
         2TCg==
X-Gm-Message-State: AOJu0Yz4KdBkt8jj7A+0nZvcdwbpHwb0mR53wTGKAF8WOuztKtqE3wJB
	jx5qP2rfMu4NT6vdc+Y92oZ+1WcefI/yGBJN5Q==
X-Google-Smtp-Source: AGHT+IFRygRx3IAR0nFAfHiY/D0jcEIh4L1xZSvqtFoYwVgeUbie0Fs3i31i+QpHfYSoKf0+zC5jpA==
X-Received: by 2002:a05:6214:5089:b0:66d:3a44:374b with SMTP id kk9-20020a056214508900b0066d3a44374bmr32965454qvb.15.1699246882754;
        Sun, 05 Nov 2023 21:01:22 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id kr23-20020a0562142b9700b0065afedf3aabsm3126026qvb.48.2023.11.05.21.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 21:01:22 -0800 (PST)
Date: Mon, 06 Nov 2023 00:01:21 -0500
Message-ID: <9d2b920cb7e59dfd56f763bdd4e53abd.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>, <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: Re: [PATCH v9 11/17] bpf,lsm: add BPF token LSM hooks
References: <20231103190523.6353-12-andrii@kernel.org>
In-Reply-To: <20231103190523.6353-12-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Nov  3, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> Wire up bpf_token_create and bpf_token_free LSM hooks, which allow to
> allocate LSM security blob (we add `void *security` field to struct
> bpf_token for that), but also control who can instantiate BPF token.
> This follows existing pattern for BPF map and BPF prog.
> 
> Also add security_bpf_token_allow_cmd() and security_bpf_token_capable()
> LSM hooks that allow LSM implementation to control and negate (if
> necessary) BPF token's delegation of a specific bpf_cmd and capability,
> respectively.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h           |  3 ++
>  include/linux/lsm_hook_defs.h |  5 +++
>  include/linux/security.h      | 25 +++++++++++++++
>  kernel/bpf/bpf_lsm.c          |  4 +++
>  kernel/bpf/token.c            | 13 ++++++--
>  security/security.c           | 60 +++++++++++++++++++++++++++++++++++
>  6 files changed, 107 insertions(+), 3 deletions(-)

...

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 08fd777cbe94..1d6edbf45d1c 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -60,6 +60,7 @@ struct fs_parameter;
>  enum fs_value_type;
>  struct watch;
>  struct watch_notification;
> +enum bpf_cmd;

Yes, I think it's fine to include bpf.h in security.h instead of the
forward declaration.

>  /* Default (no) options for the capable function */
>  #define CAP_OPT_NONE 0x0
> @@ -2031,6 +2032,11 @@ extern void security_bpf_map_free(struct bpf_map *map);
>  extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
>  				  struct bpf_token *token);
>  extern void security_bpf_prog_free(struct bpf_prog *prog);
> +extern int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
> +				     struct path *path);
> +extern void security_bpf_token_free(struct bpf_token *token);
> +extern int security_bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
> +extern int security_bpf_token_capable(const struct bpf_token *token, int cap);
>  #else
>  static inline int security_bpf(int cmd, union bpf_attr *attr,
>  					     unsigned int size)
> @@ -2065,6 +2071,25 @@ static inline int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *
>  
>  static inline void security_bpf_prog_free(struct bpf_prog *prog)
>  { }
> +
> +static inline int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
> +				     struct path *path)
> +{
> +	return 0;
> +}
> +
> +static inline void security_bpf_token_free(struct bpf_token *token)
> +{ }
> +
> +static inline int security_bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
> +{
> +	return 0;
> +}
> +
> +static inline int security_bpf_token_capable(const struct bpf_token *token, int cap)
> +{
> +	return 0;
> +}

Another nitpick, but I would prefer to shorten
security_bpf_token_allow_cmd() renamed to security_bpf_token_cmd() both
to shorten the name and to better fit convention.  I realize the caller
is named bpf_token_allow_cmd() but I'd still rather see the LSM hook
with the shorter name.

> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> index 35e6f55c2a41..5d04da54faea 100644
> --- a/kernel/bpf/token.c
> +++ b/kernel/bpf/token.c
> @@ -7,11 +7,12 @@
>  #include <linux/idr.h>
>  #include <linux/namei.h>
>  #include <linux/user_namespace.h>
> +#include <linux/security.h>
>  
>  bool bpf_token_capable(const struct bpf_token *token, int cap)
>  {
>  	/* BPF token allows ns_capable() level of capabilities */
> -	if (token) {
> +	if (token && security_bpf_token_capable(token, cap) == 0) {
>  		if (ns_capable(token->userns, cap))
>  			return true;
>  		if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))

We typically perform the capability based access controls prior to the
LSM controls, meaning if we want to the token controls to work in a
similar way we should do something like this:

  bool bpf_token_capable(...)
  {
    if (token) {
      if (ns_capable(token, cap) ||
          (cap != ADMIN && ns_capable(token, ADMIN)))
        return security_bpf_token_capable(token, cap);
    }
    return capable(cap) || (cap != ADMIN && capable(...))
  }

> @@ -28,6 +29,7 @@ void bpf_token_inc(struct bpf_token *token)
>  
>  static void bpf_token_free(struct bpf_token *token)
>  {
> +	security_bpf_token_free(token);
>  	put_user_ns(token->userns);
>  	kvfree(token);
>  }
> @@ -172,6 +174,10 @@ int bpf_token_create(union bpf_attr *attr)
>  	token->allowed_progs = mnt_opts->delegate_progs;
>  	token->allowed_attachs = mnt_opts->delegate_attachs;
>  
> +	err = security_bpf_token_create(token, attr, &path);
> +	if (err)
> +		goto out_token;
> +
>  	fd = get_unused_fd_flags(O_CLOEXEC);
>  	if (fd < 0) {
>  		err = fd;
> @@ -216,8 +222,9 @@ bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
>  {
>  	if (!token)
>  		return false;
> -
> -	return token->allowed_cmds & (1ULL << cmd);
> +	if (!(token->allowed_cmds & (1ULL << cmd)))
> +		return false;
> +	return security_bpf_token_allow_cmd(token, cmd) == 0;

I'm not sure how much it really matters, but someone might prefer
the '!!' approach/style over '== 0'.

>  }
>  
>  bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type)

--
paul-moore.com

