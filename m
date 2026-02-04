Return-Path: <linux-fsdevel+bounces-76324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH+/Dndcg2mJlQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 15:49:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B86B6E7681
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 15:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD7FF30154A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E1C2C08AC;
	Wed,  4 Feb 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnPhJVF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9482C0F79
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216562; cv=pass; b=OoK0FYAxEUE5g3qrwj11v8r8wPDx7I9ihhucmMIEjVdIp0Ky+JmX89BxMNBCHv29nDO1svqJTaLkOSaCZPcNBIf3jIKVdVyv0tfMyJjXAYVKNeyCo0cqzA3XFFuIdd89Hmz+VosGwAm9OmQbBRf2qLp6FIGc2dhf/E+8dgM5HoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216562; c=relaxed/simple;
	bh=Y4LZu8QKoDxQan2rRLck/+luzrXPq1Xsu4TeMZmhNkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vw66crpiVJavqbhUztMuLGr2emXgkifUIdttrU/YWRcQKa84RuNi350Zmvzc/6LbG8k4Lf5tafh5CME5iCClyJrtCPz4CPPqOBbPiVZ/wTHFjNy+dKmn0avZDk4EsSsG+SSqD4j5MuaZlrxwl8+LcxA0nZQwWbYd6Jo2d5cHL5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnPhJVF0; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-649b31e9010so897160d50.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 06:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770216561; cv=none;
        d=google.com; s=arc-20240605;
        b=Nnx25fF+GCtd7rFho9Hl6mux1PdJ/Y/d/cm8zyoZDDBkvFZv5n0jsCAWRsordOgSy4
         Zy8Ec5rGRgm+kGUROfCfnSpQO/5DrP7QaJk7T5YtW+RyPj05g74taB50Bp//Kv2PsC9l
         ym/XkGN4Jn3ckQ/VCxyLuGtN41zVy+XIFVikAv8ot5iybY2YawUk0e0ZFE1XJbH2ia2O
         U7e4WqRnMToR6ToK5oS0Ye6jfvlbYuJ4lER0BqjbYkR4oRj9wYwKpqeBSRVsfMFvHLkA
         wsrYr8GBdNijKOr+pU2MvdQ8mhWAnlfk84qXoALfFO079PHuvZ/mWcLwKx0rzatIY2Uf
         7cMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y4LZu8QKoDxQan2rRLck/+luzrXPq1Xsu4TeMZmhNkw=;
        fh=ChtOuQNq0IDMVhbUnXmECOHiwO+WNi2zRC6KZIJnKF8=;
        b=FIsP9Cm80NmmvFxyK7Aj8nmKDpWPE+56xSs+L6eCMHJgYZvxeLlHq3B7QXgAZn9DwA
         76z53FilopYvL2NduAiG6/n7fiMDN8UISudShxWv0j+i13L1n7r+MzLYNYhHE9IZgzrn
         DTtX5x2vUoaGCkrRuIk6umb8AuXehIjq6ZhQScM2K13BOsiv2Qj1y0LhG7x/JmoG8zVN
         0OWTBaLm8uxsr8LVi+enxhHnxtdupKNN8utn/kIXpuAlOzzVjnR8QwE4Ej7nGiLORjVi
         Ew+/7XoPoowNrDmbb2wzWs9hTdLJiPvseTjvukhh+brFkFCia1By09XqIPE3/CARCg7/
         lazA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770216561; x=1770821361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4LZu8QKoDxQan2rRLck/+luzrXPq1Xsu4TeMZmhNkw=;
        b=cnPhJVF0V+R23MwZvEFDk/kMXj8R57uKAl/fIMrrJ6c5JuL7cV/9oYgpl+RSZ8Cvqw
         eVR/CV2/s4ie+LoLnF/Znp4G8tL1yEhfV2RnuBiT1WbCo8j5UYf15erusx5JANgj+vIx
         yn+ZnZHSqjESVGY3zQGOv4stNlJ9ms2D9yBoazmshnY1AjezUPKb/tcTBBEBcpT8xUpz
         M4PGo4OWWaW1t5goRzttOVE7k1aZ2oEquwJiVkp5mIk91ieWrsqRrvBFzpODfvLkTPu6
         3xhb5mGLNJGlSl+rNjs1eXYtOloaqpgtbFOM+JPWyTv8gnIo3v1dg029UVIJT3O4qCqX
         u2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770216561; x=1770821361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4LZu8QKoDxQan2rRLck/+luzrXPq1Xsu4TeMZmhNkw=;
        b=tAD8OjUCEIoh6btLS8pWrWHddjOKQqibzuk6ezWiK+iqbWA6B6YOLIhWVWq+5XSQ2Q
         WO+mEz1AIl1mteg6bo9baiMzooZSYYZKg47526jvG/yvDdIv77anTTXb8szS6qz8pZBq
         +weUyaklXCefVPy9My8go89AWtauuYv5Ew3bgx8ppbtO7OK49Dorb1kmV1fPYeqVHQJg
         2oIgwi5l6o9F6j8s1yUJ3F529BCENnts3LJcfKpobh3ZpoqTEgokMrzoVlL/7Xouh57Z
         pMpOlGtGvFZIrhmKHpjLIyxSfm5fXA4PEzuRGSMSyaz1fdLXFZuT9Q68A2p5R/vmykaj
         Sl9w==
