Return-Path: <linux-fsdevel+bounces-73467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E4BD1A2A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99CE9305A8D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B4629B22F;
	Tue, 13 Jan 2026 16:17:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188DC27E07A;
	Tue, 13 Jan 2026 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321039; cv=none; b=BYfggA1yOs1I6ev10P3QOL8fF240cS7UL6ciX42SaxnuKg9soVesrawiMbtTNltQtIbtDGDZ+13w8IvcbUwV8BR3njyLIF7U3L2aE9LZMRRqMhnVSMviIAVLMDdOZgJW3oKZVNeuEWYgzHDQ7qraMUsgkMXWSY1g6jyIgV44bHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321039; c=relaxed/simple;
	bh=TU41s6DT8VDus7loHd+eyb0iaAey2NpOvvPdsOD+Rng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPcLQeKMPx9VsthJP3+78wR2wA6aXVkrOS7Npxbdm9xfDCaQQ0oX5hwCeddYfF3GoD55f4iJg70knM7NeTR700llU5xSlwFh9i+ICnKhgmbi4Bp0VaUypYSGuTBNcPlGQQ+WGwmPfFtA7AYomAUTNlUXgHlLEOLYacajk0AAcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65483227AA8; Tue, 13 Jan 2026 17:17:15 +0100 (CET)
Date: Tue, 13 Jan 2026 17:17:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 09/11] xfs: allow reconfiguration of the health
 monitoring device
Message-ID: <20260113161715.GC5025@lst.de>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs> <176826412900.3493441.14037373299121437005.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176826412900.3493441.14037373299121437005.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 12, 2026 at 04:34:54PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Make it so that we can reconfigure the health monitoring device by
> calling the XFS_IOC_HEALTH_MONITOR ioctl on it.  As of right now we can
> only toggle the verbose flag, but this is less annoying than having to
> closing the monitor fd and reopen it.

"reconfiguration" stills sounds rather pretentious for toggling the
verbose flag, but the code looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

