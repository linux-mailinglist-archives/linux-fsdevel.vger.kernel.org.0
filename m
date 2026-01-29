Return-Path: <linux-fsdevel+bounces-75866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJEXNf50e2mMEgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:55:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDA8B133D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3254303464D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 14:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E9B332EA4;
	Thu, 29 Jan 2026 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE/vJbin";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n8XZk00q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65632E724
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698326; cv=none; b=HoVuYlRYmqVjGL5YIbooa1MoZkONmkwY/1lrgNWsd/j3PR+iEXdmyUKKeS1aPM4nmwKc2BYn0GcZM5ituW3gmbKml77QD5FmcIMQmicJphueOa4MGQk1Vl26mLbxhWPQ/iQs8c+pKdN8rtNJ3mAEx0nURORc/4nRsKJr7whQ7bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698326; c=relaxed/simple;
	bh=whQFO0imdqg5QUuh6ridbMtxCHkQa/EwXHMd6X70r/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnUU7tJ0INJdz8gsulAHtxE+y9x29tHPWkZbbIJl2KWnIGt6DXdmcpxZBs4g1g5PTvL4Wte1Xnk7xxEw+RiKDfKxpgBC0n+lp8Kc82Qw6LbJodrOWZpVcqpfMeUkG5YbC9M9+TSD5x8t+Kf5eMboswCJ3uBiTz7nzq+dXOA8f5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LE/vJbin; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n8XZk00q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769698323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m31pY/sxRUdVfac4+BuGSMMKkDrCtKZLQDSOVfYYwBg=;
	b=LE/vJbin+vML3GMH8ozEbd+Ymh4W+biVwpOENBcAlkwfaXUZ5No4RrpGMt0sDJzqNKJzu6
	/p2nXMiGdRHLsqsEINhB343v2bYgCiWR38eFf6ROFA3Qe3pIyAtEASRfbfz1o/Ph1MES4p
	Sl2y19jl0MBrZEoDlQ+bT4MVzXFz5yU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-mDWHa40qPcu4om4ljWyong-1; Thu, 29 Jan 2026 09:52:02 -0500
X-MC-Unique: mDWHa40qPcu4om4ljWyong-1
X-Mimecast-MFC-AGG-ID: mDWHa40qPcu4om4ljWyong_1769698321
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430ffc4dc83so1322086f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 06:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769698321; x=1770303121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m31pY/sxRUdVfac4+BuGSMMKkDrCtKZLQDSOVfYYwBg=;
        b=n8XZk00qTMzK2Cjxlcj2wK5j2URV+5RJ/SAOd3zOCAmXtv8T6pxPw4zvyK8Lqjiwwl
         I0W0dfjtEbPO0q+yBazr19sqn2x9WnG7xsaVu4/EX/JjCy3tFDVs0+/YRPPEkBIOYKqK
         yAQKpvJOf7HkUyj8HELQHkQdJn9Ir9EVykf6Q7c9PENEZfAQt1M5y+5WjapZwzwpoG0J
         B9o4nZz1yKSuDiAM8vKSVVDp9Aut8I1xY04DYJxPspjkj0xnyXpXCcZ5RqneCQKSEUyc
         4HG5JkCfu+gz+G+vZBOZtTQJJOzxrQbNKcV5g1tAvejl4yKV3Gcm86SKyU72H5tW1HMF
         goPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769698321; x=1770303121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m31pY/sxRUdVfac4+BuGSMMKkDrCtKZLQDSOVfYYwBg=;
        b=X5JO1kVJ6My9/ljfkx2q2zYmj4kkAbx53yVPQJW6x0uY6HMR2qrPOCzG8U0cLy764F
         xy4C4FXJ1Af6U2W9lCpcULGud4RPI+gr08WSrGSXcIwgCm8YjoEzSMUqxWUde1NUFmDP
         09OE1y8cdwQybYuvZCym6avfKT6ZIWIgR5xviwwd2RmJlVnN8ofmYdcK9b9dcBLiK5oZ
         PkeK7qmuzfi5t4Swe+BDQvljF+ksTF0OFSxE5xMLGxjyYg9bbd6buNzY8MMlPhgV+TQs
         RU8znXhIGJvJ36DL9bG8pCJS7VVm5JZ76dYsqfMDuWB6TBnIj/wFs/hjI/wGf37L9pRh
         JX4A==
