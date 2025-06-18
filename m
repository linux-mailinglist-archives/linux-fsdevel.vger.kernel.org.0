Return-Path: <linux-fsdevel+bounces-52018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA353ADE50A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 09:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8481895320
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDC627EFF2;
	Wed, 18 Jun 2025 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="GD4gxX08"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F8727E1C3;
	Wed, 18 Jun 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750233437; cv=none; b=OxUI7VNcYqAk6mIZ3ySNQtlesC2TPkP10Gt67lFgTNBV+oFctYiRsduHcN91E1suU3CCkyYPsvif0A3Hm4cxhD10DIP1aI8ZmiUcpA6oVdzkpq8HRxgex5UMpHjiAz/c0hissSXmGDv3FpRwa5pRqKl3J9PZy98DMjyRZqcD5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750233437; c=relaxed/simple;
	bh=5zvmr8pm/c+D7APma0KnxH34sVexl6LLCRDgJ5gKzy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPCHaIJtZVVodL+3lsLePqV7kQtSyWB7PD0e6eBs0ag3FwX1sJAgxZrbR3GV/vpjjwOI5kg324fZSHPF2XBQ5PKdwNgbURzXmo2hBPF/D4yQr/uJ23dWujgkTfyYIcxtUC1rTIyyEf8TQs8ehqgb7JfkinewHchJ22u0z5iRC6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=GD4gxX08; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bMbgC2tP2z9snJ;
	Wed, 18 Jun 2025 09:57:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1750233431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h2p7JUo5nzavgmecf2YIy69ilRVITZZedcevH0ZCS9s=;
	b=GD4gxX080G87GWE24uuPcOloUVUJ9XDvXvGOwuyTxAO7x9+Crc2H9JPC129IgTxsfgCtBF
	RmYOPrSXEhVznKBQMihUMK4uO2TUqlMW3i8ASP0vp8w4ESmA3g4DBG96MEypg4YMeiLgIN
	nH6OSHprqU0tyt4RvdF29/bvqSFIdmPzNlDK5402gT2oo3XUf2FW4RlE+GFg7UueqdX3C9
	PMoKrBhh9ZWXKASbHUzmuzk4Cl+bzIXTfiLKU1m1dRZxAmo5NWh8WUckUVnzbj6sRCAs8H
	WwRxGe7BR89vph+MeMN9LrXfUdliCD/i3F56naB/rMSPMt/SMSGomfNFkM/yBQ==
Date: Wed, 18 Jun 2025 09:57:03 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/buffer: fix comments to reflect logical block size
Message-ID: <ji24aaha6kcsemgagfw7expdesxcbrbd2uxxaonuof56xlbzog@sgewqljkd5qd>
References: <20250617115138.101795-1-p.raghav@samsung.com>
 <yq1msa5x218.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1msa5x218.fsf@ca-mkp.ca.oracle.com>

On Tue, Jun 17, 2025 at 09:48:50PM -0400, Martin K. Petersen wrote:
> 
> Hi Pankaj!
> 
> > -	/* Size must be multiple of hard sectorsize */
> > +	/* Size must be multiple of logical block size */
> >  	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
> >  			(size < 512 || size > PAGE_SIZE))) {
> >  		printk(KERN_ERR "getblk(): invalid block size %d requested\n",
> 
> OK with me. However, maybe that comment should just go away? The code on
> the following line articulates the constraint very clearly.
> 
> If you tweak things, please fix the spacing for "(bdev)-1".

That makes sense. I will send a v2.
> 
> Either way:
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> 

Thanks
> -- 
> Martin K. Petersen

-- 
Pankaj Raghav

