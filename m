Return-Path: <linux-fsdevel+bounces-78004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJLvLCfKnGlHKQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:44:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7D317DB10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A1173130563
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 21:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C4C378D8F;
	Mon, 23 Feb 2026 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR/KjGM2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE7378D86
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882905; cv=pass; b=dT5LqnQV8Zod+CC1BMX2MFI4NmQIytDIukoZnT0l8XoVTrmPYEtvfQIQ0NKJfR06kaQij0zanx/XuxFkry8ZDREd1fxB2aM7rhhQo4E7GdK9Vj+EU15GT+1WR46Z0x3Zzq4sDz0arsFLh9ctXdurBAGy+z8uFCmnhl3e5QeD1LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882905; c=relaxed/simple;
	bh=1JG2cynNzhGyhQW47nj1rwIOUkkhTWpJb7I8OtRgOjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvMRExQ7KYze5/4Ou55IWKlWVBaqSvBfZ6zsedACaPLaIPoHzfZMtBrfwXPPpdaY2cJ62QINcgOjKiQK/JA22jxr059uTMnfj7XoEfyos7mD28x/918tYqKl0cX6oxmSO3NKN0/iUNXK/tVP3mhBq7BBOrBjdOJt7sQo3ikj2Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR/KjGM2; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-649b1ca87ddso4225160d50.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 13:41:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771882903; cv=none;
        d=google.com; s=arc-20240605;
        b=Za67PYGPiKGCTSZ2ebDxiQWTKmANUDxJbU+J3iymCD604E37lbANMRqDNTTDzcQCFt
         V+KBNlRXLXBbcbbILS60QpTK5qKABzDGjsau+/NraIUJzMU8qOl+4xAOTKj3nqbz+Nvn
         L0hqfNgpFhXk5n0eY8NuLMRVYnNnTa98nXG8AA0OIBuiRYDY3h4/epCRq47SlcOz/fR6
         n8TccwOnjnwK2PXuinUEhKZ2+TuHwe3EfmWTzz6YdK0jpMoblGqCUwEKG+RHqDvuSRwq
         izbQy3p8Bv+SWqF7q0QGcz5kpimlYNQk2V8tYk7IEsNnBzPpHtk+gA+jmOUO/bI99DLn
         B+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1JG2cynNzhGyhQW47nj1rwIOUkkhTWpJb7I8OtRgOjo=;
        fh=xpADS4eJ7FY2n1Uh54qCc7QQiThmDc1jJaakEYY05dw=;
        b=e/3iV1GkxC708Nva+8uCIEPf7UUh7sJV03RwY/VuH2PdYzlhaPBx+VI8R1lxj+Okbh
         uOZgr3KkZo+gHvGUePwizi1TQNrDdOHW0Ks1n3dq+HDinkiFZ86o/RIgYOXjeNmhSH7/
         uamo0A9DMI1BUlKppwx2j0Gm8tbwmbujSj/LW8E9Jzsl6BW2yGRQbYXDmMQTUBCdj8UY
         8x2CGqKfsHSwDgiXRuHygUnZItcjNOeWT+k62c2f4yyKf1LoBeD1Z1z93z9TfB9v5Yl9
         AYz7T90/i4garadrvgOOQu/bsFpOCYYi6UiAaQfffbTiUyVf5glxmt2NLcbjONHvKNJP
         wkQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771882903; x=1772487703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JG2cynNzhGyhQW47nj1rwIOUkkhTWpJb7I8OtRgOjo=;
        b=mR/KjGM2e1PoabVLs/GloteJgAksAVkDI8QYaZN3u/WSycdLe1qJsALkq8LIuz6X1a
         rRM/Xr4WKXvciPRlqCxUf99PgvoZ9LBE7Deik3xsE3MVoGz10lPjpyHrKodJL60XT5ss
         4z2i+JAP5z830gB/43N2hP8op3xluX8BUsilz9oKrA1qDE+5ooIIa639vIX9Af6KccUq
         kmfftViRVrRcZdDMTcSEfeYgGtWl3Q/4+7Ft8mfVPkJ5d97RKsHpGwoROshuap45Jm//
         dIeB5C+/It5H8vESVY10A5vvW6t2AMoWtVE3Yadcjyc8eciah27PTSgk6CZoXjzJ4Ynp
         bBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771882903; x=1772487703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1JG2cynNzhGyhQW47nj1rwIOUkkhTWpJb7I8OtRgOjo=;
        b=STvAApAoF2DkLuKtMQf3v3F7nDrzynKG1LAoYiOOIGQ4aJ2MbWrBB87+iavHrz80J8
         pZ1vdTauCfBXIcWObZVaFlsA2S6tjOkaDSLM/W0suDnVZlTSwELlyHZVt9xmcd99OQCM
         OhJTiYbVueC7Is8IjRKEIaKL4HDt6hh02cJnVEspPiwPXgqNg+Thuspc6rxI7sbQWaJU
         7rSyp9yKfc53tHXyuazLfCNx2axHOt7HqVsD0zpNYGqkQrEOobtsQQFPhxRmv895yqoP
         NCoeeUest5JK+8D0PXNDw0WH+KoL4eg9rJsiplsaZ0ICQNaLUzSSwdkZKz+rit0LiyBL
         9s9w==
