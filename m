Return-Path: <linux-fsdevel+bounces-14665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD1587E04A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 22:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86381281D8F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 21:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA372208CA;
	Sun, 17 Mar 2024 21:24:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D36208A0;
	Sun, 17 Mar 2024 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710710688; cv=none; b=j6ZJhi9vR8VVNi1ZoR7k5ai75sFgFVWG1R6lsCZXlxSaksCRH52Gh90ebhXKS+vIoutYQsGeiqqizfhRcN4ceLcOIzXdtVS7AQUrPpUfJYdA99DxvpgQce5eMuFX5/WR7WQI9In6Wvs1p5gws0PtOORYeXYrqkpjC0Zyt1DGedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710710688; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2RsO9bPZkBgJ/imQ5HrmLf2CkVl1EsZH4OIoZHJMHGWZldxq3jCfcEbeTYwIyJlBUK9WyGv9ubH7CMViWc+5qGtud0k4O0eVZqDS15u1p94OC1jAlkZRnc289z4DMRyq/DErowikIA0mq9YIYTQgEDIXYe0LcaPkPj5vLq3wYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4FE0368BEB; Sun, 17 Mar 2024 22:24:44 +0100 (CET)
Date: Sun, 17 Mar 2024 22:24:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 09/19] gfs2: prevent direct access of
 bd_inode
Message-ID: <20240317212443.GI8963@lst.de>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com> <20240222124555.2049140-10-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-10-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

