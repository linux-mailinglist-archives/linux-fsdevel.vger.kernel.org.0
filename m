Return-Path: <linux-fsdevel+bounces-74063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A76D2DA99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95375303D144
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913DD2DCC04;
	Fri, 16 Jan 2026 08:01:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4AF10F2;
	Fri, 16 Jan 2026 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550461; cv=none; b=tdKmC5jzZxqeBjuw2IxV7feMncsy2c/QdkZ5etqYHWMEfS3xRccNwaM10PPm39k+Vu0EJh2GMPx7E8TVBdM0cluRG1XQ5dmVEBSSLvivPZRkekNbIME20QgnvQElWAFjc4JN8QSv9Mo62/X6ZCp3MOEMjxMRpO79b9qtzFP/PEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550461; c=relaxed/simple;
	bh=xCFo0toGihdq2mZuxm/pdFXR+zLJcPz2qz4f7pm9YT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfMNGEAQbbbeyKtsbGadvruGpQ8J30P/Ht8JkKac5ySvXfJ96q/gAVhlXuDhvgoc9yh2dbxs3df3Ozc7NGHBu4u3y5+P53swH/QF2vE3QMxUR9r+CcfnKl8Ffhif4pv6VTmFuwDZur/ILzezPfR+0jE8wC8wTp47laT6wHD0tAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 304F1227A8E; Fri, 16 Jan 2026 09:00:47 +0100 (CET)
Date: Fri, 16 Jan 2026 09:00:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH v5 01/14] Revert "fs: Remove NTFS classic"
Message-ID: <20260116080046.GA15119@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-2-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111140345.3866-2-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 11, 2026 at 11:03:31PM +0900, Namjae Jeon wrote:
> This reverts commit 7ffa8f3d30236e0ab897c30bdb01224ff1fe1c89.
> 
> This patch reverts the removal of the classic read-only ntfs driver to
> serve as the base for a new read-write ntfs implementation.
> If we stack changes on top of the revert patch, It will significantly
> reduce the diff size, making the review easier.
> 
> This revert intentionally excludes the restoration of Kconfig and
> Makefile. The Kconfig and Makefile will be added back in the final patch
> of this series, enabling the driver only after all features and
> improvements have been applied.
> 
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Acked-by: Christoph Hellwig <hch@lst.de>

