Return-Path: <linux-fsdevel+bounces-44681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BAFA6B523
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 08:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402351888082
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 07:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691B31EE7DC;
	Fri, 21 Mar 2025 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OAPjI+Nt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163471E9B3B
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542554; cv=none; b=VsJJwZu2jxWmDV5M3AD/aL4SCl/K9WoVV0tO+HBhmp3HeSBIsfUvXxkmUmU9awCuMnSiodHsLMYnQOGBrrvm7TAtYrdVfW1tvWP8PUqAKpmO53D7PXxCIYHxW/5ZgU4Z4FwWYwyFe4XD5PTLDPd5801Ha9TWAuYzKnCscHro3Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542554; c=relaxed/simple;
	bh=oVEU4h1wTtlqlUbh+FEIic8QhsG6E3beaWkZ1pscJx8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=INi3BdfniGlHekf4H+pMVM91U5eCF5+Q/1i5YgxZc4O7vyhGMSkls0spy+/q1w+QvzJahY22q43xrQdPGU7Vgn7dgdSt9nJxespQKzdXdbJLcyfPTlQDZaphvBvmd7P8g1RaUuDLRP0x5MwNh/YPtN2v3xJOTPXhUr1zl6TwwD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OAPjI+Nt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39127effa72so192679f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742542551; x=1743147351; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uE0YN48K2zRXVt+YdSQ/RPd3ayIjfmSlm7kfHTz7O6c=;
        b=OAPjI+Nt8Mx7oV7aEVLf94wsdw+DPtnZFtkzH1+AA2u31jCIT1+VBXpuzC/2X46qXd
         x558zm27VkDuYd75yDwCGQuu9lhq5Xj+h41lYnMHrm9krK9AyzXE2UAZUEYZRGp0WxMs
         cJqdtk9U6Nx3CFN4imX/4xn2O2btcPml93+vKVoV4monqJ05p9WMdHx9rToeFw+yb/Dz
         MIy/AwQZkpRzQWF65imYjbbFbhvMKNFMtxfo3QIfFjf2+Wc3aq0hmwkU66NjrQACmYMH
         XFXCaiPgCRmEm/sRm7nFcbQmPR2a7RCeEsqkBAT5wj57EOelvetdxbMq82PQmd40/kob
         1WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542551; x=1743147351;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uE0YN48K2zRXVt+YdSQ/RPd3ayIjfmSlm7kfHTz7O6c=;
        b=A74Ui0hYUnRtn9YzoTMx2ZJbMKbzChI+pyfkVQyCrIeJg7yX3cwJrZU3nwrnyOJgPK
         5qDXQSAvCk+YRS4PncLdSEU2g3hUfmr9NcvSk2pHHfGRupBVMEvmoYVZ3n5uMPVdpUP2
         xNm/bPSelKdbozBC6oz+il+H/JD1n2sH++T5G1znLgNZOwpXysti7lwKX2y2yeng8evO
         UO0VRLfivkKgf3HDnbtmTZFj6GCWs/+iqLD8UMswb6ZDVxuAB0xw4NNZJrXqmPyZD+pu
         PMVF+4dAVJB+YdBOfZcZDxBrhXyhHXyC1ehxnUHDwoR2PR20DqMIh81xC0zZHfocD1ne
         YiTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+vRv+7fJelIAuCFlJxGbXXnK+Fg7XQ+viw0Ste60HHD1g7Ukw8Cxz8n35Z0RBtQwvJdhBMzK7DgP5/9kY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4UuomNjOA8Qnp0PKIQ5QJ/ZQOOv/R588vgRj22Ek1ZXOglro
	b9yvUvfUuKD9483QpCuGwfoKMjLkQZ98JMzJmS7BYkBwt4eA4WQZjUFVN5qlBUg=