X-Forwarded-Encrypted: i=1; AJvYcCVxw6/p+gibHvrm+fKdfI5BlGRuGQMedabS/wSK26KheNhObNc8tDYcFr1IoIp8bkozfI9LYOMDvSqiFZU5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2Hc2UIP0qeLXnqw/CJWQyAdWa/Xirds8fZnIHcXREQnjh/L+
	/3duLB5iYFgbjH2MJPUOrWCsmNwzJW5NcnlobxSgr1HOM16KUi2L8/JghOx7Htl7zeEptP3bAio
	5DIQ8fP2CoX446v7ec7LaDrCwnRawTsk=
X-Gm-Gg: AZuq6aLeiFEq6oVuqFHp3xVsrBgJ0aFAFQ14TFUxxhbCha2RbclOw9TwxhlRnyMDVAp
	GcIMxgsHk8W1g7U1orekkAFibUB8nkKTor+I8R979zAWnKr9w6/aZTgJu2VpNuRTNgT809lWb3i
	pPH9Usk29vCYzt3aCb6r36vSE4ZAP8TrZYZfmdfmM1EQCVjlSYVBWmcl1cLeLZNBzF6/JK0/cHG
	sR24C+8uERRl+KUi4iGUgf0HL+YlwZNuwZJm4bi9vNEC3wBYNoYZqPzJLlY/bZzf2/Rfng=
X-Received: by 2002:a05:690e:1508:b0:63f:af33:e413 with SMTP id
 956f58d0204a3-649db34a3c1mr2779141d50.24.1770216561010; Wed, 04 Feb 2026
 06:49:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
 <20260201195531.1480148-1-safinaskar@gmail.com> <20260203-prost-lorbeerblatt-abd2df8c83bc@brauner>
In-Reply-To: <20260203-prost-lorbeerblatt-abd2df8c83bc@brauner>
From: Askar Safin <safinaskar@gmail.com>
Date: Wed, 4 Feb 2026 17:48:45 +0300
X-Gm-Features: AZwV_QggcuX2I10WK2N_MAlIFYH5fFixDaE1iHycnt6z4Zzioth3_9pqZ8ncajQ
Message-ID: <CAPnZJGBUGa=LExdU5KTSndeXPvtfxXo-2AqK_uU4VWi6mXoG0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fs: add immutable rootfs
To: Christian Brauner <brauner@kernel.org>
Cc: amir73il@gmail.com, jack@suse.cz, jlayton@kernel.org, josef@toxicpanda.com, 
	lennart@poettering.net, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	viro@zeniv.linux.org.uk, zbyszek@in.waw.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76324-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,toxicpanda.com,poettering.net,vger.kernel.org,zeniv.linux.org.uk,in.waw.pl];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: B86B6E7681
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 4:01=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Sun, Feb 01, 2026 at 10:55:31PM +0300, Askar Safin wrote:
> > Christian, important! Your patchset breaks userspace! (And I tested thi=
s.)
>
> If a bug is found in a piece of code we _calmly_ point it out and fix it.

Okay, I will be calmer next time.

> > I tested listmount behavior I'm talking about. On both vfs.all (i. e. w=
ith
> > nullfs patches applied) and on some older vfs.git commit (without nullf=
s).
>
> Looking at a foreign mount namespace over which the caller is privileged
> intentionally lists all mounts on top of the namespace root. In contrast
> to mountinfo which always looks at another mount namespace from the
> perspective of the process that is located within that mount namespace
> listmount() on a foreing mount namespace looks at the namespace itself
> and aims to list all mounts in that namespace. Since it is a new api
> there can be no regressions.

Okay. Thank you for your explanation.

But then instead of a loop (
https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/namespace.c#L5518
)
I suggest simply using ns->root->overmount.

--=20
Askar Safin

