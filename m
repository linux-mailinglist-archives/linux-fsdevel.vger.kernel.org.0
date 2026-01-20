Return-Path: <linux-fsdevel+bounces-74714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A5lKvbub2m+UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:09:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 284274BFE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB951A2920A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC1344CAFE;
	Tue, 20 Jan 2026 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXVVO1J5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E471F42188D
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936239; cv=pass; b=iJeKKMYnFtvoq9bYOPPzKmxTiMwQBa9LM6vruYa10J4fy9hgS+fObQCSzdAB+atTY55zLKIeNZ1if0ALR7Fltheo9rwKg4TF/68aoKURCLFnN/3wsv6YtQR+4/bfXgrhsZoiAquja5EsbPJvTQFbLZWr5LBd6QDUE1d1ynhSpxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936239; c=relaxed/simple;
	bh=EX82y+L+Fx6C8tG5ENzqvocl0zLvmjlhkPjry7h9vjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYlY4Ybr8S1YQSfeXWNspibQ2inEfmecyzTtgL3mB0N1Ee32cjnkBsvpR+XHPyY8oOaZCnOKcOPNAYSlIsZM9CxTKjfsmJdixuhLjcQk5HGHo8PPdq+nm1S/2BMikjuRirKVCNfkcE0d4BJx4Tl7OfUPKL/2i7wVoIu86vq3aqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXVVO1J5; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b72a1e2f0so6672811e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 11:10:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768936235; cv=none;
        d=google.com; s=arc-20240605;
        b=BcDXEtamj5KzMRHhSc7In2zxsbz1ykqGcWOTfPa+7bvDYHG1uzefDYakulhMNrAreF
         1P92N31a8ayl4V9IeetPZ9vDCXoZxXHgeIGHJ6XmgajMjFXFUdu426dr7qwTcut32Sj5
         DdeoRMVd+Kvi+MIxQwLwoB+lSm94YgdAb43DqHqYYkQyGJDOt07FeIMom+jOJ6ec2JTz
         IRjldUakmOXgD/DCkAAE11dGzcljPza3UDVedHWEMrbSOS8O5YR+8ugoP86UYmLK066n
         SAeaU+HYsJ59/FX5366lIjgLquSogDHbckKWYDMqLqGKee9Pt2wZOw0ARgbc/qVpSSWS
         n/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WrTuJnKKE8W4GQWlDJXtErrmVMH9CcETXLF2qSAZx8w=;
        fh=dsuexeOuk9w71fDVbTyaDZcditWLB642jqfwVM4VXcI=;
        b=egT6TxlziPTLr/shGEfrWL1BebKIRJ7JMMPi/lTo/k4hWp0586IycGC7ppuqGu83lL
         8Ya6FjLcoJQbzx+hCLSuD+CAOuFqBR9LRbZlV0phsBUiTF0cGgEYtVJirgFxuQ2vETTV
         Ma8n6jQuzKD9Ve9RJcolfiuxDH0AmtQ1p03qg42CPo7bv0aBFE6fL1zRmTFP40hhUkBB
         Vj4rKLRVAHF4fm0pPAoKWfehc9WCjFy8vXpuzs6YmU87st4ZtgPAmPyE7M6HDkWSixxV
         n8mRdrXf+80eO4xJznLtaSH3Tbl6OeV6Ghs+463aPttwxo3DnRUWTb/U4IsQ2gXLxw7S
         G2jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768936235; x=1769541035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrTuJnKKE8W4GQWlDJXtErrmVMH9CcETXLF2qSAZx8w=;
        b=gXVVO1J5xniK0/dLO0uu/J1MxzEQizrtzWm6Gdj0QlPHmrzb9gCacmZODsmra2Dt84
         uplgft5/2IkSR6KhaYHBF0JFpSzQMOiLp7FgSyl1bZB921efegJREuQWwAlU1LrRBn2t
         P+ots+ZoUdwNV6DhqavzOo/N2Q69KxDn7mBCRC85FR+A3qfSGOtv85F8OWNpFo62bSmv
         mW27iUSIYC11qx9F8BgzY6wGh+6P5z2sX8T9RaR8hLkeC0QySF7m2KezPx2SzLmiAKAZ
         b00jKYX3dVPcEiFXyisXDX23XmO50IosRU6lUZdLDIY86+LH0flenNJNT/5xZwZzLOre
         WJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768936235; x=1769541035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WrTuJnKKE8W4GQWlDJXtErrmVMH9CcETXLF2qSAZx8w=;
        b=lZNZoZ0MDExZI3R8E4CmHWNpWLpMWWf6+IOZ1W4UFuNDgmgFG+3BI16f5zPPanqVJs
         DESJhJR1tvYlBmlkULdlrcMlR+BqEUwxtfvApuLZ3qnJKQP5ILTN+vbGGs0+0B+KkO/s
         WGgaugWgXBpyMkFZJK82wl16qb4G4lANExxWPIYJ2YaXxcztsMVoPATmSiQxYB+YU3Ox
         ko09tKTh9Cp7/Dptc75YTjLDQjVX1ORioSxG7cq6xCq0ebyw+oxnXJLMSf9wfStknWlc
         Of5ALmKwwSRE5j2JU51i8wrgRmkbGNH4DGxn+gUt/A/KzWjxKdZijE+YQPhvkALDZyhQ
         K7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXVQ9hbADBbWmc0AmnIjgg7EKYosd5ZjbG8bujjDYRcFGRD+sVt7jLex2FZOjPcFhuW/NHwLCCSQQfjz75x@vger.kernel.org
