Return-Path: <linux-fsdevel+bounces-79484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBtVMHN0qWl77wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 13:17:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB7B211771
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 13:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 753B23084F06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF44F395DB8;
	Thu,  5 Mar 2026 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+Q1rFVX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D81E7C23
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712970; cv=none; b=mDD+QJjkqCCYa+OQHErSUYGEiJtA49rAKKMZJEuF4TBPsYhBFkGhVLMgaYEwyV+cGAHr3Yk6d/sxE1gKmGPSl9gtHBCcAUyXufCE7tJ1i1YTvhdCxdnIUNxk4O4qbVCxnfq844MzWyp3VzVIAhhHcDg/9yfX2FUOUVIc2uPSP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712970; c=relaxed/simple;
	bh=aiQ1glvuDqvF5It2qKpBaW6NuMv8+Rkj2G8i9nJKvx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXTVkLAz1LNjYK4DaDsiD94vp+crDFYV0YDZK+YEfyLgfPpiyh1HthczDciQ7ZLnzqIQQR1KlAhqe+mWBeRQqhgtggyzrFe7z+rHfRnL1LW/SCqUqe3LPjTFHRKOfwOZ3lYJK6YZAHohnPuRLnbRsG5N2EYCY4/hu5QcKi6yojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+Q1rFVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52A4C116C6
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 12:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772712969;
	bh=aiQ1glvuDqvF5It2qKpBaW6NuMv8+Rkj2G8i9nJKvx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t+Q1rFVXncEM4q4XOj8ItBqDgBsml3RnF1f7L60HI/KxctukA2S8LUVPDSmucWSrm
	 FCse3ANdsCKxRqad8V4WWgs190bVZ+MZo/fNQFi+pK1zUHiBBRA/4RKgXkwVrq3FBH
	 3w4TRBYo+pB9bFO+HQ3kcwJN19y1xApJnC2XFhRig2l6W5Wo+4X/xI2aZJ1GGPKmSH
	 fXCHxcmMlJX10ql1xg10zZh5tBwFJSn+Lri9tqPMg/0dpLpRGfF/kL9aXOvdMf3t8t
	 NvjlsJUe/CdPjpe7iL88OxJvHeqeE0V6gL4xzAlzKoTomNKu4cyF3V/S014YiQDqrM
	 KYm8GrE1riuVg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b904e1cd038so1070935666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 04:16:09 -0800 (PST)
X-Gm-Message-State: AOJu0Yz9scdu1zwrBWX9/LTU5R3BXju5J6e/HGlJs0cAt2lZVBfct7b9
	3aT9uYucDqdBVylS30HitKaZFVs1VW5suK79FwqjBMOv4X2LxPYHlVrBfrfKfUVgWYNYcTHl2Sz
	b6ny521xcH/wb7/lsvbOjEImlZpoUWQI=
X-Received: by 2002:a17:907:9302:b0:b87:7938:7b77 with SMTP id
 a640c23a62f3a-b93f138709emr323473966b.30.1772712968455; Thu, 05 Mar 2026
 04:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303031409.129136-1-chizhiling@163.com>
In-Reply-To: <20260303031409.129136-1-chizhiling@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 5 Mar 2026 21:15:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8_krVy_EPEPGwNewkGtmVott2CnZi=JGkpR0djSg6quw@mail.gmail.com>
X-Gm-Features: AaiRm53QEVZGmn2oxLCh_uxibyyW8Mx4zoT9plLex9c9ObpXDyNiU7NXScD1bTI
Message-ID: <CAKYAXd8_krVy_EPEPGwNewkGtmVott2CnZi=JGkpR0djSg6quw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] exfat: improve performance of NO_FAT_CHAIN to
 FAT_CHAIN conversion
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Chi Zhiling <chizhiling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2CB7B211771
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79484-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,kylinos.cn:email]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 12:15=E2=80=AFPM Chi Zhiling <chizhiling@163.com> wr=
ote:
>
> From: Chi Zhiling <chizhiling@kylinos.cn>
>
> This series improves the performance when converting files from NO_FAT_CH=
AIN
> to FAT_CHAIN format (which happens when a file cannot allocate contiguous
> clusters). It also adds proper error handling for FAT table write operati=
ons.
>
> - Patch 1: Add block readahead for FAT blocks during conversion
> - Patch 2-3: Refactor existing readahead code to use the new helper
> - Patch 4: Remove redundant sec parameter from exfat_mirror_bh
> - Patch 5: Cache buffer heads to reduce mark_buffer_dirty overhead
> - Patch 6: Fix error handling to propagate FAT write errors to callers
>
> Performance improvements for converting a 30GB file:
>
> | Cluster Size | Before | After  | Speedup |
> |--------------|--------|--------|---------|
> | 512 bytes    | 47.667s| 1.866s | 25.5x   |
> | 4KB          | 6.436s | 0.236s | 27.3x   |
> | 32KB         | 0.758s | 0.034s | 22.3x   |
> | 256KB        | 0.117s | 0.006s | 19.5x   |
>
> v1: https://lore.kernel.org/all/20260204071435.602246-1-chizhiling@163.co=
m/
>
> Chi Zhiling (6):
>   exfat: add block readahead in exfat_chain_cont_cluster
>   exfat: use readahead helper in exfat_allocate_bitmap
>   exfat: use readahead helper in exfat_get_dentry
>   exfat: drop redundant sec parameter from exfat_mirror_bh
>   exfat: optimize exfat_chain_cont_cluster with cached buffer heads
>   exfat: fix error handling for FAT table operations
Applied them to #dev.
Thanks!

