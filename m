Return-Path: <linux-fsdevel+bounces-76673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHyMDsRkh2k6XgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 17:13:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2B21067B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 17:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 845933005162
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Feb 2026 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8451033507E;
	Sat,  7 Feb 2026 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab5eK39g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD142049
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Feb 2026 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770480828; cv=pass; b=ZANPWz4WMoU0/jVZYI3/NnCsomPi1PBigzFE26VM4DIuaK2RZtL0DtCrPWTxuxqlIhAsyRrbHA8io0uHmxzoEyGaef9mhSO2ZF40BxWQQCDhsCDwdnsjZSb/Cy1EO+2HOnDMjt0d1WcP1DvRn3BIuQSPCSZi+PAPQZ/Pqma2oME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770480828; c=relaxed/simple;
	bh=DbFyM9F0Ova3xSH/8Zz9pHOVhyi25IeRYLEPEnQ9r/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMKnfE4T1DAi+6VM/Zn+9YHrvykJrWqKJFW7n4Gpgk7NT8P3uGBCClpiH7oIOO14vbHgnl+CJRp6eG/YTVzhp2AO1dwF9O2LOUvsC222zLEOaK6+XFoNdShOpKrebwwrntBosMmtqHe9xCAvD2unOtWSteb69I6Mt2ygl9zIbjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab5eK39g; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7945838691aso54015957b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Feb 2026 08:13:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770480827; cv=none;
        d=google.com; s=arc-20240605;
        b=IVVruZj9H5k11RJqZiP7XXDRczxRcFywxuL0NzAyQoU+A+HnnUIgXqB3f/YItxu9Gl
         /3PcLR0m4091EZzfOD6F7Qt0VMTN3VCVhPAjJsdGkF4aGU6hoV8hDe8KUmJepAfC45u7
         jGRQs1QotSpEPnO9Mtc7Q/2NIHWYzV30rapMCaovewVnSOLyccskQ3xtoYevoOPA3GD+
         zlFi7cmAibhfgCZQJSK4qwkZ4z0sQ9a6LqpJXD/hy2X9VHWp+yE7aLjiWfICz5zON97f
         SBewevNt+QiEq+TvWJtgbvWjDCaVSm3kV9a/M2aci5g+RkvbU8AFBgeaOziNz2YhtNmw
         ROeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DbFyM9F0Ova3xSH/8Zz9pHOVhyi25IeRYLEPEnQ9r/I=;
        fh=ui4ohfuC7/8Y3AnhSmxSy2DmHPmp3PJO6niwy8UfRAc=;
        b=YHfxlXVT71GiIj/G98l0RAo/wL6PeNMUA2OdgpCd4SpVKun9Dj0hPf2f90Dw7vcg8i
         N1T9Bqnv5pr1T0d9+2zJPO+GGqhAU1F/VQCQ3XRXtVFaUhQ5sK9Wq6jtaf/PeFch+ZNe
         aftonqfjOXBVVc3uCNW1DTfmk33hDqNxs3CHqeVsldNL6DQQ/rZndzY9rIxcu1Strk0x
         MGfoAChUCQLwNo/F/1QoUvwhXyXflcf9YFgA8g/DcCoHxKWFUcxRDrNe95kvYKxSxUMC
         CalW0sCT2AuVJrqfmytpoa19VW/ibwOXr7bv83vC+FgldI5AnAmtAxvsXrN6m8PmzExM
         j7ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770480827; x=1771085627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbFyM9F0Ova3xSH/8Zz9pHOVhyi25IeRYLEPEnQ9r/I=;
        b=ab5eK39gU8QTQCQjdqN+WKcnl1R7brm0WxMtkNGL1umbZ3kJucTvK1UM+/c3e4jXQz
         ZzpOch36YVe4hfiNxwuNK1XWVTW+culgTaR2t6v2e8IqCDYerxJa4QZQ3nuiYr4bRt9G
         9Vu+OUwYA/gQqNZFh9u21Rg5blhTJ1s6Lr+rZ/+UytHOj4/mNoLIFywmNVpgdGAQdoFN
         GIOkL0hNWE2u9gi5BGhrHPXjibc0HYBwaMOOAsa0rla+KZXFN0eysOi0c0fXPJBiTv9b
         q5pKZH5tQyXCw8nLfe0W1fQl66OEz9A7HyPB4Ik8Hq10/qZoWH19FGIRIN9uSIkJwh1q
         TotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770480827; x=1771085627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DbFyM9F0Ova3xSH/8Zz9pHOVhyi25IeRYLEPEnQ9r/I=;
        b=ZhWOShLmjWGi+oRADCqBC7Y9Ng6AMnnxg+CBr4o9exdqIIxBxrtCs2oJSjUfnLZmyg
         /xwMuyRuX0d57TgTbuPimfZLniFybjo6wTYPUud//zmjBzcP01tNNMZxERTrcryYOsi1
         ssTxGgfwT8sg+HD8LzPdEbNt7EeAacsgnuOEHyK/P7TA4dJBj8DI3pteVZ0awN0FdOYN
         Z2y193BbIvs0oxV05YFqE4JrQd2KhOtObEiZ54HL/jLSfkYemksvwzDP+WX/CKNG/IIk
         OsEsUyvnFNSZHG/+ao2OpdKBtJtoaQp9yExRyTJcu+SnQ/ACxd8tXXUHDUIfGTYyNloq
         kBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW67iQPqG+ugMVT1xidrI0Qbx6QbPvBufVGJugRCDBcCbr8aI2Tc3nHODbb4EAjFdKRY+DUZIkSx+tvqgGy@vger.kernel.org
