Return-Path: <linux-fsdevel+bounces-58697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4354FB30928
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E643AA552
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258802EAD1C;
	Thu, 21 Aug 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K9hhFLJy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4102E5B3F;
	Thu, 21 Aug 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814903; cv=none; b=krOQuOSXCIO4cPKwiEPpHRNeD9+OLFLBM8J5ejT0qst8jQJ/Pki1Sj/iNn1d1PliPJ9e5tEMT8m13lmp6lYEC+QfIDGG/B4+r8oID9FFg+31juwpUdjYtUo/WvqqR8ONeoN4SHg99IqVNoe3brAjoThSH8tc1drkvZVyYvLzXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814903; c=relaxed/simple;
	bh=E9AxT6oQKzAi3PCee/hi6lbfPnHdyA8NZ4C26Db8lB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kt2YYrxNpYn72dJ/MQHDTsgGzOWT/fNkjyYNe4mi7xyurocvh930swvIh1eNGiWmyVVMHljXbwPwylWz0y6VqiMr+inIXbcG53gGnPZdodIhaT0uSAp/GQnv0YPZv8yYTRRhaT1an0+hTtfO5hXOd2Nm9VUguhTYt3+ChLgasgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K9hhFLJy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iAnjSHVca4QKBa6RZo8xZY7/SB/V9H3bxiE51Kzwc94=; b=K9hhFLJyUw9DIS4iRwzx03qqBA
	g721xwDGbB50ENH0Gf5Z0OgQLT+nnmexVWX2quNbuRkq9mkEAz7zY7h2kqQ9IaiX67Byn/VHcr6SE
	Ekz3KuvqFBZq/EVkpYuTzOJAOB3xKsUGo4+L1zA+Hdx64CVW9Uwluz0pWHIqdbC2q3Kn2lQ5Umc2i
	+pI9k5Kxg6X8QA9uevAGWENS7vwF+RI9iu+MxdoqCm3gZV0/CIJU85j4aqGZS8bghNX6Zg087IePF
	aT3xBN4QHAc6k00tjdMinFuWDnozdj36TkzR2G1p16JqYUjY9V3KutEM3BkED0HP1WEDTM+WDmSHj
	F5tHe7bA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upDf8-0000000Er0I-32r9;
	Thu, 21 Aug 2025 22:21:38 +0000
Date: Thu, 21 Aug 2025 23:21:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINER SUMMIT] Adding more formality around feature
 inclusion and ejection
Message-ID: <aKeb8vf2OsOI19NA@casper.infradead.org>
References: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
 <20250821203407.GA1284215@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821203407.GA1284215@mit.edu>

On Thu, Aug 21, 2025 at 04:34:07PM -0400, Theodore Ts'o wrote:
> There is the saying that "bad facts make bad law", and the specifics
> of this most recent controversy are especially challenging.  I would
> urge caution before trying to create a complex set of policies and
> mechanim when we've only had one such corner case in over 35 years.

Well. we may have dodged a few bullets before now.  Just in filesystems,
I can think of Hans Reiser, Jeff Merkey, Boaz Harrosh, Daniel Phillips
(no, i'm not saying any of the others did anything as heinous as Hans,
but they were all pretty disastrous in their own ways).

I don't think we can necessarily generalise from these examples to,
say, Lustre.  That has its own unique challenges, and I don't think that
making them do more paperwork will be helpful.

