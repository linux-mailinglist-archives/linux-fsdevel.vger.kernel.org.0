Return-Path: <linux-fsdevel+bounces-75543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEwFOynjd2k9mQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:56:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7386D8DBFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 22:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD745303749E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86542FC006;
	Mon, 26 Jan 2026 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="fSWf0xZe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6482FBE1D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769464588; cv=none; b=EsIuA3OKzeim0z9hbKJ4zdu5YpzmvRbstJDkFXVFZdUmIkq5McMVSTJTVrh6HzgUNYcx8y7+J+GIgUuwVAJg85HZlUyfHxM3W7xhsHUSJJ/q4J7gUu1IvVM94wXWJwii3bkKosoxk9sDudHhNeQYZGHkfWkhwf6502arh/e4SSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769464588; c=relaxed/simple;
	bh=oy/NoBC3Q8FHKt5xViq8h05UdNDzlJgEYLMGFJwNbSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQk8XZCDvlZ+wjinjN6Owyu5ZRbr9bSR0djqRpfHFppwgduAx/BxeyHNca1Ayn60LYSS7ep6fEUlKYfYqE2deoeyjp5FRTQtw5kw5j5P1ZuDF5wtghgvtKhfsoQK4Ib6LC10VYoYhZbU/jtYDlRuFZI/Hrl47yvd3czl+YXXz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=fSWf0xZe; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12336c0a8b6so812842c88.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 13:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1769464584; x=1770069384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lrUOAhghPwzKg1J5j2JXzrncTINsAcnCOvL8lgOY0s=;
        b=fSWf0xZeY1W3iliLX2r/1KiF6Wq9/H/UPaTNEIZAP3NqRnCR+VrUr8tC3QOxOkxVdG
         L4arTBM+nON6EALwEWHZcHLt8XcMGP6YrR/TMvm+vxPbSGYfNWWG0ivJrQw0nzQMlU8v
         tKzOhLprN0PKTCNBJQ8SJTPqfmc4lbi6TKODPnfbRCMyZ0RyPhNi3UJ2EYHGkUVvQ1P7
         943yz8aJY6c610bw3F+SieriHPk91yxu+5MVRSaB6elaFagrK68QGEzHxfsDJH6QIx4Y
         oZG842n3dCyAky2u2j6/A6kJNo3nNK4psbjoiun8Wv6KoIz/mSNqy7IBwRZKteR4yuDM
         6gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769464584; x=1770069384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lrUOAhghPwzKg1J5j2JXzrncTINsAcnCOvL8lgOY0s=;
        b=PH+iDxC2Q0Q8FY4QdIk0nVrq5jB6RxpY6GKDfS3Xmz0SrCVVvC0k9QG0ixVd+8UPLQ
         /f541FYbDKxp15a9aGczczO0L4tfi6C/G1Zrqppvpiym1oROYgBd3i7lVb59zDf7qj9P
         n27tIWF18SQu13viwS+Ygxs8ITISZdTKMR5NP0aXTa8kR/Xn+IJzI/6oCuPsSFEarf2n
         SlyM0hvU7waSbCOkr05r41umd4hgBUvrYPrMu1cVdGpUKvLefs1q//KXskllorZ2HOrw
         fwM82ojEpG50x5+C5gU/B7PeTTpqD8qgtUGhRYi0H6dPIPmp1kvdmpFHGTp/PeMSFcEj
         81qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbElR9i9BuvoT8hFjJON1Gc2Odnw5Vxv9n/yungcXmLDZxGKFMy4bny22LRN0QuaYOW8K+aJyROOv1HO/r@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ldtX+tJu+Wdo9M9ozFUz9rZE81zjJm4F0KIQbf/d7NkVX5VM
	QCN3WPbARG5mWwJVrmJaJTFu5L7vPdtXBrG1KexVzvmcGohElpUankt71ADI9asLHZY=
X-Gm-Gg: AZuq6aLlQ9rL2uUwkDZTsEymQMGQbNywjYCQ29I1vHHOrGoTHBSrbmuPwm/IEae2OQd
	WASuzT64N3FgZKYKiTrM22SQKuHGV7r2W3zrv7HVFTLKX9GTjReACIIUj2KjKcXVVsOnurw+ghB
	L3jJmy4uqjwlgwOwHrRGS3mUWHPpTyaNLmycMGyNvL30noxV/3xUjqFzI4CkVtQjb1+lqAQrTDZ
	eonGlrwykRWQg7Wmh86f9BTGf8lYqP2GW40FAVb6YlhUMISfvK+1DpXg7GFEJF3qwtgIAFtnzE3
	dXgGejihDDDu7OhDzY+6tw4WzSob6jxjRofW0mkreyYgwnJFFasovPvlh4hxOtk7BhYBVdoreI7
	w5XeLBLnyIe7ev/Z2WrPLjTy7mXlpXZ2tmRfzw0efQZH5RbM4Bw1gf1xqkFqL0uaP1jiyn3tt5N
	R9P69X/NsYmudMWKg687F/
