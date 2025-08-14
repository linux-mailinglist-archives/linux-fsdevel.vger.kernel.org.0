Return-Path: <linux-fsdevel+bounces-57959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F15B270B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 23:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEB0565932
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 21:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E860A274FC1;
	Thu, 14 Aug 2025 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="yrijASuw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76624DFE6;
	Thu, 14 Aug 2025 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206346; cv=none; b=YUni/hVyZewFBADBY6ZyW4t/tVx65aQ0Cw5y69C33U0WmKb81D5RbQBNGFvlvpp+3Gc/cfQERNEr38e/JuM5HgRuiwGoKoNe6ldarLKs3DKEv+jKu+dUtDuRjDPIP2ZUmvdzUImoeZ+FnpaDyfyZqQGFSd4KsYP9JBAJ4H8aV1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206346; c=relaxed/simple;
	bh=u0J0/YnPeGRJ3hclaLO4KYX3+QmnfN14rrUH4j85gEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YA6ix7TD9v0GwgvU4T7yiay4yA8NQAXlbRuBtKtvv7bpWsSEEeQ8dkmM9rcaOIgZcf/cAkghxsYxvqYn47lsvAyGGzKFj6ErgE+kurwRjJAm0mL0RZk571cLfn+rvjdIZkRtOP0/1Jplt7/veKiUb1HNRQfVUlwgj8IzscHGXkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=yrijASuw; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c2ym429tKz9sdD;
	Thu, 14 Aug 2025 23:19:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1755206340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=232qte4tMCviyR8d5oDa9j6UWlzKhLlAuwX6y+U88Us=;
	b=yrijASuwWj8sI6kdjAZ2ctYzAt6Jt4DAlJykv0dI9SRYCzEN5jTPH1tueE+p+Wg36jFvsY
	lbm7jrP7snafljMqwzN1a69Jsk5nWDmrD6XAZe0nf8wZ7aL4ll5ELKOs02ECNy/JwgeoUf
	hMEEeDHHESqgGbr/Lxpiw0NXBLJB3juogFjCYZWeGtnb2IXjB8C/jWeMBpUAnS54yhlDZT
	QEQQq+TiKCk/kVUT3U/6TTVbn+GFKCJZlOa9AFIbpwO9xwcLIawMYjK6YYgQBvgezCox6Z
	WH4VSE0m7V7U9mqZ1rp6i5m7+703hnMkujunQ655cddfIWnaxDNtfMeGFXUrqQ==
Date: Thu, 14 Aug 2025 23:18:53 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com, 
	linux-xfs@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] iomap: use largest_zero_folio() in iomap_dio_zero()
Message-ID: <ujw7gc4mg4oi5qpkjqrvvto7qewpqthuid63etsetzag5epyug@zmpq2g2btd5i>
References: <20250814142137.45469-1-kernel@pankajraghav.com>
 <20250814182713.GS7965@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814182713.GS7965@frogsfrogsfrogs>

On Thu, Aug 14, 2025 at 11:27:13AM -0700, Darrick J. Wong wrote:
> On Thu, Aug 14, 2025 at 04:21:37PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > iomap_dio_zero() uses a custom allocated memory of zeroes for padding
> > zeroes. This was a temporary solution until there was a way to request a
> > zero folio that was greater than the PAGE_SIZE.
> > 
> > Use largest_zero_folio() function instead of using the custom allocated
> > memory of zeroes. There is no guarantee from largest_zero_folio()
> > function that it will always return a PMD sized folio. Adapt the code so
> > that it can also work if largest_zero_folio() returns a ZERO_PAGE.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> 
> Seems fine to me, though I wonder if this oughn't go along with the
> rest of the largest_zero_folio changes?

I included them in one of the early versions but later removed as we had
to rework the implementation multiple times. I just wanted to reduce the
scope of the series and send out changes that uses the API separately :).

> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks!

-- 
Pankaj Raghav

