Return-Path: <linux-fsdevel+bounces-61249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BB2B5680A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 13:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DD3420ECB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A146258EF4;
	Sun, 14 Sep 2025 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="SKgbY8na"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0144E1D54D8;
	Sun, 14 Sep 2025 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850330; cv=none; b=Ue8bav97mENywowm3+deyqqXlhi4YqRwjSJNv8ytjpceGtwSQ2fqVR22bG88EMo4jdmGV5e9F3X8e2+u6p5n0yoPxIQjHi+XdythXbJVj67eBgRGZ//sk5QqCXN9/sPoGq02zORVI071U5ZtzyIQXlbAn3xHAjdXc/rtFtOzL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850330; c=relaxed/simple;
	bh=vuD14M2MX2jTgEECLZs6XWUd8/Yt2kL9/eV3cqHghoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5+tYph7gWgT7gEgS5aysdBzHh9+tVZmYdF6IoAx+OlB+RT3nyjsC40zy8sEQwkszM0rbS2m23AM53LRdZSUvVEF07Y0DRH9BYYidGCfCEWHWZwO+TacGCweUFPsNamD2ooo+DrcR/wTIVj0gjW61vFv0pvL2rS3W7G+W8UKEq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=SKgbY8na; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cPmYq00Smz9tFr;
	Sun, 14 Sep 2025 13:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1757850319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFmnnV5eWW+GWFY6z+YrcjM0r1aXV5qGtCsxI+BfkNM=;
	b=SKgbY8naVPDmocBelnFw4O6R9Xshuw3IWdAcWKFZGMXeTrKrrVJS5ZP9sL6sqSDFWmC1Fu
	LwrTI6s9+5JY1uHaqiaPEruqQIaI1nkHS9amiRjnf2lvljUgsUJTbszwxxE3FN9T1/m8cG
	F1nycM63zTbjlFBPuanaGnzPETOaEuSYyIZnrWI6BxlihzJp86Hd04O+WU24M/a/xMGsbB
	UHVetIIO4D1W7vl5PZBxJgRdiIAdsLzKGIwvvX+UkB6xc7w7av1gNr9jTqNWQSFQysUHlP
	8Dw9V/FSriomz4xaYni0QxuGHXPjeVuMZS3dXviuPSFcdh1kTbmG6HXHpM+vSw==
Date: Sun, 14 Sep 2025 13:45:16 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: alexjlzheng@gmail.com
Cc: hch@infradead.org, brauner@kernel.org, djwong@kernel.org, 
	yi.zhang@huawei.com, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH 1/4] iomap: make sure iomap_adjust_read_range() are
 aligned with block_size
Message-ID: <vath6pctmyay5ruk43zwj3jd274sx2kqbjkfgvhg3bnmn75oar@373wvrue5pal>
References: <20250913033718.2800561-1-alexjlzheng@tencent.com>
 <20250913033718.2800561-2-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913033718.2800561-2-alexjlzheng@tencent.com>

On Sat, Sep 13, 2025 at 11:37:15AM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> iomap_folio_state marks the uptodate state in units of block_size, so
> it is better to check that pos and length are aligned with block_size.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  fs/iomap/buffered-io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index fd827398afd2..0c38333933c6 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  	unsigned first = poff >> block_bits;
>  	unsigned last = (poff + plen - 1) >> block_bits;
>  
> +	WARN_ON(*pos & (block_size - 1));
> +	WARN_ON(length & (block_size - 1));
Any reason you chose WARN_ON instead of WARN_ON_ONCE?

I don't see WARN_ON being used in iomap/buffered-io.c.
--
Pankaj

