Return-Path: <linux-fsdevel+bounces-75478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHzYAoqRd2m4iwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:08:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0C48A7E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 169C6303389A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A6E2D9EC2;
	Mon, 26 Jan 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIdwD0Ip"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD62D248D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443685; cv=pass; b=F0ZcGTT3fmWUQdEoz52M3duB579LA+R6fSOPhZeKx2/jIs6ksoP8E2uLapGD+ALy/JZakqafKXQ15KzD3DU1QbvxuWW6VEyiFjmJJ1cqLPlN517EbUKfolmJLo2ZH/M7+2qt3JlV2X9seHtwzkgAXTmK28wuzvlxUHp/NogfpLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443685; c=relaxed/simple;
	bh=3k9Z+0VKRnzeHoKxC/OGAP4uOCqCPQ9FHq9QQWAjhIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3u8vKIfF6S0aTdINzBtyCwM8dHLeRWXBcnb+WOoonDosXgl/mYMuadW8EdxWP0GZGEyua2yTbyHxZdI9EHBI0b554G4i6s+4HZtQYIv5bOLSgbBQNUi2A8z887bwYsN5fRW276mXa2ULW+G3RMpTMr5x5Hy4HORPzq4hOJzYQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIdwD0Ip; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5f535ff78abso3805463137.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 08:08:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769443682; cv=none;
        d=google.com; s=arc-20240605;
        b=gAiYIS55V808xfxKdkhYpV+Vf19Fytf/1Mlxue4+xLxv0DMhN4IliSi9d1yZmphzRl
         tgR8HfjRsNP3zEleU/9D9q2tvhWcxAcVTDPO5SvNDwJUNZ0VrC0YNWw50AnTZWz9ozPM
         ZRlPB7qgHu9N2u/xCznqE6UovS0am8d4s/WdkWMthdKtHcQFtoe7ZeL9aBRgRgS2WQCb
         GXU6+thNI60AYVbFlWMbVj8kbVIps+nsmmkijuvEXcwrs678V3H6xBz/ChcWVYFZ+iPR
         XE7HpyJHb7HtOqb2O/HxmGSFKXLAHnEDKEceRCQDe8AaueKQw0bjBxvjyfOKS9EeTnUJ
         YYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qPIgCo/ATii9cdA7BjleG/QUmh+mhPfQoIzdlGN3WQ8=;
        fh=jlAoB5NRf+sckPI+BiLWTGIaMSNTTaiib9dUFTScdA8=;
        b=VDd83MgGUTlN2MeVLUikvCazUV0TE9+yYwXOjSF6FgwARmPGRSnNE+3MF8p3xxo0U5
         X/tPeicYNAlsxvalTRnb4njRAxpzWnzXK/b0a+EIAIb+DrJdvXMk0jH8wnyH4TX5fQnH
         W+5XFuto2j2696BFVYFetTJjh9r3pGpn7eVcYLZ/6rSPJtHLBNQvCRD0hNRyYx7U8l3e
         SQivgxecgNSMtaiE3EV19ncdJVR9Tv6EbbgPuhoWpAWWhvK2YeOSX7nuMFMIyLMkzkRy
         hQdpisrEgKGF70QKVwVkj2meKA+4UA0WHszFnA5ihYaj+EsjdwCoa8ZKRp53SK9wmONH
         bdfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769443682; x=1770048482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPIgCo/ATii9cdA7BjleG/QUmh+mhPfQoIzdlGN3WQ8=;
        b=OIdwD0Ip8B9aEEUOFNNE1hBGldhuFpubE1Pdt2I6hG8/CrGKmfiOs4h5UNt1/xFFKo
         JR1NhDnwR7Cak/1Jbi+YvT8b/8ZenyaQEhCDUwgb6d3OW6bHAZJAeH6kDXFDW516eIWt
         pt7I8eGf7ry4xktPabWjmvzen8IRjND3YrNIf9gR9BHMrnVEu3aLACskonOGRxVFKJ+H
         zAX5GgYZV+StDKd2yKq3NhyOcxboW1+yg2YTJoa3YK0a+G2SrhY1P7SO4vQwEEx/25T3
         NFAWD27scJI0K3siZ4mvyKPu2BW9WMXkzvXhCja/7bOz5jTBmGT68oohCucKM+hvvfJF
         9sYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769443682; x=1770048482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qPIgCo/ATii9cdA7BjleG/QUmh+mhPfQoIzdlGN3WQ8=;
        b=oFsJ91+cQkGyWptU8P/6hJwxVOWfwjab8Ww/qcSjmWol5sB1bwBSuFr2syPuBpZmEZ
         giHJLF3tGNa3s+yXMNJNh4yNyQc5s1xKd8yC+j1PYzQuRwhJkytB/Twu+tpkMbans1ob
         fdApnZMeav9LpKMa717+mVdJX6FyuCMhuXP0xXkJypWkfuyCUbeNES+K4Np+01DGsqsK
         onrrMOoKKQIbuKCTxW9US3o9cVdMMjMpvjI+/7QQXpZwQiQs4VIfKzllU4zCD2Byclwb
         RBUC0u3Rsxk/Y2IE/HlTSeiCqvr7FMzciRY7eOunDX7aNLyyv3N0poMJeymJw4CkvAkj
         L+dw==
