Return-Path: <linux-fsdevel+bounces-75386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBsxCM85dmmTNgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 16:42:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6E814E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 16:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EB203005652
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F11F3254BB;
	Sun, 25 Jan 2026 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2vqNHrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5499324707
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769355724; cv=pass; b=K3na4+flXEz1GF/lB9T11SRl4RS0LNvYTNhAn23Fo1q9qd2DDeddXQdkMnyPcnWiYhJ5ddYRHQBnVIZ4AWE3GuYaxCpyzv/c3OCeERcYbRzQzu4u206yruWJKkBLrqL++o88U5wYk7wrGhvsXh4Pi1VgEV8/7e6YcLPpkrYyUT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769355724; c=relaxed/simple;
	bh=rNk6ePg/D71f1bVvLdkIMLT2fyEpWH9p+c3WaoD0KpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/7yniJjTk5hKwTzPxwrfI8plk66CFTA7jQ3w9ooK+nb02SySBpvEHvBqh3P6oJaWFZXV4eNBCvqM3dmw03Tf6Hj4UOy6TynpLofLTKfyzdkiARSC92TL4EBNp7Hin7Dz84KXH07t+tbqh+7SjkiHb6SxpMECJVo52MUkWkFZiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2vqNHrf; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5663601fe8bso3290781e0c.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 07:42:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769355722; cv=none;
        d=google.com; s=arc-20240605;
        b=Db6Oml9uc0y4H1Tc25O2cOuDPIQR4+QrjNQadg342ornv78UGwEikJc/PNw2cTFwuc
         7GOduZsAB1wUwY4FlMpJNkoc3pi72T6TwPItUJ9WEZaebp2LcazF/KXiEnwAxiEWIkaE
         oheZ2B6/jLW0sb1kExajRXhwid1D6yyYwGVSyARGDI6f6YrXI5FIXaR9atesclBlvzr4
         NG9JoOCE1bjlYUAjLEs1wzPZVwZkxQ12uiWzTjxriXu0wZvNOOlYAicrF0+i7PAXvJus
         IdbFWT/PCN2fF8RO+v6o089wuVuAX9NDgnSJhpgIGdyHDQOX4txEzseghK88hhRssIbK
         jq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p8tYbUMORQ+mIeOx9diAkXGQUAiatsPi/KGkl/H1Hio=;
        fh=jlAoB5NRf+sckPI+BiLWTGIaMSNTTaiib9dUFTScdA8=;
        b=Wj6h01rO7gEeJhNUvkKoG9jjrrnQCG6rsZD7dz4p8PiPfpBFlo5FwDJubdMd2imAHN
         JNah+5PGwaojXgDtLeq5QcDinjy7SO13llFkUMvBRcyZHvPyernPDZhz7KmtVsdsoCFR
         slQrums60X7ZfFtNz2OpXE3hXH/n9XoGRZeJZykjS91Wk1dpVXL8E9SCTEoDcZoCRaFX
         PQ3yS1xeaUSI7JYDkp8djE9PV88ggjGHiQCYZ+HIoZNh/pD708NpWI3HcbGmX3HO6MI/
         CDFigurOyCJFt0fD7hzmO0TCt0VV53hz+AeI2wB0FbAaG6OA4h+hpYk4jtEmzmcgvZTd
         pJIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769355722; x=1769960522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8tYbUMORQ+mIeOx9diAkXGQUAiatsPi/KGkl/H1Hio=;
        b=W2vqNHrfruApUjJxmSpsGyy+4gVF5IjRtYo3bpYWVXwa/vpW/MBcKqsoeP9UdJRUz9
         byy6Q7SLepR/kXt20pvF/wX+/k3drlQYLqqypmUf4AADMhcxYFSi46AYzaiQ/tV7ZKEe
         P01l+8Ht2+pG5dpp4UsK3fkwDuRuToc8/v0XWps4+sgbKFQvR2NoA25EeSBAnAfGOT3/
         McOUmWmzXmxPQywmG8i1BQLTGuGnRRLeh5AhvjVFUmgSR0pdMK6emoys57sokQAyKF0P
         DVa8tonLLqEJp79tgcr41OwPDQXfLfKLj6lCl8SGj6cUrOAf9eozfZUyi5vP1vJ+8JfJ
         W0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769355722; x=1769960522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p8tYbUMORQ+mIeOx9diAkXGQUAiatsPi/KGkl/H1Hio=;
        b=S8R6qNNhkPTzTb99W7Ana/MRVvHaW6sAM8fzEcNSKISF+1zkGQGHUq99+qYSe/FWt4
         cjg3g9Qz1y8zQJBA/vxIjKmFCtBcEt/qgc21m2cUdMewueoNEAbKgTWNrfFWF8vW8y36
         iUiKF64UMII5tDor5oys1S7dp92a9lE17L+o9rIxEQNYtCwc0jq4wR5i+ptWv0qSJ9Nl
         sW3NiDi2pUUOGvDP7sBipVUEOsDVHPzLyGGlcT7QOoeaokUfiDzmD39+1H5jULsO21No
         JUy8R4HMvduZxXkmclCd5qgRnxdoEI3fRcizGR927WhLAQXgQTZNSbUUfhqSwoXAEDrC
         K4Ow==
