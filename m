Return-Path: <linux-fsdevel+bounces-79111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI3jGFJkpmnxPAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 05:32:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC891E8DD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 05:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 730183015BAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 04:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3596537CD37;
	Tue,  3 Mar 2026 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="DU9z7B63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187725DB1C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 04:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772512332; cv=pass; b=qQZiBMyDhxNmKwarVXtUuIdDnNhZPJ7Ybu/cu+Blz+wPQIifgFv/Izfg4Ulu7GNMwXtpbkr8wmI3o13xUcs2sgpmy5B7KJ08zi3Y2hBhuROAcGstC2aIuvKXT+qva6ZjhxiicRTCFunVwasOZdhl2UlmkWIfV29Y8D6rOoDG1JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772512332; c=relaxed/simple;
	bh=6w/G9HagsxRSvdT2x9/q/VQ4/NrLZOBn1E2lWDQQiqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOd0Yxg0dypTdG45kCWDBgL9n+Ur7ZB6l0cWNzQIeooUeKTKJUw3kzFIhyMjAFrriC+iEMLspAkV8Js60NyzZSpgkXddYnAjGktWPsA81QPN2aiB41El9HxPTHOTQKW5hYj4U4qCa/UoFiqvaMfeZK7f0W3U2fRc1RtB/UM/aWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=DU9z7B63; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79628fb5c05so40437897b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 20:32:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772512330; cv=none;
        d=google.com; s=arc-20240605;
        b=kvpynT7ULQUK2oBm8ATESEdbt75BURtlA+1BG62wrREArRczVdnlWCUc4TGKAWVvfQ
         rO/kEDhZ7XS7wgLDdZxhxTbir+INGIp643vy9tIq2p5dA8I05ZH5yFOl+w1vHWEUYo9c
         f7cv4PP1PDdsP5bXLBWby3AEQ1uoXuR14XUdJzcWCiYvhocZTM/OTy7eIv4sNytptRPl
         iChslyYDxWuVJFgKvwvmv1xxQ0D9Zc92DCvj0iRqU5wA7ziVkBQKaP7TUie2n1u0ljfK
         3q/8rAgyCB62kx3GpuOYwHDn5AFYyCp8+YemvFJu+Up+JfhUP2Yt2CeK+oqXFcBC+HDM
         +SjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vGFounTaPfTh3BSvvZSUHOsDY6NUzCCD/Stg39Oh89o=;
        fh=k0VyJXdGmjXQhayUGYxoSm5dD851XOYBP4k5SEk/570=;
        b=fCkBGY/dOWR+/u0IgltpTqksJuufPS9Hx2G3NQGKoS0IpcBGl5hOOrC7fA8rzVZyYX
         NUZoIit6pNTgtwHzkESSPh4zazwIo/fodylYRIn+f6mNjnJZ9+AAKQjwDwPRRjoqvBfC
         17/xiCwE0iDLrVFu2NkH+L7O9Exf4qPWR9xqFPY7khIVNryoTfbxsf2p1oyVHX3R+fjq
         WFfDWaBRl6ntZNkZi8XuvANxnmv+6mtPQBlzERBs/lmK5gbbrMtyXUdKVStvVNWZgLwV
         kFElK0cwUJ1d3kWqbkYECw436K+lH0upigejFJDde6ouTMs/BQoGW0iVm+XKONnmFK4+
         /p7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1772512330; x=1773117130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGFounTaPfTh3BSvvZSUHOsDY6NUzCCD/Stg39Oh89o=;
        b=DU9z7B63H/zefNd3BqoBtXceBKfqJn+2xro0uDYc5uRdUsr63z9wUA4l0/RoDJo3fK
         F4OLZn8+oZey918Xw/3u+tYfPV/F1NlqKdOLDtBsux2jETs+UvXQ47ODbsygFwLE6Gxy
         oXm9GG4zZXzPZGASb6vgj+r6+ZKWqHSgGwJmkl+3p7e4aBlcjaQfDt9LmMJ6z+ZYyfNk
         SSbb7xkOySxoLbZ387IrYzAkphxjy/dPpV7Jyq3bID59KQUZ46U49437Y8spUlEfjKeF
         mIGtj+65MMDNjdYTPiVk9eKQ8A3fBp+tynXlRNPFStOJCLcWM9NXhP0gZfV38jgaXXcz
         4H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772512330; x=1773117130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vGFounTaPfTh3BSvvZSUHOsDY6NUzCCD/Stg39Oh89o=;
        b=Z1AFkX9iOYFFQ6NzEVCih4CHxXbhd2Jlng3iiD9t/Q7qzcP4JBUhjSudDcGkmLOEaX
         Cs+Ja695m1JFKN339atdOulaJS3pPaKqL+jLo3+sWUa4/Cn1dhe9INxYt7TqH4oZRQ0w
         LiUu2XWQXwAauZGyBjbczybPTFwT8XqlWWaqZ7+9+3nrBs1zky4GDs1rcgdrlI2v5+6I
         pDgkZTNK1ukMoM/vita3PjPYkuSz3MVmbVR24Ulw42MfTk/koMCqN5FVXnbJvuT0dIwJ
         ZwBRMZPFJB5DgKoMHx/Ajn87wqJFyIILdj5qLLT3mettQ8JkZZ2eaU/D2IS7C7AFa79l
         C/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWtO9kAARJCEyLdxdHVJ/ou6BXh69HAYUcOB3lHSwit3q8AgZSUs61f4XWHwClS/4nNYrX/tDzntwlqh4bI@vger.kernel.org
