Return-Path: <linux-fsdevel+bounces-347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7EC7C8EDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 23:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D0E1C2112C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 21:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068B0266B4;
	Fri, 13 Oct 2023 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ONoscX7y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8025113
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 21:15:47 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A6BC9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 14:15:39 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7d9d357faso32577197b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 14:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697231739; x=1697836539; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wYzHXGOUHBWgy4f8CLaqiKrpM1b0/h0Z9hKcRAULFAg=;
        b=ONoscX7yPlZH1JpmU+8ZtZplBrXzpsAJfXkImr65WnXsrtqXYsLcO80NXADu8ff7zZ
         h+RS6RPcLGvPQNpMHnjoGAZc6zI1yOToANR3YnfgAZ82adYDgoIq8C1YC1e23IAPLFIB
         gPudwhGML7QLHR6bFJvWAo2++A7327LARO9m8L6JRF40iLheZ4jjasCYVfmjsAvcYVzG
         G8TVq3CJUVMNJcTFZhDLrMqggeuISTWb1HYmf7OIoDr8RnSKeH91m6DdcKuex5F9e256
         4QrWc9fXcN+xAkyDlFcxlmw/yFXfUxv4Um5F5OUaHvPqzyOTrHkQnO4d+amh/6wPWrEj
         ZxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231739; x=1697836539;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYzHXGOUHBWgy4f8CLaqiKrpM1b0/h0Z9hKcRAULFAg=;
        b=AsgHD5FFX7EDWJgAsiPb088hwqiahweiGKPxQGw36VtwPJQhUQz/NL6EsMn8XanUQy
         sp/eKIc/UYv2ZCHooOba3cudfQteg5Nz5IQOtynMGGgHQ+RbmBGhCZap49i6Gn9K9OpS
         N3n0jor01fnYllbn1xSrCunVP2zApUs4z96+iJecHS7rDhuabe/oHzXs91B6qlg2k2AA
         bW4kAiPpR3BCwMN9wOrB9qk6l/sV3qN8a1skzyj4osS5dM7pW/7libtc/JGWYCkQnoc7
         i/F+przZNdP+b+p5K9kZaNFNPIEhaE8Cee05Pg2KtaaluCRpYuVu8h16tAo5yVnprgWj
         26Xg==
X-Gm-Message-State: AOJu0YzgButChv2jf8+RP/U2Hxv5nxm2Wmvf9MKFBfCAI9m/ayJ8yvGs
	yIQ7Jx3Ao82KPli/tNTNOtZH
X-Google-Smtp-Source: AGHT+IHFl8cQ1roo+h5Gs3S6OL6iA0G1c4x7pX1/CR0n3hXIRGlEPeKHSqa27ohzG+vd+gNQKcLJiA==
X-Received: by 2002:a0d:df11:0:b0:5a7:b81a:7f5d with SMTP id i17-20020a0ddf11000000b005a7b81a7f5dmr14483089ywe.18.1697231738729;
        Fri, 13 Oct 2023 14:15:38 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id eu2-20020ad44f42000000b0066cfbe4e0f4sm971106qvb.26.2023.10.13.14.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 14:15:38 -0700 (PDT)
Date: Fri, 13 Oct 2023 17:15:38 -0400
Message-ID: <91ed4874a98b620dfa2bd6fe2966f8a7.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>, <keescook@chromium.org>, <brauner@kernel.org>, <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: Re: [PATCH v7 11/18] bpf,lsm: add bpf_token_create and bpf_token_free  LSM hooks
References: <20231012222810.4120312-12-andrii@kernel.org>
In-Reply-To: <20231012222810.4120312-12-andrii@kernel.org>
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
> Wire up bpf_token_create and bpf_token_free LSM hooks, which allow to
> allocate LSM security blob (we add `void *security` field to struct
> bpf_token for that), but also control who can instantiate BPF token.
> This follows existing pattern for BPF map and BPF prog.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h           |  3 +++
>  include/linux/lsm_hook_defs.h |  3 +++
>  include/linux/security.h      | 11 +++++++++++
>  kernel/bpf/bpf_lsm.c          |  2 ++
>  kernel/bpf/token.c            |  6 ++++++
>  security/security.c           | 28 ++++++++++++++++++++++++++++
>  6 files changed, 53 insertions(+)

...

> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> index d4e0cc8075d3..18fd1e04f92d 100644
> --- a/kernel/bpf/token.c
> +++ b/kernel/bpf/token.c
> @@ -7,6 +7,7 @@
>  #include <linux/idr.h>
>  #include <linux/namei.h>
>  #include <linux/user_namespace.h>
> +#include <linux/security.h>
>  
>  bool bpf_token_capable(const struct bpf_token *token, int cap)
>  {
> @@ -28,6 +29,7 @@ void bpf_token_inc(struct bpf_token *token)
>  
>  static void bpf_token_free(struct bpf_token *token)
>  {
> +	security_bpf_token_free(token);
>  	put_user_ns(token->userns);
>  	kvfree(token);
>  }
> @@ -183,6 +185,10 @@ int bpf_token_create(union bpf_attr *attr)
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

As long as bpf_token_alloc() remains separate from bpf_token_create()
I'm not comfortable not having a security_bpf_token_alloc() hook in
bpf_token_alloc().  If you really don't want a LSM token alloc hook
can you fold bpf_token_alloc() into bpf_token_create()?

--
paul-moore.com

