Return-Path: <linux-fsdevel+bounces-75887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO4tIOKbe2nOGAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 18:41:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B45B31D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 608D230098A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 17:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA3B3542F5;
	Thu, 29 Jan 2026 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QshS1DE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF93542C6
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708508; cv=pass; b=L9a5NpNTLE2eZ7X/+K6D3o2k9nVEZuwaHusgu05NNBt1eyc6uuRcknLgYQ5V2l1VX2gfo2r3PRLRIrrU2g0QsaV6Knf/rnj9yt0EyIrPw6cgZS9CWV18qZ3wc42FoYeUjND53HRJDkp3p5aM5tFxjMwJoNJOyDedNIrCx61iwjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708508; c=relaxed/simple;
	bh=/8NbqHnxT5RKiMS0/GkD6tEPsHwxJGkgOeDvilo8E/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKnUDo8HkYyBmRx9Qi5RQh7yCdtzXu3uNwEJsgmupN4LwMHm1IjX1ftEm0tLYkh/Z9Zp7ngjslwWDWgTjB17GBre/wqktSovNtX6T5Nmz1TxSfjOr6GTgOXPFW/ZlHc4/Red6klpXRIIcSlUp3bl37QEFQbhgq6RBlFnefEczoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QshS1DE8; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93f5729f159so729300241.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 09:41:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769708506; cv=none;
        d=google.com; s=arc-20240605;
        b=eJkRfoBNv2NnIA4DrhFFwmEzXYL08fZ28h06pGRNFVS70X73ij/TCtpbadwcDUboAY
         1ehfEvXAaayLOF7uNYNGhl6JsdgI5DPa1Iw/TXp2+2qB9hBZAghZub+M1I5502+9YNWw
         K4DQXitLl9eB0xtLPalnR5JZMMTCo4bkuJI/zEaA8PZsJ0L1DaDZqeQiwfysE6roVPaG
         NH2aJNXdaRVc/CVsvWaOKlC/IuIqOuiYTJQDff4FsNryZY2yFAkh5Wj2uqp6pljbzYw3
         Out+qbiF0lsjUmFd/3TdtsiSrCXF4igAFkkcB7FZqoa9c9bdzkiMQYNHJZM+tooG6E9Y
         G0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/8NbqHnxT5RKiMS0/GkD6tEPsHwxJGkgOeDvilo8E/8=;
        fh=PlVw6/2N1j4C8owxR94IGvIL6pG98x5/2nJQCtbQ3uo=;
        b=PMwh0P85OhJtk9hAkFV6FQT2A37BYGK0gFSFRurVvraCPRpzD9gBgiChLWFXulIW+9
         jToBVIx+TA/QIQfTBYJBOPYfu/eZWpYmamQGqzTvAh3AmTqzeMCygQPl4MVZbbgF22EB
         C4vgEabKWy0lRFlq0+mejISzeZK46o9YDNzFBzQxL+SyZtU6JqPSqXcUsqkLPrDT7gee
         RLmKslT65thOcTwwsk4VLBkULq4xr0Bu3VYdeGmqshglj3PEp0F/ko3qr+VXChuBTRgG
         T8LuHxuKwl6SCppHqCTyiy2KiSdA5QlFdMh1ntVrCQRA6BJ+H8lcQafZ0w+SsAgPXmHR
         j9Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769708506; x=1770313306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8NbqHnxT5RKiMS0/GkD6tEPsHwxJGkgOeDvilo8E/8=;
        b=QshS1DE8UDJsdIeul4bbY6vGxbmENosSF7Kqxn01nB0CzkeaJEHxql6Z99XvO0pTQI
         LULtr/cLRqH5SKuN/9wARVzRPZ5/DTrtTlXrDwN1DW7Qd6v6VGanWpD6LLu1yGMAUYMq
         q6u5csWb+w9uwTuuB7tO0dgd1zco5HMp9/JkPSRDSE5qnx4QguoOIrNKslroBi5M6TYU
         LWqLA3M8k+tekoZPPMV3H5tYVOIu+pv1+8YwKQalTeLG0e6Fw7Sb8bAkvf+f6fwcPLWU
         FvDedIBa+qmzTKl8Da3jCuxVECwBNlAtnUvARPXkBG4aPT+RQX9D8PafmbipXorjCJ/m
         QXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769708506; x=1770313306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/8NbqHnxT5RKiMS0/GkD6tEPsHwxJGkgOeDvilo8E/8=;
        b=hDYGcO04Khkm4uy7plrzNvMPGPUBn427lgN8zOD/ter8M/iBfTuB9UvN8FZLpa7+ga
         d458AMKaYWrt7Qs8PoNfcNUPVPhtncI+g1lwsKPyX1iNBGHbtH75CaE0MnbwmZvkhsT4
         oa4iwKhHHWM2SLuOUR18giujzKCDO1Lcjsh8DV4xAb5BtP1gzp1gjEqTxELgRLLP0b3i
         vhMkykEz2dDDjj5U9kBpcHQ6e6cNbWr7cjHZ1yFHsqvE7adr/mSM+4ig4ycVjvTDiIEb
         I4LM7Yjloor0YfbWSzxoQcjeyErACrhivMWIlr6hhCa0obHsNhxKv/d7nxP4g+eYnuRs
         U41A==
