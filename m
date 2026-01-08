Return-Path: <linux-fsdevel+bounces-72814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAC0D03C8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05D8D300A539
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4F5488513;
	Thu,  8 Jan 2026 10:21:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD34884E9;
	Thu,  8 Jan 2026 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867669; cv=none; b=pRM72bAxonsCpwnuHIMh5q/kWgQ5/krwUHqr5aPtfPaczqIoe1Ytx0th9v6sU5ma1vimw2raiIg14wG/fSZHD/Kzyz4Z1Vo8ErKrIpNeea/xg7VHQw+J3nqCjiREsO6zP3Zd6b6L8WksnhuZxqfg3poUC9Hz3ZN0rfuGa1LtSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867669; c=relaxed/simple;
	bh=9NSMKlbYrqLjViN3gL1U4PaHv62SXFFxEg7DL5e3LT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLGWP565W4bnsJ51urlVlZWn9Ek2OZhPuP0yykfnNCQUmc9qHAqiRsYMuiw2ggjaz2iviwY4q36zxVEL8LdlWm8HFlIsmMPbDnZewW0i4KF1JY08oza37579r6IwRMyYaKU5gpUvZZ1IbKb0Uw5qndxlryU9olCUUfuY8cR7hqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 04AC8227A87; Thu,  8 Jan 2026 11:21:03 +0100 (CET)
Date: Thu, 8 Jan 2026 11:21:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/11] xfs: start creating infrastructure for health
 monitoring
Message-ID: <20260108102102.GA25039@lst.de>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs> <176766637289.774337.11016648296945814848.stgit@frogsfrogsfrogs> <20260107091713.GB22838@lst.de> <20260107185055.GE15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107185055.GE15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 07, 2026 at 10:50:55AM -0800, Darrick J. Wong wrote:
> > This almost looks like a not performance optimized version of hazard
> > pointers.  Not that we care much about performance here.
> 
> Yep.  AFAIK the kernel doesn't have an actual hazard pointer
> implementation that we could latch onto, right?

It's in the works.  And probably complete overkill here, it your
code just reminded me of a presentation Paul gave on it.


