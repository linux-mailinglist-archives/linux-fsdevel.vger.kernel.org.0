Return-Path: <linux-fsdevel+bounces-25764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7294FFDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 10:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D00281C32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776DD13B791;
	Tue, 13 Aug 2024 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Pc5lMfZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B915B7;
	Tue, 13 Aug 2024 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537816; cv=none; b=Nfw4+rcdzTW7LqB/uhd4UevCmcfN67x2mGBjHr8O6kdJh8IorWg/AoUEscVraNUDLwlPQJjG2Lr1nNj25FJ6FvB3kLdEyXn2j9Z52MyD3PicsBlFRQJjlfzvaAJxcbUruYoTmjw7z+8UoxgLvi/mTEP2HDE2SS8sQ8509ghQyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537816; c=relaxed/simple;
	bh=y0C49A+3DSbowzOYlaeyco5CnSLYing6DxPAyGbG71M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVHRVhtjRxCsBZj1M3JULmd5OoOOti+N6T3yjXR4Ya2koFrDeRaD2efnevdIKQFq6W10n33uOg58LXTMGnZDRnhIVfj8a9rNEcmUV5BaV+erXtcO3KM/iQQ+p0/Cp18VFz83MIRi1rOHlzzTvH8EpyRwdVRKYJG3fGVNZWCidtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Pc5lMfZl; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wjl1n4kZwz9t8D;
	Tue, 13 Aug 2024 10:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1723537805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhyxrPRjBr7w7C8YUOMjSbrMqpnOADkhbON58UaX+OA=;
	b=Pc5lMfZl/LA/itLRIvGEAAoyU6ldlzV0tgaNEkyyVWVplfeXjEW0r2eMYysnQjVIuiqQgT
	oWcpGMQDkYg0q2xv+pQtngEGIru1kdHpFoixfigkpxagjl1aYC8OMlRDcRvG9H+uGcidqc
	ythcDdrAP305QH1z2w7ZbmoKIptvAP3p8ezZtZqOFkXU3+2so5/2AQvVqSKKrDnfZX03RV
	fg3T9O6UX3WeCsnv+bvgSw1zIG6Imp6cf62F93CCEt9ropyMaODI1UEq9gcL0NNuQvByXr
	Gerw3akQTbun7E7+4WYbLpQ0sB98TLeJX7rv+Wta9jLVUOxW98C1CV7OSCAtog==
Date: Tue, 13 Aug 2024 08:30:00 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, p.raghav@samsung.com
Subject: Re: [PATCH 2/3] xfs: convert perag lookup to xarray
Message-ID: <20240813083000.soja6ixtad3mq5k4@quentin>
References: <20240812063143.3806677-1-hch@lst.de>
 <20240812063143.3806677-3-hch@lst.de>
 <20240812163956.xduakibqyzuapfkt@quentin>
 <ZrpcTAuJFSzE4-nA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrpcTAuJFSzE4-nA@casper.infradead.org>

On Mon, Aug 12, 2024 at 08:02:36PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 12, 2024 at 04:39:56PM +0000, Pankaj Raghav (Samsung) wrote:
> > On Mon, Aug 12, 2024 at 08:31:01AM +0200, Christoph Hellwig wrote:
> > > diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
> > > index 7e80732cb54708..5efb1e8b4107a9 100644
> > > --- a/fs/xfs/libxfs/xfs_ag.c
> > > +++ b/fs/xfs/libxfs/xfs_ag.c
> > > @@ -46,7 +46,7 @@ xfs_perag_get(
> > >  	struct xfs_perag	*pag;
> > >  
> > >  	rcu_read_lock();
> > xa_load() already calls rcu_read_lock(). So we can get rid of this I
> > guess?
> 
> Almost certainly not; I assume pag is RCU-freed, so you'd be introducing
> a UAF if the RCU lock is dropped before getting a refcount on the pag.

Ah, yes. rcu lock is needed until we get a refcount on pag.

