Return-Path: <linux-fsdevel+bounces-54916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E519B0516E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 08:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C537AFC75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 05:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205422D3A96;
	Tue, 15 Jul 2025 06:00:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6AF2A1BB;
	Tue, 15 Jul 2025 06:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559223; cv=none; b=q2b3AjJhVbpxOjJGV9J0INcacDGxt7JITk9N2ZvSZteHCcX6+o9KAzwKb/tS/HQueO6bpllKnKNOr9bRejG8wvEcMXYZSWiaIcm8ka5Djp/ZvdJ5A8RMbazPulAB5iD2p0V/GBxMy+UrLhZZhSMUch4Sp9wSQocO8ZNvyrv0J3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559223; c=relaxed/simple;
	bh=5pSuA0ExRDvP2VznQVTpovpDSjuQy3DtY4EvL0tEqHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGGBUsAQDsf4MvddvhXrv9425m4LTPMYz5rnzAW3DEXlGosSpM0H36lF34i15EEWT1/DOR2nolkEof6u9WRLJ6ZsSNv0tONpHcaHSrvq5uSfcEnnYXXxwxX1hn4DtyTY/lUzElp5816X3si/aHcu8bTgu8EvFrkRj6LwUNQmx3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 18D8F227AAE; Tue, 15 Jul 2025 08:00:09 +0200 (CEST)
Date: Tue, 15 Jul 2025 08:00:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
	John Garry <john.g.garry@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715060007.GA18349@lst.de>
References: <20250714131713.GA8742@lst.de> <20250714132407.GC41071@mit.edu> <20250714133014.GA10090@lst.de> <20250714160400.GK2672049@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714160400.GK2672049@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 14, 2025 at 09:04:00AM -0700, Darrick J. Wong wrote:
> Do you want to handle it the same way as we do discard-zeroes-data and
> have a quirks list of devices we trust?  Though I can hardly talk,
> knowing the severe limitations of allowlists vs. product managers trying
> to win benchmarks with custom firmware. :(

I don't think whitelists are a good idea.  I'd expect the admin to
opt into it.


