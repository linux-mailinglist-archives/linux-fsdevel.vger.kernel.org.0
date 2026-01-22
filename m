Return-Path: <linux-fsdevel+bounces-75006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMW5C1r5cWmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:18:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E8D65217
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99EA47616A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460913C008E;
	Thu, 22 Jan 2026 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWCXsuZO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5S3K+5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D7F3ACF1B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076798; cv=none; b=P7NwjWYvGNQN1D7Y3N/nemPpYKqywQI1QJhNNWZWD5S2sjaxDRCzHnk5nwx/xymCrO/hJl9UwFU409GBPkj863UBoboQa4d6NPr4BT81hNWnrunvPw9VMhzCdUuwUFNaz4+nPjN6F9hqc97YBtwzDWUsN5As0qjz9cEXLVhEfrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076798; c=relaxed/simple;
	bh=+DaVDwDFTaE2CJY7NQbgkoOai3RZT+Zn59KkM8yLeo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZD+W7Qc9LObm+At/3AOC8A/CS+cAqafXhmiAh0+/bvDM9UhuHVYNVGsuxJ13bzCMKGkUOKpDs81C7/wbgR47Sex8H/QUm5bbtZKpUbLqUX/cvv1cdCVQanG95N64Q/kzMc8kwD/DkoSe9hilPShdE84EP4ekvRwY0AaEBboxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWCXsuZO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5S3K+5K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769076795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3PvjpRuZOnSj4n9pyzBuctSprFCgwIRN8fXSvvKed5k=;
	b=XWCXsuZOsF99mYL8KILDVW2EFbl6CYdDV9JmLRm66EUXI5x7RK9DMf7KhLDja6WSQEaWSC
	XR5GsClxOzplgcBVCAwgyjvQPf0C5KAkCDdqx6a29G7ZBjhJDxGRlPGiYEDfA6/fTFTLHC
	if2vUb5aAQVB2jdv9jCWKO6XlnEN78I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-OFF1GqeVOpK4L26Pp6jUgA-1; Thu, 22 Jan 2026 05:13:14 -0500
X-MC-Unique: OFF1GqeVOpK4L26Pp6jUgA-1
X-Mimecast-MFC-AGG-ID: OFF1GqeVOpK4L26Pp6jUgA_1769076793
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4803a72daaeso6536675e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 02:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769076793; x=1769681593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3PvjpRuZOnSj4n9pyzBuctSprFCgwIRN8fXSvvKed5k=;
        b=g5S3K+5KE9TU90sCN1QAz80NYI66OosJyZHhY+7yAiUx1pPBL4tBu1PJdbZCUucOjE
         BzoWrZeGYy1ajTFZuepFHm2CenYr7g0MuhGf8oFDI5/4vD34Ka8NtNqtbeFBiJk73kT4
         bPe6nQmSaaPs1w6A/ghFYW1Eimk59akp55KoKXak5CKMcMwwBrDpHqIBSRLkg4bLKO0T
         r+X5GIkyiWABZOpIBv90hIWizH7D+CBox3zmKCeRWfniE3BhVuczFs9V7f0TyLXrJkXn
         xXtNbQmArNN2NWrlaONrnGeqP8LCZ9gTEiSIzYyW9zJc+aTA1ic/LxmXoEOLL8qpPOqT
         549w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769076793; x=1769681593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PvjpRuZOnSj4n9pyzBuctSprFCgwIRN8fXSvvKed5k=;
        b=llp894U3LcrBWJfmUrxJN0zSKib3vQI23l8FbPkrxlZoWMY2OFzHdDVDmttSQpb8NV
         OQKjhQNn/yLzBAoaPGmQzgc0rth6AeHxa46aktJWq4IOWebOAi5hMSR9pFkR2VbuCcp1
         kAwALVw/7/QfGUWhZfgZhteYzdvlEK7gMuwryULH0+ZMgbTcJzng7WdMq72MStlrFK6d
         Uz4bDYfwJ8p1tLr+/1WGSOdAF6EiQUrhcS0hhIzsaBOKOp7+7Bx+saXy/HwK7DZdnu1Q
         kGaXARJ/HKrfvOtfeCIng56L1eXjUlSQEbK/XyzaZjPA58A09cV3ByKfT8xHPDCwHAsc
         iK8g==
X-Forwarded-Encrypted: i=1; AJvYcCXvIM5P5NXb8dlINCuggmrnFXW52xGAgf1vm+7LGm79/g0c+0W9Dne/DEKwD7rvNnB8iEB3sma+1RzKRf/W@vger.kernel.org
X-Gm-Message-State: AOJu0YwXur0olqFut2tg3S3SAb5QaFym8YrHwTR9xW4Ku9zE/RtHSvcx
	Aer63HI2vCYJsPRcON2PBkfU54PgZK7jchVxXQ+9w3PV14TxyGIPHzTt37bPnDA2ddXjPToSq7S
	EwHCpsF9J2a8MpkpguvwaJ+oIAvBzb19oLJTnuzfzwkPI1RzX4aUXXpbHXmvaayizlQ==
X-Gm-Gg: AZuq6aJFqu0GLfLJo4I7/9zPlcEjgFK9j/7y/R2ODZlNsq13giF0xNMOK7aepq/qoDB
	bMXv26HynLul2KrNWfW8sIQ6kr+EYwo5eC38+BudjRvRH72F7A2mROsKOy89E8lBmcCcCY+RfGv
	Cp30oO7sEaCFOTN1S2/x2qSU0Ui9SIkH1d15lx6V17EIXtak9Pau+XQO46bX2QlgV/5DgrQoY1y
	8AczvA2v6zQGd907Kgm7c/UHEZ8gSFBZXHfTlPqbEh/aNKZczw0Tqznm5x9D9WsyvigcUZC/x5y
	2CTQHMD+9YVs+XCycRjsUeUdJbVQ2UxbL5rg8KBNU668141zilADOMxPTjxMHXw0VdNyoRMSjY8
	=
X-Received: by 2002:a05:600c:58d3:b0:47e:e48f:43b5 with SMTP id 5b1f17b1804b1-480470d4b5emr28224385e9.18.1769076792940;
        Thu, 22 Jan 2026 02:13:12 -0800 (PST)
X-Received: by 2002:a05:600c:58d3:b0:47e:e48f:43b5 with SMTP id 5b1f17b1804b1-480470d4b5emr28223915e9.18.1769076792425;
        Thu, 22 Jan 2026 02:13:12 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804702fb04sm54550985e9.3.2026.01.22.02.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:13:12 -0800 (PST)
Date: Thu, 22 Jan 2026 11:12:41 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 04/11] fsverity: start consolidating pagecache code
Message-ID: <a3oh6pju5fuodkmhb42o5t7qkqo5oqtwk3nu4wls57p5ihz2rh@q7mt6lpuprvd>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-5-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75006-lists,linux-fsdevel=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: B4E8D65217
X-Rspamd-Action: no action

On 2026-01-22 09:22:00, Christoph Hellwig wrote:
> ext4 and f2fs are largely using the same code to read a page full
> of Merkle tree blocks from the page cache, and the upcoming xfs
> fsverity support would add another copy.
> 
> Move the ext4 code to fs/verity/ and use it in f2fs as well.  For f2fs
> this removes the previous f2fs-specific error injection, but otherwise
> the behavior remains unchanged.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

looks good to me
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


