Return-Path: <linux-fsdevel+bounces-66192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16348C18C7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0042F5075E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 07:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A33C30F95F;
	Wed, 29 Oct 2025 07:44:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5030F93A;
	Wed, 29 Oct 2025 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723896; cv=none; b=NVHRb71+rbBSiPQcZUdovGfiMviVLYgQuX/5L3RxAtliYb1XHZnIcco17pyprMYpEMlT0f8bPL4Eb6ninhXmaRklcokBFxm7igT8KG6Kls5AtLBpWFwMrFHP+NIZI30LAF3dLLZaY2TBRGmHVBHFON6x5t6Q6uh3c8tpUqjsIQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723896; c=relaxed/simple;
	bh=re3QNcIEZPb0d1kk7cxbAjisGZnYFOd47y2ZGQcEmEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhclQUyWLl0fs3lCFOUMZLQzSDeXpr9vprhaieHDjO0AMHVWFPL0mkckilmTfnBWTgB6yYZ+vu7NrPZq5Kqy2vrod2S9KOOOR61K61qacIde7bi39kSw0dh8u/vRapkBwt1fpLSaWzurUY6JpCWNUZ+i7LrX0v8dXdQZUZskkJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 34B22227A8E; Wed, 29 Oct 2025 08:44:51 +0100 (CET)
Date: Wed, 29 Oct 2025 08:44:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/4] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Message-ID: <20251029074450.GB30412@lst.de>
References: <20251023135559.124072-1-hch@lst.de> <20251023135559.124072-2-hch@lst.de> <20251027161027.GS3356773@frogsfrogsfrogs> <c4cc53b4-cc1a-4269-b67c-817a0d7f3929@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4cc53b4-cc1a-4269-b67c-817a0d7f3929@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 28, 2025 at 08:11:21AM +1030, Qu Wenruo wrote:
> I'm wondering who should fix this part.
>
> The original author (myself) or Christoph?

Whoever resend it next :)

Unless you want to, I'll happily take care of it.

Any comments on my tweaks in the meantime?


