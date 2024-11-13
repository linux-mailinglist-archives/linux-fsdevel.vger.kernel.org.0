Return-Path: <linux-fsdevel+bounces-34645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82859C719A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77902288FDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6CB20013A;
	Wed, 13 Nov 2024 13:55:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4ED1D88C4
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506119; cv=none; b=a08yJyYB/twr15tvT87soRs4rR77OYrFcp9lqJ3SQaAVu5JdwTZ/RHE2PSOXyptPyu9YNH/LDo7OI1/rY768YTC22F0KYM3SUr9unR55+97Ua0CVYsbf6sD1LGJx4zgTRVZB8gpMnOQITqS1h3aXHQolGgJBwqiK+o5mZaG85aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506119; c=relaxed/simple;
	bh=pdHLa2AoMLn4Xb28UFLsnGSijOHfZnCqWpDnXK4g4Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbLAQtATZMv5MCyDcrST7R20r+gpYtqISkf6u73WbaDJmo4gF7Cpee98GHtoRTdFhdcCuw5Qzk0MYTfFakxeXnLVCFhWPBIWpFr3dTZK80NIC4TPqcNwhHINXulmwn49Xfb/JlYo/86V2Eba22t5jMXL4imCtrZifRS+FKaQ/zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e2e444e355fso635029276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 05:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731506115; x=1732110915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFSXxFcMQ2EECeEkU2Stj5CZ/EJogh6o/NiDrc32KvE=;
        b=kayZzcWh2Dx6TaLhCzP/3t3O9Lp8tDu+0ZTnXpXxdSlibbtajm+wNS8DewR485mDtR
         hPALPbkFg4Mo/0QKrupkt01vvbNhXxNV91VvoEeVMWieyQ3Uh+JatbWISGgweic299uL
         hUuPgI9Om/KfNJ22uFZ94Vwn9iF3MDb6EGS4gJL3gm89Abs1NoGTUT3WetmzgcggcmWK
         l919nFuMXOuyXxRLtpEB/8TodYLYkk6/I8h9XhZAz8m+2LM0QHXP/+mj0km0igmYkaHH
         OBBJgtmqP1e7m5gQ8JtI20MVrmm0UETpFb7ibPEME4sNPkXavuXo0E8z9WQAlF5jO8fR
         aAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0z5ogJf78BEqkhtjXxu2gqnacE4WKtrUIGwZMc5oyswh+5E05vOirkwYINTCVOhgdcxa0sXkAp6nnYUzc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7KtsWB/R8/JnIrqgWu+2hmzbtTYQb8KVwxj76Qfy46vFqMBAi
	rRfWFxqhBcGUKtIgQL0R1s9hn+AWJaOXBdVWPgzLzjpgCSOtywt5sjzvTAEX
X-Google-Smtp-Source: AGHT+IERZVsXN70QqLye19jkUt2IueqbmhfuduAu6/RsyjnOthwAos+UuxVqqtWkjFC1++VJCqmhbQ==
X-Received: by 2002:a05:690c:6e0a:b0:6ea:6666:c0c2 with SMTP id 00721157ae682-6eadc0a20cdmr171051037b3.4.1731506115534;
        Wed, 13 Nov 2024 05:55:15 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8f099csm31089957b3.48.2024.11.13.05.55.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 05:55:15 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e29047bec8fso624279276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 05:55:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlOgMKkY3+diqKBxGR+Zj422MyHSz4L8k0QCPotgpx+KLEO8ehTwHYxBfSEQ8bNZIsnVA5sFhsQSyGq3NJ@vger.kernel.org
X-Received: by 2002:a05:690c:74ca:b0:6db:da0e:d166 with SMTP id
 00721157ae682-6eade45bda3mr168692847b3.12.1731506114746; Wed, 13 Nov 2024
 05:55:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731290567.git.thehajime@gmail.com> <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
 <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
 <m2pln0f6mm.wl-thehajime@gmail.com> <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
 <8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
 <f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
 <CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com> <m2o72jff2a.wl-thehajime@gmail.com>
In-Reply-To: <m2o72jff2a.wl-thehajime@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Nov 2024 14:55:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKAz0bxBGrbbHD6haeCbhYh=pCb4stox1fOifCvyCwpw@mail.gmail.com>
Message-ID: <CAMuHMdXKAz0bxBGrbbHD6haeCbhYh=pCb4stox1fOifCvyCwpw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
To: Hajime Tazaki <thehajime@gmail.com>
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org, 
	ricarkol@google.com, Liam.Howlett@oracle.com, ebiederm@xmission.com, 
	kees@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	Greg Ungerer <gerg@linux-m68k.org>, Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tazaki-san,

On Wed, Nov 13, 2024 at 2:17=E2=80=AFPM Hajime Tazaki <thehajime@gmail.com>=
 wrote:
> On Wed, 13 Nov 2024 19:27:08 +0900,
> Geert Uytterhoeven wrote:
> > On Wed, Nov 13, 2024 at 9:37=E2=80=AFAM Johannes Berg <johannes@sipsolu=
tions.net> wrote:
> > > On Wed, 2024-11-13 at 09:36 +0100, Johannes Berg wrote:
> > > > On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
> > > > >
> > > > > > > > -       depends on ARM || ((M68K || RISCV || SUPERH || XTEN=
SA) && !MMU)
> > > > > > > > +       depends on ARM || ((M68K || RISCV || SUPERH || UML =
|| XTENSA) && !MMU)
> > > > > > >
> > > > > > > s/UML/X86/?
> > > > > >
> > > > > > I guess the fdpic loader can be used to X86, but this patchset =
only
> > > > > > adds UML to be able to select it.  I intended to add UML into n=
ommu
> > > > > > family.
> > > > >
> > > > > While currently x86-nommu is supported for UML only, this is real=
ly
> > > > > x86-specific. I still hope UML will get support for other archite=
ctures
> > > > > one day, at which point a dependency on UML here will become wron=
g...
> > > > >
> > > >
> > > > X86 isn't set for UML, X64_32 and X64_64 are though.
> > > >
> > > > Given that the no-MMU UM support even is 64-bit only, that probably
> > > > should then really be (UML && X86_64).
> > > >
> > > > But it already has !MMU, so can't be selected otherwise, and it see=
ms
> > > > that non-X86 UML
> > >
> > > ... would require far more changes in all kinds of places, so not sur=
e
> > > I'd be too concerned about it here.
> >
> > OK, up to you...
>
> Indeed, this particular patch [02/13] intends to support the fdpic
> loader under the condition 1) x86_64 ELF binaries (w/ PIE), 2) on UML,
> 3) and with) !MMU configured.  Given that situation, the strict check
> should be like:
>
>    depends on ARM || ((M68K || RISCV || SUPERH || (UML && X86_64) || XTEN=
SA) && !MMU)
>
> (as Johannes mentioned).
>
> on the other hand, the fdpic loader works (afaik) on MMU environment so,
>
>    depends on ARM || (UML && X86_64) || ((M68K || RISCV || SUPERH || XTEN=
SA) && !MMU)
>
> should also works, but this might be too broad for this patchset (and
> not sure if this makes a new use case).

AFAIK that depends on the architecture's MMU context structure, cfr.
the comment in commit 782f4c5c44e7d99d ("m68knommu: allow elf_fdpic
loader to be selected"), which restricts it to nommu on m68k.  If it
does work on X86_64, you can drop the dependency on UML, and we're
(almost) back to my initial comment ;-)

> anyway, thank you for the comment.
> # I really wanted to have comments from nommu folks.

I've added some in CC...

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

