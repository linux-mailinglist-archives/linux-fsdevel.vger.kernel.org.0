Return-Path: <linux-fsdevel+bounces-7595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2E0828435
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 11:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F195B22139
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5C7364DF;
	Tue,  9 Jan 2024 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCL6dvOb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1276567E;
	Tue,  9 Jan 2024 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cce6c719caso30713411fa.2;
        Tue, 09 Jan 2024 02:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704797195; x=1705401995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d2I1N1QBrrZNMBB2Yfvcz0ti5UiQaZvG8ERh1G9fYRg=;
        b=mCL6dvObjqR1D0Y8S+TK3UcKX8aUp3NrFVvMGewzotUUp8CxMJYZ3CL/TU4eLecFdd
         fNllp8ArHXr92quAh0EfSyFkoMeqjm9wxXGOJnlpyFyRXNaJAkKlcUZJTT7HKlK/aYlC
         6X3mR2w8bPWG2eBzH48J0jQmIOU0cmKOE/rvFic0EIiLZFZEPDhScofatgePuQLGeZfA
         zNR3rNo5s4CprAWXEiBuygmKXbQCtHr07zn4r68X4a/J7KoqeqISq7FqWIwSadh9rfSH
         nUYUCr8p5pLrmhoTIkyorIvqh65GlEdRWEep8LZtJbGxv8p3rTysFQfFgx5EWG3shWey
         KXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704797195; x=1705401995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2I1N1QBrrZNMBB2Yfvcz0ti5UiQaZvG8ERh1G9fYRg=;
        b=o7GAX4D/01ehv7Th5peYTDqLsnbOBNl4huP7Nkhb1Lz6NzJZ2Kw6ihpbzNRvQqsx+q
         KNdOqqvptt52uxIdWmp5+jFQRCP+jTRq7vObGc8LmZ3MBNUJ2L5R2jA+AMXjXflOMRD/
         XM3oXwL2NJ+hBDYBBjJi17KZHpYgyEdl6DCvuiXHBP6OgWbDyhIw/r2Uq9YrDcdR5LgV
         BaUazB1ncXhgmODJrV5568rSXsRhzN0Ma8gwTGqruiU0+olEMcEYNjkS92VJIzOp2ZpA
         sK5XC3o9Olsohs0xbhM4j+vCZ1EEmvsi43gewpd+XYIRBR6rrGZeNrdseM94bnzO8Prs
         AYXA==
X-Gm-Message-State: AOJu0YwJ4ulcjSPBha9SP+9KEt6xFoyJDtnFt4woE6TDBdva+NyAiJ/a
	klU1YRCMvw36KbCgkFO6oU7DTYc8Ay/SjPQ3JsJ6zD566E8Ykw==
X-Google-Smtp-Source: AGHT+IHt9Cs0k7SKPTfyOtW2IhkE977ShJiQXwY8yzSNO68SoanL7Xf9sfcyeUGG0j+6fcbBzSH9+inWYn08uyX0w2c=
X-Received: by 2002:a05:651c:104d:b0:2cc:9817:6389 with SMTP id
 x13-20020a05651c104d00b002cc98176389mr2235315ljm.99.1704797194352; Tue, 09
 Jan 2024 02:46:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105-vfs-mount-5e94596bd1d1@brauner> <CAHk-=wjfbjuNxx7jWa144qVb5ykwPCwVWa26tcFMvE-Cr6=vMg@mail.gmail.com>
 <20240109095214.GB12915@willie-the-truck>
In-Reply-To: <20240109095214.GB12915@willie-the-truck>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 9 Jan 2024 11:45:57 +0100
Message-ID: <CA+icZUUWuvcgzsd8ryER1sS1bvU8UMXpzcYf60huXb4NJ3weSQ@mail.gmail.com>
Subject: Re: [GIT PULL] vfs mount api updates
To: Will Deacon <will@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 10:52=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hi Linus,
>
> On Mon, Jan 08, 2024 at 05:02:48PM -0800, Linus Torvalds wrote:
> > On Fri, 5 Jan 2024 at 04:47, Christian Brauner <brauner@kernel.org> wro=
te:
> > >
> > > This contains the work to retrieve detailed information about mounts =
via two
> > > new system calls.
> >
> > Gaah. While I have an arm64 laptop now, I don't do arm64 builds in
> > between each pull like I do x86 ones.
> >
> > I *did* just start one, because I got the arm64 pull request.
> >
> > And this fails the arm64 build, because __NR_statmount and
> > __NR_listmount (457 and 458 respectively) exceed the compat system
> > call array size, which is
> >
> > arch/arm64/include/asm/unistd.h:
> >   #define __NR_compat_syscalls            457
> >
> > I don't think this is a merge error, I think the error is there in the
> > original, but I'm about to go off and have dinner, so I'm just sending
> > this out for now.
> >
> > How was this not noted in linux-next? Am I missing something?
>
> Urgh, that is surprising, and I just confirmed that linux-next builds
> fine! The reason seems to be because there are also some new lsm
> syscalls being added there (lsm_get_self_attr and friends) which bump
> __NR_compat_syscalls to 460 and then Stephen Rothwell's mighty merging
> magic adjusted this up to 462 in the merge of the lsm tree.
>
> > Now, admittedly this looks like an easy mistake to make due to that
> > whole odd situation where the compat system calls are listed in
> > unistd32.h, but then the max number is in unistd.h, but I would still
> > have expected this to have raised flags before it hit my tree..
>
> I suppose the two options for now are either to merge the lsm stuff and
> adjust __NR_compat_syscalls as Stephen did, or to take this patch from
> Florian in the meantime:
>
> https://lore.kernel.org/r/20240109010906.429652-1-florian.fainelli@broadc=
om.com
>

Applied upstream:

https://git.kernel.org/linus/f0a78b3e2a0c842cc7b4c2686f4a35681f02ca72

-Sedat-