X-Forwarded-Encrypted: i=1; AJvYcCUEkwAZCk7GmlCe3A8l0JFUQ1uaPNO0gzktYSSoPKWCpM/0rieScwf2a0BGf3S1Vm/TdjjOvobSlXx9rdtM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4QZhIGLuoLmydoqrVlNmt6fcrZccJDbT7UDjeA/OKX00BHreM
	mPJlv6I8hyQlg92KSoZNm5nJllYBMbo3G9Fhyg6AXT+Ruj5xmRJA/Fpzz9y2RJxYDJi0OS0/OLc
	190gz5rPaX+eXHVam0G6XksFReCPjfV0=
X-Gm-Gg: AZuq6aJ3Z0ZzcPETvy3Ix24lz62w5uXLtYMpC8x/gvTT4ENttUzGSI+JHFJeOHAdrde
	pUPGVUHF6Plg19hW77+ecWmvS8tG0sM52qh6wpXjoeH2VRcsCJWefzHmiepy0LsJFfWxrjaVQlh
	5sdZy8NuB4XyIMeV1rN3cw/tHz6M51RBKAURWFVInoUd9A2WY2a6cRkYffNqNOAft1QfutmE3U1
	5M3EGHLOeBQTV80MfCU+Ih13gCNRy7M2eM/+fgyyzqiws5o2uXaWpnK4cnTs2EFnRn4npI1Q4HM
	VKZOw2EXXfuR0AYi5Mxq0YrHlOlvHm8=
X-Received: by 2002:a05:6102:cc7:b0:5df:b2cd:12c9 with SMTP id
 ada2fe7eead31-5f8e2620183mr103475137.40.1769708506271; Thu, 29 Jan 2026
 09:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
 <20260127180109.66691-2-dorjoychy111@gmail.com> <20260129-siebzehn-adler-efe74ff8f1a9@brauner>
 <2026-01-29-shifty-aquatic-tyrant-gypsy-9XYQeE@cyphar.com>
In-Reply-To: <2026-01-29-shifty-aquatic-tyrant-gypsy-9XYQeE@cyphar.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 29 Jan 2026 23:41:35 +0600
X-Gm-Features: AZwV_QgUmgRxqGG7u0gYdXkgbsXqlMMg0UM5YE-KsxdJyK7aG_S89R3ER2sYwVM
Message-ID: <CAFfO_h5yHUB5UPzod9fHeRui1GgC4ofVskQB_ZsZQbwgBBf2AA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75887-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cyphar.com:email]
X-Rspamd-Queue-Id: 23B45B31D9
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:03=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
>
> On 2026-01-29, Christian Brauner <brauner@kernel.org> wrote:
> > On Tue, Jan 27, 2026 at 11:58:17PM +0600, Dorjoy Chowdhury wrote:
> > > This flag indicates the path should be opened if it's a regular file.
> > > This is useful to write secure programs that want to avoid being tric=
ked
> > > into opening device nodes with special semantics while thinking they
> > > operate on regular files.
> > >
> > > A corresponding error code ENOTREG has been introduced. For example, =
if
> > > open is called on path /dev/null with O_REGULAR in the flag param, it
> > > will return -ENOTREG.
> > >
> > > When used in combination with O_CREAT, either the regular file is
> > > created, or if the path already exists, it is opened if it's a regula=
r
> > > file. Otherwise, -ENOTREG is returned.
> > >
> > > -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (not
> > > part of O_TMPFILE) because it doesn't make sense to open a path that
> > > is both a directory and a regular file.
> > >
> > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > ---
> >
> > Yeah, we shouldn't add support for this outside of openat2(). We also
> > shouldn't call this OEXT_* or O2_*. Let's just follow the pattern where
> > we prefix the flag space with the name of the system call
> > OPENAT2_REGULAR.
> >
> > There's also no real need to make O_DIRECTORY exclusive with
> > OPENAT2_REGULAR. Callers could legimitately want to open a directory or
> > regular file but not anything else. If someone wants to operate on a
> > whole filesystem tree but only wants to interact with regular files and
> > directories and ignore devices, sockets, fifos etc it's very handy to
> > just be able to set both in flags.
> >
> > Frankly, this shouldn't be a flag at all but we already have O_DIRECTOR=
Y
> > in there so no need to move this into a new field.
>
> You could even say O_NOFOLLOW is kinda like that too.
>
> In my other mail I proposed a bitmask of S_IFMT to reject opening (which
> would let you allow FIFOs and regular files but block devices, etc).
> Unfortunately I forgot that S_IFBLK is S_IFCHR|S_IFDIR. This isn't fatal
> to the idea but it kinda sucks. Grr.
>

It is a good suggestion. I guess we can still introduce a new
how->sfmt_allow field and have new bits (instead of keeping in sync
with S_IF* ones) that allow types and just start with regular file
allow bit for now, right? But I guess it would be cumbersome for users
as an api to use different bits?

Regards,
Dorjoy

