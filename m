Return-Path: <linux-fsdevel+bounces-44345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DFEA67B31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 18:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5C919C64A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C496211A2C;
	Tue, 18 Mar 2025 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mRZiuDpZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C6211A04;
	Tue, 18 Mar 2025 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319750; cv=none; b=F4wWjbGZe8e4GSM1lOq+rfcVFwUwBhjpagTbSUelKSVLcEvR7jwHc1IjNpFCvAlQ/2lySbNb8B6u4h8Xjh9tAfh9jJJFfI0+h5AV6MbeSXmjhT0xHduJyaZf1xUCrSfDvDOmyY9z4e3tEAUTbdZW//AeDMp0VzRifyB9DFjUarw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319750; c=relaxed/simple;
	bh=uBMGCmpRkySXdW0ViKd8ets6zijLHH+Iy6pM2LFlE60=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OpyEp0ZKL5u9P0tPEiNT/JQ+M07t2+aFAVULvciOwvbQmRmqIjT7Ft4eMn9au5xUqWxF6OQ0xwTupr0N+TrBwNoCbFr2GguZSUAt4UO13PHlVEGUBxC6YE2hcPJDs95i0tyItRU05S3RxvejMWjWLtOafJyT3H334bqTAoQhEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mRZiuDpZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=uBMGCmpRkySXdW0ViKd8ets6zijLHH+Iy6pM2LFlE60=; b=mRZiuDpZyZzCwK+JTvOq8v1itd
	HfHfXN0FptfCauveymqf6IZZT9IzsTFMsyBBdXHbWSoyS3HtjWlQ7khPLDh/9mp25dB0nv/GfcwtD
	cPPwLnGQwMOBykc4UU6h1GGorQDEWf4aoCnsSndhMry98WWm9gxXVIy0D0aShbLLRGblzx9O0dN3c
	O2YUPWyBP70kAYu73AoPtgBhUoEHKG70oi+aB2Ii7gbQiIZv0yfJyOcqz8/WNrrGK+uDG5s9jFTzB
	E1Ixd8GI5DVNry4EDcgHtPkUcXSzJCoZbOGI5e9/8jN1aZT5ukfmjcP4Kc2KCg1Svk1kPz9Hj2K+A
	6a2m8FOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuaxK-00000001lNV-1jy7;
	Tue, 18 Mar 2025 17:42:22 +0000
Date: Tue, 18 Mar 2025 17:42:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] State Of The Page 2025
Message-ID: <Z9mwflUa2uucwFHo@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I would like to once again give a "state of the page" talk across
block, fs & mm.

As usual, I will give a brief overview of the transition from
pages to memdescs:

 - What are we doing and why
 - What subprojects have been completed this year
 - What our goals are for the next year
 - What adjacent projects are also in progress

2024: https://lore.kernel.org/linux-mm/ZaqiPSj1wMrTMdHa@casper.infradead.org/
2023: https://lore.kernel.org/linux-mm/Y9KtCc+4n5uANB2f@casper.infradead.org/

January 2025 update:
https://lore.kernel.org/linux-mm/Z37pxbkHPbLYnDKn@casper.infradead.org/
August 2022 update:
https://lore.kernel.org/linux-mm/YvV1KTyzZ+Jrtj9x@casper.infradead.org/