X-Gm-Message-State: AOJu0YwecxR6VquIl6ZOHJkyE80WPGkTaKpb9YYMkLMDUq6JJyNN30oH
	p9kAjpcPlNG0yB579IBYmDG1/3l5vx94SeM4Eh9hmFOzrAVIFC7bD6aaAICWSYjkCyQmU0Bx8l+
	HwMKidqddLPuSKduKLhWuKmXY46qPs3w=
X-Gm-Gg: AZuq6aK6EiRCgbqWWkfa0xg8pZYmGHKaRo59t8XD9v4IEno8jF7LN9I5QOj6dp7lTWv
	a4IZwFaLMcUjDM6F1JGiCF1+NaDfxaxmkdCYAyJBCwtaqKLQMbd/lz2F4PFEegTCMVZAsc1uU2e
	1ca/L56d5ISEXqKbDsxUilUCSjbbzxzglPcmyvwHvn/Hw0OE2DeT3LOTD9u8ljAaX91Z1vns8Qk
	nJxgxagYO1NvnbHMsCP4Zc8GWaRGX4VE7osbXqJ/V/lN/QRgYr3D6kSTNcgrPe4YzxyxeQ=
X-Received: by 2002:a53:ac92:0:b0:64a:cd13:71bf with SMTP id
 956f58d0204a3-64acd137441mr4362558d50.20.1770480826891; Sat, 07 Feb 2026
 08:13:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-4-joannelkoong@gmail.com>
 <20260206133950.3133771-1-safinaskar@gmail.com> <CAJnrk1YEw2CJb5Vv__BX7DaZXmZMfTsH3WYtQ2s4RGDWNRW4_A@mail.gmail.com>
In-Reply-To: <CAJnrk1YEw2CJb5Vv__BX7DaZXmZMfTsH3WYtQ2s4RGDWNRW4_A@mail.gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 7 Feb 2026 19:13:10 +0300
X-Gm-Features: AZwV_QgxIemzygJR1-WscAENyJ1BOl1fzhPCwisptJ7ninyK_TCUKCeB4-vDv6U
Message-ID: <CAPnZJGCPNHS=R9s2dW4ebA2vtW5AQOmX7RLUtEiC2QOHKUdBmQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/25] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Joanne Koong <joannelkoong@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76673-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,ddn.com,purestorage.com,vger.kernel.org,suse.de,szeredi.hu,infradead.org,samsung.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4C2B21067B8
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 4:22=E2=80=AFAM Joanne Koong <joannelkoong@gmail.com=
> wrote:
> I don't think this is related to kmbufs. Zero-copying is done through
> registered buffers (eg userspace registers sparse buffers for the ring

Thank you for your answer.

Please, don't CC me when sending future versions of this patchset.

--=20
Askar Safin

