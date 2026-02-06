Return-Path: <linux-fsdevel+bounces-76589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO0uGmAFhmkRJQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:14:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3303FF91F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05864304DEB9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6E3283FF9;
	Fri,  6 Feb 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR+xHuiq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74127E1D7
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390533; cv=pass; b=cCwkDPa/axEuPxGDmBGswSKXvtB1ZhGI4r64TWddvT+Ipb99SrNPeZnHtXM8dCCKHyR33aNCJ9oJdE8r0xaNhBVgm5BFTxArO6Nef9zEh0CaTDf3clfZGD9UHPGzNSA7nmFvbxujy8neELSXEhCmeM1RmiJFjAWef6gLwxY7j7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390533; c=relaxed/simple;
	bh=FmcW3+jk1TotXNp0abhfHHj1CNo1HgJv38wXpbipRZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mq9Xgr5Q1x/usJsXdBhqJ1gxlf1qnqCQgZ/7b2r4P2H2VLvH/ma+G8r/YS3KuIE9OGePLh0iat8XTVpShmYwvn/9MORy6/UE1MUcsQ+uAmzChD0lrFuUllidIuURFQKDdtwLG3JORTefwNJUV1LIi6RzT3Z2CXUJSqtI0tJlQH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR+xHuiq; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65956402da9so1650271a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 07:08:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770390531; cv=none;
        d=google.com; s=arc-20240605;
        b=cVKpRu/iOHKG67EoQyQOzSTT8KlGpmX4hXxYDOq1cY3uWMs9jpVhPKbYcTZQOaQDv3
         SirmyIAVhHZVxVy95F/4QI0/zoDgbap7uYKCAdxCNbd33rVqEGEXEBz7Le5JbjcuxxDI
         tlLIaalTdkjKnrGxpAuJFDG5mOIzZwLVWVbCVhrq7KM3sRxujHscX4lxWwiigaizpV7W
         E/wGa3LhKcj74eHlcBNhuNSaouCIyfEELlLgWbloh5LEv1DfZp2jLZm7UlMb23PXzx9e
         24Syi6kqN2lsJw4EUJk3uAQ0gfT4EK3UUmccScuh+/mGkTXf2sqNaxc0e0Fat+8LxR3T
         wn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IV2wXVQGGux8HdfCehvXRHDBtsaFVEwot7iSA9nA38k=;
        fh=vN+v+2fkbpJ1Ija77MOiWXAbfg0LfQCkvA31zRXHO1Q=;
        b=DH9VFUUotFDiTBWGLgzNcCL1WeefWBjIa38V+MnZEPpQIJbexaBC9b54Akw6UeVE3g
         4PpZ0VT7k7Tp+kQLmrFlXaraBzleOC9l9ZyKOea3qZjVimfAHCfwln/q13VtPyUIbCzF
         oPaYeWKeFet913vgerPUKr/tIhBl4ZG9i5iVSWpnbwUBPSmGMoEyDdyl5+pIvsyQ6AEL
         j7S6OPJQPk2eNwHt3vZBWNgXCMwPduwkrmvwnZtKM7jXnD6bzh1L3DwiRH7zp0K5ePNO
         X4VmJsshE1cwkFN6iLNASSQ4e0mpflWZagO1TRCo5UFZJQYJ50g8DZLuJ81Ap/k62ruF
         Kglg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390531; x=1770995331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IV2wXVQGGux8HdfCehvXRHDBtsaFVEwot7iSA9nA38k=;
        b=WR+xHuiqvLCmeR7rhyGhO4/EwrBaQa3a6rSz1gf5I28lqTnIaym+sW0J5xNtMzszE3
         SUmp2/WeTD7mcyCB82AoY80uSjupBet0cijyEjKlIO572PNOY/h5PcRSKPib4ab9Z+4N
         /DPXqqAIH9bqx5T8gDWAubblFgKs9+y6pOgNa1a8Ah9HRPPusDwQhE/dgFeQdZcUgy46
         qEmAsWuqWsVREbHBkuG5kzqa6yY3M7PWrk3z4Moh2RJjY44U3Jo4g6IYun742m5n6Pi/
         iRddR11zq+/xH79/rzcLbGQ/Qk2Oa+LmzNUaSKdbwVOVE2YGWoYUzO7LXhaznte2lsU2
         bP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390531; x=1770995331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IV2wXVQGGux8HdfCehvXRHDBtsaFVEwot7iSA9nA38k=;
        b=ADdE0Z+BjebPo+yn7KgQ1einO+vWpbcd3eVfbJdgQwcVYRWHa/s11mab9kH6+Qi8TE
         fuJM0X1NFGTJ/QRxxWn2A/8aLyvzPjcGSIV/pNFTRTjgKLZ2Qei8rXJ3AD3ItQMjlWrH
         a6uBGYIn/DhcdXzH/OgboBnkc5+ANlUa6L+3G/osYoKxc5ak7IsbOgYot6wSN5rn58So
         OjuAn38EMThqR1UJJRPxJ2gEoSXUmw3iCSojjC0mgnx6kYaJ/+++w5BiCd6kBp+nC9tg
         AV/l+CURRd+Eb6L9gy9+fjAnnE7hOI2luMnaIJRvOgg+dlZNjRK1IGprdTZho/d4qZxw
         GNJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt8Zh57cB0Di6VnbGpYTVG++28DVfGZvLTCpu5Cx31rsYaB5bUh6VsmRGKMBDHAAg6drSSoSSQTry2ow/T@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/kSJTckUwbbSczHXGtkB3GSUsRYweQfoofMvzgKeALDwzfEqA
	2rwBo2uVmX2dCDRhV0GhJtrOK3/FKcFipqtPO/9e0EUkX5HkCUmXowxPH1xNsQQDv649batApNn
	I/yu+BbKzL0xMG8TY9K8ghNRJZ7cqPw==
