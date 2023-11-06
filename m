Return-Path: <linux-fsdevel+bounces-2036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E67827E1989
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 06:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A40B20E0B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 05:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99943BA38;
	Mon,  6 Nov 2023 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SSdavXQW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B948F79
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 05:01:28 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBC9191
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 21:01:24 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7788ebea620so265027385a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Nov 2023 21:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699246883; x=1699851683; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cR4hwl+Lz6w67yTWB4/IzZPUv5zKIhcSMoE3ZPbpkzY=;
        b=SSdavXQW9z/bqfek1ZIsQRLhu2RIAs6Gb4py4EpLR7v4PgycwW8QsBnsvpuSaXGLsg
         eeIrpsl7IisMCPvS+Df9+QRaWPkf3oOu4tkHBNTWvFCaa5a6KkQUvFNUC7mKZCRjSi8u
         LJibvdPPyf5OE4PjLG9Wp8hGZzmYrBPsRfGSO8goetwo7NlHscdmEPXZ5hOtUwQ66aXa
         nFug9DpEByz3HLXSrpMNqzvEEc3r12XYIBRsYQ+SegBjtFt+G17DGJQzc2s2ixvyngwy
         9ikO/EyfmDq3ORinT21yj+tmpLFquqgt1WKhL3f03Ho4E/Ye78OWjBpDEEEP+wFWwMy5
         riDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699246883; x=1699851683;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cR4hwl+Lz6w67yTWB4/IzZPUv5zKIhcSMoE3ZPbpkzY=;
        b=pCbyJE/nWN4vPyHwuPGVHujyMwJddTs2GH2MWexyJhTgqcCN2zwMN9fR6hi2A7xdRd
         510jHd2+pRK7a1MKo8uUULN4m1r5+JtMeOyP6DqO1Gt863tffGNlp9HgbUSHmotsBT7Z
         rYQHytKutEuIJI8eKnEcCpu6D7xXJaC6R0Hd91gv5pETArc5tkBCDc1khibbEUbcl48A
         pHgktz34iTCUd3TU62SJYlooCXBXxzYTNAJR80KhOhdBk4piekiGHjkz7kXF61RjqV/Q
         0fW+rPKiKRUm7rE+HI7vbIQkzTh3/eBFtVK1b+iDRIYqDEJnHhymRyndS5Y+kilFqqw6
         RcOg==
X-Gm-Message-State: AOJu0Yxa/7SQ2H25cF1ltT/qUtLNMvvmAYJkJki9ctdkBbG/3xnZ3+ai
	Rz/JJpfO+4U237PvXFa6nZZd
X-Google-Smtp-Source: AGHT+IGmtdOVKOy7ELOiV//ynvLuRr3HWRp2ErE9AdJ8pksk5yqacUh7nr3XUjLtbR/eY1SQNzzENw==
X-Received: by 2002:a05:620a:3728:b0:778:9a8e:575 with SMTP id de40-20020a05620a372800b007789a8e0575mr34746168qkb.25.1699246883546;
        Sun, 05 Nov 2023 21:01:23 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g9-20020a05620a13c900b007677347e20asm2988963qkl.129.2023.11.05.21.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 21:01:23 -0800 (PST)
Date: Mon, 06 Nov 2023 00:01:22 -0500
Message-ID: <257c16919acd2ec98dac2e6c4f21c906.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>, <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: Re: [PATCH v9 17/17] bpf,selinux: allocate bpf_security_struct per BPF  token
References: <20231103190523.6353-18-andrii@kernel.org>
In-Reply-To: <20231103190523.6353-18-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Nov  3, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> Utilize newly added bpf_token_create/bpf_token_free LSM hooks to
> allocate struct bpf_security_struct for each BPF token object in
> SELinux. This just follows similar pattern for BPF prog and map.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  security/selinux/hooks.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Thanks Andrii, we'll need some additional code to fully enable the
BPF tokens on a SELinux system but I can help provide that if you'd
like.  Although I might not be able to get to that until after the
merge window closes.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 002351ab67b7..1501e95366a1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6828,6 +6828,29 @@ static void selinux_bpf_prog_free(struct bpf_prog *prog)
>  	prog->aux->security = NULL;
>  	kfree(bpfsec);
>  }
> +
> +static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
> +				    struct path *path)
> +{
> +	struct bpf_security_struct *bpfsec;
> +
> +	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> +	if (!bpfsec)
> +		return -ENOMEM;
> +
> +	bpfsec->sid = current_sid();
> +	token->security = bpfsec;
> +
> +	return 0;
> +}
> +
> +static void selinux_bpf_token_free(struct bpf_token *token)
> +{
> +	struct bpf_security_struct *bpfsec = token->security;
> +
> +	token->security = NULL;
> +	kfree(bpfsec);
> +}
>  #endif
>  
>  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
> @@ -7183,6 +7206,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
>  	LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
>  	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
> +	LSM_HOOK_INIT(bpf_token_free, selinux_bpf_token_free),
>  #endif
>  
>  #ifdef CONFIG_PERF_EVENTS
> @@ -7241,6 +7265,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  #ifdef CONFIG_BPF_SYSCALL
>  	LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
>  	LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
> +	LSM_HOOK_INIT(bpf_token_create, selinux_bpf_token_create),
>  #endif
>  #ifdef CONFIG_PERF_EVENTS
>  	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
> -- 
> 2.34.1

--
paul-moore.com

