Return-Path: <linux-fsdevel+bounces-982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B977D4913
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 09:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D82628188D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 07:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E4614A92;
	Tue, 24 Oct 2023 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgPBBOZc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10FB13FED
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 07:55:36 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8764F9;
	Tue, 24 Oct 2023 00:55:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9bf22fe05so25586045ad.2;
        Tue, 24 Oct 2023 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698134133; x=1698738933; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rryMd0X9WV6QFu55eyAQUdUJEIXyug/kgmEK9WWRvfQ=;
        b=mgPBBOZcnFhTdGj94p7wAnxLw9spkHglgm7IgCipSFkZn1vQakLdbiGxdCg3+1yL5j
         3zX8UXURqNaVavfpIV1FhZO34DxBC2JsD8W4QSuWhp6AowAcA5o6CtkPWEKzHG0tt7PT
         +MjdL9kfOOzP5nOiwPBmyX+Lb5eJuhKGFEz5fo0axneyAmtveP22R2/eEmAD1SbAVcsQ
         DEys1xXGhujhinuo+EYBJMDE/Iid1qeKy6SkBatbNHgfEZBHcMHtmjlRsgwpmVnQ+5Hf
         xXs7nGW+LYEH6yC+LjVf38loJqN01Vspmpwl4Lh6slE4EmqdaT3z+wrHnt9FrFGsMpa+
         4lOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698134133; x=1698738933;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rryMd0X9WV6QFu55eyAQUdUJEIXyug/kgmEK9WWRvfQ=;
        b=w7s1RRXM/9D1f/D2NgXRw1nDKsoRZDB7l8eZfbBHQUCQAjOVDSXKZuD4qMS6aH3177
         5xkg/fxqlteUoLxAq/11GEw+tB/44f2kuJb9fqxdP5QQBR2O/vqveftC06FEKLef3lNl
         UCItewoNytZdbBCnNmXZRtMWzeXcFn/U86obXNQmHsSjQF4x3vOeZMWx8EwRVwqqsH+G
         33zmYykTh2OWXXMq14jdPAahUTh6UyUbjmjoaNDjIIiYHwY2x+mPTvMRo9qGmYN4JS5o
         OoEhN3l4UD/HoKdNuxsUnoo0dG8DvJZQTOBkLNi4Wtcd9z8l2eQn2o/Ew4TaziFwqx45
         e8hQ==
X-Gm-Message-State: AOJu0YwiPe4GjmMJZp9qJGSdi6+Pq7aFi2TNwlnMVIbe8P3UksDcTv7u
	QyBtfLwFcYl6sovCdJsCKx6dqRrhX+I=
X-Google-Smtp-Source: AGHT+IFzIRaOleX12I4ui38DgrzuR5MDHSegKCH+0WDtTjaT5p3P/qRLJ2gPYCdahRV3qCjph6dhEw==
X-Received: by 2002:a17:902:ca0b:b0:1c4:72c9:64ef with SMTP id w11-20020a170902ca0b00b001c472c964efmr7090388pld.40.1698134133184;
        Tue, 24 Oct 2023 00:55:33 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id iy17-20020a170903131100b001ca86a9caccsm7051112plb.228.2023.10.24.00.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 00:55:32 -0700 (PDT)
Message-ID: <429b452c-2211-436a-9af7-21332f68db7d@gmail.com>
Date: Tue, 24 Oct 2023 14:55:27 +0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, vladbu@nvidia.com
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Memleaks in offset_ctx->xa (shmem)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> We have been getting memleaks in offset_ctx->xa in our networking tests:
> 
> unreferenced object 0xffff8881004cd080 (size 576):
>   comm "systemd", pid 1, jiffies 4294893373 (age 1992.864s)
>   hex dump (first 32 bytes):
>     00 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     38 5c 7c 02 81 88 ff ff 98 d0 4c 00 81 88 ff ff  8\|.......L.....
>   backtrace:
>     [<000000000f554608>] xas_alloc+0x306/0x430
>     [<0000000075537d52>] xas_create+0x4b4/0xc80
>     [<00000000a927aab2>] xas_store+0x73/0x1680
>     [<0000000020a61203>] __xa_alloc+0x1d8/0x2d0
>     [<00000000ae300af2>] __xa_alloc_cyclic+0xf1/0x310
>     [<000000001032332c>] simple_offset_add+0xd8/0x170
>     [<0000000073229fad>] shmem_mknod+0xbf/0x180
>     [<00000000242520ce>] vfs_mknod+0x3b0/0x5c0
>     [<000000001ef218dd>] unix_bind+0x2c2/0xdb0
>     [<0000000009b9a8dd>] __sys_bind+0x127/0x1e0
>     [<000000003c949fbb>] __x64_sys_bind+0x6e/0xb0
>     [<00000000b8a767c7>] do_syscall_64+0x3d/0x90
>     [<000000006132ae0d>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Memleak trace points to some syscall performed by systemd and none of our tests do anything more advanced with it than 'systemctl restart ovs-vswitchd'. Basically it is a setup with Fedora and an upstream kernel that executes bunch of network offload tests with Open vSwitch, iproute2 tc, Linux bridge, etc.
> 
> It looks like those may be caused by recent commit 6faddda69f62 ("libfs: Add directory operations for stable offsets") but we don't have a proper reproduction, just sometimes arbitrary getting the memleak complains during/after the regression run.

See Bugzilla for the full thread.

Anyway, I'm adding it to regzbot:

#regzbot introduced: 6faddda69f623d https://bugzilla.kernel.org/show_bug.cgi?id=218039
#regzbot title: stable offsets directory operation support triggers offset_ctx->xa memory leak

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218039

-- 
An old man doll... just what I always wanted! - Clara