X-Gm-Message-State: AOJu0YwKzapbJLa6ixU2G5G/nx9RiN6eqGt1wnI8FOenwi8pRImC7inF
	+pRV1nTyxVVIMSlPozwUB9njywJPeZSmpe3k0fdHGY+s2qiJ4ib6WKgPvU/WHmoy7+fRmt6wGFS
	NAb2QobvBHmq8OcFmK6dzn6P+L7Rv1X7ZN06KbfbQYg==
X-Gm-Gg: ATEYQzxX9e7VK6HDKd2TSIWFwDVcUrbUX9eWzGyi/XeJQWQzHkEAakYoI/QgKooT82u
	k0yrIj4vFNAQ2OMiumbiX0ZaapRfd0RgETp4k9vsyNhTAaDb3sQjBOJ8a0600lSvYpylBEM8iIX
	f1V0yzh8mWJxpVvtByz2A/vu+1JpED/kCRPP85JYKskHq/OkCObeYcfXbJHbfNsowYCUh9Co5lD
	C0J3gyzijQWqSkLV7KEFrgoKBjx1nc79GtI3bHLqkYmZitiwECe3QcqT7dF6k0hANlFifsQyBmo
	2wDPZ9kDSPhUWdECKEULqp+0oaxXxeizbbd8ZNrerw==
X-Received: by 2002:a05:690c:6612:b0:796:31ce:6026 with SMTP id
 00721157ae682-798854c24aamr125016587b3.16.1772512330401; Mon, 02 Mar 2026
 20:32:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302155046.286650-1-r@hev.cc> <aaW-x-HVQpSuPRA1@casper.infradead.org>
In-Reply-To: <aaW-x-HVQpSuPRA1@casper.infradead.org>
From: hev <r@hev.cc>
Date: Tue, 3 Mar 2026 12:31:59 +0800
X-Gm-Features: AaiRm53mvWIuAt2Ru8-fwHAqfutzxjaU88asfjV6R2vdeAh35ONU4AEXTH4oT_I
Message-ID: <CAHirt9j-appZ+Mn=8AoG=SW3Lrqi2ajdZDGp8yYWiBWkzBbQ9g@mail.gmail.com>
Subject: Re: [RFC PATCH] binfmt_elf: Align eligible read-only PT_LOAD segments
 to PMD_SIZE for THP
To: Matthew Wilcox <willy@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5AC891E8DD2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hev-cc.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[hev.cc];
	TAGGED_FROM(0.00)[bounces-79111-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hev-cc.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[r@hev.cc,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 12:46=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Mar 02, 2026 at 11:50:46PM +0800, WANG Rui wrote:
> > +config ELF_RO_LOAD_THP_ALIGNMENT
> > +     bool "Align read-only ELF load segments for THP (EXPERIMENTAL)"
> > +     depends on READ_ONLY_THP_FOR_FS
>
> This doesn't deserve a config option.

This optimization is not entirely free. Increasing PT_LOAD alignment
can waste virtual address space, which is especially significant on
32-bit systems, and it also reduces ASLR entropy by limiting the
number of possible load addresses.

In addition, coarser alignment may have secondary microarchitectural
effects (eg. on indirect branch prediction), depending on the
workload. Because this change affects address space layout and
security-related properties, providing users with a way to opt out is
reasonable, rather than making it completely unconditional. This
behavior fits naturally under READ_ONLY_THP_FOR_FS.

>
> > +#if defined(CONFIG_ELF_RO_LOAD_THP_ALIGNMENT) && PMD_SIZE <=3D SZ_32M
>
> Why 32MB?  This is weird and not justified anywhere.

The 32MB limit is intended as a practical upper bound. With 16KB base
pages, which are commonly used on some 64-bit architectures, PMD_SIZE
is 32MB. Larger PMD sizes (eg. 128MB or more with 32KB pages) exist
but represent relatively extreme configurations where alignment costs,
virtual address space padding, and ASLR entropy loss grow
disproportionately relative to the expected THP benefit.

On 32-bit systems, this issue is even more pronounced: PMD_SIZE can
reach 128MB or 256MB depending on configuration, which is clearly
unreasonable as an alignment requirement given the already constrained
virtual address space. The cap therefore avoids these pathological
cases while still covering all realistic and widely deployed PMD huge
page sizes.

Thanks,
Rui

>
> > +                     if (hugepage_global_always() && !(cmds[i].p_flags=
 & PF_W)
> > +                             && IS_ALIGNED(cmds[i].p_vaddr | cmds[i].p=
_offset, PMD_SIZE)
> > +                             && cmds[i].p_filesz >=3D PMD_SIZE && p_al=
ign < PMD_SIZE)
> > +                             p_align =3D PMD_SIZE;
>
> Normal style is to put the '&&' at the end of the line:
>
>                         if (!(cmds[i].p_flags & PF_W) &&
>                             IS_ALIGNED(cmds[i].p_vaddr | cmds[i].p_offset=
, PMD_SIZE) &&
>                             cmds[i].p_filesz >=3D PMD_SIZE && p_align < P=
MD_SIZE))
>                                 p_align =3D PMD_SIZE;
>
> But this conditional is too complex to be at this level of indentation.
> Factor it out into a helper:
>
>                         if (align_to_pmd(cmds) && p_align < PMD_SIZE)
>                                 p_align =3D PMD_SIZE;
>

