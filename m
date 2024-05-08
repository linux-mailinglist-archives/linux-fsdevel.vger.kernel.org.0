Return-Path: <linux-fsdevel+bounces-19081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A12B8BFBE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 13:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B422E1F21EA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035F1823BF;
	Wed,  8 May 2024 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="GxZJdzRU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFCF3F8EA;
	Wed,  8 May 2024 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167353; cv=none; b=kUzsllfeZAYZspWKC/je4r4OqzJ1HmIG6YzY3SDCEui8jgg+p1aWoCbTS7D3bCBcD5/VCOYUy3xTRoELwnao1eOKYHfVa0BT+NhN9+cuOrOdZtcF/fbvooh0q6s7w2uSFbEdC/2IoC3Mad1/5QFvSMc/eNzdWhY5RDkvPPLpBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167353; c=relaxed/simple;
	bh=WqS0Z6CFkDljrlBKBkE6xKHY4rZ0KYd5P3qj6M1T4AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rb1noNH9kgUebQQVP/g+TqeEvc2VVxQ+3gobYU1EAkIPN+2e2OE6KqdsC4pRQscKa48X5iryhDXIjgC/A7hFW7rC+ji+hLgNpq1A4gvmqC2BD/PAnmLF/5YozipxTwKHiaxCGVfvEAx5qmUypPKRnLylhtC/xbyr0o3lVCmVDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=GxZJdzRU; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VZCRR5Ql0z9sTc;
	Wed,  8 May 2024 13:22:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715167347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EdIGErpvvibBR4nNdikj9JRxEGZBf8SHMI98catsm7M=;
	b=GxZJdzRUKxcdids+Hn+s+DVoctkTJd6lAo6DvQX9ebtPb6YGea5AxBM+bCDmYWpn0md+sN
	guORSaJyn/EWB0ATpr5QzyVtxDzLgHlN7jYSrTq+aMpafQLBn6pn2Y4zZgBkm5sQjF/XBL
	vPABhmU91Gxvp9ukidzve7I9UR99uKibjr2smIigb5OzFXTMRsjofaZm/SZ9ahQxqTVdnm
	N9jvv5i9BtjebkUGmYouSbYgBh4nkySM1AxusoTPwRy0Xj0waw+kFcRYxrKfpKo1OcRtAS
	urVc6SM7+kQV7YcEnTtllW22AYAiWT94LkEncmfD6Vvv2c5UYHEfT7fXRWWBKQ==
Date: Wed, 8 May 2024 11:22:24 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, hare@suse.de, ritesh.list@gmail.com,
	john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com
Subject: Re: [PATCH v5 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240508112224.gnvdhr4j4fphzj6n@quentin>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-8-mcgrof@kernel.org>
 <ZjpQHA1zcLhUZa_D@casper.infradead.org>
 <ZjpSZ2KjpUHPs_1Z@infradead.org>
 <ZjpSzi-HiZkx_Kdq@casper.infradead.org>
 <ZjpTHdtPJr1wLZBL@infradead.org>
 <Zjr-lf2tJAmwLzzu@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjr-lf2tJAmwLzzu@casper.infradead.org>

On Wed, May 08, 2024 at 05:24:53AM +0100, Matthew Wilcox wrote:
> On Tue, May 07, 2024 at 09:13:17AM -0700, Christoph Hellwig wrote:
> > On Tue, May 07, 2024 at 05:11:58PM +0100, Matthew Wilcox wrote:
> > > > 	__bio_add_page(bio, page, len, 0);
> > > 
> > > no?  len can be > PAGE_SIZE.
> > 
> > Yes. So what?
> 
> the zero_page is only PAGE_SIZE bytes long.  so you'd be writing
> from the page that's after the zero page, whatever contents that has.

This is the exact reason this patch was added. We were writing the
garbage value past the PAGE_SIZE for LBS that led to FS corruption. Not
an issue where FS block size <= page size.

-- 
Pankaj Raghav

