Return-Path: <linux-fsdevel+bounces-78672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5/YuEvkEoWmSpgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:44:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFBD1B21BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 03:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 825193049960
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 02:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF012EAB83;
	Fri, 27 Feb 2026 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL3FTDcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908A81DE2C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772160243; cv=pass; b=RQHHsI9hpsjFWno2XFEiE54EFr/otITyhYzmf8HsLH8wqYuRQcvYoyYz4nsbUrOpz9FrAxj5qm3Xdtacckim12iG5dVBMltTXTyM8Qr/+zSqcDHX1AtzoyWk8m55WyJqjgdJCRXF0LMo4r3ssOuxQje9pod2N1XKWP3zSxZbv8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772160243; c=relaxed/simple;
	bh=kqc0Q8nhhn3btGydrYNTBaTS51KXyWTp7vY/Q4qZzeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDWTcS5/RREhgKu/J+l88pOy+pPc+rtgmzMerziaaxIyExGgttkBozOtIc4CJZeNJQAbgetGO8Coz2xxiuLrOKkVjiBvTb7SWX0QK+pavc3KrnTZK6SbztY1mBf7ztA4H8o0jVG3g49Ycvnsl+IZfVqIcapQE6HK2O3yZxEWkq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZL3FTDcN; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899c97c5addso17731026d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 18:44:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772160241; cv=none;
        d=google.com; s=arc-20240605;
        b=DSUAcagoEXHjaY3sWnqfoxhggqQWpJ0TMyPbBGQ155NgLCzzXg8CJ+wNYvXUnGriKO
         POlgCi7114T8tykkcCjE2r2kKSItssPAmT3BxLwNWcvqVgG0KEdYqRvkD/P6UQxr0nWq
         QNAPBUhpM9OxcPcAIcGbTVA2rv/KM+T3JlJzsq5p0B8r0wjoQDhSOHXSCEOLNV9NUhMk
         WLTP2yoabUmjhOnw1GQCDmtfQFLFWvkCmvsz/gl7L1DjBnliCcKKt+QzUH4ivimTNlBC
         JXZ5iznA6UXpitkhXAYqcBZm9wxzTxBK5n9rcxILji7Bl3bKpkqgLBbzx7jToS2BaxC0
         7luA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OepVsImbDy+KSgEARNrV04CP8F8rjel+Y+lfhx3Eafg=;
        fh=tKRPMvKzNDCxN0gjWvR8G4XSwQWUi/j7mO4hiR7BoA0=;
        b=fesRd/h4kiUJr+I/2TsXwHA9jGlPT8Nq0wwpZ0t3KmLNoQZ1f4Kl+O86LAwQX0086r
         s58dkTpsgPP54IM+GCirk8GZwuRJcqUESmY4bNNOY5cnptScmxskvl37Mw3UDXJe7RaR
         KrkJt7ZWP42P6M5SGARJRCdp6ri29dX+Gv9hPYmyOt/OqgL2aWTWC0TeOHc1TVr4JZGG
         217AShx2pO59eayT+E9Na3PAtdeFuZypJimw+Wic7ycykzKvWBc7wof9j3nTt2r/Z0XM
         lnphyjdbv1jo7kyZLe+v/uDFpP6wpi/tca+JJ2614S7g4uG+IbZRuUel75T3E1tGeDga
         WSig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772160241; x=1772765041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OepVsImbDy+KSgEARNrV04CP8F8rjel+Y+lfhx3Eafg=;
        b=ZL3FTDcNqlY4aLaQPTXPjKc+CnKxpwnRe4m9t0HXlaDzB8M3VDWudN9zasKfVkJ1az
         baKFy2dMduBWzrayJZIjoSIAJMc87R1v8n/tmXHrMaqtRavlYws9emOoaylh5OWGFIVk
         SkkO1rxBQhNqkPd9sVAwYZJGyde8uPGDzMachFHmamykJUctkI0NxnONEW4+bU3RyHyZ
         MY8nmW0GrlhxYpBDh0+krMBdfpLDmpgaLbLN+WWP39Wmhehb4ZC15M5R6ml4y7U1VfL1
         QFh3azHDPaxuaVSuY5sBGUrQe+4GjGcce9Gni1DiZSxYsZNLjVRncxOjCIo4abKTjFaj
         KtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772160241; x=1772765041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OepVsImbDy+KSgEARNrV04CP8F8rjel+Y+lfhx3Eafg=;
        b=RdA5EvnKQzZCXT99wHX/HTEFzPXB9SFQ6HCiWWUEQBwYGv2OG3ZEAM3BEh0p0DDTJ9
         bx8p3Z3PRUCHFOVI1MTlWBJihDCJQLeD62Bs+00Mg8MOkcjuCZ8F+X9Ub6vfKOmxcrsx
         f+SV5XVg4ap37K8MlRgmT0iymijBPVlhACdHiuX0va8c+IPsRQDGzCfD2sefaZgiu9vt
         ynLr6lPwB3G4kjofiUC1TCOD6U/riIcDtShDlTHgel/PQMv/S7Tgruz1qMHuA+X6f5mg
         SJWAGHzE244pVnT+0WdZg7DajU3ECSGFQwgM1oHOLX7KVhAtPlp+C7pl2CjoRnYYxK/N
         TJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc3e2PfunGlVx1mdKRhmRJH8HFS27YXHepFBh2h1CJTGEXWQcUxk2Wn+YB3Pesf6CzPlMfsnxtWbX9j4Kw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7EB91A0YwAsHJeil/c/KKa8JcCwPaRRkssFD+wD9t1bn5xmSB
	y1LFDQnh+qxON6y5RN1SP8tyxsJb0NGjUvV+LyRTU/rZpG4OJQgBN+CaV4awEVUcg0XRXZN50fL
	F3e2WO1W7OTtNvR0fiXliwmP7/w4ULGE=
