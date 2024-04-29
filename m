Return-Path: <linux-fsdevel+bounces-18061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5929F8B50AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86491F23189
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7990DDDCB;
	Mon, 29 Apr 2024 05:19:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0329D51D;
	Mon, 29 Apr 2024 05:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714367965; cv=none; b=pRQ3TMHNPLLzjpw7KR+qYtoXNMz9i+GMNIrkpAkIQtSX9x6ltO+KkmpBHUy00kb9iiaBvsWS210B8NH10i20GiHGVFbyDaFT7Y6Do9M6LtpLSbGgFQ6VaR9drvla52ynuvGHSfKpvTNl8Ej2ZKQUimjmFPkLzY1QuS4b7gkSnys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714367965; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXBugqD3RLNYOsOSwGhL9AmpLnyO310bDa6nb/aNXfX6VqY7FJ8iai75iZF2yLvjUfx9Q0gAyWuZjdA2aktyKWiE0C1QcN6yIw7b9w8QyWi1a86mpXXq/WuWQ7dtx8TcVsjJMCHW3xneO1Z8fg2Gf7xFNWYIbVWRP8B9u0kClWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 769F7227A87; Mon, 29 Apr 2024 07:19:19 +0200 (CEST)
Date: Mon, 29 Apr 2024 07:19:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/8] Use bdev_is_paritition() instead of open-coding it
Message-ID: <20240429051919.GA32688@lst.de>
References: <20240428051232.GU2118490@ZenIV> <20240428051418.GA1549798@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428051418.GA1549798@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

