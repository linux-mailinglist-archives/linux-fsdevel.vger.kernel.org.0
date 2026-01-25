Return-Path: <linux-fsdevel+bounces-75389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rUuWHB9MdmmNPAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 18:00:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3F181848
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 18:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C08903006B28
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 17:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E28233723;
	Sun, 25 Jan 2026 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAKA0GTL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EAA22B584
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769360406; cv=pass; b=Mwc2OH0b1dQwO+4VBYKmfT0fjs8r2ye0SlOj5FYv10wIbkfZEDc/kXdnvXnDTc1Wow9YHwDfyFftMY0SVshzK9LvCevBV5LSmp+pPefjZCCeqBfA5cQ95SZOcUIT/AqK8SpDKfascoTP691+QYQ6DVzTE1sxY0dxJHuDCmK4siM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769360406; c=relaxed/simple;
	bh=wEUpso/LW09VIlbZwUl7J9gJj/tEje9aOJIqhGatMf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCYLeYgBZwvCBGwfiz4zcIMk0viBUspFWN/U7ADPszhWZTfGyzOtd1pP6IsmIWk4oLsf/6hpnA7N369wJInmNU+gh3mQgmLRgSxnv0uJwp3NkJKko64qOqLVK3r8GUyotK08xiBWsIr4RPnR1UH4M9DkBSq4v1xynkEqcRZe4b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAKA0GTL; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5f53505f012so4251150137.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 09:00:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769360404; cv=none;
        d=google.com; s=arc-20240605;
        b=if+vihVBDaUdxh5yrLnEU1zDM98tE7UyVUHLjOkCe14JIXm5nr8uclMw+3YXeraRUQ
         jvhO8kIm2lDQWKJaHZZvycmwZkXryhlRH0w4kHVbjubilp3T5hY1nwSvqpuC8U9Qw9N9
         UngAbOxz/WEe1UTiXL8c83czrdX1aAmZ9swZsAFQzk0U+vO/hz9umgEG13hZEy2m9cML
         pnejpd7KncL2Sr6Vv4uMeEegp4MPfdeKBS4jsOLW/HesWhslnt8rGOCOiVcqMV9foHQq
         uOBSg1lrWupMPtbJnoNzA2GEAKyZwzKrUc4lNjRR+YpinPA6bRLyHJozhW68erN962MP
         /doA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6LXiSHqJRizU4OV5EHhzOr1JagoAstmUae9zo875oFI=;
        fh=kK0K8xs4gfa3u7cRrYraWarRQGabm5fkWheO/4CGOAo=;
        b=fJwnpVKJh1MQqySTFLpuM6DIydJQpjXwmNM/kfOL/mibiB/DsxkSVbOf7ZhRDV1wU8
         jYy6meDMYtSq12TlE1hRQL7URrzAS1whmFosSVhWSJfX/18HHbeIb+r3gFf3uBKp9QxW
         T9Oghy+AWyz4J9AujyWCWCkS5PpLcp5sqA5T0e/+AjeyR+BVXB+d9x2vI+KYvZK3LOZr
         jF58yEkR/bkgEXrk0E0SIg17nSDqlg9h7fhG3Qv/g96TSkP9pESRge31deoZ3jgOEq00
         gXd9lQIKfLD1CVcZRaqAcJud2hT8xaeJip4jGVBEzYpIFaucA+6G/k9XqIvgI8HPWzEj
         ItWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769360404; x=1769965204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LXiSHqJRizU4OV5EHhzOr1JagoAstmUae9zo875oFI=;
        b=HAKA0GTLKcOr745TyP74pnCzeAhmxwhKg3YaHDAN9kqA3bNYTntG12I6zg2vKy2Nld
         3f2gX5YbJpy2IVIjZ4CTAAuO8A49M9kddpNhalY/N4ibJpJI/csDNSWBCly2OwyN6zPu
         7yPY7zNERWcRqNk1mvMGG95emZnlZB+blcHZ6oeGNNIwh1i8VPcji6055zgL22st4vBW
         A+ClkhtnM/JxAhD5MuU/SxlTP2v/gG5THSvcMiziYJLnHtBJXwIQsUAQgUPQxY9h0lly
         B92M0OX2s7HYHWW+KGmw8ZVtV77mbB6k3QdBjO7LMgRVO+P8VgZorLI4nohd+VvKpWdg
         SuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769360404; x=1769965204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6LXiSHqJRizU4OV5EHhzOr1JagoAstmUae9zo875oFI=;
        b=r4Ps9aAk982HyQZomqJE5jf+Vyd0cFzJD2I4eZUbKB8Xy5th0HtkHkatyPrr0BtKrK
         6zsik4wAph2s+KMKT8AupNjCsKvNwKAwo7Bc6brpy8iqYxzH77HTQubSaCKoczQ/FxHh
         kCg1T5135uFnlCZyk6CPZ4g+ReE6GO2LW2Q9CRHi202OEQ6pU+NkbC7caCGg1E2+i4ta
         Km3Re0JsIdmqVYC9VmiHU/hwENVNzIadI5CghuRCVClw7cGXK91zUiH4mLNbDiuUqDL6
         XEy2Rer8VdV9NWwhTyQ6z4Vex/GholzC53lyxxKrBTIbMPbLXmo94IaP5e6zNtSho3u3
         P4lA==
