Return-Path: <linux-fsdevel+bounces-44873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0CDA6DEE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 16:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E6C3AD0E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAA6261563;
	Mon, 24 Mar 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jyR9JoAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A862E3392;
	Mon, 24 Mar 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830762; cv=none; b=Ef64n6fHYKn7rSKD1fwwOIEW2qeqRP2EHXgi3QnK5cQ6YsptmICQT9C20k8BoVfBcRkzPaZJPKUI1KvYGfFlyFGS/RpCzENA4tukOAEnviVL2d4cBj5CSpPD1J0CpQZav/hBK0GUTjE59jEgarHwi4GpT4FiODxcGVrL2/Sasc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830762; c=relaxed/simple;
	bh=/ZoXOiB7VVELWrlLFv0mJtuwhQjwKXGM/R6fgQUlk9w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeMwtR7kXRd5br7QxTAdZM2c0B+tlmrtjE1gBYPtf3rd8Ydqm85VPN2/rouhzPr8z9pnKl6mII2ekgol3ucj2wD7VEyT7lZrPJtewP+mQJFS3cOD3mv8BSqTzUWNQRgZWzgaIt1ZZZ8MRkY2NfxV/4O9DFzfiCoXH2QiE8+qPwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jyR9JoAn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/ZoXOiB7VVELWrlLFv0mJtuwhQjwKXGM/R6fgQUlk9w=; b=jyR9JoAnGQCnrCoi5UtTZQQEXG
	sqU1vgwQ2y4R+dOlOFRSrEz+lVAWAWQSUqMSPiTw4//AFUYkubZmD5tyA3G3QjsaLYM8kqPuFMtg/
	JAWfHaVR7AnP9liFj7IC82HPeW1UssVgNaYK2hiTEjq3yNeGBIMKz2QBpvEgeftBxWjUwISK6aMIO
	LcFVWJG0cXgqgP8JBz1MxmFq6fvXHQHiGeOq6PgbQm81mPylBZIoX73bZfr9EIwtVOExt27ff9jmq
	DUPURWywOr9WbXSV4rQlI7SoqmEZ+7s+1K9dDfHcZX+E+Iny1GHbnKpUdkWh8X45DVslSUFgcWpCJ
	hdq9YGeA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1twjtW-00000000qkD-0Ph2;
	Mon, 24 Mar 2025 15:39:18 +0000
Date: Mon, 24 Mar 2025 15:39:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page 2025
Message-ID: <Z-F8pQsIduQgCXxr@casper.infradead.org>
References: <Z9mwflUa2uucwFHo@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9mwflUa2uucwFHo@casper.infradead.org>

On Tue, Mar 18, 2025 at 05:42:22PM +0000, Matthew Wilcox wrote:
> I would like to once again give a "state of the page" talk across
> block, fs & mm.

Slides as presented (with vboxfs typo fixed and Mike Rapoport added
to the thanks list):

https://www.infradead.org/~willy/linux/2025_03_LSFMM_State_of_the_Page.pdf

