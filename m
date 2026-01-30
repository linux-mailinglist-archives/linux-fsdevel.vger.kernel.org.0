Return-Path: <linux-fsdevel+bounces-75967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHk/NHoxfWntQgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 23:32:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33514BF234
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 23:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EBBF301952F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 22:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7573038A2A3;
	Fri, 30 Jan 2026 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xSsduIhT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81834A773
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769812330; cv=pass; b=q8vb53GpB4kXLEdkmRYbQqxGiAeznriMaMipmbo4+HnJ/PsoDwib3+N6ppU2t7cUjGxhpvlJlkU6JeXYw0JU9NgNVVeHqjW6266SL5VwP+8xb1AXUjOo1IvIGCKGXb0ws/pgVaqH3tPWAicEbDFHoACyWPJjQk9/jmtSenLKUtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769812330; c=relaxed/simple;
	bh=1L9Z4WjLTMd/nETiB4o0uKotvQN4Rh7dUtNkmBInouo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TC5lYGwERIc4Z4U+oxKDFKWxc5k7ah3jPfSU8dj/0clB1aNbPaDoNXkdArN8wtDmEKPiSt6gt1ybnDMiFuibpXEbLMT+R1xOV5sdPHd9C7o0jS6aWFzzpdSrOLcUFOVWB+UOjHP7XSfjMoY8YdgrmmZ+x72nSHeYNXcW8WN5tSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xSsduIhT; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-658d54197d3so3815974a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 14:32:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769812326; cv=none;
        d=google.com; s=arc-20240605;
        b=Rp1a6wR0bcoPEaC7rz9KTANiCsI/l8nEXTramiD/IYLD44A3WvblwQNmOH9+bvpkAW
         WCNjVZZGED/A8JqHjwCEBiL7DT0hZv65pp3CcgeNBOmfm8ugezERe9uZyH4u3e0QJfF2
         BWuby/QZYQ+HMnV/I9YaiTGP3Tkg9hQ17W0t0Gi0IXQiFNckS7xaEXxBWscNWRS3zVnE
         nWNq1RUUH0e/gky+3y0ZU26pmG40Jh3jgOBuR/b0/aam6mdrLBdclK9SvxbwYDK9OJQs
         s6Y1qx6vFeUuvSOXaeRXp8CLUZ+HmEAibl4AvYiaxJ8fRo3Q59TMdTx7bz2Csfm8LEP/
         aDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V5nbc6oPm8LRFAHxRjfK4s+TrvKdniacoUK6JWeX1CM=;
        fh=Rms7xpd+Y3EBDQlYw1MQXdKdDf2yHZqGEPnKtZi7n3k=;
        b=jPkRBzazyDGOsk8wHwWz7XeKKB69fe9i1d4nJBwsqafqY6x2wWNSoUQ7LEGFVa0gRc
         Y/RY/sxbwtCxvC7Tc17153D0ftTan1qNmeOEHOODbuAy/ednjNGyT9viCNpNUtV3e74b
         UCE1KYOIoJwVAAFUN3oTG/hK7WTcFCYBoSTmsnx6O3k5vla2xrHnoyjwD7MyEChUkYDw
         ojVQiFToFOWHucSeCkIeeiSFrD3hsdRUnCUIt5yJHoOGCZe4DUXLK652o5n/JeAaw06e
         Pq151reo1L5uZIq60A/gVoPhz9Ii9jU1UqRNWUrCGBkh0mVas9RjA2Df9vne0E0M8wJU
         O8RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769812326; x=1770417126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5nbc6oPm8LRFAHxRjfK4s+TrvKdniacoUK6JWeX1CM=;
        b=xSsduIhTCrRwZ3JLNdbKh8tE+MdhFL5H9uFQ+5tllsHBric51bEYgyU7uP/nPJVuVm
         PXBuoZbGBGhd9jC11zRL1GU483f7Fvm6uslzLapeb6QBFVPq0QqUEi22Yh4za+kn63ZO
         VYPzScWvoAqGFSaLLyA8MHrbxgl4Go5rekjKE33pKIWosCL170UwdnhFMbcWW6Jy1nHl
         BTUoIyOiMwtb7w1k7xMz4I30jgy1NoIFY4KeyxuPTUlWRVzku48qag4B+Mw5y3wg9X4J
         7qYXltKRhjuTRa93Kg/i5KMrUJXJP9GaY7mIYlek1UyxtuCoSVeghV/7vYzm2MaotHdL
         Ekpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812326; x=1770417126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V5nbc6oPm8LRFAHxRjfK4s+TrvKdniacoUK6JWeX1CM=;
        b=SNnNvr7E9Lk0BBfjzFYA5hih/xvBaDJnpPsZ8KwzD1CbtgbfRrXuAB+KigIcTZRXJ1
         plMm2AGpqK7q/S9IRhMEkEMJRNAUoKFltTwGaJCT5SehFxiUa63wguVOO5n98rpZkWVH
         IEfQ7GsEpB+TBc6XqQlr1yra2lRAlxbddDJ/DL37iZD2yhAVlnvFxRGQxVJL0y8GPeT0
         pMXHbM67VYBknd4DgWeeoBOn/ZhQ33v3ss8kQNS9VesqALLFsDQmjE6J9L5w8xP1M8Ve
         Y+E/kOCcPx/xqsd1+tHU0WoAQxoGmyJYOI8DC72MHFEF1Hy+E4I8OLxR5T12Xu0jK0gf
         vqhA==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZDQqhSS/jTooAWQcxpc+NS9ueGQARCM0gDKlDcisB0KfMHJh1g9yKUqi2C85dXizXnkjyjp3Srjxj8J/@vger.kernel.org