X-Gm-Gg: ATEYQzz8vVDKJ+dh/K9YZKDqAP6oDu3/WAA2y9EQE0xiRtulCSyft8+BWAHLSoKOyMa
	cXYHZnhFepw42AuwficG6az3PmY/B2uH9GAOW/YSUeaz1CtIyLRsrQse1hVR+Bg1vpN1etHhBom
	ywQKeUm7lkLOxaa4PtFazB7kcR9y0q3vCiFlBs8PlQdjnNYHziAlptb/OACmKOJnlOrpOG31K8H
	2vZPZWsvm1gTMMButYTYuQ4T6t0D7xaAj7J6RIl7yy4xsPeDe/DR+ViaYkYb6SZJ/05k1ilU4xD
	wC3SJg==
X-Received: by 2002:ad4:5b89:0:b0:895:4852:ef49 with SMTP id
 6a1803df08f44-899d1e54f38mr20558826d6.34.1772160241078; Thu, 26 Feb 2026
 18:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75f43184.d57.19c7b2269dd.Coremail.nzzhao@126.com>
 <aZiCV2lPYhiQzYUJ@infradead.org> <aZiqsQsWFSCjcfE_@casper.infradead.org>
 <aZzIUnYprj_wTyqn@google.com> <CAGsJ_4yN+RyF5hh-=sBfnRGp-r8KZBYY-ByT_V9KjiiKy1FgSA@mail.gmail.com>
 <aaD7Qf1ljl4yFB8e@google.com>
In-Reply-To: <aaD7Qf1ljl4yFB8e@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 27 Feb 2026 10:43:49 +0800
X-Gm-Features: AaiRm510HyYOJcNs9d7INj8mxdW--GNTCph1Pr3PQSqsJ-9cIWscEsMFF2mztVU
Message-ID: <CAGsJ_4zNvSYa+fyBVkt1eOqpMPGi0Wrckb+fxn8Pqt5erZbTfw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Large folio support: iomap framework changes
 versus filesystem-specific implementations
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Nanzhe Zhao <nzzhao@126.com>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	yi.zhang@huaweicloud.com, Chao Yu <chao@kernel.org>, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78672-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,126.com,lists.linux-foundation.org,vger.kernel.org,huaweicloud.com,kernel.org,suse.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8FFBD1B21BC
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 10:02=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> w=
rote:
>
> On 02/26, Barry Song wrote:
> > On Tue, Feb 24, 2026 at 5:36=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org=
> wrote:
> > >
> > > On 02/20, Matthew Wilcox wrote:
> > > > On Fri, Feb 20, 2026 at 07:48:39AM -0800, Christoph Hellwig wrote:
> > > > > Maybe you catch on the wrong foot, but this pisses me off.  I've =
been
> > > > > telling you guys to please actually fricking try converting f2fs =
to
> > > > > iomap, and it's been constantly ignored.
> > > >
> > > > Christoph isn't alone here.  There's a consistent pattern of f2fs g=
oing
> > > > off and doing weird shit without talking to anyone else.  A good st=
art
> > > > would be f2fs maintainers actually coming to LSFMM, but a lot more =
design
> > > > decisions need to be cc'd to linux-fsdevel.
> > >
> > > What's the benefit of supporting the large folio on the write path? A=
nd,
> > > which other designs are you talking about?
> > >
> > > I'm also getting the consistent pattern: 1) posting patches in f2fs f=
or
> > > production, 2) requested to post patches modifying the generic layer,=
 3)
> > > posting the converted patches after heavy tests, 4) sitting there for
> > > months without progress.
> >
> > It can sometimes be a bit tricky for the common layer and
> > filesystem-specific layers to coordinate smoothly. At times,
> > it can be somewhat frustrating.
> >
> > Privately, I know how tough it was for Nanzhe to decide whether
> > to make changes in the iomap layer or in filesystem-specific code.
> > Nevertheless, he has the dedication and care to implement F2FS
> > large folio support in the best possible way, as he has discussed
> > with me many times in private.
> >
> > I strongly suggest that LSF/MM/BPF invite Kim (and Chao, if possible)
> > along with the iomap team to discuss this together=E2=80=94at least
> > remotely if not everyone can attend in person.
>
> We don't have a plan to attend this year summit. But I'm open to have an =
offline

It=E2=80=99s truly a shame, but I understand that you have prior commitment=
s.

> call to discuss about what we can do in f2fs, if you guys are interested =
in.
> Let me know.

Many thanks for your willingness to have an offline call.

Absolutely, I=E2=80=99m very interested. I spoke with Nanzhe today, and he=
=E2=80=99ll
prepare documents and code to review with you, gather your feedback,
and incorporate all your guidance.

Nanzhe can then bring all the points to LSF afterward
if the topic is scheduled.

> > >
> > > E.g.,
> > > https://lore.kernel.org/lkml/20251202013212.964298-1-jaegeuk@kernel.o=
rg/
> >

Thanks
Barry

