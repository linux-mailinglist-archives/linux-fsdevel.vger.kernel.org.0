Return-Path: <linux-fsdevel+bounces-66639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 072F6C271BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 23:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80D8B34A5E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 22:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D45532B98C;
	Fri, 31 Oct 2025 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4LMjaStg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986CB1E8826;
	Fri, 31 Oct 2025 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761948636; cv=none; b=UBm09Ui2Ro9LdCXdQkDUQL1kv/GYtJlooqKmPuFCogzTEo0+VHbCkFT3fkjehgryUFjcMf7i+0ipnB/i5MfhClSBsFyn+R8A++lGT//VN481btNvfMrDtd+wjXFxTM0iNwh3HLu0yF4ka+ry0rGIH5B8dAdEz2/d7QSbeAzRbww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761948636; c=relaxed/simple;
	bh=nKBOettWaa9pD6fqUbnve1xXwVoFQ9NnjoRR+YTMrQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrwlnALtqCjF5f2T6PxVcfYdYb37J3AT9A6fS5zytyn/0nVft9/Kbq5SpVZ5jqsSRdE0mncr72AEvAaNp2ZbIXbe0GRLFvzx55bm/Al189YQ7uCFZaXrDM7Cz8TpP6kzMSApfj+LxDYiuHwbCe9ePYj1j52a5Hg/w4m+Eq1isNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4LMjaStg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=RCA5EFSksST1h7GGV5nB7JZEARYhgQmdDRPr1+5iH94=; b=4LMjaStgwdzYsA1UwJNJJ6/6UM
	hijNFvmA8DAWr0ggzHedHqV69LL+MWvx8ioToi7GH7JH2epZqmQATsQuVh6AyuqIVs0g2V1TY2xTA
	0ef36pafwaYg4cWlw/y7og3ET9ZAenKPOTW9k88+zAkGN840SGV/OoexbROT3/y8kMSXrvvx67+67
	Y0HcE9fwUx4PpigC/zFSJyYkpcHJcwcKNWtUtqaEQ46OTJ7n274hbQa/7VNfii/rQRTpMVSbEKBSX
	vqBnk59X8AUujSJTxSfiETwwWcneFferjCEOHnFenDbpHRm3v2MEk8+fZHKKyyw/Lql05DVLWpTze
	EtUDailQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vExJr-00000006qiy-0FlZ;
	Fri, 31 Oct 2025 22:10:03 +0000
Message-ID: <d442965b-8716-4f89-be88-bc62459af712@infradead.org>
Date: Fri, 31 Oct 2025 15:10:01 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 17/28] riscv/signal: save and restore of shadow stack
 for signal
To: Paul Walmsley <pjw@kernel.org>, Deepak Gupta <debug@rivosinc.com>,
 Andy Chiu <andybnac@gmail.com>
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
 kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com,
 evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com,
 samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com,
 rust-for-linux@vger.kernel.org
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com>
 <20251023-v5_user_cfi_series-v22-17-1935270f7636@rivosinc.com>
 <a8f469b8-5750-dfec-2390-09bad4515f99@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <a8f469b8-5750-dfec-2390-09bad4515f99@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 1:07 PM, Paul Walmsley wrote:
> On Thu, 23 Oct 2025, Deepak Gupta via B4 Relay wrote:
> 
>> From: Deepak Gupta <debug@rivosinc.com>
>>
>> Save shadow stack pointer in sigcontext structure while delivering signal.
>> Restore shadow stack pointer from sigcontext on sigreturn.
>>

> 
> This patch causes some 'checkpatch.pl --strict' messages:
> 
> CHECK: Comparison to NULL could be written "!saved_shstk_ptr"
> #271: FILE: arch/riscv/kernel/usercfi.c:186:
> +	if (saved_shstk_ptr == NULL)
> 
> CHECK: Lines should not end with a '('
> #300: FILE: arch/riscv/kernel/usercfi.c:215:
> +		pr_info_ratelimited(
> 
> I've fixed them up here in the event that v22 goes in, but please do the 
> same on your side in case a new version is needed.

Hi Paul,

Is checkpatch.pl --strict the norm for arch/riscv/ ?

If there are enough arch/riscv/-specific patch expectations,
maybe they could be documented in Documentation/process/maintainer-riscv.rst
(a new file).

Thanks.
-- 
~Randy


