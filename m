Return-Path: <linux-fsdevel+bounces-58965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEFAB3381A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA8816BAA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 07:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B0D287256;
	Mon, 25 Aug 2025 07:48:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD028507C;
	Mon, 25 Aug 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108108; cv=none; b=YJdHiVJZ239W+muOauUaPO1gh/xDpJ4O2+yTSlzSa/yGZHDaILiWnNnfCTYkaSB6kG/mL3Od4Jm6DYNhwAfpJH7RwnzPo8IEdUPOwoxGwd355HbEg9GbP8EWR3ljDc8060LnywCstg8Pm7J1OphM7IP4S8LPREIwuDP7gCbtE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108108; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkdQkodJWxOiU1xhZ4MsYc2GfbAiNyVWGNqcC+bkcteUr9Yeh/V6uPa7/rYPJG9V/lsTzpfFoJcSPn1eCb7RivGH74TJjvmy8yY8YlXjWEyV0E/s/RuYWabwXaVrE+x3hZ/eG88cvRr+HzCVQm4ZYpa/+z3vSOcwhHvqhgj1QsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1074E68AA6; Mon, 25 Aug 2025 09:48:24 +0200 (CEST)
Date: Mon, 25 Aug 2025 09:48:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
	dw@davidwei.uk, brauner@kernel.org, hch@lst.de,
	martin.petersen@oracle.com, djwong@kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv3 5/8] iomap: simplify direct io validity check
Message-ID: <20250825074823.GH20853@lst.de>
References: <20250819164922.640964-1-kbusch@meta.com> <20250819164922.640964-6-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819164922.640964-6-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


