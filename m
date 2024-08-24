Return-Path: <linux-fsdevel+bounces-27019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40495DB88
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 06:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26496282C0D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 04:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D070714A611;
	Sat, 24 Aug 2024 04:49:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C83182B4;
	Sat, 24 Aug 2024 04:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724474944; cv=none; b=ZxXlqrklYmROHJuOwAVW3wLwihRwrRqQioaPpGvpMShQ83IJpimqrS96QW/p9ZCq9TfWcZSPb++OLFTbRSy9N11iZ07TmTzNTEBxq/ha5QPowcHZXAy053YzDoiubR95yJaUq2X+KgGwCxC1LanEbw7/1Iw0OaYLhJNPQmpbAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724474944; c=relaxed/simple;
	bh=RLVWhuQEQAFMXlbrbdLRuW0+KHWDDPXP5LciXzNxuUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmA2Wmxkh6Mz17z9guSZHHorvxgX8e05thZvZg1V0aGgVGVCMWGVtBZ7Pz09MqohJrJQEtl2NaV3P7Vy1zkPH2fuPXCijt/424pqL/3nRqlSQkd4RJLpoxa/ruUqZMRAXKHEzUpLC5ObENfoEPbe5ltfZ/3fGPlSCWdIDl2jrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 82DA2227A87; Sat, 24 Aug 2024 06:48:56 +0200 (CEST)
Date: Sat, 24 Aug 2024 06:48:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: introduce new file range commit ioctls
Message-ID: <20240824044856.GA4813@lst.de>
References: <172437084258.57211.13522832162579952916.stgit@frogsfrogsfrogs> <172437084278.57211.4355071581143024290.stgit@frogsfrogsfrogs> <ZsgMRrOBlBwsHBdZ@infradead.org> <e167fb368b8a54b0716ae35730ddc61a658f6f6a.camel@kernel.org> <20240823174140.GJ865349@frogsfrogsfrogs> <ZslTjr9P-2JUKVg7@infradead.org> <20240824044643.GS865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824044643.GS865349@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 23, 2024 at 09:46:43PM -0700, Darrick J. Wong wrote:
> "It is critical, then, that this patch must not be backported to any
> kernel that does not support fine-grained file change timestamps."
> 
> Will that pass muster?

I'd drop that last sentence as the previous part should be clear
enough.

