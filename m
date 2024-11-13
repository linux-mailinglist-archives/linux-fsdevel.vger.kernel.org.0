Return-Path: <linux-fsdevel+bounces-34597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4E99C6A7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779771F22311
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 08:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FA918A6B6;
	Wed, 13 Nov 2024 08:19:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4317BB1A
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485996; cv=none; b=cwfRV4Lo8naB0D27n3rrYtSf5olF844Z/t/ZoZPnOrPFcApYyAnT3bpJINy4/toz8IkqgYAreYI7PE6V/GZdfAWOxYW6pzN2CWAgbAUuZCVMVJCjS5pL5rkk+ic4rJRGwx2alPCbJ7T+dZnl4n8ariJnKUCx7i6I2a7IvTH7YDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485996; c=relaxed/simple;
	bh=UBXncNuxVU/9y6PiNmHxOfhaDQpevP0eRfiBDYbZzWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3rNdOddh1Qmy9y0Uwmfo7xRbPKDPykZezE12/8uPf7hjv17Oh78ZpFtLcSXEo5YrpEI5ORcjYyxnF6BAX+Ophk1rQp1WnL4Ueyub8jq2EW0NsIn9W693i2tVg6103fUB94So6UMLQWsfItA6VtpxLoJXluXJAPEncFJFTEYKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ea85f7f445so66298097b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 00:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731485992; x=1732090792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A//o7AUbFlR1hR/WSlBOYJvvqpE2fTFXB/MVLNsxfNA=;
        b=RzxcqRzi2+YICUCruEjIE9uJ/AyaQb1FOKdo6/u2pgmBDnfAWxfvlUSRvwWDkpF/EK
         mcOyKFgr6WiXBFweUq4DVRjkAvL33Mn7TQNM3fw0ICUA01RK5r0wWgwOaNV0ut/NQImS
         gE1ncqeWc9cNu6UkFVlEyyKiAZqdvFKZMsU7/N56AoizcrGN+0MDVjmYTiTjaRsCT4xZ
         a9PMAw8KfEo6LK3BH/9U89+FBATzw13ZJsLTWCuGI4TANIiE12fejEKIKcPBJbGKYpo8
         Of4GmlcNEkr8YVqa9QF4IXOAEjh+eO9pk2JyhASG4UUg3eDY9yz7t8wHjDBT3AReQb0d
         odug==
X-Forwarded-Encrypted: i=1; AJvYcCXZSBnDWDHnWhh5CJ6TVpA153LVSFoTYSrBwqEF5A8+r87An249G8t0GAXaHmY5TK7WCxXsZutBBXX1Fcfs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Dx/rjUcgIMi0u/C0QMTT3OVcZb4MsYagDlHDLh5bhoFE0XbP
	kSUtri7TiHnAkOnw3jJaiRlfbl2BQH+BPSeVCe83izTw+Zo0abo9C/X5hnjx
X-Google-Smtp-Source: AGHT+IHzTJIhvh0MhUKGGRIEgvS9V1okV1eaMHT2XVSm2G5A19TMftD4zLphzxy2UWfcrLNam3aZwg==
X-Received: by 2002:a05:690c:6207:b0:6e3:d76c:9354 with SMTP id 00721157ae682-6ecb3482373mr22324827b3.41.1731485991973;
        Wed, 13 Nov 2024 00:19:51 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb8f9aasm30068837b3.124.2024.11.13.00.19.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 00:19:51 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ea85f7f445so66297887b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 00:19:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJHzZQ/pNDDBeY5qtjHx0UN/xAsgZRAzZ4ctlcL8pwVlWBswA/lSe6tscT2p13LX+U5pPA6vNBQ2Weg3id@vger.kernel.org
X-Received: by 2002:a05:690c:3582:b0:6e3:116c:ebf3 with SMTP id
 00721157ae682-6ecb345f3e4mr26763207b3.28.1731485991068; Wed, 13 Nov 2024
 00:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731290567.git.thehajime@gmail.com> <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
 <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com> <m2pln0f6mm.wl-thehajime@gmail.com>
In-Reply-To: <m2pln0f6mm.wl-thehajime@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Nov 2024 09:19:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
Message-ID: <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com, Liam.Howlett@oracle.com, 
	ebiederm@xmission.com, kees@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tazaki-san,

On Tue, Nov 12, 2024 at 11:07=E2=80=AFPM Hajime Tazaki <thehajime@gmail.com=
> wrote:
> On Tue, 12 Nov 2024 21:48:28 +0900,
> > On Mon, Nov 11, 2024 at 7:28=E2=80=AFAM Hajime Tazaki <thehajime@gmail.=
com> wrote:
> > > As UML supports CONFIG_MMU=3Dn case, it has to use an alternate ELF
> > > loader, FDPIC ELF loader.  In this commit, we added necessary
> > > definitions in the arch, as UML has not been used so far.  It also
> > > updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.
> > >
> > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > Cc: Kees Cook <kees@kernel.org>
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> > > Signed-off-by: Ricardo Koller <ricarkol@google.com>
> >
> > Thanks for your patch!
> >
> > > --- a/fs/Kconfig.binfmt
> > > +++ b/fs/Kconfig.binfmt
> > > @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
> > >  config BINFMT_ELF_FDPIC
> > >         bool "Kernel support for FDPIC ELF binaries"
> > >         default y if !BINFMT_ELF
> > > -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MM=
U)
> > > +       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA)=
 && !MMU)
> >
> > s/UML/X86/?
>
> I guess the fdpic loader can be used to X86, but this patchset only
> adds UML to be able to select it.  I intended to add UML into nommu
> family.

While currently x86-nommu is supported for UML only, this is really
x86-specific. I still hope UML will get support for other architectures
one day, at which point a dependency on UML here will become wrong...

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

