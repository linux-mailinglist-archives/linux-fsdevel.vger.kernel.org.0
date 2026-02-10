Return-Path: <linux-fsdevel+bounces-76901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOyWITuzi2mRYwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:37:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5CA11FC59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 695F23079BB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 22:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526AF3019D6;
	Tue, 10 Feb 2026 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3hlrQyD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6772FD1DA
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770763031; cv=pass; b=MjPwiXg6iFV4iHF1MfxBO2dA1mPcmTelCh23ohPYpokuBGkdKkvO0gVc4F7+oyAk7WYCRamPO6eBl5deWWuSG7V86WbyFXOsZPZoCoZkLooMM13JwQYa9TFu74SHpXVeVKb6NMxUGpMXKafr/B8FmXlMQzUdyb810Gh4sVCmmBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770763031; c=relaxed/simple;
	bh=zM6jScGUQfkU/V7Tz2UWPHFqKPVk2m8/RXnqq38SAUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJ1rfxdbasdFKKp+Jyz2iRJU2/jT8nDEUN4Dx2YFZMBW/ugNyzKHdhM/XHuTPgq7HXHl43Z0CTlUCEfC6c3M/dBsq8jofySHaRlLMUVc9pJybQt3OV6UDBDdC+GX8HpJQsToetCntNQNBKtGnXFTaPC9rtyREAaAyjnkH097zVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3hlrQyD; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c5389c3cd2so139625385a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 14:37:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770763029; cv=none;
        d=google.com; s=arc-20240605;
        b=hFOGQlZOWzk+N7OHoiJwrh0gee7VYVWotEjSdZLJUBqwOYMjFssYgle7OBZ0C54GrS
         c6eQMW1lb/FecaVl325fHo7BT106suNVt//CREhqktdP0q91CmBebNRZcIYFFT4CmBVk
         Ma3qWVpVuLcd3j/TEiVjZ95zxJEbDlXbsI7/XITeud8q7ovpWpTWql3qxSBqtOB5XkTk
         rscPTTSMIv9WFMh1nmBAbW7navtA7IwXgi0aHiMzKXmzdWAAxrnY/Nu/gBAJBqznLkx+
         1eULCumzhffujLzCH3Se9YxhDc/8Mj/qjSmf0pN7crz7/oDXvXQnIa5NkC5s/OVeHQRh
         r/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PNdyL5FAbFX1kBrECZQF7i/AJRGqVtpBwFrf3abpyFw=;
        fh=dfGsQENsPohcLVFYhKvqnJCGowopEdVc22XgYMeO4Tc=;
        b=MZ8NK8/Xz9cM25gIoGFwmpvsK3R9/Lvog3oPf0m9dpAII+bORiYGSZP1ZgI4fiaf+u
         B7ukLzmk3e9MQc81ACE49Pvf5iFvskwQgDaS9w/lUIqfAgBGvz6agohNjObTlxrvU8pN
         +borDA+I66P8oxflddS69UrwjVirM3fpAaOwxLEvXtEzL4g/wss49Sd9YAWkNA//SAve
         JHsN3au62mxSDvwJGCzIZSTvP/lKCW9mBG6Fj/K+S1hsb9JOUEjyWbVq9KkvZeVmxFlq
         pgFp6YaQZq4Q/O2e7juYiyFSfrLkjFdw5SyGKYXS2O+DqI2Id5OU9QshsJbHQET+fsMA
         /jvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770763029; x=1771367829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNdyL5FAbFX1kBrECZQF7i/AJRGqVtpBwFrf3abpyFw=;
        b=J3hlrQyDLpubHpI1W0EBeWCVNqUm+64weajtuK94871Vt4nKxdRoBtX+EGEeJI7v/7
         Xwsw64tKsk9Sxdzkm4pMlaayPUQ+cDdg1oaBRow6v+M7s3ZaCy+UIcUfbjeEHkxolahF
         2xK2ijLuxHLWkAwlzgm+rt4t/5uF/v2UZHjd5CTa6W9XAtpYYxR4bPvhxoIQqtFn9e97
         +aEXYNfHVmZ3NC0sod9qbd7VR8hJwumZN1Af2RJ/nqvk6h+agrqF9kEpMyzlHgYlhvTl
         GZ8pneG2g4rYwoSFXRRKeKWv1ius24rDTqz4tAjpv54CCX7SMY0mV4nmHDQkY/lCQ3BG
         bDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770763029; x=1771367829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PNdyL5FAbFX1kBrECZQF7i/AJRGqVtpBwFrf3abpyFw=;
        b=VItnTq7CVGmvKlLJoikjMk6NMGR4LUwMXsvNTjJaajQDYb+n/cxqBxD7PhPhZvA+sl
         lPOAGhMuFOxHOD8qHMy7ijv7/nuGcHMIet+ahwvVViruxKy+W4h8EfiEI5iM1mOjWN6o
         M+Pd/cLFjJxaKXrKNvS94Nq6cUBFoqCBS8pOvovmQ+3eLe9duBS5We5pY+JkgwxriTym
         BoXYfxn9y3wKrSfsnvXYdBbJJNLGoZGG1cByyTouFWqdYvWTGo73u78qgY8mlI2ZbubE
         nUsNmUtrRS0zna/YXt3t+uEZ6gcoXbusrRKiedcxo44UtYSfGQwqk2rcsjXQp6phmKOQ
         zwNw==
