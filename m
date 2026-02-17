Return-Path: <linux-fsdevel+bounces-77331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJRTHjbrk2lX9wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 05:14:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18107148AF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 05:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 705B3301C885
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 04:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9507C2620DE;
	Tue, 17 Feb 2026 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frU9r1aQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78577A13A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771301674; cv=pass; b=fypV+vtRBXpkNOn4n4IM+ixgmQsBS1dLO4B7E9FJ/8xN+/+wMCCJlaMULi5oeLWQDnC/TXmt87uJs5FxDKwkZ2HkdYJvypZjjdJmcxfkuf4DX17112SbgxcrCONmspC56hXAXGArZHG4INs8/OnP0PGCw6dpOy8xT1ncxtUVEUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771301674; c=relaxed/simple;
	bh=vl73Wg7pS+Ahm5P0YPj+Pe00Z8nc8FXlY1ga54JpjGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RloOgjXu5n9xMYsalaM0y4q8ap373OgXz69BD1T8y+2IFoQoV+XA9TMAjm0Cf/6/iVYpcfYjSLJ2GI8YRAPgDFyuQHDkbVieMn7ivgkQ2zSnYKk+AzIIHV4imXK9+Cnf5iFMa0KVX3eblYbzeOWMeLN1lA06/5pxC97hAoxaTtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frU9r1aQ; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65a26c220b6so5013245a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 20:14:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771301671; cv=none;
        d=google.com; s=arc-20240605;
        b=MZEvTF9M1wlpCqIvlOO4nR9O04DIslSrrFJ1gptv5zca1aprONSo611p+bEsx0jQY/
         nvJQ9TsQ036NZV1QMPOVMybfwCRmew3uM9mwxxaypKzPU/n153x8gxA9jWI3cqUJ30Yb
         KctHaNYSPUfQGJqr9lQIQDb0PAlLY3EomiiTTBhf9l/LZcz70cIKQg1xtgWlmTlT88Uf
         SxNPErQmuBAXvmPjHpPrKXJmE20T0Uc0ubqZMH0BK3OME5Lsy8mojSE+o14UPK6+7MPi
         MigyS3W63TNqJc/FXFRSrrUOCkOahYYBAdKbKetbA3a5dONWQEeUky4wfdpMM9GJ1cxF
         Xkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vl73Wg7pS+Ahm5P0YPj+Pe00Z8nc8FXlY1ga54JpjGA=;
        fh=zQz/6fhs1gaZ7d537myU7qomZKjsVzkHybNh8i8wKNs=;
        b=CmM6d3JuQsEU+y+k6R8WYQw2AVoqQzpwHnJxoQgbGglTOTCo4IgD0z3egscztwtAC7
         xOP45imCBHj6A1hAW523H/YEyFvJ/0gCHzlCROitGaru5eso1Lj3Zh+4kuuyti1IUYOB
         OxE5h6xHPgErWNd+WOzhN/L3HxxUULseJuYKfOjagR+bP+NUeofsGsqPZ5b9ELVIvzdj
         d3f7xgnVORE8khajDWqbV6PqwWORLJGNGDGjwO/4tThw241mMri9gNM6B990VP2BDcHi
         h4KJvOcOaAsg7Rj5UU/ThjrcPuftEAosHAMmXbRCYEfoyacaOLIOxxFCLhSms+Ls+yJq
         q3mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771301671; x=1771906471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vl73Wg7pS+Ahm5P0YPj+Pe00Z8nc8FXlY1ga54JpjGA=;
        b=frU9r1aQzw4+qVjkdlz0wFF4WcsZnuG+7GoE6RmXGgXbKH5XyIT7YRYi9o9kywK680
         MpfuggRA0eNfMF06O8JKzkVMLPJOTPX6TOrjP7n2dos/DC3PfBCyWuuy+Wz+3nSf/KSC
         SXY17n5EqmA1q77NyOBul2ZYU3Sl3jz0wmtro3G+8KT0cXL/bWB1pdvfahwXdLmil/F8
         TsrENVvZnaQdWGghHJebwx1gx1uaRS/fNqOycVBM7LuMPAKcyj66FZHuHiebHgmLkojB
         6KO/FCE/O/yFVjILTpjMcHbEHNVPPgTJLXEtNn9k/KAy9y1mAOwQDjCkmTv7kx4vLLZt
         qBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771301671; x=1771906471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vl73Wg7pS+Ahm5P0YPj+Pe00Z8nc8FXlY1ga54JpjGA=;
        b=XRvIxmPaAXnozoiTYKwlvwtZ9itc0V4RbQCLut6+VOkZTAs3PjmDDPFysZgIHHZoZh
         VmMIIiG4xGfvvgGPt2Fu/a1Uhi0OfxLpKOtiZhhtZihziQ2Ng8Nd3krmo54T2uLuKnl4
         ZtxqxgK9RjIF0GF+lJAEE+4k4wMx+9oQL43kzWbFu5POtB4PP7Joiod4kKZyfhjqA/O9
         oZTaKkRgwgL80/Kex0x5M1FfDupeddpHF1iTEmecLmLUY+Zj5//RjHUciEq9sBE/u93E
         Oz78A4m3qajk98Q2raaFEnCOox7hQNCEat8AW71Rtyo/tR1AaIx+WJx57OpuYuGeRY0G
         WgQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6p1Q1ntZRr3ZCvHrPPbcFvpNaZvcbBcCr6eIW18f9GuR5pIvG7GbBor4vQx1SHFXEjZgUL5jGtyNRZkwP@vger.kernel.org
