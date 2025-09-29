Return-Path: <linux-fsdevel+bounces-63021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A46BA8F08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 12:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C595A1C22C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 10:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518252FDC2D;
	Mon, 29 Sep 2025 10:58:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2702FBDFE
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143509; cv=none; b=OeZXkVHDhQ17Eor+Trw6xVNsqREVhhsdBcqw41sABS1v64fsU/lLoeZQTPw8/Ms7fkS7LnWU2Jhp/wMpEfYzAlNXsxCyhvBEVl56VZirkTtNeNH07n7WSduWogmJsvkzfFys0CZL6uxhnC+WO+rrCrrIaFks0l7iDTeM6DZtSHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143509; c=relaxed/simple;
	bh=AIov++tWGwEKyifuT48l+bxxj97iIWePTzxd3YrxKIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwGx9JtfzuM9Cb1a33Ewb1veEPkdSizsM4F8g7iNmlXI3y416GAywUAL34BniRYRWgHn+GDaJBcrZzfDk4Uu6ZLBh1UBY2agPoTTPzLqVFkgX7pRStP4Tnht+jbIpLbC+wP6EOcf0k1OOsEySGjvfcfJ4oUUlbSPlYqwJ2+9CT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-580a1f1f187so1848896137.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 03:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759143507; x=1759748307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+MPZozySbtur1IZVuljxCO3XEppmGl3RjxuL+jZDRc=;
        b=b0eDT1tzl71ZEN19TIn2OfPxdz6W9+VeO3+7YiZsyqIMFamvfJxCNDDOnp7OZMhyza
         xTMmtXOmL/8VFtyH3aJ2gUgdYh3LySPOq0mnENwT9fzgiac0mq+fCLFhRFBaCUypBuRl
         n0gqF9Rxm7SVK3nZ5EoJM48jv5MANZVGqvjWlU34sVKFhAmghVxy/WpF6EkJremcNtrG
         kvwax2Ra/VPW6m6bV4hkWFLqg2OiTGiMUifOTjHr8dADKs4sUGL00lh7cHbuI5zah3/j
         ZdXQ/oYRce0wYKF+IQGewE6dEo0c8LFzopxqV6wg0VyD6g2ZDm4DhlBA6x018cYODoQ1
         LuTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+Ed7uUum3Bfym3Jri1XYVlH2X3rNQcHXE7DlaZu1vYqtd1MptvRny2aGNjvY1rno8kpIAGTQgdKJuvriK@vger.kernel.org
X-Gm-Message-State: AOJu0YzZieao1CG9+x90t/JXGF0m6ZYAfadCndPi8L4uebdi0E/2hMyt
	V/mkqSgKo4/sc0G48nR2PG1JH50ML5tMYqoD3olBDyKEPbYKNCKWhG1ncD9trmD5
X-Gm-Gg: ASbGnctT8qvZhpFX024pq+lMEg2Pv2wydUTHsUEwrgCelOw/QQG2JRjtScqg6Bq79+F
	0w8OB1iG/I/Ego63N8F5tZmnaxE/9MeBpISD/OYJEgpBXkWYr5lmLGR/xLaiaZ1HusU82PM80He
	wshNkOklbQ4uUyrmeoHf/FFizx34lfJ9M6U/IchF2BZrd9oncBAvBjQSKwm2vIIDSMFyx3E1ggG
	Ws4hYTI5L8VUuDyG5weam2Q/HvELT7rDOM57ysKbMY4qPAcSCnlNJsBKlSuCXJ5yn/jk0VQsoFg
	D9J3uwz2JiB6xm8Blri4Wy0GsgYWoevtyvCDtVTw9NDtQr61n5m8cfairoB5UD47T19kc4jUGKp
	c+nX4r9c/4U7jBRK/t2k4WtEH3bGr3w/I5mB0rbjI/ZoRRU/ncym/gb9xwlX3qcEJA9YR/KA=
X-Google-Smtp-Source: AGHT+IHt67tIgM+Tg4MB3e4DpPMmSgdnqss/aAT2sB3c9ZabzgIb37BedslaUSFqldTt6CILRd6EMQ==
X-Received: by 2002:a05:6102:3ed1:b0:51b:fe23:f4c with SMTP id ada2fe7eead31-5accd5f0ebdmr6510629137.22.1759143506743;
        Mon, 29 Sep 2025 03:58:26 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae389dcefcsm3256069137.10.2025.09.29.03.58.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 03:58:25 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-580a1f1f187so1848852137.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 03:58:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4yxhvJtBz1tOGTKE+ANtRYuzq3eVEtjrjqr/XO3IfzWtdl4VHofGAonlHncfZ94cvzAX8GRwTkxZenBgn@vger.kernel.org
X-Received: by 2002:a05:6102:50aa:b0:534:cfe0:f864 with SMTP id
 ada2fe7eead31-5acc473077dmr6450963137.4.1759143505642; Mon, 29 Sep 2025
 03:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916163004.674341701@linutronix.de> <20250916163252.100835216@linutronix.de>
 <20250916184440.GA1245207@ax162> <87ikhi9lhg.ffs@tglx> <87frcm9kvv.ffs@tglx>
 <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com> <20250929100852.GD3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250929100852.GD3245006@noisy.programming.kicks-ass.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 12:58:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW_5QOw69Uyrrw=4BPM3DffG2=k5BAE4Xr=gfei7vV=+g@mail.gmail.com>
X-Gm-Features: AS18NWDQJuqnAIK-2DUIq8EbZk99RAekWX-gMhtGREaGuJ754MDAMcZKkUQDKxM
Message-ID: <CAMuHMdW_5QOw69Uyrrw=4BPM3DffG2=k5BAE4Xr=gfei7vV=+g@mail.gmail.com>
Subject: Re: [patch V2a 2/6] kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang <
 version 17
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Sept 2025 at 12:09, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Sep 29, 2025 at 11:38:17AM +0200, Geert Uytterhoeven wrote:
>
> > > +       # Detect buggy clang, fixed in clang-17
> > > +       depends on $(success,echo 'void b(void **);void* c();int f(void){{asm goto("jmp %l0"::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto("jmp %l0"::::l1);return 2;l1:return 1;}}' | $(CC) -x c - -c -o /dev/null)
> >
> > This is supposed to affect only clang builds, right?  I am using
> > gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04) to build for
> > arm32/arm64/riscv, and thus have:
> >
> >     CONFIG_CC_IS_GCC=y
> >
> > Still, this commit causes
> >
> >     CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
> >     CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
> >
> > to disappear from my configs? Is that expected?
>
> Not expected -- that means your GCC is somehow failing that test case.
> Ideally some GCC person will investigate why this is so.

Oh, "jmp" is not a valid mnemonic on arm and riscv, and several other
architectures...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