X-Forwarded-Encrypted: i=1; AJvYcCUe1TF2AHfAuHRhEmR6s4TWVrf9AuwoHRtl9nOE1bRBlVF2Z1djf6zEBUbOg0tMeC2fAzMotkXzxqdgNuhU@vger.kernel.org
X-Gm-Message-State: AOJu0YytmkhfYX3J+eGhqBk103K+27W2Gc2p0yeRMOzMJueRdWN9K/Kk
	t/IPlI93ZXfBwmtmox5n+QOpSy457ZGPROjXFZBE7xgrO5LrHxs5MrPAMPI+f1tYlugecsa/1C0
	zq+NXGMqyeXJd5FrKZlG3bBNnEcliFn6oxA==
X-Gm-Gg: AZuq6aKW3Dh8jXOBoo+8fOgPrAQea3E44XASY7iL3PFeSpDnizQAi+YTkCd5iTnobeC
	yvC5K/SlyuuoVpUcAxpWjpwkWwlGpLgR3c3taZi/0uzhoSdma7L+lhDNtS1tXKsps/7ulEzzaFu
	k0K0yqmlm6Ew1E+VA34bSNZX4eUqaavjaszEkssTyrn1kh/Ehtst3SAeUfEqNPQp/dhmyC8cciC
	CBeSVgPCw5elpijkxPFNaD4Uz9wMuClG1ST2RNSCnsDhrVl2+2YFUSqOe17ivGPbN2hfxwvWTZb
	RjixPBNXzym8iWcIbJc0lcxQjFnUT2M=
X-Received: by 2002:a05:6102:2ad0:b0:5db:cf38:f506 with SMTP id
 ada2fe7eead31-5f576493716mr636015137.23.1769360404009; Sun, 25 Jan 2026
 09:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125141518.59493-1-dorjoychy111@gmail.com>
 <20260125141518.59493-2-dorjoychy111@gmail.com> <57fe666f-f451-462f-8f16-8c0ba83f1eac@app.fastmail.com>
 <CAFfO_h7ttQPVCR-yQ_=h4BLoHYW3QZOWQ+oSNSFvY-7NOxxeHw@mail.gmail.com> <20b25d6cc8a6ba04f77b2518d3d4f0154be58f13.camel@kernel.org>
In-Reply-To: <20b25d6cc8a6ba04f77b2518d3d4f0154be58f13.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 25 Jan 2026 22:59:53 +0600
X-Gm-Features: AZwV_QgB9UQaKVTaojcDJrNqrIzWLtCm90r7I74i8KXVUO4mUgPBeJZdi5s_wsg
Message-ID: <CAFfO_h4OcP4ad_FL43Vx0sDur=7GUUgyHX5DFEFKGtu4LLPBLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] open: new O_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-75389-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: AA3F181848
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 10:28=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Sun, 2026-01-25 at 21:41 +0600, Dorjoy Chowdhury wrote:
> > On Sun, Jan 25, 2026 at 8:40=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> > >
> > > On Sun, Jan 25, 2026, at 15:14, Dorjoy Chowdhury wrote:
> > >
> > > > diff --git a/include/uapi/asm-generic/errno-base.h
> > > > b/include/uapi/asm-generic/errno-base.h
> > > > index 9653140bff92..ea9a96d30737 100644
> > > > --- a/include/uapi/asm-generic/errno-base.h
> > > > +++ b/include/uapi/asm-generic/errno-base.h
> > > > @@ -36,5 +36,6 @@
> > > >  #define      EPIPE           32      /* Broken pipe */
> > > >  #define      EDOM            33      /* Math argument out of domai=
n of func */
> > > >  #define      ERANGE          34      /* Math result not representa=
ble */
> > > > +#define      ENOTREGULAR     35      /* Not a regular file */
> > >
> > > This clashes with EDEADLK on most architectures, or with
> > > EAGAIN on alpha and ENOMSG on mips/parisc. You probably
> > > need to pick the next free value in uapi/asm-generic/errno.h
> > > and arch/*/include/uapi/asm/errno.h and keep this sorted
> > > after EHWPOISON if you can't find an existing error code.
> > >
> >
> > Thanks for pointing this out. I will fix up in v2 along with other
> > comments (if any). I looked at the existing error codes in
> > uapi/asm-generic/errno.h and didn't notice anything that I could
> > reuse. So if I understand correctly, I will need this new error code
> > in both uapi/asm-generic/errno.h (not in errno-base.h) and in
> > arch/*/include/uapi/asm/errno.h (I see some parallel
> > tools/arch/*/include/uapi/asm/errno.h files too) just after EHWPOISON,
> > right?
> >
>
> nit: Can we call this this ENOTREG instead of ENOTREGULAR? That seems
> like it would read better alongside ENOTDIR and I hate extra typing.
>

Good suggestion. I agree. Will fix up in v2. Thanks!

Regards,
Dorjoy

