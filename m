Return-Path: <linux-fsdevel+bounces-74713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDfPLr7hb2n8RwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:12:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC594B173
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 21:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E42FAA17CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 19:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B99346AEEA;
	Tue, 20 Jan 2026 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxJR+jvA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515AF45BD44
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935971; cv=pass; b=HZiGeMqEHP3MT2+4zwkamTLuJot+gY02/NnushQpUd9TB1m+xH+jORR39o6PIdEdp+JmK9Fv5bBv8icjydJwWshX5Pt2qNPEWSx75KejQ0RO15ONm+NQceblE9avs7bGjA4TWSV4Q1qxW2LEaYxQyGCRhYs2mazseJK1a2F66Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935971; c=relaxed/simple;
	bh=PAlrU0YPhRTqQL5vbXglJKRcOFvIvwP1+msIyCpDKjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jn8JM2UnEPhWKvse8PXn+yvZKr7YuJgoPBHAYBY7c7QM1f1wOlEoqOtpbLwQvqhTqZl0uuAbiBU/2NORiQizcRK89WXqRWOxlQ9BFnTR4qT79syC5X+zNcRaj+fo5F8I7amem/k0cUIqAIy0J6roYqC/64y1OdrsQn/J+2TCCrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxJR+jvA; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b6df3d6b4so7130232e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 11:06:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768935967; cv=none;
        d=google.com; s=arc-20240605;
        b=WMDA8YKfmXmHXxTCBzddfzNoRNn/FHnT5PRLqPIQMNvImhrE3awT+wAolq4oKHlmpp
         Pnnn9xkYnPQ4tE9Ls3O0X7zhHYHuQo7BztqJIIVP2UCg3yflAWi+fJCDo7lPZX/EI+VH
         LoFQMNI3m78367RoTRqCGlDGQqFVQO6FTBJRrkgIqgEWmKb9mOMKMCX2n0SDhfxweBxJ
         krY7mvyf1FDGqiQ5lx4R3dgXBdrgo2NKKiYMl+aKwwlYGJsIMdnz5hDC+k3PDYPjgQUD
         St1bVaifjZZs00OK9mz5hBiNGfsqQUtfqccu4BdDDj8KF+QnoWo+C57oQDVpWda7BlRu
         Dttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=58sG2490Nc8wtxrd3CZ8OOBiRjzn8OCfpleiYB8BHNY=;
        fh=5T6iEt5F2CsP030ESXN5K6wk/YS1fN+HqZcIX5zHt60=;
        b=CoqsJvIEbSFnlrWyr+qMNuzxbttxFoV2mQTgydjdj/a5y2WtqxxsKUALwDFm8/X40w
         pDTncW4pUpK8w59L6kYGJxPUR4fFmrc6lhKFAO9IZXDc2HsczEuzOFJQFgqA/pA0/IEa
         CrnWV2KCWuvNRQmKh/Mgc36VoNsEeRrZ3nfiYvDNyurG2SIzNOIyIvIpITefOmlX7/38
         majg1Hs5X9FYle3CWe97z2ZwNeS4vEEujLo5EwbgfS5z+bzBZlCMKOpMrEmw8SnOzqdD
         YtEwIkEB/Mwvr+8wPhQOPiJ0wM2HWig8EqYXg/6H0wflq6l0HgSjiv7PXRb9TNummJW6
         1LWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768935967; x=1769540767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58sG2490Nc8wtxrd3CZ8OOBiRjzn8OCfpleiYB8BHNY=;
        b=XxJR+jvAyKgeGrnRUfY7gsA88JzBZHeOTdR9luZtAHZrTlpBefG31I1i6E7rlhXV0R
         1MECxT+7sJSNMwrrcKiSiTtKM3iBSrarO9OnpNGYlvBD1LySKiZIN4dlVKNz5Q4ggMWT
         D9EvOvQca6//devYc9ItQHnvl94qUOYwBZlbVCPgMO5XHhJFZnJoC6AA8CMBDPDTBVDS
         lR7mM5fM9tEh/twKLSIeougbYQYuI6AvetLo9bXJb5lFn43b/7jTJ4V2C8gvXFPzxd25
         h4me2wkogKnUXLEo5KjxhrUrpb8c2xtPFo7jfbxuNSPLVXTXwlmdKNpwxWQ5Iae2w6Ri
         EWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768935967; x=1769540767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=58sG2490Nc8wtxrd3CZ8OOBiRjzn8OCfpleiYB8BHNY=;
        b=doUvNmSzV2uXF1MeIe2Dbp5HLGICuxY/eNk2pGuRPgHM8otomVMKtAk41kD0oiObvZ
         VSfy1mPVARCeuBjddfw5QRxf/r+CQweEOMnzgM/ENyhCRwcY+e8AtWwy+/2Abe05NMCr
         kXJxZTRWD5t5mhoyrcVqMzYYX0/JiwBk5RbuMg0fgdDTyUwaey7xrgyqRJdzGvNcyuG0
         DfukF3ydizVDFJP0gwk1JtI5z5VkwbaQx+TXdFnm+ptvyW94UnTt/8cwuZ+GKzwTShqm
         OVhAZ/t4SPc13uctlcI15xmze/JNs5xC/PKZBe4/gtHy1gm7sE2la4+rVWqoI2ZBPon+
         FsIA==