X-Gm-Message-State: AOJu0YynWYzOrjNcGcV6lYizZw8N1GhAa/5AEdsIv4zZVvG2FRC5cc/r
	Mik7KQpnMbRfT78d+Cof2zcZIjAkFyyF/8SNLpypvxoUk3YiAOl+7NJdc2rBxRXfvaCcZoSyhr9
	h4Z1LlFhdHiFaN96e6Lxqn0kyeM4nEOw=
X-Gm-Gg: AZuq6aLiCwidrh5q7bYrbRm7GKUTemM0ScGaLqio35wBKOqE83wStTSnAsf/yNZJJl2
	3YRoKXj4gxfOx/KaJj/4Ayunrlx73gwvEaB107vOzyyVbX2Cd3cmGg/2Qa8dpeCDE2TBwxd/dAz
	i2SPy1GPMY3n1kOA2J3mkDozlwRzOzCqz90WcwRJ5U7DSMhL/sArsuieu6CfQwKJnA1j4AG4bhK
	XBE5IRHjdnNcIKw5BhAH9xrGiEZDRYr5dtGwivpIRtCz3Rv/OzxOHzPoC8e9z409O60eoP1Cn2i
	vRKhfQ==
X-Received: by 2002:a05:6402:278b:b0:65a:409c:6fe6 with SMTP id
 4fb4d7f45d1cf-65bb1161199mr6549992a12.15.1771301671063; Mon, 16 Feb 2026
 20:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rDxeYKXoCJoWRwGGXv4tPCM2OuX+US_G3hm_tL3UyqtA@mail.gmail.com>
 <7570f43c-8f6c-4419-a8b8-141efdb1363a@app.fastmail.com>
In-Reply-To: <7570f43c-8f6c-4419-a8b8-141efdb1363a@app.fastmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 17 Feb 2026 09:44:19 +0530
X-Gm-Features: AaiRm52qcDduH0WOoiy86XQ-uP4UAzjzDBGWAMpuxDVbnPDCNM8VzO-fhxMilbY
Message-ID: <CANT5p=rpJDx0xXfeS3G01VEWGS4SzTeFqm2vO6tEnq9kS=+iOw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Namespace-aware upcalls from kernel filesystems
To: Chuck Lever <cel@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, keyrings@vger.kernel.org, 
	CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77331-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18107148AF7
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 9:10=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
> On Sat, Feb 14, 2026, at 5:06 AM, Shyam Prasad N wrote:
> > Kernel filesystems sometimes need to upcall to userspace to get some
> > work done, which cannot be achieved in kernel code (or rather it is
> > better to be done in userspace). Some examples are DNS resolutions,
> > user authentication, ID mapping etc.
> >
> > Filesystems like SMB and NFS clients use the kernel keys subsystem for
> > some of these, which has an upcall facility that can exec a binary in
> > userspace. However, this upcall mechanism is not namespace aware and
> > upcalls to the host namespaces (namespaces of the init process).
>
> Hello Shyam, we've been introducing netlink control interfaces, which
> are namespace-aware. The kernel TLS handshake mechanism now uses
> this approach, as does the new NFSD netlink protocol.
>
>
> --
> Chuck Lever

Hi Chuck,

Interesting. Let me explore this a bit more.
I'm assuming that this is the file that I should be looking into:
fs/nfsd/nfsctl.c
And that there would be a corresponding handler in nfs-utils?

--=20
Regards,
Shyam