X-Forwarded-Encrypted: i=1; AJvYcCXKtCQFnIuQ94wSCKB/6i+Pw2287ZtRmaV1e1GVWRObpmZRosqGES562AWqzB6E+3IPrPW91klnQrn1Ot6t@vger.kernel.org
X-Gm-Message-State: AOJu0YygV03REG7wqhUa8p6bLgBVk3e0AihPFi0DejIkkIuhqKravhUJ
	1GOirz92hCSuw598jQ7wneUhrg4QgaiI1CM21U4Afl9P/jIBZVR2q7d9Tzsn6Dpe6VRNfnUYdMw
	121GdcotERl5kVFnnn/bbo4k+FMr3s1Q=
X-Gm-Gg: AZuq6aIbXR4NEw8cEfO9ycxxr7If6uKJy2R5kTwSiao1Ln2gitvBUEgDuLirdcEhOlW
	Ads3roxVXmDC27lQI/aINs40CTpWkS63Bnm69+nEYkekjtEVfgX3s1Xi6amG+zBr1cQauFIhI33
	Htq1XwwoFwfYpp8xBEh7JtOSmpR/3OkvgG9O5CS8hTDLW7DrBxBV+VZV49Is5DJZ85p/z8s9zeu
	D3hikO0zCYCQYV10MrWRiqBIcmbq0Ajl5hc1tZq5vkOC/r0ssElGkPjESFAbsWrjsDg75CCmDiE
	vJ8xBg==
X-Received: by 2002:a05:620a:1a99:b0:85c:bb2:ad8c with SMTP id
 af79cd13be357-8caf17e6c53mr1916209685a.74.1770763029066; Tue, 10 Feb 2026
 14:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-11-joannelkoong@gmail.com> <4e12c801-4d3e-4c49-9a6d-6faba5e05063@kernel.dk>
In-Reply-To: <4e12c801-4d3e-4c49-9a6d-6faba5e05063@kernel.dk>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 10 Feb 2026 14:36:58 -0800
X-Gm-Features: AZwV_QgnFMoPwFDIGhVzgLCOJ4YJAomXQk6kMkMi1m3vdbwEJ7bGY8CNkPMkhJU
Message-ID: <CAJnrk1a419AKBCYf-1fkB8m0u-PwL5RRVZ6Vq9fiqBHqq+GUrA@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] io_uring/kbuf: return buffer id in buffer selection
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, csander@purestorage.com, krisman@suse.de, 
	bernd@bsbernd.com, hch@infradead.org, asml.silence@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76901-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,purestorage.com,suse.de,bsbernd.com,infradead.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DC5CA11FC59
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 4:53=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/9/26 5:28 PM, Joanne Koong wrote:
> > Return the id of the selected buffer in io_buffer_select(). This is
> > needed for kernel-managed buffer rings to later recycle the selected
> > buffer.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/io_uring/cmd.h   | 2 +-
> >  include/linux/io_uring_types.h | 2 ++
> >  io_uring/kbuf.c                | 7 +++++--
> >  3 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.=
h
> > index d4b5943bdeb1..94df2bdebe77 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -71,7 +71,7 @@ void io_uring_cmd_issue_blocking(struct io_uring_cmd =
*ioucmd);
> >
> >  /*
> >   * Select a buffer from the provided buffer group for multishot uring_=
cmd.
> > - * Returns the selected buffer address and size.
> > + * Returns the selected buffer address, size, and id.
> >   */
> >  struct io_br_sel io_uring_cmd_buffer_select(struct io_uring_cmd *ioucm=
d,
> >                                           unsigned buf_group, size_t *l=
en,
> > diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_ty=
pes.h
> > index 36cc2e0346d9..5a56bb341337 100644
> > --- a/include/linux/io_uring_types.h
> > +++ b/include/linux/io_uring_types.h
> > @@ -100,6 +100,8 @@ struct io_br_sel {
> >               void *kaddr;
> >       };
> >       ssize_t val;
> > +     /* id of the selected buffer */
> > +     unsigned buf_id;
> >  };
>
> I'm probably missing something here, but why can't the caller just use
> req->buf_index for this?

The caller can, but from the caller side they only have access to the
cmd so they would need to do something like

struct io_kiocb *req =3D cmd_to_iocb_kiocb(ent->cmd);
buf_id =3D req->buf_index;

which may be kind of ugly with looking inside io-uring internals.
Maybe a helper here would be nicer, something like
io_uring_cmd_buf_id() or io_uring_req_buf_id(). It seemed cleaner to
me to just return the buf id as part of the io_br_sel struct, but I'm
happy to do it another way if you have a preference.

Thanks,
Joanne

>
> --
> Jens Axboe

