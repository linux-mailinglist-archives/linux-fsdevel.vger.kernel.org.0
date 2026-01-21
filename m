Return-Path: <linux-fsdevel+bounces-74934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABuBCR1gcWkHGgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:24:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE25C5F71F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9737F4C9798
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FD745BD50;
	Wed, 21 Jan 2026 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1pDHJU+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004F451068
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037231; cv=pass; b=t+EBcPG+h9wKY3AFYJt1+V2pdI61jOcAxV79mwVxetqw6fwBz2nIvw7fL5NtgjD+262RePjM6xSPlvl0on/ayKortb7oMxIXDqjQePCYXm0auyQrnmvgFbp73iqBxYT7p9xjXjfdhWvlzNEgmvKcXFsnVo56k7Oablicmz+n7qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037231; c=relaxed/simple;
	bh=MHfLw38A9Q9AVzBkDIMJjXhzfiK0y+Tu/bPnVfF/NFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1CkoItkwmjwGGnKQhZnUYPZBnhY9+LAzUOyWBpPneQdVEDzflkszG1c2+wNSzwmvnI4jsnvrO75McS5lACA0/eI1SpA3sCj3Nt4EcdILuOSaPS8ca9i8Hp6glIv+fkuCSeHzIg91LxhlzJL+eWbwHSTCdUnkQCC4iV9a5qswQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1pDHJU+; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-894770e34afso6219536d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 15:13:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769037228; cv=none;
        d=google.com; s=arc-20240605;
        b=KzA9pUFNWSc82WZv7euHWOoNVRxx62nzESC9kV5SJcHKqqsiQHvgCcSvYNRD9HkS7M
         kbmJVT47z3GIBumRur9NPaHaWSl1zYAfEZDg85Io5101n2oHchat3mmJUWw4g+HYYF5C
         s0UJMeuDrydNFGy6hC26Xr/jo7446sPQL0HY5gTMYvA7Gs+TE/rR7xVdf0TI4XBps3q9
         7024z1hIB0asxjZuXxLO0yfh74P9wq83msInZPIaOwio2piIg49cgTyqZ4PQE2sF/fa5
         zTIRJaWKK/A2kke3KHWyaeu28jXC6cqtkgxINLRrtwGLTKFIiBHI/w840JcRpdZN0rI0
         I22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u4PissXs67yUt2ma/MJ0DB9UiB+sIqbGkwP/O64nTD4=;
        fh=wlvbyoFmI+aEdGc+QRXVp6YmmI02P/WR5d9JkzHjgGI=;
        b=RaUJh7ttLINkzCMY1Q+82lP8WAcnlOKf0D3CUVIhceMFVGI/46kKGZnXCU2tB43lKB
         iDhYRMsqwPibop7Qzug3HfJ8V0MGNm4ZT7wrs6cvxuiDGRFXgej2/gf33Ec6MR/4FrTu
         fFJuYQNd0nOAgSppBqH0qA9Lhx/8tYNY0oK9dsWTRyaLoMvJGf/kV+lgQd/OVnEMxaS6
         fR4xaU6hEbMNC6ydJF3nSh4d9QuSmPSxxuCDCiAhfpqsVnYLncG1zaxrJwxEEdoJ4gR0
         g6XRbNERS6WU/htkPAuhzyg2/0nCYkThf+iG88WP9KP5kOLu+3mFkBbvs6mgWLcoYtmH
         ugDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769037228; x=1769642028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4PissXs67yUt2ma/MJ0DB9UiB+sIqbGkwP/O64nTD4=;
        b=D1pDHJU+7LHNzJa13j/mO7MBthrDNFMwnlvwxXhudlYbiH5JrMSfkBdGABgzaC2C1b
         lRa3eO3TYO2Bo0k+oInft9Baox/QEvrzmXY/BKLYRIWupY5Y9UuNgUsWuJp/zHChWYy5
         WeqQ0XbRh/o+fDRVHiDN5LEDUOihdplIBHsLOE6dqpZoBTBVEl+reK3DCxT2n7NanfF3
         /b/HaOINKKrOB31+K/jY0kFrePnRVBHO7iGNi93TUVTdebI3peH0OIR0dOj2tRbDZ5qe
         mNJyYi4ScZ11jsnPZA07F0xvNnk7X7qYG3ORxD0ZV4PhP8F8zoNSW3sWcQ3vphuKB4Ke
         Y4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769037228; x=1769642028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u4PissXs67yUt2ma/MJ0DB9UiB+sIqbGkwP/O64nTD4=;
        b=IxEpBHkjTnLSp/JjV7P3jbB3uRhjxrp6lul2FSU3towWMfIgRu7DhHoEVb4I1w2cNf
         BgOXNS5tyj7gphf78v327c3+8S4biQSctQC7KdHrezNIHLBKmC+mB2Wo08+mYYRnRxse
         8IAJDGvJcOCCkcUE57+Ar1YlsQutNOknkCyKpawMZmmakK+QG4IsGy5u6MwAWxa4DVNN
         Ny0niKiujlWZza15brQHX/Nu2Unx6nUZOUoOhkBvkU7uYyUzAfnGefNsGPTnHszKjRW7
         5lZxxfvQSwkFDq/qGU3l8JTnCh/Xg7638faZiQaedqJNY1/smS+hRboj+BVZ3DPh8kGQ
         ueUA==
X-Forwarded-Encrypted: i=1; AJvYcCV02TwogwfDEWNdHjFEm68+BFn3oCGAOBfeidTJNZgr0W9vvXMmriP3RZvkA5fA/Y+NZd2HkrYxPcqxjaH0@vger.kernel.org
X-Gm-Message-State: AOJu0YweLNYIAXQWPUslarmPMLb5KWij2sJOVxgSkI4LM1A7eKUKRj8Q
	olisyZyVJf58WanDCqgFzHFKdSmBr8GNK3ccgeseXtywKSbD1rWiID0wWkP1s2ocRiUJl7OE6+P
	WIPOQZr1p6DXJGE/JZ8eP6ceZutOZXl0=
