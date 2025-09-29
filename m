Return-Path: <linux-fsdevel+bounces-63025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82183BA8FD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 13:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC551C1600
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932402FF679;
	Mon, 29 Sep 2025 11:16:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1ED1373
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144590; cv=none; b=PXmA5PKydN4/xvO+4h4EuJpz9W2aEw55wlXV6Qcm9LJW4fxG0r2H0ojk0sMAwW3NLAA5W1Q8xX5NLhskvtLetD058AvAlOGDXY5fjMs5nHcSYsZJ6a/JAaa7BWOS+a4NdSYprwUFHX1I0r4bhAKSGsqKbZxgoWVmK/n2fBeECCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144590; c=relaxed/simple;
	bh=Vub8S/uaeeP/i/sARgDCmpVy3EEPQtjFb9sPbB8ndsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXBU34VTZttcSwsAU96FVzxLi4B4LdLLOZxuli5TwNhFsd8aoJHLR5NwsRj0x+ylgZXOTX5Jh+vJ//BYsd73U+Fc4LHtGCwg5B4bDNCeF2ZbrzCLbDqlC4YN0YTmnoQo98l0hAvkZCvqMIJaTmJGMn8i6Bi8zSNZTFYhnNRLpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-36af61f2946so2640455fac.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 04:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759144587; x=1759749387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLLC+wbxjpk4XmEv75JaQLpBxns7cUiLP7TpNdTyiBs=;
        b=tYHXd3rNstMWiPM2fHBf3VhzOli4RUE+bVcoeOZKSY6hbxiZqwKDmh8G+xwmsqnNsv
         lQYVA1QTwQg1PtOqbgxmEus4tu5Zf766PCFXvbAEbuv9ZUioDmtHqVYCNwQZ2qlInD+6
         YfjRNwplUutZIPDTS/KiBksU06a8+ubMv9aYl5sRtPb4y5hYBO7gJzpwnV/Tp9z3kkkT
         Anb1M/bpJcuX+D61/5sIiW9tYtsjn7e/PUqXJYcfKgwJExgw2GHfTiFA++pM2jBiFFdU
         DpsaptYQWW9O5RH9KPKC+Ww94VH8Usy1MiBKdOU2thp5HbFQmcImMKzYL3+JCZyVI4w/
         xPMA==
X-Forwarded-Encrypted: i=1; AJvYcCVEYnCpf9ZTG/+54/MSI1MTyM+FskwP1LDLQOFUZmsSyr1uPBRp1RNnbZxoOKiMfwVyyErjlPEUPp7/axBS@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCNRhcBLZlUsxTufd9XchI3MxNwUcF8p/s3ubiQBcNUon2gxs
	ab40L407lsj4ocqCH9i3IcFugBG+slEO2MFe8yIY0e4X4JbEzRqDP/de9eWyVw4W
X-Gm-Gg: ASbGncsDukNvSJQv++X46MJtOkBMRVPZHIjVts74XAirbtcX+IenP66dP9JSBJ+g3Jf
	Ek6ltYbdk83yBbMhISMBUR+qezpd1FEsOfgNjLm6ivyHEz7J18lQ2wSNOPb+dYZbadhUknadIAJ
	GTm6W+6iyNKZ8Ptj+t8kkwtSpW1wSpi/AE4h1pe//ML2tBvomM37HueoNP3Lu8JDDLhOURg3ocI
	nyPNi3UVWXx7TGBz3IKkiDNW3yLptb8eU3V8bhoquC9E4Mu1lRMUNKVx7bomqP84Qfs2dnCq78J
	b/S8nHmBpmdk4ASYx0Vr3PYPQlxEguhmvDBtFeIqhjydoRCM5rPkNlWf0Rl3H9L8IUbZIios6NS
	+sg5aQA8i+it64CELA2GmhIPGqqgIFrRj6d8GxRhsColRZ2ETHpPXHbKes0RcVHmZORvIZm8PaF
	W6YqAvkA==
