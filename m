Return-Path: <linux-fsdevel+bounces-76663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K6YJCiUhmnuOwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 02:23:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28796104776
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 02:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E68A63023DFF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Feb 2026 01:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197E927816C;
	Sat,  7 Feb 2026 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk2UUZUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5D2264CF
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Feb 2026 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427366; cv=pass; b=gtwQ3VzTp1yTmmG+FpvyCx3CCT2o31G9HwprCqvv5BEN0jsztLyTLHhgL44goZolBiXdv3am5PW76Vj+VKrGyMfRQhuYIpRqgQ/57nf1co9JAYh+O/UU19IEx2kxt9tjhe8zwp2hLZahZX5WqnDAJXo4WEH9fVEX2DB7g/8uN1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427366; c=relaxed/simple;
	bh=w6ehWV/UdsOefVPVO/LSKgkiGRVYbFAtJfDqBHGr9NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfgoN58Dv3JsusZuyVamy6NCY9pEWt+0dfJrFHEqs12regF9NlbVvvVQtwYHzaifgnOuC8TGdFqTufsFVnSyeWf+P7FOuG2ZLJkjWwLOl12hAzoQu/eBwlHm8q/1xmTTCRW+qiOakSwi5POxM4CTiSGAPdGBl3rklvt5ZDC/jyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk2UUZUe; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50146483bf9so30174991cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 17:22:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770427365; cv=none;
        d=google.com; s=arc-20240605;
        b=ObVt1qngzIyNZhDxdG8BcjD8cbAJR+xTR6a3ZBM6RgxzRBiXUbzWwK9a2mXxVbmmts
         4wdof+ubsTCk/55HuvNDCbIY4ElkEDXHxCRRYp8vevF0rD6ibAFVJgTn15C7PrVaSyye
         Q9DkVJD69WrcyafrTae0f8OFX8qXfUUEuGUjjui6THD4cbDzduhfqSYRIAThgSaDXTQI
         D1NzLzxkyRxW0Zopk6N6whLIkmeN4xroHOOtEGjt9i5Dmvj5E4KZRhbSBzcVz2r5Eip0
         Gnd7cJde15XQPmfMQ4bC5NWqmExPM8CUDfx4DE3kHknL4ObYuIkYT18GyJPw2x65HmWl
         O22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w6ehWV/UdsOefVPVO/LSKgkiGRVYbFAtJfDqBHGr9NA=;
        fh=8dWLl+UF6KfX4k/4EQmUQ/a6KjGUM4p59Iw3ZtRbysw=;
        b=bCjkktKFKWcYCricweL1BZrcFCY4hb+buhZKkcssrmb2+vZk0+NygbMNO96ZjkoQHt
         jmiSMq+pPXTKxWJ+W5hq4Q7GLIAW41MMtWiVnslEmNuoypYYE0m58WRePBLgQGEjidzP
         Q36XhyOiIcVLV5Z7EOb41cOBJ+8jfoeJiXinwgVKJX659c5xTe9q52hIcv44OuZ/Won9
         nGTizfE+i6YxdWhnzcs7zXFG+XK/CSYy3JDQtY1DTS16PThaqTvCpglZFmMpb4/zaZHL
         6KXa/8wUJWA9mCOHyII7FOnLauOA8VpP5BlvEMo79nE9Zi0IN7d5omrXmyLZ8KrwKy1g
         MlLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770427365; x=1771032165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6ehWV/UdsOefVPVO/LSKgkiGRVYbFAtJfDqBHGr9NA=;
        b=Mk2UUZUemwK+JSrIDO9rw/yFO0+WshfGBrNEBUZA70yX3/xylB+Jot4WrxzgM63eN2
         fBkJf5LxTJXrofhFePRI7kLrZu/XZ8Znk/RucRlwz/zm31vEkJ7WFKC11Kx0pEEzBhex
         E8NBlXZLkvPOUM+v+u/eHkHw+92yeJb3ggnyryMan5YAtAOaKGphAENZsrMfIFvXHOro
         yx80V1lDAgVmFdRHOnibJy2/l8wpKb6Wocdgfh6v3lpLJFmggTWJ0vEFn2nwUDihrVxo
         FS+m1FRiUV/3ZzHorPy1jV2JXH3kAYAYs8f7S4lhqtPaIK1XsHapsVvkntSyqpzhL/1+
         5XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770427365; x=1771032165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w6ehWV/UdsOefVPVO/LSKgkiGRVYbFAtJfDqBHGr9NA=;
        b=w5jszx5ktXNaY1tSb0bId/k2ispxFJa7bssccaMTGnPk02viy+ubzSoxy6mvrS0k8n
         wiXix01jqriG/9ziNcXh8UPSSP1B4zJ8c4wU1pauXWs9TWthXGK/GR8iYQ5sCCRDVZqQ
         SNA5EHUIn1wcTJsBB71++tX31MM/bglHGnY+ualDb3pR5klYqkSWyitZJY1GV0nLYToj
         Mhniq7PJgGHbEASd5w8MQr217cMt8lbCD4QfmqjAXEeT/yBoKHg1dC7NQ8ASvqBzzzBW
         XQYUzwjer83Z7gCxUC4g9y9zt+ThKXNG0es14wFm6lidApNl4MdIm2rOgea7pcDb67Ji
         jvCA==
