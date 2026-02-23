Return-Path: <linux-fsdevel+bounces-78001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJFLKGPEnGnJKAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:19:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FAC17D80B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73992300F280
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 21:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE21037882A;
	Mon, 23 Feb 2026 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feZ35/6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F103331200
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881566; cv=pass; b=Ok9YjRESlIsFlmWN3IQ4wJNGlou47ugY0cu6r9ySSsaQjx+NShwRr+DRF7c1FYDOgf62uySs02ICy7IvO0fREpzrReooYMVH5AxPxU87188QdDD8O3P0e4aeXRacizXg7ZXuLRcdeS8CMFTUAbutVEhSzqbR+044pLKOVh9+VZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881566; c=relaxed/simple;
	bh=6xucJiKz6gf7cBFoHRvH8DDttfd7LVVX7JhNAoPFST4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f116bjfutsJTMCQTTo50+LcnPO1kSIpjiF9fDgH2kLbypqBVJwnqJxzgGuczP0LH7AQS8sh24LCL7vJK2CNWoD9WstbwbMlTcS/Q7+d47ASyeyjGD+ICPw2HyVtIWE6BUg5MnwvZ+4U3n2t7IKtOkRfL+mM/UN5l1t6X8bqf2tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feZ35/6C; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79427f739b0so43206477b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 13:19:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771881564; cv=none;
        d=google.com; s=arc-20240605;
        b=K7g3ejF8dKhFpSI2vLFe65CzbBofW2E1kyRfllMirpFwZIBepnYOmyyhSEaHRcIFvD
         WmR7qO1Z6GA1ecAG0af/oWl4gKSlFn2tP5tx6KiDAwEinFye38S5e3SDANdQ1VWTmJgr
         ztpnwdK2Hn6SXr9p9UZ33JGyLeqbvqypB+suO6ZyHr+xK02p2gZ4KWykwSrl1WM66CO/
         mB7UYlzwI2NIg55YfHkfj7VKSteEH5ixv1OREU+iNyo4/GfsKUomAiq3EbMMqQXH5d8x
         GQctKam8vXbmAej+LuDpW9AY4LEv9HY1GxLRqA+tE5NNowrB5X+A2aSw3F5/n/Lv5V9V
         97kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6xucJiKz6gf7cBFoHRvH8DDttfd7LVVX7JhNAoPFST4=;
        fh=tq3QcxRhP6nIoMrDwp0CCKeUDMYQR8LB1C7SNVZvsC4=;
        b=Dj6zlFHnoONrlHdaHRa6IDPuKd8HgMNsovUY6hJzIN9T7peC5MR+AaRioh+uzwh9VG
         IonjdO/K9J8RZSmgr43YAIH4rT+CXM5UxGqz51rfvf984bO3Z9W9qa0uk/wWTarSsWuD
         RMIaej6aDHv65Hllb8biSVyiMYrJdVCJwkBWK0HC886l3CtGsdj/1wYXZHweOjuEGlJX
         yXxZqfQJi2XEnkrTVznAEQQkgqeNlUAo8xMhjpVOiFVMPenQae2Nl2iWJANnpYnTqzPM
         Xpy+tCwLmNXuOe2h+s3jn7Sv/A6Fk7vsUB6v5WTbFCFysG07zAfFa4UudRIbfcQtd5GJ
         wJRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771881564; x=1772486364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xucJiKz6gf7cBFoHRvH8DDttfd7LVVX7JhNAoPFST4=;
        b=feZ35/6CpLG18uFRD53yp54tfgbDQPSVpZKLlLIKJQL/7/Qb5cLP70jz8fUNFaGZeO
         XWlKM+VTx1EH8i5Klk0lEDjCr0xS4+o7patwo4c9uWXEk7HK6Yd+doLhe9DkMah8DhNY
         7616VXQL5mSRF1ss/milvO1prJ9dRSqPXAU1zbQvf9Z0gzJpcEx3uY89jN2hCX4IV64P
         UiYutixwkuYyCHCYO4EHuKuVSu7VGTmWqVMU2PbyFST1UzBU7as/KSye2MxwuMCVnCoY
         /iYzL41TlC1wlMsGr1lDemrC05094hsKbShHNnpUe376F5uPwjNFG5y5ThslNDTXQC2b
         Hoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771881564; x=1772486364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6xucJiKz6gf7cBFoHRvH8DDttfd7LVVX7JhNAoPFST4=;
        b=IJ1HTLL3wXpy3lS9TZByv9iMlPnUD07TNqF5VGAQikzaEhFUNYXTCLuPc5d5sV/QEF
         /NgMTJHLL6OxNhs9O+hIWS9z9WELO8+hhsH/ZMSx8typ8qDSK0NbKfHXmTkRetd6A+Ki
         eYQAE26pZapCRmT5B0Dac1m82YpAwU41wrV17Gj3Kp2vlkG+PlF9SWrB4+41HjxpyZjj
         s1PicNAvpsUaJ7Sik7vA/KDINeoHAudnHOPV7brnAnBD5xEekLHvSBi4TDdv5BoGPjRM
         px+ZFUwHQ5xD+OVvtAyy8tTp6sn0UmNp4m3YCm+zPWjhg4fWGrCYnfL+y5dNQDnPS81T
         zzlA==
