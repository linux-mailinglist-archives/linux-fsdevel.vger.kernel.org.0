Return-Path: <linux-fsdevel+bounces-35981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9459DA790
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 13:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F0E285D70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD231FBC99;
	Wed, 27 Nov 2024 12:16:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779521F757F
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709809; cv=none; b=QbE/53c6LtUoI+UV7R74pPx8cUJLrhZzAQQUIr/disZrOeAvrqciVkBv2YldGlE6kefJ+f6aF2kuMQYG/dgSMQUWZmsm+zynGTg2h+70Jw/LS+mDx724Hcv/gPMG9pFNELV7Bar/241N6Yr3QdNC4M7EB4w0AEYTeHIzDoXGLi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709809; c=relaxed/simple;
	bh=FHWrDa+utyHpvpUo4IzZXOss7qL5qmM8SMY3nLu2qLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPBEqN7VpQzAZGMV4RPKcon75yohQW8HxiooDkyZmnBEbEvdHthGU7QwaKQ6BhcoQnJ4RHIAV2gt3d+rkeVzlRSyfOsm0f+1HBTPAH5lSPYEn4WzyT06bGGA21oqIWLHTeQ0SnhygE10Ewdk8SzL0opplAhX7oKyNb72eag06g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so71897181fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 04:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709804; x=1733314604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1izSNhs/MtpbUL+pU2QDmnwxbUA62z5JZKZpfJgnol0=;
        b=u/wT82HM8tOn9CeKIsjjkLGYno9IrnuM1tHh++B14iBF/5l3zpJB2b0yqrdGqss4Y1
         I1XmlApUQr9Q9v3UoxuAKICGdxPsTdcVNivVt0JOo5KYsEO/DdY3zybko2mnuyUGXTv8
         zRHblAmLEVtjtWlsvsqF6bpSdJgSKCuXZhPWI8zB0AacU1s4dbwG0iVCdizVIl+oxote
         iOVzyMquUljsCTTEQIbgp1w+PNBx31pNLS2sF6d2CZbGqfcICRbQW2SZm5hVUKMz6VV1
         IXryWTrCl9aUoodLXeUh36NpKVfGQ2hxEBmBoaP+fgxDZKjVKByHRp+grx1tFJO+h96z
         Ztuw==
X-Forwarded-Encrypted: i=1; AJvYcCXp9pl9GLYBNj3u1KhO58ye9gFeku+i0oQgeQEYWGBKZiB5csmNXt5FHzIKwyOHQo3lapVCwy/b1rvafqf6@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmXKeso5MnyUWtbwutqF/MRqASrZZj17Glp2P4LAGVcb2FJF2
	N7YY8VC2JVXa2DH7kcZp0a09ApwLz4Q9wJDJQbA0xvJl7OAG5kn6s2OnmUcnFL4=
X-Gm-Gg: ASbGncuuJhuqgr1bERSk7TccJeqmqlUBR/gb0V/MTJ83QeeAvk72o2dz296tKe39IM4
	lCxQlGjZMIY+YbeUfrWGDhz2lPAlh+iiBa48i9E8KZshDsF87TuuO5KWj1suR3vF2m+ZnBl6ZMr
	jLbPEYdH6s2vPouPOUVYbYayD6GhonbmjM6/9sXl4O+Lj4CmIdTZH99M0WYUF5I66DoFRLNjyfw
	FTu6Xt1QzQ5UHh9g87PDOTFUP7gHPaTwjPngbRigtrGruU0koi0AnFfMzROUOeBnPaUdqkJd0tq
	c7aPngLUueGZ
X-Google-Smtp-Source: AGHT+IHGJZomGESjtBd65VH9D0I4NSQMDq22mD3VciWeXs074qhzc6V5LaVSBKINADNx3aFuQCK5tg==
X-Received: by 2002:a05:651c:502:b0:2ff:a055:a13c with SMTP id 38308e7fff4ca-2ffd5fcda1emr17615081fa.8.1732709803382;
        Wed, 27 Nov 2024 04:16:43 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52f99csm709754566b.100.2024.11.27.04.16.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 04:16:42 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa545dc7105so575715966b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 04:16:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVx38CHZ49mwWdql6EuxQQyFFnirxjFmPI9do43qsEeI6jdFFxC0LWNeRzJ1+FE8hJVzThnAQrIOnk0FXJ8@vger.kernel.org
X-Received: by 2002:a17:907:c0d:b0:a9a:1437:3175 with SMTP id
 a640c23a62f3a-aa58106648cmr241990766b.51.1732709802220; Wed, 27 Nov 2024
 04:16:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com> <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com> <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com> <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net> <dywzjfeburew25fitcwspay7i4ckynhehpuvtmsi2k6b4ip7wd@xfcbztze47q6>
In-Reply-To: <dywzjfeburew25fitcwspay7i4ckynhehpuvtmsi2k6b4ip7wd@xfcbztze47q6>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Nov 2024 13:16:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUU7+HeeY3Rf+QG-x+4A=tk=y14byZJ6HUfzNBb6Num3A@mail.gmail.com>
Message-ID: <CAMuHMdUU7+HeeY3Rf+QG-x+4A=tk=y14byZJ6HUfzNBb6Num3A@mail.gmail.com>
Subject: Re: UML mount failure with Linux 6.11
To: Karel Zak <kzak@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Hongbo Li <lihongbo22@huawei.com>, 
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>, rrs@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Karel,

On Wed, Nov 27, 2024 at 12:56=E2=80=AFPM Karel Zak <kzak@redhat.com> wrote:
> On Tue, Nov 26, 2024 at 02:50:38PM GMT, Johannes Berg wrote:
> > On Mon, 2024-11-25 at 18:43 +0100, Karel Zak wrote:
> > > The long-term solution would be to clean up hostfs and use named
> > > variables, such as "mount -t hostfs none -o 'path=3D"/home/hostfs"'.
> >
> > That's what Hongbo's commit *did*, afaict, but it is a regression.
> >
> > Now most of the regression is that with fsconfig() call it was no longe=
r
> > possible to specify a bare folder, and then we got discussing what
> > happens if the folder name actually contains a comma...
> >
> > But this is still a regression, so we need to figure out what to do
> > short term?
>
> I will add support for quotes for unnamed options, so that
> "/home/hostfs,dir" will be treated as a single option for libmount.
>
> I am unsure how to resolve this issue without using quotes, as we need
> a method to distinguish between a path with a comma and other options.

Escape the comma using a backslash?

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

