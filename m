Return-Path: <linux-fsdevel+bounces-76190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCIaCivzgWkMNAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 14:07:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B609D9AB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87800303EA90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3792234D4CC;
	Tue,  3 Feb 2026 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMC1tV7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC64A34B68C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123793; cv=none; b=GTThPoD/bYKQLVkAIJM/hVS/hEV8SYGzBRiGn8U+HgHGwvsQ6/rDPYSatLD5d+GiF977n15VGFmQdfIy1D6kJjmixxlWSDY24tMR6AL6IJ6ofnFkmKBKUmhTUbSh+mVsOPBDi0l1husvAQziARYKKbP2Ypm+XF1XT7QBw9/h/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123793; c=relaxed/simple;
	bh=veP+CJKcGkT7ZrfLafWME85AVnfjBNZczf3e1OcDWN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjmI03I9dnhagb/DiPdpmE1dttnjos5Wsu/tccZr/ZaIW5cBh/2+OIXiJDAzHjoOIZ+LDhfBvaCCNkLmD7MZk/tucVjTF3eTxAIKthTisqbAmNlSVSwrCTFpZLO5ScY0PuJAnbqXSFFawYJ9KYVz7UGdmtkIsz/w/nMlSsk4tIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMC1tV7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1590C2BCB5
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 13:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770123793;
	bh=veP+CJKcGkT7ZrfLafWME85AVnfjBNZczf3e1OcDWN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oMC1tV7L+V6/mHDK51uw63CuJykle5JZSZk7kn5Exbgg1dtDzgXQcdXQEeK8zcFro
	 8Xu63DT7A7mkVdGfu6lvvbTVwm5be0IjXstKtp+BadU5ubX0DDgA5/iPYkpljSb6D/
	 0+YxALiVN54zMBuuHKCe4Gd7wNYEBQxmrysfRD8J1EjG4XIV8J8Df3BO+UiUi+LIpj
	 HBosau1zBMyrrSKdMxx7mHbTK+N4nar4TTDtGwmRUszWB0oCLHIwJRDqboDVhMWQo6
	 6bv2QZkf3Hsu+eAHMJ9VCaOI00gBKgkgaiPRnvDVf/bEJscPGF/H7fjKM2NIL7Cu9W
	 3o/QDUhl/hYFw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65807298140so9406643a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 05:03:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUWYMvSuZPctFe8xb77/Ir4XcX/Xz0Rsj2EvwaFebc6NowxEXNDh8N5/iKELvgHTK7emrvGcxLBpA/a3CL@vger.kernel.org
X-Gm-Message-State: AOJu0YxjjGQUNQDLIFAVC9V/eKB+pRm7vhL8v08qU4hpsGVJuekdfdlz
	U3VxE7Kr24Ih828DI9KVVfkISRWvK9QlGXa75IrLuz6nrKQnPGypzt+9yfbI7uxViVqFll2yebR
	NZ52tUilqB7XDjPJPjrfZZ44mMuFisGo=
X-Received: by 2002:a05:6402:903:b0:658:3838:282 with SMTP id
 4fb4d7f45d1cf-658de58a2demr6465894a12.22.1770123792160; Tue, 03 Feb 2026
 05:03:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-5-linkinjeon@kernel.org>
 <20260203054741.GB16426@lst.de>
In-Reply-To: <20260203054741.GB16426@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Feb 2026 22:03:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-6AZ6JD8S0r1Y-c_Ap=aqneJi+dmr_oiYJjC1O7=7b=g@mail.gmail.com>
X-Gm-Features: AZwV_Qhu40DJCPT7O_T1B5NeHrrVRNoJPzDcLQbL2s3FUspbpaUQbaPkzyOd_qY
Message-ID: <CAKYAXd-6AZ6JD8S0r1Y-c_Ap=aqneJi+dmr_oiYJjC1O7=7b=g@mail.gmail.com>
Subject: Re: [PATCH v6 04/16] ntfs: update in-memory, on-disk structures and headers
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76190-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:email,checkpatch.pl:url]
X-Rspamd-Queue-Id: 3B609D9AB8
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 2:47=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Tue, Feb 03, 2026 at 07:01:50AM +0900, Namjae Jeon wrote:
> > This patch updates the NTFS filesystem driver's in-memory and on-disk
> > structures.
> >
> > Key changes include:
> >
> >  - Reorganize the comments in headers for better readability. (Fix the
> >    warnings from checkpatch.pl also)
> >  - Refactoring of core structures ntfs_inode and ntfs_volume to
> >    support new features such as iomap, and others.
> >  - Introduction of `iomap` infrastructure (iomap.h) and initial
> >    support for reparse points (reparse.h) and EA attribute(ea.h)
> >  - Remove unnecessary types.h and endian.h headers.
>
> Key changes include once again does not really add value here, and
> a lot of maintainers hate the "This patch" wording.
>
> Suggested alternate version:
>
> Update the NTFS filesystem driver's in-memory and on-disk structures:
>
>   - Introduce the `iomap` infrastructure and initial support for reparse
>     points and EA attribute.
>   - Refactor the core ntfs_inode and ntfs_volume structures to support
>     new features such as iomap.
>   - Remove the unnecessary types.h and endian.h headers.
>   - Reorganize the comments in headers for better readability, including
>     fixing warnings from checkpatch.pl.
Okay, I will use this in the next version.
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thanks!

