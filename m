Return-Path: <linux-fsdevel+bounces-56620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6D9B19BCD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4084177B76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 06:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7053235061;
	Mon,  4 Aug 2025 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OtxvodTt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cnJpHxnw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e02CcipY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RYRHLtbr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3C154BF5
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754290633; cv=none; b=flvDwywGTL3Ip/0F1UKiAT+SIqt4seyLDiJs2MNnIQkbZziTzZNDJbS3OcHWJYE4B1gStDFVFYcxg6tn2XU+8+lHD+HxMbDZS4s5AEIrGZBECsBDfZOgg6B5WC4ZiMSHnddNQdl+f9CrhiqiiYIhC2/9zdsM4kUKpkeknBFuahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754290633; c=relaxed/simple;
	bh=wRD7mlOm9w3DZYz1jJnxwlb5RUPDfu8jWCf6Q/cNMnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9uOmH3qW/ezgtTvvPnBhew5mTXWw8U+a6jHzSktyRNIaSl31sO9jckGroqFIjusm+vt40R/0v44cb86lbmEdGJrpK1e/inkB/rwhDsdPf7WeiNSDtAxbjLATNS6BQj9DHgUwnLkKMDE+FU5z/O7ad52J2A9na5ISNhvYT65ECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OtxvodTt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cnJpHxnw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e02CcipY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RYRHLtbr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 15EFE1F387;
	Mon,  4 Aug 2025 06:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pzq8x6BoCGb4uP6Rqvdrz3/AlWW5+cbRZldMfH80tE=;
	b=OtxvodTtZPbZ3KwGnIiN3ZFAzQHA2oy8ztAV2CWvgUw/kFAyDT0J6HqeWZPjB2j/IsdYcj
	0DgVcWw4sk9sv28iY7xnSzXHY8U1c/QUKsXJgjdGTB2Crbd72KNrZsSmMZTQalob7FnYcy
	wlg6KbBpVSCwMIybE19cUvafBoV6arE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pzq8x6BoCGb4uP6Rqvdrz3/AlWW5+cbRZldMfH80tE=;
	b=cnJpHxnwIsL5qqq57qXOCnipnSI2DNeaZhesd1Jx5Qx9YMOXXZQiS2Ne7MFlOfSpDCelqD
	IigicdoXlmx1vmCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e02CcipY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RYRHLtbr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754290629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pzq8x6BoCGb4uP6Rqvdrz3/AlWW5+cbRZldMfH80tE=;
	b=e02CcipY5lqD0hlPSYa2VqHuPqrPRcQ6Ap+0fju5QjB0HKRjOjoUdcr+zy8htzgSEj89z+
	NinF1+xp/KeE7GhEWfoU3n75k583y9TdBXU/HgKBfI7wlDmktqJOTZ+djpEOGkZ+79KVtM
	kV7FU7icNCKojR6fp7k+DmLkJVuWwLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754290629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pzq8x6BoCGb4uP6Rqvdrz3/AlWW5+cbRZldMfH80tE=;
	b=RYRHLtbrw8wuSZzCpjpPKVU5QDYLuYgcgLidAWqmOt2xrArY6ji7cqWZMwpfgMJTx4/pC6
	/zdtvBt7ICJE9XAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B26FC133D1;
	Mon,  4 Aug 2025 06:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oR/qKcRZkGiOUAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Aug 2025 06:57:08 +0000
Message-ID: <f8f0a124-74f6-4fb8-ae11-c6bce2deb0fd@suse.de>
Date: Mon, 4 Aug 2025 08:57:08 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] iomap: simplify direct io validity check
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-5-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250801234736.1913170-5-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 15EFE1F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 8/2/25 01:47, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The block layer checks all the segments for validity later, so no need
> for an early check. Just reduce it to a simple position and total length
> and defer the segment checks to the block layer.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   fs/iomap/direct-io.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 6f25d4cfea9f7..2c1a45e46dc75 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -337,8 +337,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>   	u64 copied = 0;
>   	size_t orig_count;
>   
> -	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> -	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> +	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
>   		return -EINVAL;
>   
>   	if (dio->flags & IOMAP_DIO_WRITE) {

Similar here: why a bitwise or?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

