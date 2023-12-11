Return-Path: <linux-fsdevel+bounces-5582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DE280DD5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 22:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9265E1F21BF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 21:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91BA54FAC;
	Mon, 11 Dec 2023 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWHqm11U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF0191;
	Mon, 11 Dec 2023 13:41:02 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2868605fa4aso3769441a91.0;
        Mon, 11 Dec 2023 13:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702330862; x=1702935662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faImnuYs+fBbDRNsbSrQ/ULHyKA5k4DP1rtcKwNpncg=;
        b=YWHqm11U+/cemQeX/Ns9hu4xZzNYM0ScBsKj29pzjbJDTjy/YTKUAab1hhBEOTMLpj
         Oos1Edm1PcHqFsNk0rnnPu8D3VJIVUWL8ieB6zAHHXxCnN5AKd47lgfGFBOHYu/QOrp8
         tMfd+90jh5dMNTmKjuL8BY77Gnt9xnNDAKnjJmShvFwSJJ1jdeUtbQ6ZTmWiNqOgJ/59
         7GMPp419xdumSSyCEcU/6ThSIuh889TKcMUZVEe3R3Jqu1nEX7+3MtJrzzoa2989vDuD
         iHSz9JBWLg3S+dtB+mpj7IifRojR79WGYX2t3RlZsX16eg9mkDCG7/GtBgkP1QUy5EG3
         JCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330862; x=1702935662;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=faImnuYs+fBbDRNsbSrQ/ULHyKA5k4DP1rtcKwNpncg=;
        b=q9B4inIMjLmue8U3RBCXWvN9t1EyqvODBjC/o/57y5hLBQbPvfTxO1RKDwXBWbMb9S
         +RZLhE0HkfK04U4Azqsu9tNlv5tZ9qUxTLrfn7f0kH4DpbponfYTQzjZDNutWhA2ZCc9
         xJ3bczXmT5n6oP6eTMEbu+Y6ZwVO7mA6g5k9i6PoTje/TsNqZpYQwzszfPZGLR6z4aak
         ULcv1AmvH6rT4QAGhWSorxYKGeaEAURucloRt97TEvspqJMTRrhkguZEfWDBHzMscCZt
         KRhEBrCMDhAlrsK6LuIs4NaasBngRSabOU0reB4qYxafFQf1avz4FRwTEdOOTvKIMkHv
         BSnQ==
X-Gm-Message-State: AOJu0YxLYOI64merQshSAsIwZkFbL8vxtuKWS79jm8fMj9JChEyVaysk
	RhZNGK4n6hj59CUgi5v4HXKueG6QGICCQA==
X-Google-Smtp-Source: AGHT+IF2jthQ3z/gZHjK69f0LYpijfzoZjrdtowUnsSzonfBxfNdNWVJYQlvLyA8x6JpkdYBa+zEyw==
X-Received: by 2002:a17:90a:c214:b0:286:e5c0:eb4e with SMTP id e20-20020a17090ac21400b00286e5c0eb4emr2150276pjt.50.1702330861687;
        Mon, 11 Dec 2023 13:41:01 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm7129626plp.305.2023.12.11.13.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:41:01 -0800 (PST)
Date: Mon, 11 Dec 2023 13:41:00 -0800
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
Message-ID: <657781ec1712_edaa208f5@john.notmuch>
In-Reply-To: <20231207185443.2297160-4-andrii@kernel.org>
References: <20231207185443.2297160-1-andrii@kernel.org>
 <20231207185443.2297160-4-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 3/8] libbpf: further decouple feature checking
 logic from bpf_object
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
> Add feat_supported() helper that accepts feature cache instead of
> bpf_object. This allows low-level code in bpf.c to not know or care
> about higher-level concept of bpf_object, yet it will be able to utilize
> custom feature checking in cases where BPF token might influence the
> outcome.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

...

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a6b8d6f70918..af5e777efcbd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -637,6 +637,7 @@ struct elf_state {
>  };
>  
>  struct usdt_manager;
> +struct kern_feature_cache;
>  
>  struct bpf_object {
>  	char name[BPF_OBJ_NAME_LEN];
> @@ -5063,17 +5064,14 @@ static struct kern_feature_desc {
>  	},
>  };
>  
> -bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
> +bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
>  {
>  	struct kern_feature_desc *feat = &feature_probes[feat_id];
> -	struct kern_feature_cache *cache = &feature_cache;
>  	int ret;
>  
> -	if (obj && obj->gen_loader)
> -		/* To generate loader program assume the latest kernel
> -		 * to avoid doing extra prog_load, map_create syscalls.
> -		 */
> -		return true;
> +	/* assume global feature cache, unless custom one is provided */
> +	if (!cache)
> +		cache = &feature_cache;

Why expose a custom cache at all? Where would that be used? I guess we are
looking at libbpf_internal APIs so maybe not a big deal.

>  
>  	if (READ_ONCE(cache->res[feat_id]) == FEAT_UNKNOWN) {
>  		ret = feat->probe();
> @@ -5090,6 +5088,17 @@ bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
>  	return READ_ONCE(cache->res[feat_id]) == FEAT_SUPPORTED;
>  }

Acked-by: John Fastabend <john.fastabend@gmail.com>

