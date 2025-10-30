Return-Path: <linux-fsdevel+bounces-66420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CAFC1E7BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 06:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2E0E4E68B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 05:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5085531A049;
	Thu, 30 Oct 2025 05:59:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1CE2F6189;
	Thu, 30 Oct 2025 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761803964; cv=none; b=uIuQbq9oaBAYoZpDLEFsbVH4Q7c1YJ65JtAQwiANdGznCMGp1nKn+GWbE8IEQZFguPbg41LXajdD0PMKhX6osr9e6+ahyEWubcYwRohZd6TNwB6o2XMGL5i+lZCGCVH7DenIastZnwqR+qC3BvOT5Aqc9/kE0V41G6kzR6a0K/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761803964; c=relaxed/simple;
	bh=wgiNbHqH4WrvjDbPjpusku8KLndaKJEHq2C8y3DxYFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhTO9/QvSegAV5Ece1GmGSifora6kn6i9mqW/Usi9dR7xbqGhUEBEobhGDi9BaPswAcQnUKjIO+erwKCrtAF5Fh4Ige4jRxkf75yExua9AQzZQcO/27mFv9VEHA4pNpV6r5DI7REJC8TDxTvZVWGDWPQmRSsCP4Fl+1BkwMBXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 88954227AAA; Thu, 30 Oct 2025 06:59:18 +0100 (CET)
Date: Thu, 30 Oct 2025 06:59:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: return writeback errors for IOCB_DONTCACHE in
 generic_write_sync
Message-ID: <20251030055918.GA12727@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <20251029071537.1127397-3-hch@lst.de> <20251029160101.GE3356773@frogsfrogsfrogs> <20251029163708.GC26985@lst.de> <20251029181213.GI3356773@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029181213.GI3356773@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 29, 2025 at 11:12:13AM -0700, Darrick J. Wong wrote:
> Would you mind putting that in the commit message as a breadcrumb for
> anyone who comes looking later?

Sure, I'll add it.


