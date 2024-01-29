Return-Path: <linux-fsdevel+bounces-9406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C614F840B0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 17:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835A628DF17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B1E155A33;
	Mon, 29 Jan 2024 16:14:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B6155315;
	Mon, 29 Jan 2024 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544866; cv=none; b=NqJoZjaXrzdVvBIiR27UJ2GO+/Qz7JrOiQ7cE0snBPnd+LOJXP+whDpy5BeyaeVwNbFf3JFtJj2q8zKNYP0PfINYh3O6zy1rJFGMeHCzYnAXNvKmsG8U7A4pR1RPRXDMaPnfS5wvZIH1+NIOe0f1MOKMsf/caJQXm01VC8veTOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544866; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnknFfOLwC9olhlBGN2P9uGx/deivYvqJX/SbwPLTEhUg9DkqNhBpTWC11/4Xjp/AbkeA6Kd7JHq0aIUc6oG3O2drUOac1Nt1gwqTkqSwHym242r69IVzfG4FamGtJR7Mc35uz3v72OSfQ7M9128jIueVIyDHm4WDz3Z4Vii2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5CAED68C4E; Mon, 29 Jan 2024 17:14:21 +0100 (CET)
Date: Mon, 29 Jan 2024 17:14:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 03/34] block/genhd: port disk_scan_partitions() to
 file
Message-ID: <20240129161421.GB3416@lst.de>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org> <20240123-vfs-bdev-file-v2-3-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-3-adbd023e19cc@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