X-Forwarded-Encrypted: i=1; AJvYcCVBCCAD7hLwHtM9mzwB6ubXTDY25tB0CQxdcCh9aqgxpcA+17Ngk4TyF8QqO+aa7qD9HQrImH1rrldA6Y8p@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvTrOCQ7J4Sj3LNFtwBGuGAKAfRVbgx+zvMXfWfETsw2rLL5N
	xsqHUfPAhuuomQUqtzQDiAEMDtcMZJs/T/hMlx3ndHgaVDEhRtbiod5ZkL3Zak1FUHI6BgjeE0D
	hJHb/kJ5/svtzfHdq/u7LTEEgVbnGX0o=
X-Gm-Gg: AZuq6aJbJ9Fl1jEqSM7jQs3zXHL8gm8W37HmIEOHSW1ExZ3tjF8XTu2DVH4dPmfXXHv
	yMrHomVKzlVwuioULm0K+rN9rH369KFhYg/Nhh22bIPbbeFyfzpDTx17ypDG1nGuY05gV3Ok2y4
	vLIvSr/I+uPGw34/IrX3QAzKTnOTkb9pt0dB9h10iwhfFtVQ1pxgyTu4BwFrIbH9Pq9pYuMaK5W
	1BJmp0zpy4VvLHhmFMzxp9ul5M0DzRm1oYklfSZZIddDMzBRG3mcF41Vw0rdDnsDpAqkg==
X-Received: by 2002:ac8:598e:0:b0:502:a1c7:4080 with SMTP id
 d75a77b69052e-5063986ae2cmr59285181cf.11.1770427365486; Fri, 06 Feb 2026
 17:22:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-4-joannelkoong@gmail.com> <20260206133950.3133771-1-safinaskar@gmail.com>
In-Reply-To: <20260206133950.3133771-1-safinaskar@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 6 Feb 2026 17:22:34 -0800
X-Gm-Features: AZwV_Qj06frHCkzPc9ihdEGHCYKBXNPzugFJmrQuHHZu6XHj5C4wvoGRD1e8Q28
Message-ID: <CAJnrk1YEw2CJb5Vv__BX7DaZXmZMfTsH3WYtQ2s4RGDWNRW4_A@mail.gmail.com>
Subject: Re: [PATCH v4 03/25] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Askar Safin <safinaskar@gmail.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, bschubert@ddn.com, 
	csander@purestorage.com, io-uring@vger.kernel.org, krisman@suse.de, 
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	xiaobing.li@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76663-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,ddn.com,purestorage.com,vger.kernel.org,suse.de,szeredi.hu,infradead.org,samsung.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 28796104776
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 5:40=E2=80=AFAM Askar Safin <safinaskar@gmail.com> w=
rote:
>
> Joanne Koong <joannelkoong@gmail.com>:
> > Add support for kernel-managed buffer rings (kmbuf rings)
>
> Is it true that these kbufs solve same problem splice originally meant fo=
r?
> I. e. is it true that kbuf is modern uring-based replacement for splice?
>
> Linus said in 2006 in https://lore.kernel.org/all/Pine.LNX.4.64.060330085=
3190.27203@g5.osdl.org/ :
>
> > The pipe is just the standard in-kernel buffer between two arbitrary
> > points. Think of it as a scatter-gather list with a wait-queue. That's
> > what a pipe _is_. Trying to get rid of the pipe totally misses the
> > whole point of splice().
>
> So, kbuf is modern version of exactly this?

I don't think this is related to kmbufs. Zero-copying is done through
registered buffers (eg userspace registers sparse buffers for the ring
ahead of time and then on the kernel side, those sparse buffers can be
filled out by the kernel to point to relevant folios), which is
separate from kmbufs. In fuse, kmbufs are used for non-zero-copyable
payloads, and leveraged primarily as a way to minimize the memory
footprint (especially once incremental buffer consumption for kmbufs
is added, which I'm planning to do next).

Thanks,
Joanne

>
> --
> Askar Safin

