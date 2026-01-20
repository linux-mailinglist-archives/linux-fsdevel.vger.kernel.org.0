Return-Path: <linux-fsdevel+bounces-74674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JocFCa7b2kOMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:28:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4112488DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A8477A0D7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07DC43D4F2;
	Tue, 20 Jan 2026 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RAEsCP5u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01842EED2
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920297; cv=pass; b=H0ISA/2Nv0AEhfUloL2cSk1P+Va5YtbKN+AstWsUR5YZB701PEeb/t4nrdIpggLbZEqfVyOLPlkFsbDGwBNwJMBqWdd+mIOVWCajkQTD+KEyO12f2KbijWCsNwbP8pPAviO50Mn39fuCXO1a1WXe9/Lj17CmOaBe2hoAO8uKfks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920297; c=relaxed/simple;
	bh=rz53VO5WEJ6mEttqNh9dmuyaN1HDtXctdjvaFqiWAyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We0JcInWu4AbxNXCc8LUUV++bag73v1Dy9y/HK+62erFMrGlZsYBHew7lejnx7lapyTCA9xWzhFj0w/MeUELlIpepxP+ZFIK3/VypZoZvihoNQmkHgttJXBwr+CYB4d/EzPjIuhlKsXWEqxaH3X77COIg6LDlol2cOlIs6M3C2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=RAEsCP5u; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-501506f448bso31179741cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 06:44:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768920294; cv=none;
        d=google.com; s=arc-20240605;
        b=b6IAbpfghQX3h62txqL56Mj7a39Q9SIB2RPacRjMThZvBRBIegrZoCs0HppzdAhHm0
         wVRGPz1FDPln+fHEMSesloRqHB8PJeOGGQ9ubeACnm7bd9hwJmAZfqLBJ9Ppc50UHsDf
         QDdSsREMbia/7mWYjACASN2NgdGhU6eV7RvG5/T7Of9eL5nETk2qyhkXyT4ACid23MVW
         SiQBRgy+a3SwRwiP1aU1we8xLj0770tT+wHXddsV9y3jFe7zNlA2dm0QYxKNqk/GRG9J
         q9a32QkNRMFdNSrERJsyDG1KGLTL6IxziDgMnRXe7Ooif5qtA5eTHs0vOtcuHXjUe9Yk
         O55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9TI6H3WwESCL57aO4N/M7cKOKDQ2SmqGN3AlwYF6YfY=;
        fh=yOsQdNNLC62puFYlmc7/sSv6gR3Uze9YhJayHXo7L6U=;
        b=a19wjjiC0OMlDWK+/38cGSjyGSMjQNfIlENvIq6QuyLcNauqI4+C60gpTJQhRXUvNA
         WK8hNaGr+L1q2Vnb4TwiR2STbf3ZJxp0uxCLhLhsnYIdUdMATGJC7BgLP6tS/eAbeFcq
         8xSGg6udKdb3xSb84L+4QY4t0q+Gak52YUCN6QCo9rRZU8I8SqHiucvLxvHvAsZ4Q7R0
         YIjK6hDcsAkwyKloQNXE7rox077fhLqIpkOIx+T1fgNYjU+LMMaKMnJJmB/mEbuFUEQj
         4/wu6wNeggQo9ePLQKEuXbJ5AfHvWknyw9EZm+YMYmhvwZSTWqy6JkIBzUkFj4Zqpfwp
         QqrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1768920294; x=1769525094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9TI6H3WwESCL57aO4N/M7cKOKDQ2SmqGN3AlwYF6YfY=;
        b=RAEsCP5uWSwcoqwjgXUxDH8ShyWti1UENOl+fypUwRkC2ol2hwKVPCeKrRBTUkXQvs
         kbwjIbWVkGTVMqYhHJKN5b53WUERJ0dd4nubxVaUnbtizmXJD9xdTU39z6J5qeExq5na
         zkMmhca3udNBBjliEBgzcNeul2H1SgoHnYsb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768920294; x=1769525094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TI6H3WwESCL57aO4N/M7cKOKDQ2SmqGN3AlwYF6YfY=;
        b=dDQQdZY2mninf53u7RDt3mFnOJq9cjLYbf8W/x3+3W++Uc0gYm/WNbjFC7wam47fXs
         dtk7O+BEFmTg+v25koAeBupuHKc4hrCFU5hR0vr48XHX8ShPjQlnBW4mgSzFbZs869D2
         1u3P624B6J91z7d1iOAcmKcr8f/rhMf1sJWsVb46VcDg/slQ1+fci06j8R3G/dARLhGi
         RpNuglzPvtGZjGvA3a5aW/drB7WnK4LCbFr0absPCQ2ALKsz1ln3UZpuBl/wOCRi9x/U
         h9yKq+ATjYH7cuYhwJ6Xc+muXBvja+eGHNE++8wGT0+0sd2tWqI19k/IHyrZ107WIQK2
         csYg==