X-Forwarded-Encrypted: i=1; AJvYcCXlRKUhR+kYstUlngwqDfdhKm2qeEnzbBh+JeFyunNHPneO8zEYNbfCZctnJNpUJZRp7RjS1iIx4urJNIY3@vger.kernel.org
X-Gm-Message-State: AOJu0YxqZI+fEpDaQf4mLoI0tmrUApF/jmx6DPAb38MjX+lnF40y52ul
	NG4dbNxindMaCehOYOY3xFw74iMbWTB7jOi0RUMv/UDBt3tih9LvpbyL1MsjbC3oZTH2/T9AO55
	/YMdwTj6N+90zG2bISwgYHZ0K2J9x/OQ=
X-Gm-Gg: ATEYQzzu0b54iutDqez55cGwMZPXShetuaKUWfqJKF43BV86X1qvTytJNhD7d0Nh3Cc
	I+cUCugqPIwrkY883byK+KqGZNPBYfHoUt9am8G09BUzw9cAc8yec6XkfWo6o2X2Dxaj3Yl5X4t
	qpSe72ZEFhSB0u8QvbsrHFJkhnDeBG6bcepeEgyQHd/9DUzpAh47kDPLbt4MPd8cNVfn85HQJFC
	zuOpOat8pLrdbZY07ntrTuqlLaN7AZAkpIh+KptVI5t1fCV0777HEffY61PDIWVBe/eezO+hxrr
	jkO2XVM=
X-Received: by 2002:a05:690e:134b:b0:64a:d67a:1fdc with SMTP id
 956f58d0204a3-64c785dc781mr9063433d50.13.1771882903527; Mon, 23 Feb 2026
 13:41:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220105913.4b62e124.ddiss@suse.de> <20260220191150.244006-1-safinaskar@gmail.com>
 <20260223121946.45b3c5b1.ddiss@suse.de>
In-Reply-To: <20260223121946.45b3c5b1.ddiss@suse.de>
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 24 Feb 2026 00:41:07 +0300
X-Gm-Features: AaiRm53G7mBkRTZxrmFx_UAZ2LIC8h6oVUqyUREBRtA1_T72X2Ms5uG-DS2L9PQ
Message-ID: <CAPnZJGC0kHEmAqHeTXwbcmuA0GqEOhDmCfjLRPRKff5DsEgW6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] init: ensure that /dev/console is (nearly) always
 available in initramfs
To: David Disseldorp <ddiss@suse.de>
Cc: brauner@kernel.org, initramfs@vger.kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, nsc@kernel.org, 
	patches@lists.linux.dev, rdunlap@infradead.org, rob@landley.net, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78004-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.de:email]
X-Rspamd-Queue-Id: 3B7D317DB10
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 4:20=E2=80=AFAM David Disseldorp <ddiss@suse.de> wr=
ote:
> There are still other options:
> - use a different initramfs archiving tool

I'm trying to solve Rob's use case. He tries to write a tool for building
kernel and rootfs called "mkroot". The tool is written in pure shell
without any C. It should not have any external dependencies.
So it cannot depend on a custom cpio tool. The only cpio tools
allowed are gen_init_cpio and whatever cpio is present on the system.

> - point GNU cpio at an existing /dev/console

This will not work if we are inside some container, such as docker.
Container engines usually replace /dev/console with something else.

> or call mknod as root

mkroot should work as normal user

> I remain unconvinced

I still believe in my approach.

According to current kernel logic, /dev/console
magically works if you use external initramfs and doesn't work
if you use internal initramfs. I simply propose to make internal
initramfs work, too.

> To me it still feels like a workaround for GNU
> cpio's poor archive-contents-must-exist-locally interface.

I will repeat: mkroot should work not only with GNU cpio,
but with whatever cpio is present on the system.

So we should either fix *all* cpio implementations, or
fix the kernel. Obviously the second option is easier.

--=20
Askar Safin

