Return-Path: <linux-fsdevel+bounces-61448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF6BB5846C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 20:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 339594E2485
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7742D0C74;
	Mon, 15 Sep 2025 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Vhy4i+tl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7102BDC1B;
	Mon, 15 Sep 2025 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960391; cv=none; b=Q02l+UxrPDEEZlQrCgV8iHpxPM0yHs3NN/9HdR+wuHMqdRJBbPVeF7pWZzcrfcmSw4Xp1LlwJ+KUZ/dK1BdFo7+I0w7ybHzxrTb1s+F5441Key21y7BsIPFTs5ELNPO+as7vseFZusG9wR6X/O3vXnSQ1aeQqsIAzl/X1/Zig0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960391; c=relaxed/simple;
	bh=OGdVM/hLtjIBOyDCGtoN4OyrR6tq4XKfj4GuSMverh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8eqFedD7YrtMuIAD2JVyWST028qH7OrPfllZa8qcy1A/FJV/Hcn9iMb8SObyTuXyrXTyY64gwCDwE54V+LmzH/EfJJjYvMJLRTIrKnTeNeFIX3kB6Mtu9AQJPELCZ/+//d1Vv02Szy2vGSqxlh9Vrt2IBlZehgWHieoxggMRxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Vhy4i+tl; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cQY681cR1z9tBF;
	Mon, 15 Sep 2025 20:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1757959952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uabTcZlsJwj8cGPmkeFh4JkdU8A/qF5iN2gRJmC26sQ=;
	b=Vhy4i+tl0RbgFcusaRlZzpZ5hXU5TXY11dM3DEki/OuRfjmIrMpqWEsyZHdnIdSa61k6AN
	AmhrTuKLfSuIZV8/TYGLkF5KPhuQmodSoX+s8wha0/xXCUqJPr0N/cbwZyd/BQA2eoh+e/
	ie5n2SLrHtv7S8ih4XDbLOXhf+QQ0dDAYeuqdw1pCSUE8kb3t26E3mtvDP+33grijYy0qb
	qNO8KkeWS2TVUWvotMa42zqUxi+qmh4K14Qt02Zf038eC+ZYS5OqergbQqlp3sQKU3gHu8
	GuPD+y0Nlu7oboyZO28Vzv+qv2aAYjBfPzqRz+oUioCkOfnrZe+TddAZF8MYsg==
Date: Mon, 15 Sep 2025 20:12:25 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, linux-mm@kvack.org, 
	mcgrof@kernel.org, p.raghav@samsung.com, kernel@pankajraghav.com
Subject: Re: Any way to ensure minimal folio size and alignment for iomap
 based direct IO?
Message-ID: <2h2azgruselzle2roez7umdh5lghtm7kkfxib26pxzsjhmcdja@x3wjdx2r6jeu>
References: <9598a140-aa45-4d73-9cd2-0c7ca6e4020a@gmx.com>
 <aMgOtdmxNoYB7_Ye@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMgOtdmxNoYB7_Ye@casper.infradead.org>

> > But unfortunately I can not find any folio allocation for the direct IO
> > routine except the zero_page...
> > 
> > Any clue on the iomap part, or is the btrfs requirement incompatible with
> > iomap in the first place?
> 
> It's nothing to do with iomap.  We can't make the assumption that
> userspace is using large folios for, eg, anonymous memory.  Or if
> the memory is backed by page cache, we can't assume that the file
> that's mmaped is on a similarly-aligned block device.

Just to add to willy's point, XFS did not have this requirement when we
upstreamed block size > page size support. The only thing that XFS does
is to pad the direct I/O with zeroes if I/O was smaller than block size.

Is it very difficult to add multi-shot checksum calls for a data block
in btrfs? Does it break certain reliability guarantees?

Another crazy idea would be to either fall back to buffered I/O if this
condition is not met or allocate a new folio and copy the contents so that
it meets the condition of single large folio that matches the block
size (like we do in bio_copy_user_iov() when we cannot map).

--
Pankaj

