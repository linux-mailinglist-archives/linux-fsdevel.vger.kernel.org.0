Return-Path: <linux-fsdevel+bounces-14669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC2E87E054
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 22:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE854281D5F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 21:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65705208C3;
	Sun, 17 Mar 2024 21:26:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070A1DDF6;
	Sun, 17 Mar 2024 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710710815; cv=none; b=gGBWzQFDbIeKJdKEaxi5fooHK5XjGSa1ZDdobRt/YQNVreNjRnaSRJtMs5s8MGbdleql7OYIibMb/qi4i9syEqtKS4bX/Uib+U7UPsMv8lgIWmzgKdHp3ij/INsct0JEuDybdbk6IAsxo40afpvYBkfwy43BH6c9kH05nvaoUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710710815; c=relaxed/simple;
	bh=INa2ZDuZfBV4svklY8kdIIWzEewEqhnKKgerTr1b938=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCoUxYSI533Tf+0AN3H5hsicpDQFB20vjkDfccKQWPD8rm3qwjdjNrg65X1OjQhQUqSEEzXCn4iBhetdESF+O8FYezKCjreqzRlKKRZ5FzqhV5Hs63nhoMxBsa9Qy05yeBvfXYMB0BsE4eChLOXY2lZF56vnujkpXJRNFECkxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B95F968BEB; Sun, 17 Mar 2024 22:26:50 +0100 (CET)
Date: Sun, 17 Mar 2024 22:26:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 14/19] jbd2: prevent direct access of
 bd_inode
Message-ID: <20240317212650.GM8963@lst.de>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com> <20240222124555.2049140-15-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-15-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +extern journal_t *jbd2_journal_init_dev(struct file *bdev_file,
> +				struct file *fs_dev_file,

Maybe drop the pointless extern while you're at it?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