X-Gm-Message-State: AOJu0YyuiVCfkyVRYNs89AXB23mynPME2GZoxvi+atqWZDJ5ic+p1Kl7
	uLe6qhdYAQ5IqcwsfHVuk9g/rZFrmBBy3JulQryuKtECXRac02TKw25dBP7ti3rlj4SGSJ7Op/b
	P77uluqI2rxrDGoXCDrdzwdWJnTnAr2dP+yEZOUAr
X-Gm-Gg: AZuq6aKKP3SX4BT1mJJwGes1EPRFrzfTONE11AfQsMry04CKAg8z1/yVDT9Ngahl2mB
	kRDn4y+s3YkAEsH9g9/Ya+0/iBCqB+CCe+U6pS2K9ys4YGurqjHddwAbP8PHLINOwwDTt1ubC8a
	vcouPNC5qlHsnEv8MNKJsYNNbkbTLXfn/8AbUXaV7arNj2YEAV2A4J3Qk5eti7aAacWv6zkqUeL
	kbASZ+o9UoiQrWUQK3z86PnW5pdsOycBSTDlrnXrRyLSOHmjJN65deHNzE/lh15yZ7Y
X-Received: by 2002:a17:907:e0d8:b0:b8e:14cc:9197 with SMTP id
 a640c23a62f3a-b8e14cca990mr91520566b.15.1769812325869; Fri, 30 Jan 2026
 14:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com> <20260130070424.GV3183987@ZenIV>
In-Reply-To: <20260130070424.GV3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 30 Jan 2026 14:31:54 -0800
X-Gm-Features: AZwV_QjYrhpLENkXIfDxcZ9u-zvP7f57lE4mcVebqUxFVKgl6ULvCT7XG0RHQoc
Message-ID: <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75967-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux.org.uk:email]
X-Rspamd-Queue-Id: 33514BF234
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:02=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> OK.  Could you take a clone of mainline repository and in there run
> ; git fetch git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git f=
or-wsamuel:for-wsamuel
> then
> ; git diff for-wsamuel e5bf5ee26663
> to verify that for-wsamuel is identical to tree you've seen breakage on
> ; git diff for-wsamuel-base 1544775687f0
> to verify that for-wsamuel-base is the tree where the breakage did not re=
produce
> Then bisect from for-wsamuel-base to for-wsamuel.
>
> Basically, that's the offending commit split into steps; let's try to fig=
ure
> out what causes the breakage with better resolution...

Confirming that bisect points to this patch: 09e88dc22ea2 (serialize
ffs_ep0_open() on ffs->mutex)

