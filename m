Return-Path: <linux-fsdevel+bounces-7731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7DB829F24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 18:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39124281CE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BC94CE1B;
	Wed, 10 Jan 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="liMpCFku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912147F56;
	Wed, 10 Jan 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UG5rTIW8JDfkf7LcpVd9c2CMgymhez6iw7HFayDkZY0=; b=liMpCFkutacydN5YhfiSiRM2fc
	C4bDOjiQsf3vFMO+kQpyV+EJB9p3jDReJpUjsC6rz0q0sR5hfahB7jnfAnI9ezzKpPTwvnbpfwdYz
	BrnwpKAZMZrkMo2GZHKlLSwNyeN1qu3bJv0+fM9BQFls5hCqteeXKdLXpbjwIXJ3kn25fhkjC7Mu+
	3DDdRK1NuV0JooCKFMQpLMwR02Vt+D56bsIWj8BCxRCLgACvjHZnpi9HtXWjhkhqTw0hMiVm4Vug3
	59y54dnT7j5jHm0QYwk5/FZmSdRsXrcDwyGCG5GNnf6tjhlWcTQv3tAiLIb+/4tvS0ZUmVEwKfcSj
	u9DvS8DA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNcLv-00Bprg-SR; Wed, 10 Jan 2024 17:26:55 +0000
Date: Wed, 10 Jan 2024 17:26:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.raghav@samsung.com
Subject: Re: [PATCH v2 5/8] buffer: Add kernel-doc for brelse() and __brelse()
Message-ID: <ZZ7TX/f5/+svtB6i@casper.infradead.org>
References: <20240109143357.2375046-1-willy@infradead.org>
 <20240109143357.2375046-6-willy@infradead.org>
 <20240110143054.lc5t6vewsezwbcyv@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110143054.lc5t6vewsezwbcyv@localhost>

On Wed, Jan 10, 2024 at 03:30:54PM +0100, Pankaj Raghav (Samsung) wrote:
> > + * If all buffers on a folio have zero reference count, are clean
> > + * and unlocked, and if the folio is clean and unlocked then
> 
> IIUC from your [PATCH 3/8], folio only needs to be unlocked to free the
> buffers as try_to_free_buffers() will remove the dirty flag and "clean"
> the folio?
> So:
> s/if folio is clean and unlocked/if folio is unlocked

That's a good point.  Perhaps "unlocked and not under writeback"
would be better wording, since that would be true.


