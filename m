Return-Path: <linux-fsdevel+bounces-14671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B746987E06B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 22:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70591C21628
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 21:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE2720B20;
	Sun, 17 Mar 2024 21:36:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F1A208B0;
	Sun, 17 Mar 2024 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711375; cv=none; b=PmA8WFZcqYgwZQ67HNJPuBQlFWeG+MXQ9YRy53WTn/r+3TOB9APkfScQwm9CwyZlgU6ZgYUlYNcYWTjeRKLrlPJPJvFaXf+4p5AgArQ6O6hYn5o3Dgh+aYn5wACn+txBca+Q00M5mo3LoV9T/sF58CUsXpsUfonPXB2SS8FHdYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711375; c=relaxed/simple;
	bh=QG8/bf/1nLHMp6ICPgIWnWTirATwee1hQVW6atK5CR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPZlAIAwVbz2NvxZpCar2U1v4zMgiXL5Qz5bx+SnjdkUhHI06Xz4Qxgz+tp6bn5hGo/hFKwuQQ4Cl7YUSJkYhfFNI/Fk9A2QGWR3qKbqeJKTe/q7nawleEgbKi7i60TPRoAReqjRXZXGljlyAbXrvxAa76LaInVXKRRFRErXXq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F18F168C7B; Sun, 17 Mar 2024 22:36:08 +0100 (CET)
Date: Sun, 17 Mar 2024 22:36:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 16/19] block2mtd: prevent direct access of
 bd_inode
Message-ID: <20240317213608.GB10665@lst.de>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com> <20240222124555.2049140-17-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-17-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 22, 2024 at 08:45:52PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that block2mtd stash the file of opened bdev, it's ok to get inode
> from the file.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(not that block2mtd would also significantly benefit from using the
normal file based APIs for accessing the underlying block device.  No
need to do that in this series, though)


