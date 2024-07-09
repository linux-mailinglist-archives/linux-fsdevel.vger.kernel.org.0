Return-Path: <linux-fsdevel+bounces-23398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0443692BBA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04991F25612
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EA916133E;
	Tue,  9 Jul 2024 13:46:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009038DD8;
	Tue,  9 Jul 2024 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532769; cv=none; b=gGmewFnDO53eevDhl09x3uIgcIkf/t5HCDq6Yv7yP0/8m7qV1/2OL4CuYyyohHIky+d5Txq1uSmqVYFh+sV/wg2ATLJzwKGE/PRKIREVL3GE9QOWTKvDVlbNsaqpiy+fJ2WsO/sWsQ09xx6JvwXbG1HA0cAbYPH33I1+E9Olv44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532769; c=relaxed/simple;
	bh=9ZAwhP7S1P1iG0E4F25DC+zNoC01hdAIA+xBbmnD+QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcEeFf/0CjjYISq4rP8sYW56RfJMnpUmWYF6t2+Ng3FXu/OXIK6Jo/NTuQ9qnMnAcNYNCZUXahdkgEFydpzp54G9Gsr2+4zkN856pJJQaouPG/U4yvtyQfx0klGu0v9S8N80HxqQvx/cziPmJZiWM+a4D4nQilhZSwvxw5S7vZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-64f2fe21015so49052277b3.3;
        Tue, 09 Jul 2024 06:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720532765; x=1721137565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Gr8V5Z/ZDduxgzrEpspzwkUwhp8x2tSzBoVCNs7Fd8=;
        b=YuPq1lamxV6EauQJz8/x/0gwZbjMDC21+JvlgN0UXGSe1vj62Eccmiy+R8B6En0apb
         Av7n1NjFO0DKGoFZsZA+jE/guxFGolrzaUK1FveuMppjjfiWDaSwt4TrS13JAETdtt+X
         SIdD6ZNiuHfy3CSSboKKoppbEU9KhhoFp488xsFmbCjf+ejMU8QnnaBjV6YVClK+gMPc
         s3KLhGI6ydNu/t1IVrDXIdlVYyolGhvpWEB7t3CqWr35/SAztvPbgq3+qwT6JwjIEwWz
         mWBuigGEaqhusV3QfDsICNpBY/4r8jLoP4ytaGm8NelgU7D4P9DCVWlpyNkDJ9WDzcIE
         Pe0A==
X-Forwarded-Encrypted: i=1; AJvYcCV5XCIL7fwuPLIhQmEWC4XYgj0EDV9LfUqT6X32eYmbEWGGNZVZ4H3QgpAkVlI46EVd1xf7KB2aCRpmWtcvYRQtyNET1wJ1buh7kQd+gmlbQjiUQ9zxh/RZclX+SkI5FjqDdtHL7Z6g6mpo2A==
X-Gm-Message-State: AOJu0Yz54bnoM+UcpvQRQy5khe9W+K10k4AI2+9xAUchu36FPCyDT4pS
	Pl++2F2DCH25IbePJ/ShneXzll5ZXkd2QBUouwLT8mWawLtnOlkD8084UOmU
X-Google-Smtp-Source: AGHT+IE8PC3rfTXNW3+XP2VJL/h6D/4l3p7cbDnZNo/JE2TX6s+ksWoBxDbuaKoKnXgoBpRpLsrmCw==
X-Received: by 2002:a05:690c:4b12:b0:64b:69f0:f8ed with SMTP id 00721157ae682-658f0fb40b9mr30226207b3.51.1720532765053;
        Tue, 09 Jul 2024 06:46:05 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e64eb61bsm3446607b3.76.2024.07.09.06.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 06:46:04 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so5750567276.2;
        Tue, 09 Jul 2024 06:46:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUG65DumPdexDH8HR/REa4KFe3ZqmLRjpjpPlBqi/B5jLai8cmfCeABN9bQvrEcF1PrrW+nGIHu0+bSiR2uQjBAy+gwnFNwn0/9g+tg2Ltbc19b3E6bfb7u1am+oCdKrgXfxoGSeaKBIJjSmw==
X-Received: by 2002:a05:690c:dd3:b0:61b:e645:3e94 with SMTP id
 00721157ae682-658ee79111dmr39513077b3.5.1720532764216; Tue, 09 Jul 2024
 06:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407091931.mztaeJHw-lkp@intel.com> <c1d4fcee3098a58625bb03c8461b92af02d93d15.camel@kernel.org>
In-Reply-To: <c1d4fcee3098a58625bb03c8461b92af02d93d15.camel@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jul 2024 15:45:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVsDSBdz2axqTqrV4XP8UVTsN5pPS4ny9QXMUoxrTOU3w@mail.gmail.com>
Message-ID: <CAMuHMdVsDSBdz2axqTqrV4XP8UVTsN5pPS4ny9QXMUoxrTOU3w@mail.gmail.com>
Subject: Re: [jlayton:mgtime 5/13] inode.c:undefined reference to `__invalid_cmpxchg_size'
To: Jeff Layton <jlayton@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Tue, Jul 9, 2024 at 1:58=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
> I've been getting some of these warning emails from the KTR. I think
> this is in reference to this patch, which adds a 64-bit try_cmpxchg in
> the timestamp handling code:
>
>     https://lore.kernel.org/linux-fsdevel/20240708-mgtime-v4-0-a0f3c6fb57=
f3@kernel.org/
>
> On m68k, there is a prototype for __invalid_cmpxchg_size, but no actual
> function, AFAICT. Should that be defined somewhere, or is this a
> deliberate way to force a build break in this case?

It's a deliberate way to break the build.

> More to the point though: do I need to do anything special for m86k
> here (or for other arches that can't do a native 64-bit cmpxchg)?

64-bit cmpxchg() is only guaranteed to exist on 64-bit platforms.
See also
https://elixir.bootlin.com/linux/latest/source/include/asm-generic/cmpxchg.=
h#L62

I think you can use arch_cmpxchg64(), though.

> ---------- Forwarded message ----------
> From: kernel test robot <lkp@intel.com>

>    m68k-linux-ld: fs/inode.o: in function `inode_set_ctime_current':
> >> inode.c:(.text+0x167a): undefined reference to `__invalid_cmpxchg_size=
'

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