X-Gm-Gg: AZuq6aJnWzwVER8+1E0l71yUEZ80Fxwy8lHJggd6o7h0KPeGoB03/XYdh+e0o1oEtLb
	u+rvkDVHbbOyWgPuYVbiWljnNG3YlAxBz8wHVPFAmbDqFtB5PZESiiCDJZsy8M9Bu9cJv6AGvF+
	GKepiAcosj+k2dfdi2vbE4rJA/QLdcIuZCjWytuQ68hNirFx/Pnb2Xss50xHIF2Sq/R/s3PBG3v
	y5ReMfWgtshj6t8AVLwHCI9AHVLUfDz846VoIPGUk7PrDaGalUiwKjy+b6cKiNGPql2ZA==
X-Received: by 2002:a05:622a:312:b0:502:6ed5:7b0c with SMTP id
 d75a77b69052e-502d85a5ce2mr93266111cf.71.1769037227916; Wed, 21 Jan 2026
 15:13:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116200427.1016177-1-joannelkoong@gmail.com>
 <20260116200427.1016177-2-joannelkoong@gmail.com> <aXCE7jZ5HdhOktEs@infradead.org>
In-Reply-To: <aXCE7jZ5HdhOktEs@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Jan 2026 15:13:35 -0800
X-Gm-Features: AZwV_QjZMlqgiZVTkkOkzVcKpZ3LHl5WmL8GhBnnbQRan5zFqOFjgo-Ym-Wi70I
Message-ID: <CAJnrk1Zp1gkwP=paJLtHN5S41JNBJar-_W0q7K_1zTULh4TqUw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] iomap: fix readahead folio access after folio_end_read()
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, willy@infradead.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74934-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: DE25C5F71F
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 11:49=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Fri, Jan 16, 2026 at 12:04:27PM -0800, Joanne Koong wrote:
> > If the folio does not have an iomap_folio_state struct attached to it
> > and the folio gets read in by the filesystem's IO helper,
> > folio_end_read() may have already been called on the folio.
>
> Not just can, but it has to, as there is no other way to track when
> folio_end_read would need to be called.
>
> > Fix this by invalidating ctx->cur_folio when a folio without
> > iomap_folio_state metadata attached to it has been handed to the
> > filesystem's IO helper.
>
> Fix what?
>
> for read_folio nothing ever looks at cur_folio, so I guess that is not
> what is being fixed, and it's readahead in some form.  Can you explain
> what went wrong and how it is being fixed here a bit better?

Thanks for taking a look at this. The problem I'm trying to fix is
this readahead scenario:
* folio with no ifs gets read in by the filesystem through the
->read_folio_range() call
* the filesystem reads in the folio and calls
iomap_finish_folio_read() which calls folio_end_read(), which unlocks
the folio
* then the page cache evicts the folio and drops the last refcount on
the folio which frees the folio and the folio gets repurposed by
another filesystem (eg btrfs) which uses folio->private
* the iomap logic accesses ctx->cur_folio still, and in the call to
iomap_read_end(), it'll detect a non-null folio->private and it'll
assume that's the ifs and it'll try to do stuff like
spin_lock_irq(&ifs->state_lock) which will crash the system.

This is not a problem for folios with an ifs because the +1 bias we
add to ifs->read_bytes_pending makes it so that iomap is the one who
invokes folio_end_read() when it's all done with the folio.

>
> >                       *bytes_submitted +=3D plen;
> > +                     /*
> > +                      * If the folio does not have ifs metadata attach=
ed,
> > +                      * then after ->read_folio_range(), the folio mig=
ht have
> > +                      * gotten freed (eg iomap_finish_folio_read() ->
> > +                      * folio_end_read() followed by page cache evicti=
on,
> > +                      * which for readahead folios drops the last refc=
ount).
> > +                      * Invalidate ctx->cur_folio here.
> > +                      *
> > +                      * For folios without ifs metadata attached, the =
read
> > +                      * should be on the entire folio.
> > +                      */
> > +                     if (!ifs) {
> > +                             ctx->cur_folio =3D NULL;
> > +                             if (unlikely(plen !=3D folio_len))
> > +                                     return -EIO;
> > +                     }
>
> I think the sanity check here is an impossible to hit condition and
> should probably be a WARN_ON_ONCE?

I'll be removing this check for the next version.

>
> So to answer the above, I guess the issue that for readahead, the
>
>         if (ctx->cur_folio &&
>             offset_in_folio(ctx->cur_folio, iter->pos) =3D=3D 0) {
>
> in iomap_readahead_iter does a double completion?
>
> I don't really love how this spreads the cur_folio setup logic from
> iomap_readahead_iter to here, but the other options I can think off to
> pass that logic to iomap_readahead_iter (overload return value with a
> positive return, extra output argument) don't feel all that enticing
> either because they'd now have to spread the ifs logic into
> iomap_readahead_iter.  So I guess this version it is for now.

Looking at this some more, I think we'll need to use ctx->cur_folio
for non-readahead reads as well (eg passing ctx->cur_folio to
iomap_read_end() in iomap_read_folio()). As Matthew pointed out to me
in [1], we still can't access folio->private after folio_end_read()
even if we hold an active refcount on the folio.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/aWmn2FympQXOMst-@casper.infradead=
.org/

>
> Maybe in the future I'll look into moving all the cur_folio logic
> from iomap_readahead_iter into iomap_read_folio_iter and see if
> that improves things, but that should not get into the way of the
> bug fix.
>

