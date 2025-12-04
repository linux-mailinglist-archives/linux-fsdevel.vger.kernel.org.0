Return-Path: <linux-fsdevel+bounces-70737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F285BCA5981
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 23:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCE1330092A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 22:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB5326934;
	Thu,  4 Dec 2025 22:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CMRJdK+Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1027FD75;
	Thu,  4 Dec 2025 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764886455; cv=none; b=n0Ghik6G9PBOB/OW5d3c5ORxWdZQMz90WRWicOT3+jMJiAVbyiGwZrd931PnZcd82EKc57rsrem0cwSEePLxZy2vA2j4dKcMJGvu67YZzYoP6lXlH6BamhOPI+k52JKnyAbQZiWKNf5JMaC98pLD1nb2KBexZBGSSvwYp0PsVBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764886455; c=relaxed/simple;
	bh=68UC/IyVsq69i1+OhDAGB4vLxZ2LdUjORIUKMRnrbng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlsrdkUCWer1xA+5DRXysn84vMAj63z4IZim/AM5Qfsy7BXjp/Ib44VAKgTrYDyexXT1KvK20EklGG2V1PyC5Xk9tRN42uEXV69h/piWFUdiLPDDeEVp68beJGzRP7euKlzQbAMAIrnfleyvr9NZLMhdW4AsGQ97d460PG0lPNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CMRJdK+Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=n2/i6tqDCIVXBXVD8CTjzLJznCHaAsCezf47hvRHxGY=; b=CMRJdK+ZbcmgHBQ2EDY6oHHSbY
	Vcxx1NBq/NHUPSj3amS4gy/mnNqsVjAVAiP2Xo+/+PRhk5oesoF+8pe1dAxtPtmyHO0kn1L8zIX0Q
	zCZGdTwC0ahwCBkezecb2Q4vJFW1PT1teeDqzoRFRwAd3I9XasOn7nQNnRRBJlQuC4kGO2Ei0bd6O
	0sWlChNbHYSiVtAXkCcN5LMsw9sWnhBNXRaEcsQVGXi3+o1Qb+oPZ+AZHeiTSqI7UQ3oh/T9J96VY
	HxWneyPkoyeYCPWDWNUkV+5IatmZV6+3reL8rjpoIIcV5isbAd8MxmHPCYN6exczwum+SsfqSzavk
	ukhmiAjg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRHaB-00000008iId-3UjH;
	Thu, 04 Dec 2025 22:13:51 +0000
Message-ID: <20273cd5-afbc-4208-aa2a-11ac04256c38@infradead.org>
Date: Thu, 4 Dec 2025 14:13:49 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 21/28] riscv: kernel command line option to opt out of
 user cfi
To: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
 Paul Walmsley <pjw@kernel.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>
References: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
 <20251204-v5_user_cfi_series-v24-21-ada7a3ba14dc@rivosinc.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251204-v5_user_cfi_series-v24-21-ada7a3ba14dc@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/4/25 12:04 PM, Deepak Gupta wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6c42061ca20e..453127ef8746 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6453,6 +6453,14 @@
>  			replacement properties are not found. See the Kconfig
>  			entry for RISCV_ISA_FALLBACK.
>  
> +	riscv_nousercfi=
> +		all	Disable user cfi ABI to userspace even if cpu extension

			                                              extensions

> +			are available.
> +		bcfi	Disable user backward cfi ABI to userspace even if
> +			shadow stack extension is available.
> +		fcfi	Disable user forward cfi ABI to userspace even if landing
> +			pad extension is available.
> +
>  	ro		[KNL] Mount root device read-only on boot
>  
>  	rodata=		[KNL,EARLY]

-- 
~Randy