X-Gm-Message-State: AOJu0Yzu65PTb1HvMR34uaVHro7lETV63CCZSrrdJUzXjmhngzsZcpTW
	Wxsx/K2Xgm76/E7FqfXnzr4cxCGnxbZoGHHdBnSEETEKmAiUSzetLCCsQjBo1Y1KkGkLqLvwcic
	C2ckQXAugkkgCrJM82kRFOdUK289NXiI=
X-Gm-Gg: AZuq6aJ8Plv63HYXZM/mmVDmuJsjACKHdxczjnHNTEg4FI45k7NKeg7tya0tYzhII4t
	prLqp3ysOT9wObcaiaSC+kd5MdxzwfZsygMfuQS1pdfcvfWWwwQ/cKg+PwPoq+0rRm15yjK8IoN
	aSsEnsRMiGcy/rCzNNDC78k7D3XFYLu3BnVgTTP7VId179Gs4wJvyjHsFqBwHiaf+SfMkaqmxKI
	NsJJeESilFG5SboYh3E5L9DrycyYnuJfdKwZn3HNOskuhCA0D8Wpxmmy3cyJcEMzFUga5h3jHEd
	uNQnK1cjnM3nw+Jz+MgxnNw4rbCFhLw=
X-Received: by 2002:a05:6102:290a:b0:5f5:37f6:2b30 with SMTP id
 ada2fe7eead31-5f57634edb5mr546757137.15.1769355721735; Sun, 25 Jan 2026
 07:42:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125141518.59493-1-dorjoychy111@gmail.com>
 <20260125141518.59493-2-dorjoychy111@gmail.com> <57fe666f-f451-462f-8f16-8c0ba83f1eac@app.fastmail.com>
In-Reply-To: <57fe666f-f451-462f-8f16-8c0ba83f1eac@app.fastmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 25 Jan 2026 21:41:50 +0600
X-Gm-Features: AZwV_QjkcRbssqctRot0q3M2s9Vsa7Wbv5qofxF2cNL1HFmTpgJVm96Xg9rRJRM
Message-ID: <CAFfO_h7ttQPVCR-yQ_=h4BLoHYW3QZOWQ+oSNSFvY-7NOxxeHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] open: new O_REGULAR flag support
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75386-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 76C6E814E4
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 8:40=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Sun, Jan 25, 2026, at 15:14, Dorjoy Chowdhury wrote:
>
> > diff --git a/include/uapi/asm-generic/errno-base.h
> > b/include/uapi/asm-generic/errno-base.h
> > index 9653140bff92..ea9a96d30737 100644
> > --- a/include/uapi/asm-generic/errno-base.h
> > +++ b/include/uapi/asm-generic/errno-base.h
> > @@ -36,5 +36,6 @@
> >  #define      EPIPE           32      /* Broken pipe */
> >  #define      EDOM            33      /* Math argument out of domain of=
 func */
> >  #define      ERANGE          34      /* Math result not representable =
*/
> > +#define      ENOTREGULAR     35      /* Not a regular file */
>
> This clashes with EDEADLK on most architectures, or with
> EAGAIN on alpha and ENOMSG on mips/parisc. You probably
> need to pick the next free value in uapi/asm-generic/errno.h
> and arch/*/include/uapi/asm/errno.h and keep this sorted
> after EHWPOISON if you can't find an existing error code.
>

Thanks for pointing this out. I will fix up in v2 along with other
comments (if any). I looked at the existing error codes in
uapi/asm-generic/errno.h and didn't notice anything that I could
reuse. So if I understand correctly, I will need this new error code
in both uapi/asm-generic/errno.h (not in errno-base.h) and in
arch/*/include/uapi/asm/errno.h (I see some parallel
tools/arch/*/include/uapi/asm/errno.h files too) just after EHWPOISON,
right?

> > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generi=
c/fcntl.h
> > index 613475285643..11e5eadab868 100644
> > --- a/include/uapi/asm-generic/fcntl.h
> > +++ b/include/uapi/asm-generic/fcntl.h
> > @@ -88,6 +88,10 @@
> >  #define __O_TMPFILE  020000000
> >  #endif
> >
> > +#ifndef O_REGULAR
> > +#define O_REGULAR       040000000
> > +#endif
>
> This in turn clashes with O_PATH on alpha, __O_TMPFILE on
> parisc, and __O_SYNC on sparc. We can probably fill the holes
> in asm/fcntl.h to define this.
>

And for this, I will need to just define O_REGULAR in alpha, parisc
and sparc too, right?
Good catch on the sparc file, some are octal, some are hexadecimal,
easy to miss. Thanks!

Regards,
Dorjoy