X-Forwarded-Encrypted: i=1; AJvYcCVK/QGkF02kM2+XKi3qJHkKn9ox3rKMNr4c2Dc1Yt4leT1NN7TsZmjuRuHMi6FovsXiOnRVhz/PHMtPQaDJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxX3z2kfxcqIxpC/3N3yeD30ChvnXFx22iBi8mKQ3aUlu+wX9Gg
	QWW4MSAMzeEQt0/FMxKX7Xj3NJQjbEiBhkxcWb7aILQWpbCk7/sJbm7Ci7lcABuJRaIBWpWUZia
	zRDUaTdZt0pa68+UIkoXD4Kp5Zjs0E9DTE/uuHbvIyxV079nSMxyqXmqtQ52gMZKMGw==
X-Gm-Gg: AZuq6aL2cMZpaPhDe1LZqypBxGmeaM3OQZv1OlcP3a/L146coOicRJ4zOMVjJh8bgSS
	YlA97aG+sON0eEMzI4T/W+ySUgyt1DBI20dex3CTl8DlOWYkFpXDPrkEdcMzUKaxVFeKG2IxUuR
	Sg2NYfVqG3t2knJFgRLFt0rorCk2Xfv3lx0SYoy8HF3gciemXPCJa7Y+Df/NFrROAcV7iR45htI
	5Pg9OPwTS6wq57wGhAULFthCBU7A9zLOO0zkeaQTx5iVZNfIz0bsE95XrApslWRWUahpGoplPdC
	aMG9g+St//l1gFD+jShcXKouSVM/7tsOAXS1I/zWTztNHej7drOIiTmllN9oQXDFa6z2RPNM3Hs
	=
X-Received: by 2002:a05:600c:4f4f:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-4806c7cc86dmr120529915e9.16.1769698320795;
        Thu, 29 Jan 2026 06:52:00 -0800 (PST)
X-Received: by 2002:a05:600c:4f4f:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-4806c7cc86dmr120529435e9.16.1769698320273;
        Thu, 29 Jan 2026 06:52:00 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5d31651sm5851205e9.4.2026.01.29.06.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 06:51:59 -0800 (PST)
Date: Thu, 29 Jan 2026 15:51:58 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 15/15] xfs: support T10 protection information
Message-ID: <5xaomhu2q2jf3w2hbtkh22dytfiqc6wqyslcfoiqdcwgsud5wk@4ykdof27ntxb>
References: <20260128161517.666412-1-hch@lst.de>
 <20260128161517.666412-16-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128161517.666412-16-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75866-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EDA8B133D
X-Rspamd-Action: no action

On 2026-01-28 17:15:10, Christoph Hellwig wrote:
> +static inline const struct iomap_read_ops *
> +xfs_bio_read_ops(
> +	const struct xfs_inode		*ip)
> +{
> +	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev))
> +		return &xfs_bio_read_integrity_ops;
> +	return &iomap_bio_read_ops;
> +}
> +
>  STATIC int
>  xfs_vm_read_folio(
> -	struct file		*unused,
> -	struct folio		*folio)
> +	struct file			*file,
> +	struct folio			*folio)
>  {
> -	iomap_bio_read_folio(folio, &xfs_read_iomap_ops);
> +	struct iomap_read_folio_ctx	ctx = {
> +		.cur_folio	= folio,
> +		.ops		= xfs_bio_read_ops(XFS_I(file->f_mapping->host)),

Hmm, can we use folio->mapping->host here instead? Adding fsverity,
read_mapping_folio() will be called without file reference in
generic_read_merkle_tree_page() (from your patchset). This in turn
is called from fsverity_verify_bio() in the ioend callback, which
only has bio reference. 

> +	};
> +
> +	iomap_read_folio(&xfs_read_iomap_ops, &ctx);
>  	return 0;
>  }

-- 
- Andrey