X-Google-Smtp-Source: AGHT+IFU4Npgz+tgkjqEr3h/0ZNArSzG7kXL4tjdDrVxjVfnAl33CAcQJjJ3ft+swkuL4iRBePOkcw==
X-Received: by 2002:a05:6871:29a:b0:333:494c:2720 with SMTP id 586e51a60fabf-37e5e1e32c3mr2924519fac.19.1759144587364;
        Mon, 29 Sep 2025 04:16:27 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-363a3d46f3fsm3587913fac.9.2025.09.29.04.16.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:16:27 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7a9a2b27c44so2527813a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 04:16:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSKE7EboHDpaKLW13tns/0iqX77JPweFOk5vd/orJ1wT/goqt9/Q4ubgjjgtXCJ9e9PZ2mpSnCTkqRxuTO@vger.kernel.org
X-Received: by 2002:a05:6122:e004:10b0:54a:89a2:21ad with SMTP id
 71dfb90a1353d-54fc419339bmr57791e0c.0.1759144227855; Mon, 29 Sep 2025
 04:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916163004.674341701@linutronix.de> <20250916163252.100835216@linutronix.de>
 <20250916184440.GA1245207@ax162> <87ikhi9lhg.ffs@tglx> <87frcm9kvv.ffs@tglx>
 <CAMuHMdVvAQbN8g7TJyK2MCLusGPwDbzrQJHw8uxDhOvjAh7_Pw@mail.gmail.com>
 <20250929100852.GD3245006@noisy.programming.kicks-ass.net>
 <CAMuHMdW_5QOw69Uyrrw=4BPM3DffG2=k5BAE4Xr=gfei7vV=+g@mail.gmail.com> <20250929110400.GL3419281@noisy.programming.kicks-ass.net>
In-Reply-To: <20250929110400.GL3419281@noisy.programming.kicks-ass.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:10:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWtE_E75_2peNaNDEcV6+5=hqJdi=FD37a3fazSNNeUSg@mail.gmail.com>
X-Gm-Features: AS18NWD0T2ErSWY-q1jXuUccpNHEsRySEci4kvFa-MWsnKplWNByVUEA9VYZXc0
Message-ID: <CAMuHMdWtE_E75_2peNaNDEcV6+5=hqJdi=FD37a3fazSNNeUSg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

Hoi Peter,

On Mon, 29 Sept 2025 at 13:04, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Sep 29, 2025 at 12:58:14PM +0200, Geert Uytterhoeven wrote:
> > On Mon, 29 Sept 2025 at 12:09, Peter Zijlstra <peterz@infradead.org> wr=
ote:
> > > On Mon, Sep 29, 2025 at 11:38:17AM +0200, Geert Uytterhoeven wrote:
> > >
> > > > > +       # Detect buggy clang, fixed in clang-17
> > > > > +       depends on $(success,echo 'void b(void **);void* c();int =
f(void){{asm goto("jmp %l0"::::l0);return 0;l0:return 1;}void *x __attribut=
e__((cleanup(b))) =3D c();{asm goto("jmp %l0"::::l1);return 2;l1:return 1;}=
}' | $(CC) -x c - -c -o /dev/null)
> > > >
> > > > This is supposed to affect only clang builds, right?  I am using
> > > > gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04) to build for
> > > > arm32/arm64/riscv, and thus have:
> > > >
> > > >     CONFIG_CC_IS_GCC=3Dy
> > > >
> > > > Still, this commit causes
> > > >
> > > >     CONFIG_CC_HAS_ASM_GOTO_OUTPUT=3Dy
> > > >     CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=3Dy
> > > >
> > > > to disappear from my configs? Is that expected?
> > >
> > > Not expected -- that means your GCC is somehow failing that test case=
.
> > > Ideally some GCC person will investigate why this is so.
> >
> > Oh, "jmp" is not a valid mnemonic on arm and riscv, and several other
> > architectures...
>
> Ah, d'0h indeed.
>
> void b(void **);void* c();int f(void){{asm goto(""::::l0);return 0;l0:ret=
urn 1;}void *x __attribute__((cleanup(b))) =3D c();{asm goto(""::::l1);retu=
rn 2;l1:return 1;}}
>
> Seems to still finger the issue on x86_64. That should build on !x86
> too, right?

Thanks, builds fine on arm32, arm64, riscv, m68k, powerpc, mips, s390.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