X-Gm-Message-State: AOJu0YxXZ74RsvOvQMn3R9k6dqSctFK2dd+oT3WoAKPgSg7/uszXzhdu
	U4kgFwz8WXGVtZeboLms1s44y3n/5+Xob8NTPYQg5jwXc/j+Qnc9SBe5wawFB+znDxxJIm1esFY
	LNxDJMVeZgonlm6wtfx8qunfLKKvsYKI=
X-Gm-Gg: AZuq6aLqbw9TTY/lMLibwOce0xnlBbUxkXE6SMhCFbR3EaZqvKNvv8kysgbKTog+DVl
	0ELsMT88fejLs5Ky5VFNxyX906O4DcxPAwtDYSQV/7Lj10wsbBMc6MO4tpF2eWdrKflkIT9gwHr
	K48uPw5yceIiU/zmlbMVwlHrFohnfnApX9tWe493QJFcp5S3T4jlHVi110YW9vmWIWljbe9StU9
	vSVBcjk2t6uV5TUQy6aDwVGdD3FK5YndE0RS5jl2gNdT1TbbNozRaLse8VewP6x16aUuQ==
X-Received: by 2002:ac2:5690:0:b0:59b:b3e8:fd2b with SMTP id
 2adb3069b0e04-59dc8f256a3mr1142720e87.19.1768936234489; Tue, 20 Jan 2026
 11:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116235606.2205801-1-joannelkoong@gmail.com>
 <20260116235606.2205801-2-joannelkoong@gmail.com> <2295ba7e-b830-4177-bccb-250fca11b142@linux.alibaba.com>
In-Reply-To: <2295ba7e-b830-4177-bccb-250fca11b142@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 20 Jan 2026 11:10:20 -0800
X-Gm-Features: AZwV_Qjf1KvYbhrZ0uCWiwQPyGilVSa9JbxJYxVyZq1cXIqtEwjfWPrCkQXFrPM
Message-ID: <CAJnrk1Y1SkEgEjsJx9Ya4N2Nso08ic+J1PUzYySiyj=MR1ofKA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] fuse: use DIV_ROUND_UP() for page count calculations
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74714-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,alibaba.com:email]
X-Rspamd-Queue-Id: 284274BFE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Jan 18, 2026 at 6:12=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> On 1/17/26 7:56 AM, Joanne Koong wrote:
> > Use DIV_ROUND_UP() instead of manually computing round-up division
> > calculations.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev.c  | 6 +++---
> >  fs/fuse/file.c | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 6d59cbc877c6..698289b5539e 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -1814,7 +1814,7 @@ static int fuse_notify_store(struct fuse_conn *fc=
, unsigned int size,
> >
> >               folio_offset =3D ((index - folio->index) << PAGE_SHIFT) +=
 offset;
> >               nr_bytes =3D min_t(unsigned, num, folio_size(folio) - fol=
io_offset);
> > -             nr_pages =3D (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_=
SHIFT;
> > +             nr_pages =3D DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
> >
> >               err =3D fuse_copy_folio(cs, &folio, folio_offset, nr_byte=
s, 0);
> >               if (!folio_test_uptodate(folio) && !err && offset =3D=3D =
0 &&
>
> IMHO, could we drop page offset, instead just update the file offset and
> re-calculate folio index and folio offset for each loop, i.e. something
> like what [1] did?
>
> This could make the code simpler and cleaner.

Hi Jingbo,

I'll break this change out into a separate patch. I agree your
proposed restructuring of the logic makes it simpler to parse.

Thanks,
Joanne

>
> BTW, it seems that if the grabbed folio is newly created on hand and the
> range described by the store notify doesn't cover the folio completely,
> the folio won't be set as Uptodate and thus the written data may be
> missed?  I'm not sure if this is in design.
>
> [1]
> https://lore.kernel.org/linux-fsdevel/20260115023607.77349-1-jefflexu@lin=
ux.alibaba.com/
>
>
> > @@ -1883,7 +1883,7 @@ static int fuse_retrieve(struct fuse_mount *fm, s=
truct inode *inode,
> >       else if (outarg->offset + num > file_size)
> >               num =3D file_size - outarg->offset;
> >
> > -     num_pages =3D (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +     num_pages =3D DIV_ROUND_UP(num + offset, PAGE_SIZE);
> >       num_pages =3D min(num_pages, fc->max_pages);
> >       num =3D min(num, num_pages << PAGE_SHIFT);
> >
> > @@ -1918,7 +1918,7 @@ static int fuse_retrieve(struct fuse_mount *fm, s=
truct inode *inode,
> >
> >               folio_offset =3D ((index - folio->index) << PAGE_SHIFT) +=
 offset;
> >               nr_bytes =3D min(folio_size(folio) - folio_offset, num);
> > -             nr_pages =3D (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_=
SHIFT;
> > +             nr_pages =3D DIV_ROUND_UP(offset + nr_bytes, PAGE_SIZE);
> >
> >               ap->folios[ap->num_folios] =3D folio;
> >               ap->descs[ap->num_folios].offset =3D folio_offset;
>
> Ditto.
>
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index eba70ebf6e77..a4342b269cb9 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -2170,7 +2170,7 @@ static bool fuse_folios_need_send(struct fuse_con=
n *fc, loff_t pos,
> >       WARN_ON(!ap->num_folios);
> >
> >       /* Reached max pages */
> > -     if ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT > fc->max_pages)
> > +     if (DIV_ROUND_UP(bytes, PAGE_SIZE) > fc->max_pages)
> >               return true;
> >
> >       if (bytes > max_bytes)
>
> --
> Thanks,
> Jingbo
>

