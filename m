Return-Path: <linux-fsdevel+bounces-14661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDD687E040
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 22:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78F61F21C76
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 21:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F4021105;
	Sun, 17 Mar 2024 21:23:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8BC20DD0;
	Sun, 17 Mar 2024 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710710608; cv=none; b=h9OA2gJasEpO6mAdPOHtcKcb/XEUgEGEj5SNeLgYON9MyvBEP3inpRu2rQkEZgTugGRjljk76XZGOmgx4FWfvwkeXzDJEevRASrF2hZFoIOE8rVz0wpL6ES1B+094kJZaCpVsNA0HUWct1MBkfxL6hkHc2a9oHcKys03XrMGg58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710710608; c=relaxed/simple;
	bh=DZ4Y9yhwOwcRq5EmqJxcrZqSnpiaKPY+u1NbC60Wx6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGv1d0I3SrMsjZGxDc+C+6GDdao6cav2cQHeGsbpHmrOvgDT9xVdp2utZddGgLP1fNDssop2rejMKqGnWci7ELIkgFR52l705ANsGBJBLQeCAME2/LaGhiEVqN8k0i5cOjd58eud8OYJd4b7PQbD2yTP5FpcRPNSpW/KVbn752E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C6CF668BEB; Sun, 17 Mar 2024 22:23:23 +0100 (CET)
Date: Sun, 17 Mar 2024 22:23:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 05/19] bcachefs: remove dead function
 bdev_sectors()
Message-ID: <20240317212323.GE8963@lst.de>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com> <20240222124555.2049140-6-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-6-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 22, 2024 at 08:45:41PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> bdev_sectors() is not used hence remove it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

