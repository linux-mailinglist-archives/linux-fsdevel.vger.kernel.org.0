Return-Path: <linux-fsdevel+bounces-14673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321B787E06F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 22:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C721F210F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 21:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B698720B20;
	Sun, 17 Mar 2024 21:38:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990A208B0;
	Sun, 17 Mar 2024 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711533; cv=none; b=SLIf+FU4AUBac7zi1zzZQEPFhmdM4o+wId56MPpDT4L8Bk1u0c8COhILuKP02fuFEJKNCxVw6x4xVc/3HdXd9vEpsOZJXe2Md9ym3rjPNNGLFaekYIwADT+oHOXlvYLAw6fGKUpZfn6rZhFqlaWBEEINWt5atQIHHEP+SnfmwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711533; c=relaxed/simple;
	bh=zH93ZOVLNgyUffwyHHoy0L+w1ZeG6/AOfheB1NZhu9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7QIwLWSh33ezr0ENEpCmuzvuFU5B9PuC/yaNUbBF/wC96zpO44hAaTzfByGNw7ONVBSaEm/RuQAmy4oGeIQUiAGlWSY0nYP30v4zBFf+2DABBwvPXy2rS5jb1TpWUOXJFjiDPw0DwFKYK8OOSPn/TZKsTE54S9tnUuO47IO17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BCA7E68BEB; Sun, 17 Mar 2024 22:38:47 +0100 (CET)
Date: Sun, 17 Mar 2024 22:38:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240317213847.GD10665@lst.de>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com> <20240222124555.2049140-20-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-20-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 22, 2024 at 08:45:55PM +0800, Yu Kuai wrote:
> The only user that doesn't rely on files is the block layer itself in
> block/fops.c where we only have access to the block device. As the bdev
> filesystem doesn't open block devices as files obviously.

Why is that obvious?  Maybe I'm just thick but this seems odd to me.


