Return-Path: <linux-fsdevel+bounces-21837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0296690B6AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 18:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27AFC1C23000
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E2015FA6D;
	Mon, 17 Jun 2024 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="eE5bGXUg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F41E529;
	Mon, 17 Jun 2024 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642387; cv=none; b=Vn+saynAVVk4Da1i+wr6lSGcX4woaLpPg3QTwNraPGQVkRDo9ir2B+4+4q1Eem2M2brnKHrhredeTDWl0oTf9Y7rkYZWqPRpRgxgHz/eogPNyVlXQeamtbbvml7POPJ8OgY/PDunljbbXozK13UcGmCHdPRiIVHrNE3Fb04Pp7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642387; c=relaxed/simple;
	bh=1hZEPte82myJACnnnRcE6xVrKJlRvnnDSh5GcNfNoWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cep2ZKA+t1g1ZKh3K9xe26xPmoXrn1PUHW8f8BQr+yFLriOHMkYpH7J5EwYDAHw2r/Pstxp5yNmI8GqU3FwPSytMQPwKLckrZJpZqRO1meg1D49vKEbx1IUyfIbATV/8ZhxCgG4EJQX10+sFT7KslEtirHC196X7Fnl/yPTTRLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=eE5bGXUg; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W2wZv4GCQz9skk;
	Mon, 17 Jun 2024 18:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1718642375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWxRtAR5qJF4uBtiIKe8eNonYfcI1Je3yK1kKPqzj0o=;
	b=eE5bGXUgFljt74LCs5lsGulyZtpMxSfBydpsTmqyARyPVMi+u4j1VAGX+vDffzu+QEYco/
	LkLV9+3nYyyLeHM/ACHBW258FwK1bmMIRxgxPlfeAFK0T0x4/Z2phd5lWyWfmSJObV4z+f
	4jBZmIh09D72GwavVyvhYdIQVPfPG1Bi9ASwMVvmHBnuhk08aC1MOSweTLMhC5twUe92OA
	uHxpZYXgYJIOw3Pa1YTIFR0Agf1FTey8BGuUf7VMOwiCj9UqsxK4Cu1srFPwmJWNpFGW1J
	RyengNIrx0GHgoZ+BQxCnOyceyfhMSSEAP7TAotUZFgyuqAteMsJyODpGNgN7A==
Date: Mon, 17 Jun 2024 16:39:31 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>, hare@suse.de
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, mcgrof@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 04/11] readahead: allocate folios with
 mapping_min_order in readahead
Message-ID: <20240617163931.wvxgqdxdbwsbqtrx@quentin>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-5-kernel@pankajraghav.com>
 <ZmnuCQriFLdHKHkK@casper.infradead.org>
 <20240614092602.jc5qeoxy24xj6kl7@quentin>
 <ZnAs6lyMuHyk2wxI@casper.infradead.org>
 <20240617160420.ifwlqsm5yth4g7eo@quentin>
 <ZnBf5wXMOBWNl52x@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnBf5wXMOBWNl52x@casper.infradead.org>
X-Rspamd-Queue-Id: 4W2wZv4GCQz9skk

On Mon, Jun 17, 2024 at 05:10:15PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 17, 2024 at 04:04:20PM +0000, Pankaj Raghav (Samsung) wrote:
> > On Mon, Jun 17, 2024 at 01:32:42PM +0100, Matthew Wilcox wrote:
> > So the following can still be there from Hannes patch as we have a 
> > stable reference:
> > 
> >  		ractl->_workingset |= folio_test_workingset(folio);
> > -		ractl->_nr_pages++;
> > +		ractl->_nr_pages += folio_nr_pages(folio);
> > +		i += folio_nr_pages(folio);
> >  	}
> 
> We _can_, but we just allocated it, so we know what size it is already.
Yes.

> I'm starting to feel that Hannes' patch should be combined with this
> one.

Fine by me. @Hannes, is that ok with you?

