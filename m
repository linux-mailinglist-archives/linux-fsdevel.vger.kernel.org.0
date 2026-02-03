Return-Path: <linux-fsdevel+bounces-76192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBjwIXP0gWljNAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 14:13:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC733D9C0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 14:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1149430E128D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9761034B683;
	Tue,  3 Feb 2026 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VshohOzr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D834A3C1
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123909; cv=none; b=W+4B2UUhGA/9m3HIPwujAzR4+Cq7vI6cByQpnEObPAknJPoheNaODu/klxmQAMzR4eHWqi5uXSqKzgdda2JypYDNJ7e9BQx5qgp03Fip0eyY68mnyiPep1HhQtBaDFnm/o+k0aZcbnMEaVL05/A4jtlvUxTifLdYGqnYQl1Sgn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123909; c=relaxed/simple;
	bh=kZ5dxAPfthwjcWaw3N0GX6tqqLPVyisc3mqVluXNHhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yl1o6auXqoR7NQcF5yOE8LDp47PxJMeTteunsW/GRv0nin/M6oihTYNzcf4eoszGkX6SXits68nnD9sqLjs+3Zlie9LSKeC5TeHCzo/nOpvcXzRzpmMrf+yxerM/kZ0eHe3bK2spN0fmTo6QCUzbBM8pPJrk4uqMgcjHE6mG80A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VshohOzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD38BC19422
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 13:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770123908;
	bh=kZ5dxAPfthwjcWaw3N0GX6tqqLPVyisc3mqVluXNHhg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VshohOzrxD6WESBjbGSe5PUs19oi0pKy63miWbijcIvQcCMeG6ZqGK0NoncpixWur
	 h1Z02dxtoRFfrUyVVkaqvqt9AIlBw1fpqd/WQdsC2qczfrHcsgMs01Obtglj8V6jK6
	 Np7FPzt/P8RhOHxDWKl1E+0vU4DMRobg6dZnLGx6js3hyfCwuE9xNMXU91cRigrpba
	 aO1Q+FPtzZeveHPOUniDRlSQyZOFZE2E9o/t2pTBWO3QeUdx10OTxzfE2MlIF0yEr6
	 W9nRTTb3wOCqIPEuWvt4SgF29HMFNEJsgDcFAWsikjWiQZHavgGelQ3kjonI5zMrcj
	 YOCiKQdryDCYg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b88455e6663so815692766b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 05:05:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBQNvHwE5Wu3/19hLGCl956Am4hAeop7teuEKxxi+3b8TrQ5YWUXNTwVe6J/gpAAWAXx6KJjzuv+FJM4TM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv7Lw6BOHIw74WG0JpvSotu5YeS7pax46yC3EUqasYoemeOC1D
	e20bIFF8CbuYwYgqqNz9GpaZjcFsn8peMfsSbPmI4QJIYuxhmW/KV4FfYw3X+p3Xai4AmpNrrQd
	jHNK4j8TsAfZGMZ1pSBIW/UR3ubfUYxM=
X-Received: by 2002:a17:907:fdcb:b0:b84:1fef:329f with SMTP id
 a640c23a62f3a-b8dff5f45bamr1037647366b.26.1770123907308; Tue, 03 Feb 2026
 05:05:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-8-linkinjeon@kernel.org>
 <20260203055515.GD16426@lst.de>
In-Reply-To: <20260203055515.GD16426@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Feb 2026 22:04:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9fVVKNYezuhfX=ZZKNNDY9n9Z3kPMXESg+H3n=27Atqw@mail.gmail.com>
X-Gm-Features: AZwV_QiPhxXY9Fn7PMFLtnLTORkcgTJP3EQKEa9UwrFWbneU6TCQw57a7ZhkJ7E
Message-ID: <CAKYAXd9fVVKNYezuhfX=ZZKNNDY9n9Z3kPMXESg+H3n=27Atqw@mail.gmail.com>
Subject: Re: [PATCH v6 07/16] ntfs: update directory operations
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76192-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC733D9C0F
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 2:55=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Suggested rewrite for the commit message:
>
> Update the directory and index operations to support full read-write
> functionality and use the folio API, including directory modification.
Okay, I will use it in the next version.
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thanks!

