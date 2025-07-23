Return-Path: <linux-fsdevel+bounces-55778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E1FB0EA61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 08:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2AD3B4CFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 06:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A41248F5C;
	Wed, 23 Jul 2025 06:12:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2642475F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251124; cv=none; b=Ngdd7yz9XzZtojEyK5AVHtOoHz0EQQHe67VD3S8OEZNZiJ/NMGxAaskwu5gQYpypCPqvQTl8UqZO6E3WVTr4fnJJb/egofeb6a+9iw+9xPNnQERoHhoKUgxS1vN7/I+XkQNNAIhGDGvebGS1lRCRTcpbsh3Aij0pup7oOIm0BV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251124; c=relaxed/simple;
	bh=tDqTmRrGYf+4FUlOp2YpmNtT/REU0EBsYBRfsHW12wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD1IAxxiSaOkQXjTXoe2/aMHO+fT5bDSN062adtuwa+UVeGgJUwoNdX8Vyssy38Ppgg8IqtfvzXX2YiVdwmlHxzQZsZtljiTeoqtUdcX7QZj8IeORP5+oDuOpYEmZlaghKsTbLeqTvfLKI9ne4CGOXQAVdBViMZ4O64Ald4zXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6270E227A87; Wed, 23 Jul 2025 08:11:59 +0200 (CEST)
Date: Wed, 23 Jul 2025 08:11:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ntfs3: stop using write_cache_pages
Message-ID: <20250723061158.GA19070@lst.de>
References: <20250711081150.564592-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711081150.564592-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 11, 2025 at 10:11:50AM +0200, Christoph Hellwig wrote:
> Stop using the obsolete write_cache_pages and use writeback_iter directly.

Can this be reviewed and if ok applied, please?  I want to kill
of write_cache_pages soon.