X-Forwarded-Encrypted: i=1; AJvYcCU24e6OkWVDjmo9MaYzNjDfQxupor1bYXYM7G92EQHdx1gSQY6dvMxPH5ZddKmKBE8T/xUZXQaHGteydQru@vger.kernel.org
X-Gm-Message-State: AOJu0YzH40L3S5mvzTDBkpQfJW8MMRbqp7iGJklOhHdzPlhVrgB6Td/n
	/tR3ZktLfk5NEgUUVvOMwC7shdq4vLQC44euiICn/ZSfRZ0IdfjkquFMyK8YAyNx9pgeBICTo6c
	Qr4lmAl42hbJ1ZXLvLTgTp7RvkgOJXvA=
X-Gm-Gg: AZuq6aIA/QOquVceo+AplzDQjLm0xIZy0sP78eFvfL60cRxp7aWh3b/E6fl3VP9i+SG
	3WWoQMQ3q3ofbv4GHAP+jpO8H8q8HuKLi7sDmtbYRZXwPxiiF7V+scHclkv5wneXhMrnVpGh4b1
	4+k943KYOca+df2Q86UcSR7JocMLCWzkJe5Uv0kV+uvjW7QBnEe46S4EXb84A/kvf2PcMCWTVAE
	ScwI6qPVlBFA8OigL9QIIWf5uulKEiI/2ycMYkbKc9Z2tV6aAGyZuB2BQR/KSh2bAUqZw==
X-Received: by 2002:a05:6512:3d0f:b0:59b:b32f:2df3 with SMTP id
 2adb3069b0e04-59bb32f30e0mr5515760e87.3.1768935966989; Tue, 20 Jan 2026
 11:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116235606.2205801-1-joannelkoong@gmail.com> <20260117050310.GE15532@frogsfrogsfrogs>
In-Reply-To: <20260117050310.GE15532@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 20 Jan 2026 11:05:52 -0800
X-Gm-Features: AZwV_Qg0I74emV4HUKlaTOi3RMx9PnGAY_DJi2mME-9Pn2MdGMQpUVcxluBgt2I
Message-ID: <CAJnrk1Yf5OJv0a0zgZQ6BV15UPJ4d+FTFVY-Fc+PwNGknh34jw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] fuse: clean up offset and page count calculations
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74713-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2DC594B173
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Jan 16, 2026 at 9:03=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Jan 16, 2026 at 03:56:03PM -0800, Joanne Koong wrote:
> > This patchset aims to improve code clarity by using standard kernel hel=
per
> > macros for common calculations:
> >  * DIV_ROUND_UP() for page count calculations
> >  * offset_in_folio() for large folio offset calculations
> >  * offset_in_page() for page offset calculations
> >
> > These helpers improve readability and consistency with patterns used
> > elsewhere in the kernel. No functional changes intended.
> >
> > This patchset is on top of Jingbo's patch in [1].
>
> As a straight conversion this looks fine to me so
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>
> OTOH I just learned that fuse has a backchannel for fuse servers to
> inject pagecache data for a regular file.  That might be kinda nice for
> an HSM or something?  Though that would be covered by FUSE_READ.
>
> Hrmm, I wonder how well that interacts with iomap... we don't mark the
> folios dirty or update timestamps, so I'm guessing the contents could
> disappear at any time if the page cache gets reclaimed?

My interpretation of it is that it doesn't need to be marked dirty
because the server is the one injecting this data into the folio so
theoretically it should already have all of this data already
committed on its backend.

Thanks,
Joanne

>
> Weiiiird.....
>
> --D
>
>
> > Thanks,
> > Joanne
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20260115023607.77349-1-jeffle=
xu@linux.alibaba.com/
> >
> > Joanne Koong (3):
> >   fuse: use DIV_ROUND_UP() for page count calculations
> >   fuse: use offset_in_folio() for large folio offset calculations
> >   fuse: use offset_in_page() for page offset calculations
> >
> >  fs/fuse/dev.c     | 14 +++++++-------
> >  fs/fuse/file.c    |  2 +-
> >  fs/fuse/readdir.c |  8 ++++----
> >  3 files changed, 12 insertions(+), 12 deletions(-)
> >
> > --
> > 2.47.3
> >
> >

