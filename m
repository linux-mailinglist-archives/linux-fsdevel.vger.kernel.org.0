Return-Path: <linux-fsdevel+bounces-14657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D9187E037
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 22:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EB9281B49
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 21:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C35208B8;
	Sun, 17 Mar 2024 21:19:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7963E33D2;
	Sun, 17 Mar 2024 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710710380; cv=none; b=tF+9v1sZaB4qLFkYBzy6DLA9/+CUz7HKGg+w1Jeb5jVRd/vsukfu/4gwFCRSFAvsgofm3Iwdw5sghcx5W9oEZb2hEuoeJWDz9ec/sMy0mSAanh0dNruk1/oUvgC5RfL3twNtENTr1zGuotCbb++1Z0Htib3NgtQ1sbBaYCzuto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710710380; c=relaxed/simple;
	bh=YWH4XbO7g73cjVvZDKnm4vwnQllnE7BWx2VcvbjQ6JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeksidmOJI7ZBNeVNxo2p9gvU21EgJyoP9RCKEkgnqaKmSwd8+S/H3iRSFBCYduioPrcHStJIvG8K5/ED32eaJ6qa3MPuqa3thpV4AHK8nwewFb0z6xaN1zA64aZ56yDyLjMF70ZR1ASiNl7pNZgQw85SuFmIctKFyIR98Ymb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 24D6668BEB; Sun, 17 Mar 2024 22:19:33 +0100 (CET)
Date: Sun, 17 Mar 2024 22:19:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 01/19] block: move two helpers into bdev.c
Message-ID: <20240317211932.GA8963@lst.de>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com> <20240222124555.2049140-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-2-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 22, 2024 at 08:45:37PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> disk_live() and block_size() access bd_inode directly, prepare to remove
> the field bd_inode from block_device, and only access bd_inode in block
> layer.

This looks good in general.

Reviewed-by: Christoph Hellwig <hch@lst.de>

(I wish we could eventually retired block_size() and the whole concept
of soft "block size" that could be different form the LBA size, but
that's a totally different adventure)