X-Gm-Message-State: AOJu0YyshSgyWuyPoC4ks5NErl+0yUkr3xZlBawFqCU0qb83kDQ/dQ+G
	et+xc00m3dGB3//6Hjrd68ogt4DqEx6GvrhhR7xOfcGZq7yd8o+w3DO7Crg6qgRMA1J73bpA5nz
	ZzdDbT3cceiUiVSLA+K8X1z6msWVcgFA=
X-Gm-Gg: AZuq6aIvG7JDrjEG/4xyhgkb9mU3VhG1dPtlZMLnPjw604W4KrXLYCsE8Yl7Y3JGXrq
	nzs9ocT5A2id+Iu6T3Hqk6qjObkPSC639p6y5hoVrIqweLW6YHbUfde22wrPG53XQROYLGxQder
	qTprItAQpgmsR8MP6ghHS/FPYHDSqzFbvhsr0/SeM4T/yxjos3F9zq4yBBCqd90YtbiKaMzScM1
	yB7Z+0BxRrfxzKKR0cexIl8GYRux42dyjGOG/hSBMs5GWiigskct86pxj6anTuEvt/Znze2yVVu
	76o3nQWPba++OaibhNm9OF25D8k/lMA=
X-Received: by 2002:a05:6102:510f:b0:5f5:320c:4d36 with SMTP id
 ada2fe7eead31-5f576548a2cmr1402936137.40.1769443682295; Mon, 26 Jan 2026
 08:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126154156.55723-1-dorjoychy111@gmail.com>
 <20260126154156.55723-2-dorjoychy111@gmail.com> <6c9d7f9b-36ea-4222-8c10-843f726b6e62@app.fastmail.com>
In-Reply-To: <6c9d7f9b-36ea-4222-8c10-843f726b6e62@app.fastmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 26 Jan 2026 22:07:51 +0600
X-Gm-Features: AZwV_QgNj5y3Cz_HMWVvTYHnZPvqbbxyU6zKPiRY1GDThELaIjO4yVmLF5aHJ14
Message-ID: <CAFfO_h6Lm0Tf39ejQ0kRBcQznSNmiS+PdixEi3GhMpA1xuD-FA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] open: new O_REGULAR flag support
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75478-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5E0C48A7E2
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 9:55=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Jan 26, 2026, at 16:39, Dorjoy Chowdhury wrote:
>
> > diff --git a/arch/parisc/include/uapi/asm/fcntl.h
> > b/arch/parisc/include/uapi/asm/fcntl.h
> > index 03dee816cb13..efd763335ff7 100644
> > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > @@ -19,6 +19,7 @@
> >
> >  #define O_PATH               020000000
> >  #define __O_TMPFILE  040000000
> > +#define O_REGULAR    060000000
>
> This is two bits, not one, and it overlaps with O_PATH|__O_TMPFILE.
>

oh right! Thanks for catching that.

> The other ones look like they are fine in this regard, but I'm
> still unsure if we should be using the next available bit, or
> reusing an unused lower bit, e.g. these bits removed in commit
> 41f5a81c07cd ("parisc: Drop HP-UX specific fcntl and signal flags"):
>
> -#define O_BLKSEEK      000000100 /* HPUX only */
> -#define O_RSYNC                002000000 /* HPUX only */
> -#define O_INVISIBLE    004000000 /* invisible I/O, for DMAPI/XDSM */
>

So should I use  000000100 or 0100000000 for parisc/*/fcntl.h (other
files are fine I guess) in v3? I am not sure if there's any objective
reason to use one over the other.

Regards,
Dorjoy