X-Gm-Message-State: AOJu0YwyDxKkuRZQBWhjxmyMJYpd9U7yensH0gPILjHCBedGQIelPnlf
	ZiF8VRAiApFuUSLjIpcKURfs+jDZIXJRAAz52PDWk4JgXNQWqFAEyeWt9QrysVSv5Dw0y8d1Wwi
	8IggbYqHTaHGjZL0eitd4e/Y81RhirMs=
X-Gm-Gg: ATEYQzyY7zMFnw34+844un6b7OIyAVPqKjBV6CEC5TQzswr587M/VpPkvTwngSK3sf/
	0dVa3jWt80Jog/WEbvnm7+4nZFTLm6i5G2QC+9DyN21uwIGveQ1Du1Bqhs00w4CkdJYq9o2uCbi
	d1bSf/xBKZRiVVHzIEVDF4L3OomWDSB/p04BRW0RUWWGtiI3BsDXW8VIclSQCZgkdUJUnyqE6tY
	jGaYBpU9CBWL1VOpB4Vf+l2LALQErulFWm8XWwAKEH7cnMVA3VM71hrF2uBYc5lEkOvKZr/xnFx
	sJ1hmeQ=
X-Received: by 2002:a05:690c:298:b0:798:3be8:b724 with SMTP id
 00721157ae682-7983be8c0bdmr55059167b3.65.1771881564464; Mon, 23 Feb 2026
 13:19:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219210312.3468980-1-safinaskar@gmail.com>
 <20260219210312.3468980-3-safinaskar@gmail.com> <e67898f6-4e33-428b-8498-b8b28f817bd9@landley.net>
In-Reply-To: <e67898f6-4e33-428b-8498-b8b28f817bd9@landley.net>
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 24 Feb 2026 00:18:48 +0300
X-Gm-Features: AaiRm50sLaC9UJuN7QdRgNE3QNOZiS7DWDKIfXjMKeU4af4U1Sw57WjY7CysLU8
Message-ID: <CAPnZJGDDFrOObdxa70nSS0bqXQ0zqRPnKWLRFUBCj-FtnkpPtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] init: ensure that /dev/null is (nearly) always
 available in initramfs
To: Rob Landley <rob@landley.net>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org, 
	David Disseldorp <ddiss@suse.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78001-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[landley.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 00FAC17D80B
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 4:15=E2=80=AFAM Rob Landley <rob@landley.net> wrote=
:
> Are you saying it's reoccurred, or that you plan to run a 5 year old
> userspace with a current kernel?

I was not aware about this. Okay, I agree that /dev/null is not needed.

> (Although I can't say I've regression tested an init task statically
> linked against bionic launching itself in an empty chroot recently
> either.

I tested current Android NDK LTS. I found that if stdin/stdout/stderr
already opened, then bionic binary will not crash if /dev/null is absent.
It will not crash even if PID is not 1 (so chroot should work).
But I didn't test what happens if stdin/stdout/stderr are closed.
So, assuming you already somehow got /dev/console, then
/dev/null is not needed.

According to code, bionic binary should work even if stdin/stdout/stderr ar=
e
closed, assuming that PID is 1.

--
Askar Safin

