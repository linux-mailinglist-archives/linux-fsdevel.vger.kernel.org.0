Return-Path: <linux-fsdevel+bounces-70910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD03CA921C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 20:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 360CB3045F5C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF20322B74;
	Fri,  5 Dec 2025 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a/bdHesi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197D923957D;
	Fri,  5 Dec 2025 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963749; cv=none; b=JixxQdme50sYwIsO05L3XQnYb9/FssZza42QIygruu8uKXn0qUfOTvPSBLX+fT+SOwLybd3xCMcTAewoBgjziF4mTlIaBSEDVVLUDQ3xJ2TJycIudGdMXVe8QbxdgWhrqhledJVl4JNg4UW4cIhTLnVFm5T0+tAVeTKMEQsn6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963749; c=relaxed/simple;
	bh=vUEQfFLArJqRXieg64Trw9f6nQK2lpl/JLVzJLe8ibk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wc7QwFMWk6b5loMNlhuoxyC6LEBFjj+XQ4B3WjpuUG0y979EDGh62K4dXaNRTtBlBpxqoriTnzvBDk46Bw/IIXBX1VHfBE4/31ySTJafRwuoCRnIpNlpivdvzh5bs5t91rV4miNWB/IvZAJGCcoRtO6/9nrUbxivuPspsf8nuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a/bdHesi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Mgm/FMtyke96+ZxY7cquZNmO3PwSewNHSLs9FqvP1Zw=; b=a/bdHesi5AkSwr4bQh57WNPXRe
	W2wtAQOpBBAlcZei2JB8AuobRhAdof+Qt5iT4owdX6N6cKp4zyn9WbDfOpYDzT6a4wbMcbjERRy12
	McbStsV5v73E52GB9/rc7S90e6eUxLj64tT9+irQrOTaQqWZC/e24LUKJPnvZBFZ6HvkTS9kfLgk4
	Pft2YbM1xe5fEaecIe9i1HJXvh21A4BCViEf/hLCVvRBGqzj+HUfRCyR4xP1fBOPLQV+0o6tbuEqE
	xZi5nZP2QCYLNLhZyw+9MD/Hgr3yKlIa1Am5XQ4AxoIaqDMNKJHO+dzWI+21eiR+BiXKZooCBdUzn
	3TV/HJlQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRbgm-00000009yBh-3a3v;
	Fri, 05 Dec 2025 19:42:00 +0000
Message-ID: <14afa916-565e-4c25-8e19-ddb87644ae8b@infradead.org>
Date: Fri, 5 Dec 2025 11:41:58 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 25/28] riscv: create a config for shadow stack and
 landing pad instr support
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
 Zong Li <zong.li@sifive.com>, Andreas Korb
 <andreas.korb@aisec.fraunhofer.de>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>
References: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
 <20251204-v5_user_cfi_series-v24-25-ada7a3ba14dc@rivosinc.com>
 <b5feba48-7e7c-4ab9-a193-072f3980f525@infradead.org>
 <aTMjS-Ok-DrJJjQY@debug.ba.rivosinc.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aTMjS-Ok-DrJJjQY@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/5/25 10:24 AM, Deepak Gupta wrote:
> On Thu, Dec 04, 2025 at 02:17:27PM -0800, Randy Dunlap wrote:
>>
>>
>> On 12/4/25 12:04 PM, Deepak Gupta wrote:
>>> This patch creates a config for shadow stack support and landing pad instr
>>> support. Shadow stack support and landing instr support can be enabled by
>>> selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
>>> up path to enumerate CPU support and if cpu support exists, kernel will
>>> support cpu assisted user mode cfi.
>>>
>>> If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
>>> `ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.
>>>
>>> Reviewed-by: Zong Li <zong.li@sifive.com>
>>> Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
>>> Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
>>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>> ---
>>>  arch/riscv/Kconfig                  | 22 ++++++++++++++++++++++
>>>  arch/riscv/configs/hardening.config |  4 ++++
>>>  2 files changed, 26 insertions(+)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 0c6038dc5dfd..f5574c6f66d8 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -1146,6 +1146,28 @@ config RANDOMIZE_BASE
>>>
>>>            If unsure, say N.
>>>
>>> +config RISCV_USER_CFI
>>> +    def_bool y
>>> +    bool "riscv userspace control flow integrity"
>>> +    depends on 64BIT && \
>>> +        $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss_zicfilp -fcf-protection=full)
>>> +    depends on RISCV_ALTERNATIVE
>>> +    select RISCV_SBI
>>> +    select ARCH_HAS_USER_SHADOW_STACK
>>> +    select ARCH_USES_HIGH_VMA_FLAGS
>>> +    select DYNAMIC_SIGFRAME
>>> +    help
>>> +      Provides CPU assisted control flow integrity to userspace tasks.
>>
>>                CPU-assisted
>>
>>> +      Control flow integrity is provided by implementing shadow stack for
>>> +      backward edge and indirect branch tracking for forward edge in program.
>>> +      Shadow stack protection is a hardware feature that detects function
>>> +      return address corruption. This helps mitigate ROP attacks.
>>> +      Indirect branch tracking enforces that all indirect branches must land
>>> +      on a landing pad instruction else CPU will fault. This mitigates against
>>> +      JOP / COP attacks. Applications must be enabled to use it, and old user-
>>> +      space does not get protection "for free".
>>> +      default y.
>>
>>       Default is y if hardware supports it.
>> ?
> 
> No default Y means support is built in the kernel for cfi.

  (if the compiler supports it?)

> If hardware doesn't support CFI instructions, then kernel will do following
> 
> - prctls to manage shadow stack/landing pad enable/disable will fail.
> - vDSO will not have shadow stack instructions in it.

Thanks for the info.

-- 
~Randy