X-Gm-Gg: ASbGncueLgvubV5bG+D/ccwAreNkPgwwEeETfZvtz7hE5qlQkeJ+2ZsR0tIOLAwP4sU
	5FT6XxR4Z+QxB/zUtjnlFgNod6rbtJouWhyR/7nOkaTeC/Ck7MGbgZZb/yzhr0U57ZNH7DX1a2v
	GNFMyndfHEMTsHIqMdUW0U0q8Q/e/62mx8U/fjfFGBUywCbbMfmPzevC3rW6nQB/s226yQe989a
	iJ6o5Ka2SwCwfTozY6AS0u1G71Ujhy7ozO4MmRlYY0jJA8B35zsh9c9I8owX5FJAKWWAuyzX6ZZ
	MVNcxm3tRlFvFYaeFkKuz0hMo+y9t9ya6Brw0mSfhz/ctQTSGmG3+J37GLNJGJxfIYymTM5yJA6
	LUYKEGXSlvMaCq/g=
X-Google-Smtp-Source: AGHT+IGZStgpQKD6s5SPSh0Un5MoJV2dCYto8osYkw90aX9XoWoskpnSL/J6+EfI/KAtzzUYKMCKnA==
X-Received: by 2002:a05:6000:188f:b0:391:277e:c400 with SMTP id ffacd0b85a97d-3997f941b74mr851925f8f.13.1742542551154;
        Fri, 21 Mar 2025 00:35:51 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b3f7csm1592933f8f.49.2025.03.21.00.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Mar 2025 08:35:49 +0100
Message-Id: <D8LRS46QQ2FE.ZF1856CR80JM@ventanamicro.com>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Conor Dooley" <conor@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Eric Biederman" <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann
 Horn" <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
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
To: "Deepak Gupta" <debug@rivosinc.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH v12 22/28] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-22-e51202b53138@rivosinc.com>
 <D8LFQYX4EHF8.2AJ01XL34WK0W@ventanamicro.com>
 <CAKC1njTyiaBkmHvAM8VT_MG4Cdch=H9P8r3C-m-=QQEuzyrRNA@mail.gmail.com>
In-Reply-To: <CAKC1njTyiaBkmHvAM8VT_MG4Cdch=H9P8r3C-m-=QQEuzyrRNA@mail.gmail.com>

2025-03-20T15:42:44-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, Mar 20, 2025 at 3:10=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrc=
mar@ventanamicro.com> wrote:
>>
>> 2025-03-14T14:39:41-07:00, Deepak Gupta <debug@rivosinc.com>:
>> > Kernel will have to perform shadow stack operations on user shadow sta=
ck.
>> > Like during signal delivery and sigreturn, shadow stack token must be
>> > created and validated respectively. Thus shadow stack access for kerne=
l
>> > must be enabled.
>>
>> Why can't kernel access the user shadow stack through an aliased WR
>> mapping?
>
> It can, although that opens up a can of worms. If this alternating
> mapping is user mode
> then ensuring that another threat in userspace can't write to this
> address in this window
> of signal handling.

Right, it must not be user mode.

>                     A kernel alternate mapping can be created, but
> that can lead to all
> sorts of requirements of ensuring the page is pinned down. IIRC, It
> has been debated
> on x86 shadow stack merge time as well on how a flaky alias mapping appro=
ach can
> become and weaken the threat model it is supposed to protect against.

True.

> Simply using `ssamoswap` is simple and serves the purpose. Enabling shado=
w stack
> access for the kernel doesn't have any adverse effect on the kernel.

Makes sense.  We just depend on an extra feature, because we should
consider the case when M-mode doesn't allow S-mode shadow stack, but
S-mode can enable U-mode shadow stack:

>> > ---
>> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> > @@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
>> >       la tp, init_task
>> >       la sp, init_thread_union + THREAD_SIZE
>> >       addi sp, sp, -PT_SIZE_ON_STACK
>> > +     li a7, SBI_EXT_FWFT
>> > +     li a6, SBI_EXT_FWFT_SET
>> > +     li a0, SBI_FWFT_SHADOW_STACK
>> > +     li a1, 1 /* enable supervisor to access shadow stack access */
>> > +     li a2, SBI_FWFT_SET_FLAG_LOCK
>> > +     ecall
>>
>> I think the ecall can fail even on machines that have Zicfiss, so it
>> would be good to disable user shadow stack if that happens.

