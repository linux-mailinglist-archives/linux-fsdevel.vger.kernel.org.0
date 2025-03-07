Return-Path: <linux-fsdevel+bounces-43485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CA4A574CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 23:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B48F7A7380
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCBD241CA5;
	Fri,  7 Mar 2025 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p60q3+O1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C501A9B34
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385602; cv=none; b=YLQnEuZ4Us41v/VZEwUkuX+Q86oG6Vlvexl47qXOfiI6+WngW+WaF6zbYE+47eEtvLqZbnuDfdSgusTcFDCmFImy+rkvyB5hcGY++Mu9jnOPWoORd849jAHb/mb4OhEWvajCw+GNHKRxJu8HLKT4EUaLknLuQce7kV3fY3Nvw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385602; c=relaxed/simple;
	bh=KwMRxmpn3XtE8ZpVcpFAihi8HdPo5E6ucnQWdOKO/SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPIPKn/+FVz7/h9C/t2f1C0zHw3zKqBstArusNZPQAhhJtoNPHtagFOeBLyQHozxmdse8u82nETN30IpjZIQc021r6DDPNrFoyhzGMfsY5KJat+8eguj9mgsfHfmpqgjL3sZvcMEo7A5/gl/TEYTdZ4ph8g6jlU5kMdv3BjMOHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p60q3+O1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3532C4CED1;
	Fri,  7 Mar 2025 22:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741385602;
	bh=KwMRxmpn3XtE8ZpVcpFAihi8HdPo5E6ucnQWdOKO/SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p60q3+O1Bw45+FzqN10htD1erTlhZIhwNiQ4LbvxJzzVssT1awvJriLLX0KH64z7Q
	 6P1TVdWx9jOIkasX98/opa7pquMAiS5N8sidDnShnkCHvx0Yb8cNi018IZNVjGMfrH
	 iqY8trVUTALAbw7+gv8NJchd4S3gkhWZ0CYdAnRNvqId8DkVIUSUyRACm0PkiLQhil
	 NGT5EAr0Kyk0vDh6t4OFTYdB6lCoLAXxD6gCMDCSFeDx5jOqvCXlyMC2UF6kgGnBWc
	 GGk8LND4rrpBmlOisEpBzeRvvGOq5XIxKPwP091lA2OIpP1ThnMrb7sDss6Uto83p4
	 P6tiT7Ni5X8LA==
Date: Fri, 7 Mar 2025 22:13:20 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] f2fs: Remove uses of writepage
Message-ID: <Z8tvgKBYOKfYoVku@google.com>
References: <20250307182151.3397003-1-willy@infradead.org>
 <Z8tZnN-CAS20Dpi7@google.com>
 <Z8tbrL1OKN8pqhNe@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8tbrL1OKN8pqhNe@casper.infradead.org>

On 03/07, Matthew Wilcox wrote:
> On Fri, Mar 07, 2025 at 08:39:56PM +0000, Jaegeuk Kim wrote:
> > On 03/07, Matthew Wilcox (Oracle) wrote:
> > > I was planning on sending this next cycle, but maybe there's time to
> > > squeeze these patches into the upcoming merge window?
> > > 
> > > f2fs already implements writepages and migrate_folio for all three
> > > address_space_operations, so either ->writepage will never be called (by
> > > migration) or it will only be harmful (if called from pageout()).
> > 
> > My tree sitting on [1] doesn't have mm-next, which looks difficult to test this
> > series for test alone. Matthew, can you point which patches I need to apply
> > in mm along with this for test?
> > 
> > [1] f286757b644c "Merge tag 'timers-urgent-2025-02-03' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip"
> 
> Oh, you don't need any extra patches.  The ->writepage removal has been
> going on since mid-2021 (commit 21b4ee7029c9 was the first removal, I
> believe).

Ah, I see. Thank you for the confirmation. Let me apply them and test a quick.


