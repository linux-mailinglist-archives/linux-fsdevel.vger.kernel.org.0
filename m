Return-Path: <linux-fsdevel+bounces-33226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF299B5B1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 06:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CE31C2153F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 05:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CFE199239;
	Wed, 30 Oct 2024 05:09:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EBBBA4A;
	Wed, 30 Oct 2024 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730264951; cv=none; b=WnWbMWe03Sh482/LEz1lfGFherjeLRlDC61D5+mcutCAMSsA4zsvTc8WgZLvPl/jAehLYsk3oZIoYjaWHParULl8KsLIsnpXHW8Xtj2x/cjiHwHAkl4Qj23Eq6nEUrzfjqK7eaQVnvYHd8R/q2fiZs0q5ed1mkNoFqwMjpxgLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730264951; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbxftd31j4DWN4NeJGkLdnCxOl687yhycS/8WlAQJnR3gG3TyXgGRnmqBGyoYG5w6wO5O6n3RjhiHsz5kYP0giHz+boyfUx9W+BLkJBa9R7ZW8V5JP6hepPfd+zfP7Wy3NRmNismnNfmlOg2hz6KB0XazyHpxKUPD3A0450fSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 689C4227A8E; Wed, 30 Oct 2024 06:09:06 +0100 (CET)
Date: Wed, 30 Oct 2024 06:09:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v5 07/10] block: introduce
 BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags
Message-ID: <20241030050906.GC32598@lst.de>
References: <20241029162402.21400-1-anuj20.g@samsung.com> <CGME20241029163228epcas5p1cd9d1df3d8000250d58092ba82faa870@epcas5p1.samsung.com> <20241029162402.21400-8-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029162402.21400-8-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


