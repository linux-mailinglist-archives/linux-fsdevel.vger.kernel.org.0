Return-Path: <linux-fsdevel+bounces-79798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN+3CMLnrmlRKAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:31:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9145923BB36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 16:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECCF13089620
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDAB3DA7CB;
	Mon,  9 Mar 2026 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nb3Xuhyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D983DA5A7
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069617; cv=pass; b=ehSFw73qLrIVrMnVzmS0DzT6ihyq9ARnb28orGlK3Sm0pcWGri7gxH59CirJSNUxr0q5F209zfcOVAqUVNBd1N3ryK8C2lHv2XQKHTMxmPmXHyEDj8X/VOKcUXqnBj29HuoGIqeRNRZev2GsJgl71Uu6p18cqM0EXVWqOTbQOIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069617; c=relaxed/simple;
	bh=H5IKEg7YbJRQOBnAbP9gg+sdlcsBSmBL5/oo85fAOCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D52Ltbr6t4JzaaZKfITKhBfDuzh8Fy1TEyxaoOO5uM456xnxd6iTTc9U4YmZJGxMEn9hA9NXezGbCOAIKaeJ2DcaGZB3YydPOhkaD3PacvDKjw4I6ac7Uo1L5EN1EKLNMFfUWKvGxG4M1cfNGjX5UTU3Y1EAMIgTCH2O+0VyMVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nb3Xuhyq; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-661169cd6d8so13199a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 08:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773069613; cv=none;
        d=google.com; s=arc-20240605;
        b=ZHvVg9/eSwGsNyy3kU5iDYEe5oOvcZ1/pzeITS91zf1mhymtLNSzakOQ+xQf4o9tSD
         +0QY/d7Eb4tBzQQB1/uQpGSENxg4upSXFKCHGiOkOIps7F3xDLg2kGEgBCwp+AHQQP4/
         FYBtbUxUHrb6hL88E+4NYpyYqzDI7wk5MH7DQWe5CJZzSjrsziKzTRHocr6U5YgP9h2t
         T1xG0jwm9ahP32VDBIfdPrO4TQHuC3xYtRXDCDcAAi9zzOYLUv5p6dyNtQcWoYwWgI12
         EG5M7dQeqoFG48nxhmkzZSherICMd44DVvt4iZ841lar39h968KYg1ZQpZdj0fGufsfp
         q/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O7Xtjq3WAt00AauKxNCHGU7GaUkyaXCJGSuqsj+jHr4=;
        fh=+/WjqGOODrJjRWEFHLCYnr7yJLLuUBSws8YhyjZh+N8=;
        b=Ag10OR0qk6arVK6wDrOGYzpT2K72ZJWxHJnDvCGgfVHsj5219NIiSuyAt+wCn16I3Q
         7foAuir0vfvuHOQOLloZPlcDnmJxt2HBjlH7zoL2INFAi2t5SDmrP9Ut7LuD68n/Pf/X
         jykNN2njehIxRa0fnA78d6Ehtxh8N3i0nyBT1I72PYIyTgSGu2PDB//QJ1zsKbLFlOwI
         rOV9fHEfNwFCIql6DApaNvUy4Yhp9G+abVsof6+aK0YeE6tfN54D26d/ONUHhJwT5vLR
         mqAJlaRJtvXTLvRPvcwYMJf05sXPLtiYLcDiYpsNQEJSQ8ZkQ+phjtVDMZD0VDVeL0/p
         /iGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773069613; x=1773674413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7Xtjq3WAt00AauKxNCHGU7GaUkyaXCJGSuqsj+jHr4=;
        b=nb3XuhyqRkPoWYBjZabfakvs/EuCZHiaWW0cbqlpgzdkyeJ4k4EqeaX9iiM1jhREz4
         3O1A/QgypWCB+M+diUAs2g1WhFPOe7kMoHolcy97eiPdJPee+huwycHL+hCMx8qw6tVK
         OFKuQAGKo6IVGo1feQkWf8pLdY1uSwlIcqmSulL4x4Bb6R/5r55htEEnHnQIa489QUub
         lEKq4qktQ1UglzgM+B/JZXm+aT8BYvjaO3xz88mGh0GBgu8rmKcUhxHGX1pAD88QdbJP
         pCE2sAgmQevC8UCwxmslUDCZ465WxlOfRF0No+Ga3++unXe9gsTcn2yDJhVcYhc2jG6x
         ZvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069613; x=1773674413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7Xtjq3WAt00AauKxNCHGU7GaUkyaXCJGSuqsj+jHr4=;
        b=kyA9Ibqdv+gorJWZJpqFWYe5LXSwp3M1tvx3i4srlDdR63ljOGDNRd13Xo5YbFhDks
         YD+N+KDovHbAOO4L9dToVm88ZjP95bbxHdupW3EN6X6h22xSXfBy4t0CccGjMz2LCmcz
         KhRDv7W1aW0niCBpwaw8WB9SS0M6Qg7yaiqe5bD+h01ORHC7mNb90PBYsWi+Zq5k22VK
         7G9zpfDe/qYC7lsJdWDhqS/DoBTgj4AQQKnyjFwWnQ4MthW/QZR11a9c6z1FcijahL1C
         PyVlUoCbHD3f9mqcmg14MjburdmHNgXPumvV5rDrm9q9F0W32MIcVO9ZN6TeBLfYSlVA
         n5IQ==
