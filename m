Return-Path: <linux-fsdevel+bounces-44648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C743A6AFCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 22:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D98886FAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE9022A1EF;
	Thu, 20 Mar 2025 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="id1O5h57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB953221732
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742505935; cv=none; b=SLmJgWBUMQKyPSvS2VEqKtx9P7DnKx0DYZlCQowUUYnFpFfOB9q6rKFanR24tQ/7h9shXpxkiUYFAiCGf/4tIkew1pWOoDoWdf18ZCwMaMpACwTHlGAYJdiabzsmPHkXiZ7kJK5BtBXM8iW/3RsgQ+XrsQuMYdkV7wu2ajL/QYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742505935; c=relaxed/simple;
	bh=vI1BPqRdoy10g+WgmlSAf2KikeZLxUqHEVWTLCbIm9w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=ot8wwrjzrT8JQU86f1AkWpScXKBv7471XQ9vF3Whq/Sw7DLAbhIUr8Ckm9NKHnfgfxFLOxtmLDi4rAQP7ReXzfA/9+hEK4b9/of6BPQ70KjLNThFs7zH8w3LlYJNp8DVAmR+XDEqThMhkleoRXjYHN2tCkLrkPUbDVX+pPdVtQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=id1O5h57; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43938828d02so1764375e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742505932; x=1743110732; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BM8p6OTMwPELuLuoM3O1JzZA7D2mDcWqh6aQhebe2w=;
        b=id1O5h57dAQjiDasqV2/7bP8JCx+7wK0qTWvGUFZIikYjPdQhH440cY1WkFWuPLj3E
         Wp7ELiRUOwLbv5xP26jsNv+e+z5qxeEWZEMtqgt6f3YuPZQ7GnRgkJbiDOFgVLYwjdiq
         /IrpNJBwrDRmcHHY327m6kexMF28rtSydbs07mSXy9UtxD0wR5Vf9pRUPX2f3H1F/X17
         BLbBNEnL9EBL4C4F6lnyA2w5DxOzdHlFTzNg/JFLzYwN5q59FOdRGCBMtAwJoJROJ/mb
         bJzdsa09nUyagj+fGusJD4w9365g5eMjbI/lVbEVJ2yfgG+zA5kvI99zIvRdbfFbUWQ5
         k9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742505932; x=1743110732;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/BM8p6OTMwPELuLuoM3O1JzZA7D2mDcWqh6aQhebe2w=;
        b=sfbYbzxQKXc1wsf9PPAkkpHFc+Xrh2YU92vgPQxDNzNbATDpxR5g3eSdwRmb4ibDkC
         Y8UkO6CdqXvdAispM8omg0/No9xjdgcv1OVfiGst3IAsBiNQTQav72kVg7bWEeZfA/tS
         g1W6jKql96Mzvx1xakDUwvHT4k20ICJ00UhmQ8JATExE9spHDFu84uno3Oj4XOalK4ks
         qU+dOk8N5SceXbouJuQ8i9d3x1S94cTQlUKa8NTtMCeV5tcrPTvpyucPGmxsgGC79zcW
         ptTEnQNCzGCgkTvzwxQ/GbYyV0euIZp4LFNEvvVxojjHJ7Qfc5BAmMwgArFkZpJR7c9R
         HQuA==
X-Forwarded-Encrypted: i=1; AJvYcCV72QOKlP5jW5U/cjIKeOc15sgvKeiNkPhFbIZ6Crh2quRi4QXlcjfFG7JQ4zKWoOq/yvZuaYmaBRO1MQ4G@vger.kernel.org
X-Gm-Message-State: AOJu0YyMO8qzMz0RIqSb9hGOF1hQHAOOSHVKVjdJPSCiIcyUjsf2pNDI
	Hopn5HLjLROEm2RprBJXcGX/7/jrmjdkkXcstOQu2pW9oHptK7zdUJ/k8ehXbIQ=
X-Gm-Gg: ASbGncux+aYiM+eMqgx+G1CzuBz6pop3kB8+3+6rd0HEXVbuSZF2rrArlxsBSf3gKsr
	JP77f8l32BSREfcUIcXNIJJ9DsfyKJqtIXQu/lO8kgIMbGe8mMWad9H/x5CE3yLv26wCX8q4OgW
	kPT9jWKEHSs1kX6hf28CKJBxMFpr2NJ7YofKWdjz8nV5DjfSUPtFjja54xyBmbYao/OBIshaEIg
	9wGZ1bkO9Zs0gS4G50l7WWzCcrC35/aAMB7QwfKkmr1eJdvuGgBaDH7suC+YR6IsG2kziC3x5g5
	4EZ3+lCfNpBYWeYKECCFJwcZil6pZzF/qXQtfLvciynNrcbqEj3O5D+IlM0IuEGtmxSgy9i3kCw
	J3R5S
X-Google-Smtp-Source: AGHT+IENUyr/tuJjthynG7pDAFWYzf7OBnXUo8NpuhgchW3KTo0PDxUCxZfCqwEA5Mqzg2/ebVjxow==
X-Received: by 2002:a05:600c:46c3:b0:439:8294:2115 with SMTP id 5b1f17b1804b1-43d50a53d12mr2494095e9.8.1742505931793;
        Thu, 20 Mar 2025 14:25:31 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efe55sm579763f8f.88.2025.03.20.14.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 14:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Mar 2025 22:25:30 +0100
Message-Id: <D8LESTM58PV0.7F6M6XYSL4BU@ventanamicro.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "Zong Li"
 <zong.li@sifive.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov"
 <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Conor Dooley" <conor@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Arnd Bergmann"
 <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>, "Eric Biederman"
 <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann Horn"
 <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH v12 25/28] riscv: create a config for shadow stack and
 landing pad instr support
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-25-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-25-e51202b53138@rivosinc.com>

2025-03-14T14:39:44-07:00, Deepak Gupta <debug@rivosinc.com>:
> This patch creates a config for shadow stack support and landing pad inst=
r
> support. Shadow stack support and landing instr support can be enabled by
> selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wire=
s
> up path to enumerate CPU support and if cpu support exists, kernel will
> support cpu assisted user mode cfi.
>
> If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
> `ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.
>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> @@ -250,6 +250,26 @@ config ARCH_HAS_BROKEN_DWARF5
> +config RISCV_USER_CFI
> +	def_bool y
> +	bool "riscv userspace control flow integrity"
> +	depends on 64BIT && $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zicfiss)
> +	depends on RISCV_ALTERNATIVE
> +	select ARCH_HAS_USER_SHADOW_STACK
> +	select ARCH_USES_HIGH_VMA_FLAGS
> +	select DYNAMIC_SIGFRAME
> +	help
> +	  Provides CPU assisted control flow integrity to userspace tasks.
> +	  Control flow integrity is provided by implementing shadow stack for
> +	  backward edge and indirect branch tracking for forward edge in progra=
m.
> +	  Shadow stack protection is a hardware feature that detects function
> +	  return address corruption. This helps mitigate ROP attacks.
> +	  Indirect branch tracking enforces that all indirect branches must lan=
d
> +	  on a landing pad instruction else CPU will fault. This mitigates agai=
nst
> +	  JOP / COP attacks. Applications must be enabled to use it, and old us=
er-
> +	  space does not get protection "for free".
> +	  default y

A high level question to kick off my review:

Why are landing pads and shadow stacks merged together?

Apart from adding build flexibility, we could also split the patches
into two isolated series, because the features are independent.