X-Forwarded-Encrypted: i=1; AJvYcCV50pI91wGUK1JkB3gyDfdzqYoxT4zAdOZz+eYcCjp4PijC36DiADXxxbJ1Px8E0D5ffQfs8b/2AXbYwOeJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxkvKcI9aaR+etTLD8WHargDNzd9Mh78Yv6uORr/Jh4LE1faZS1
	Q2oWnHTsfI23hH71tw0aZQZ4TaeD4X1lY91SjcUL8i2Rb7SGmhbQ4Ouz73d72ARwRXkIJ24NXpH
	28mn9x+SdkWiElm14wokgiTRgkKQ0EfxJoS4bD+7PqA==
X-Gm-Gg: AY/fxX6NDChk6L8fOO1cAKhV8KnFDOyLKYAkmzLynt19YHpJE60r6nnuXBPjQfgMhJP
	QWag2RZwKPlz54yAOY+4ByG1nM44Q29ujXMoSGqH4NmuQEaQCr1uIqbHz+XAHy4Zx5UnokaoNcQ
	JNLTVgLifknBzFaU5A/D/G3hnKVX35e9SVAR1ws++WL/a2dvjrlziK75HFGZcpP0xlhjczb6Kbe
	sTgXjrn4Jvvq8eVgOj5Lhq3K+SPXQ/joSL0FsNWDcg1MA8OF4H2DtV2poqa0P03uyRF7eHAMA==
X-Received: by 2002:ac8:578a:0:b0:501:3bdf:f0eb with SMTP id
 d75a77b69052e-502d850754fmr21826231cf.39.1768920293837; Tue, 20 Jan 2026
 06:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <CAJfpegt=eV=2OxgfiVYG7drw_yN14b7edJhj+bsF_ku7cVGuig@mail.gmail.com> <223B0693-49B1-4370-9F17-A1A71F231EF3@hammerspace.com>
In-Reply-To: <223B0693-49B1-4370-9F17-A1A71F231EF3@hammerspace.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 20 Jan 2026 15:44:42 +0100
X-Gm-Features: AZwV_QhDJIknwKN18eydHboBF4zqKqUes2ycxxJujxBh2JV7RqxmtX4z6Jrqa9Q
Message-ID: <CAJfpegsDTopCcAQzxfqvrMJajfCRt5MnTzEM0oCmVSM=1ik3gw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74674-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[szeredi.hu,quarantine];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E4112488DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 at 14:03, Benjamin Coddington
<bcodding@hammerspace.com> wrote:
>
> On 20 Jan 2026, at 5:55, Miklos Szeredi wrote:
>
> > On Fri, 16 Jan 2026 at 15:36, Benjamin Coddington
> > <bcodding@hammerspace.com> wrote:
> >
> >>  Documentation/netlink/specs/nfsd.yaml | 12 ++++
> >>  fs/nfsd/export.c                      |  5 +-
> >
> > Would this make sense as a generic utility (i.e. in fs/exportfs/)?
> >
> > The ultimate use case for me would be unprivileged open_by_handle_at(2).
>
> It might - I admit I don't know if signed filehandles would sufficiently
> protect everything that CAP_DAC_READ_SEARCH has.  I've been focused on the
> NFS (and pNFS/flexfiles) cases.

Problem is that keeping access to a file through an open file
descriptor can be better controlled than through a file handle, which
is just a cookie in memory.  Otherwise the two are equivalent, AFAICS.

I guess this is something that can be decided by the admin by weighing
the pros and cons.

> Would open_by_handle_at(2) need the ability to set/change the confidential
> key used, and how can it be persisted?  Neil has some ideas about using a
> per-fs unique value.

I think an automatically generated per-userns key would work in some
situations, for example.

An unprivileged userspace NFS server that can survive a reboot would
need a persistent key, but that would have to be managed by a
privileged entity.

Thanks,
Miklos

