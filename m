Return-Path: <linux-fsdevel+bounces-34628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4AA9C6CF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6BDB22949
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B31FCC47;
	Wed, 13 Nov 2024 10:27:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5051FC7F9
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 10:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493647; cv=none; b=uZ4uVTLF6sTkFoPd33plrZK9V1cUgdrD3ufd47+/BE1R/EgZI2zsQzfRTnA0RAbOtHXQ9L5kzRl4+Pzny/znRyuky4MYq5Tt52V7RgcFryEtjOa/DYf1dpx8RFT+7NKbQlVHTqOJg7stl+Pf3R/HZuqEKMF2RjP7g95yK2oIXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493647; c=relaxed/simple;
	bh=d03u6h2GHv3zPqZMXhPtIkgL6Q62T6SnjQleAzVC1MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaZsOaiuscxXDOPSR2Ea9nnyY0F4LckmZd8uSiQFrJhOaXxVuRvL0mQUsXP+EEvRzi6qBbV6ZrhPCUeq8IycLYOkPX0AQXvOndSWmTVQdxvkzrfq0lW10m115+v0Y2zb3Q4Ze+DKEKpFnmCE/UbtmLWD8OaRLdD/op+Qyxi1X9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e34339d41bso58970827b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 02:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731493644; x=1732098444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSgVRiYR7fQmsN6xkSW2NUSMa3DrW919md6sDkd/rfg=;
        b=dwwEaBJ9TntweylXNQMBpFWUAa0IxbAbvK3621UPDArv/p48MhMTy1OZMisES5QT77
         NqgxnjMT1uzS7FrvgtKNUQLTNAUGrhGZucEWL6KlQS7AjS8q1jGTU6KKuxmpGd4ykriP
         Zmm4ztriJrgCAinHIpoQ+U+2pC7LdW122cotd40pCAGYjPgYdLMlrlmRYkmmSLsrml3B
         iUr86ObcqbwDyk8BUtERvxF6mmu5MZ1KBaOPj82D3qi9G7e08exuQ1874VGK7OY5+6Aq
         XrBLUmpoyu9o6KN+3ScBTQBLHEx9uxBHuWnDCCQGfE9LsJSVJD4V4Wc+Ib1GaZ8srkIG
         XoOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZQfNByWarxi7twGx4zNKzS3BbUQgI7OIVIPUL2oBbk9/TG5q1oyEZOUN35vKe4uP1M79+9cHOSJYxVx0q@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7g5g/5riJQjT4QELVbavsJUDeQrPxEEUzYVJUQoXsVyf9gUCn
	h3up7CWnWFwsV3q8Lv7MX9qwLnmLCJNnv+CjOPlFg1ENS2ptOS8JsOJFFDwx
X-Google-Smtp-Source: AGHT+IEZnHyQ62a+NUMvOLwiXQl5qfCkMv/dqqAyqedECZvwauXVejMR/MJl9RXdYI4U5UQJZvepEg==
X-Received: by 2002:a05:690c:3702:b0:6ea:c467:a632 with SMTP id 00721157ae682-6eaddf9f93cmr207276417b3.35.1731493643878;
        Wed, 13 Nov 2024 02:27:23 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb9660bsm29732337b3.132.2024.11.13.02.27.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:27:22 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e30eca40c44so6301182276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 02:27:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjdVdeDrjcO/Fk80iAycjI/Zee3UHpkFWtT8TI6rXwzeKJbGrZCotyUWmMYgF85AfzO0OVh4a5yTLN23pD@vger.kernel.org
X-Received: by 2002:a05:690c:3681:b0:6e3:da91:3e16 with SMTP id
 00721157ae682-6eadddb0e10mr208300817b3.22.1731493641988; Wed, 13 Nov 2024
 02:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731290567.git.thehajime@gmail.com> <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
 <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
 <m2pln0f6mm.wl-thehajime@gmail.com> <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
 <8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net> <f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
In-Reply-To: <f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Nov 2024 11:27:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
Message-ID: <CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, ricarkol@google.com, 
	Liam.Howlett@oracle.com, ebiederm@xmission.com, kees@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Wed, Nov 13, 2024 at 9:37=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
> On Wed, 2024-11-13 at 09:36 +0100, Johannes Berg wrote:
> > On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
> > >
> > > > > > -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) =
&& !MMU)
> > > > > > +       depends on ARM || ((M68K || RISCV || SUPERH || UML || X=
TENSA) && !MMU)
> > > > >
> > > > > s/UML/X86/?
> > > >
> > > > I guess the fdpic loader can be used to X86, but this patchset only
> > > > adds UML to be able to select it.  I intended to add UML into nommu
> > > > family.
> > >
> > > While currently x86-nommu is supported for UML only, this is really
> > > x86-specific. I still hope UML will get support for other architectur=
es
> > > one day, at which point a dependency on UML here will become wrong...
> > >
> >
> > X86 isn't set for UML, X64_32 and X64_64 are though.
> >
> > Given that the no-MMU UM support even is 64-bit only, that probably
> > should then really be (UML && X86_64).
> >
> > But it already has !MMU, so can't be selected otherwise, and it seems
> > that non-X86 UML
>
> ... would require far more changes in all kinds of places, so not sure
> I'd be too concerned about it here.

OK, up to you...

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