X-Gm-Gg: AZuq6aKnjjOODfyYryFmJ9M1mFwYwiu2Q+FITJNymS/9BJX7fSdWg/QtT76r3te4iQY
	IyDTayzVZ8Re2Rp0z8rs8CPdpMqFeGLDKMFqOTw9I7awOZtKWkDD9Bigr2kIPZDiuKALo4edBQF
	YTVNRt4s0/xU7NPvV4cAM5m6mdsuaqVeeFBLpPsXLRpJztQBESS6NK1teglQA1aspnUtglggUx7
	y0vw+GJbNtvsaDBucSnD6hpyl4cKIov+pXftxcIFDVfxMm1XW8PT+pbqueMw7QdyZaa2ew7jpUS
	yhpPkJcBdHyl83nsh1X/i1d6DPcS6R1VkaYhk1hBjm37/eoeVSNfZ/LoDA==
X-Received: by 2002:a05:6402:278c:b0:64c:69e6:ad3e with SMTP id
 4fb4d7f45d1cf-65984192b46mr1665335a12.33.1770390531549; Fri, 06 Feb 2026
 07:08:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
In-Reply-To: <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 6 Feb 2026 20:38:13 +0530
X-Gm-Features: AZwV_QhSbcTXF1vOFniIsckdgf0WRvSvELPcT6UCzLuL9aGCZaYlbLnCwaCB9sE
Message-ID: <CACzX3AupFeAy0-pPsZ51ixd7qW++LYYjiKBZ3aK5Y2JDrB_JWw@mail.gmail.com>
Subject: Re: [RFC v2 05/11] block: add infra to handle dmabuf tokens
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76589-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj1072538@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3303FF91F
X-Rspamd-Action: no action

> +
> +       dma_fence_init(&fence->base, &blk_mq_dma_fence_ops, &fence->lock,
> +                       token->fence_ctx, atomic_inc_return(&token->fence_seq));
> +       spin_lock_init(&fence->lock);

nit lock should be initialized before handing its address to
dma_fence_init()