X-Gm-Message-State: AOJu0YyIGgjr2bP6XOVjV3MDiNMo/WD+/wDBafEKRIKwdNUUswDecLo1
	fCDhbNyRzVXKrD82tj70kUB0diV0mwxX/zXBPA2YcfvPMfvnNBpcDkb9P6W7TNgA35VI1Mc99yA
	Wui3I+qr2+gWqVf6YC+YFxJGr7gOVPLC8zrWcyJlw
X-Gm-Gg: ATEYQzxVD4NjgO+PO7X20h9Hf2VJC31bfuvm79RsHgKnYlIco2W/o1P++k7ZfVSCqB5
	wSq6cL4NMDVDrnNqcFotHxxdlFICzQwz34t6Y0RXYE7GL1CmBB1/PhXRYfWZcxnlUSYlcLZjDRN
	VSEPESRzbMKnP6YgyrQ1PcA1gP5SQTD/Jky8YyqHjpn4g2jcU4nYv5Kev5oPmR+O1w8ATAHYjAW
	S+GXh4kCCj76rEtYYEffOXMgfTw6Py9Q+4s73MKBBq/Z+TaAGqnS3S5ZT4/8MmP4Y9iNW524m0m
	OkNsh7lFSWKDLxFAC23rFTb2hrI4nsUBOi3w1g==
X-Received: by 2002:aa7:d5d4:0:b0:65c:212b:6b6 with SMTP id
 4fb4d7f45d1cf-661f5da4ddemr53624a12.15.1773069612505; Mon, 09 Mar 2026
 08:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org> <20260306-work-kthread-nullfs-v2-2-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-2-ad1b4bed7d3e@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 9 Mar 2026 16:19:36 +0100
X-Gm-Features: AaiRm51-Q5v6TxzzyPpaFTXKx4dz26Gd4PPOR7UlqsHpAYHZZF1a-LEa2RyWUEE
Message-ID: <CAG48ez27WdeHPQWeLaz39n62pFaGoqf3oc-st47qv28mgtQg-g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 02/23] fs: add scoped_with_init_fs()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9145923BB36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79798-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.942];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 12:30=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Similar to scoped_with_kernel_creds() allow a temporary override of
> current->fs to serve the few places where lookup is performed from
> kthread context or needs init's filesytem state.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
[...]
> +static inline struct fs_struct *__override_init_fs(void)
> +{
> +       struct fs_struct *fs;
> +
> +       fs =3D current->fs;
> +       smp_store_release(&current->fs, current->fs);
> +       return fs;
> +}

See my comments on patch 15 - I think you'll have to reorder this
patch after the introduction of task_struct::real_fs and changing
procfs to access task_struct::real_fs.

I'm not sure what the smp_store_release() is supposed to pair with; if
you get rid of remote access to task_struct::fs as I suggest on patch
15, it could be a plain store, otherwise it would have to happen under
task_lock().