X-Received: by 2002:a05:7022:2510:b0:11d:fd26:234e with SMTP id a92af1059eb24-1248ec01e46mr2897894c88.16.1769464584287;
        Mon, 26 Jan 2026 13:56:24 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90cd61sm22036468c88.3.2026.01.26.13.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 13:56:23 -0800 (PST)
Date: Mon, 26 Jan 2026 13:56:21 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Paul Walmsley <pjw@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>,
	Andreas Korb <andreas.korb@aisec.fraunhofer.de>,
	Valentin Haudiquet <valentin.haudiquet@canonical.com>
Subject: Re: [PATCH v26 01/28] mm: VM_SHADOW_STACK definition for riscv
Message-ID: <aXfjBd7eCE3ypUnf@debug.ba.rivosinc.com>
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
 <20251211-v5_user_cfi_series-v26-1-f0f419e81ac0@rivosinc.com>
 <68e1702e-f803-2db2-0e16-53ecef4d9eb6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <68e1702e-f803-2db2-0e16-53ecef4d9eb6@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rivosinc.com,none];
	R_DKIM_ALLOW(-0.20)[rivosinc.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rivosinc.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,redhat.com,alien8.de,linux.intel.com,kernel.org,zytor.com,linux-foundation.org,oracle.com,suse.cz,sifive.com,dabbelt.com,eecs.berkeley.edu,arndb.de,infradead.org,xmission.com,lwn.net,google.com,gmail.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,kvack.org,lists.infradead.org,wdc.com,linaro.org,rivosinc.com,intel.com,aisec.fraunhofer.de,canonical.com];
	TAGGED_FROM(0.00)[bounces-75543-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[debug@rivosinc.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[62];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sifive.com:email,msgid.link:url,rivosinc.com:email,rivosinc.com:dkim,canonical.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fraunhofer.de:email,debug.ba.rivosinc.com:mid]
X-Rspamd-Queue-Id: 7386D8DBFB
X-Rspamd-Action: no action

Hi Paul,

Comment inlne.

On Wed, Jan 14, 2026 at 07:57:19PM -0700, Paul Walmsley wrote:
>On Thu, 11 Dec 2025, Deepak Gupta via B4 Relay wrote:
>
>> From: Deepak Gupta <debug@rivosinc.com>
>>
>> VM_HIGH_ARCH_5 is used for riscv
>>
>> Reviewed-by: Zong Li <zong.li@sifive.com>
>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
>> Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>
>Here's what I'm planning to queue, after updating it after Lorenzo's mm
>changes.  Please let me know if you want to change anything.

Yes looks good to me. Thanks a lot.

>
>
>- Paul
>
>From: Deepak Gupta <debug@rivosinc.com>
>Date: Wed, 19 Nov 2025 09:55:05 -0700
>
>mm: add VM_SHADOW_STACK definition for riscv
>
>VM_HIGH_ARCH_5 is used for riscv.
>
>Reviewed-by: Zong Li <zong.li@sifive.com>
>Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de> # QEMU, custom CVA6
>Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
>Link: https://patch.msgid.link/20251112-v5_user_cfi_series-v23-1-b55691eacf4f@rivosinc.com
>[pjw@kernel.org: clarify subject; update to apply]
>Signed-off-by: Paul Walmsley <pjw@kernel.org>
>---
> include/linux/mm.h | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/mm.h b/include/linux/mm.h
>index 15076261d0c2..de912272c5f9 100644
>--- a/include/linux/mm.h
>+++ b/include/linux/mm.h
>@@ -359,7 +359,7 @@ enum {
> 	DECLARE_VMA_BIT_ALIAS(PKEY_BIT2, HIGH_ARCH_2),
> 	DECLARE_VMA_BIT_ALIAS(PKEY_BIT3, HIGH_ARCH_3),
> 	DECLARE_VMA_BIT_ALIAS(PKEY_BIT4, HIGH_ARCH_4),
>-#if defined(CONFIG_X86_USER_SHADOW_STACK)
>+#if defined(CONFIG_X86_USER_SHADOW_STACK) || defined(CONFIG_RISCV_USER_CFI)
> 	/*
> 	 * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
> 	 * support core mm.
>@@ -460,7 +460,8 @@ enum {
> #define VM_PKEY_BIT4  VM_NONE
> #endif /* CONFIG_ARCH_PKEY_BITS > 4 */
> #endif /* CONFIG_ARCH_HAS_PKEYS */
>-#if defined(CONFIG_X86_USER_SHADOW_STACK) || defined(CONFIG_ARM64_GCS)
>+#if defined(CONFIG_X86_USER_SHADOW_STACK) || defined(CONFIG_ARM64_GCS) || \
>+	defined(CONFIG_RISCV_USER_CFI)
> #define VM_SHADOW_STACK	INIT_VM_FLAG(SHADOW_STACK)
> #else
> #define VM_SHADOW_STACK	VM_NONE
>-- 
>2.51.0
>
>
>
>

