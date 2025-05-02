Return-Path: <linux-fsdevel+bounces-47896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CE6AA6B24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 08:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E03D16C1B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 06:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86928267387;
	Fri,  2 May 2025 06:58:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA01D554;
	Fri,  2 May 2025 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169130; cv=none; b=C/46EzitOLpT58P00/T8xEClEzJlgCtM6932Egtd4jzGRqTPB1bDogFOjPuD5Y7QOk0+wkV8SDQoFRkBkBZu6qVKpk48y9stW8vYuaqBpZ8R7U+zWfXnErs87jFWEogfykWJ2/l6BQPhqk9O7aUTDKau+tQnsp/qQTJnlT628ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169130; c=relaxed/simple;
	bh=u0QYB/yQYMVBEeETEU3lrgrJnUshqMxwaLV+dMtj5M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHeaMOlPOS/4r5Ez9tFm0rkA0BRdlZWVTJ8tgfnamEI0LbYG0B/SixwKT7Uo/OQKZU35MM+h5pRUhy4Wp9JWrDpjdSz5g8PlC/OGqrSrzTn+Iw4kWmTlKcmL+vlUjpJK8IDOV7vFnOrZIvNbgm6bjxszP2u8y5LdNWOSBzCHwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0038D68BEB; Fri,  2 May 2025 08:58:41 +0200 (CEST)
Date: Fri, 2 May 2025 08:58:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 17/15] xfs: move buftarg atomic write geometry config
 to setsize_buftarg
Message-ID: <20250502065841.GB8309@lst.de>
References: <20250501165733.1025207-1-john.g.garry@oracle.com> <20250501195305.GG25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501195305.GG25675@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 01, 2025 at 12:53:05PM -0700, Darrick J. Wong wrote:
> hch: is this better?  patch 16 can move up, and this can be folded into
> patch 5

Much better.  Although I'd also rename xfs_setsize_buftarg to
xfs_configure_buftarg and xfs_buftarg_config_atomic_writes to
xfs_buftarg_configure_atomic_writes for consistency.


