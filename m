Return-Path: <linux-fsdevel+bounces-45121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDF5A72E13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 11:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EE1177C57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 10:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BE120F073;
	Thu, 27 Mar 2025 10:46:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1894D22615;
	Thu, 27 Mar 2025 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072399; cv=none; b=Ymx1cfaRgmKayEk1bTsqkiNShc2peoEvXDKnbb6Qi1S2ESg5/pZEyhOEkQjDCLN7HmgGa6OJ5BtJBqBmEQKZjfG6SYC95TmU/vwYUEAeBeZHYPHGjuh7YKs/hASwvLL9T4Q3qjSh2kdNigfIKThVw6siQXj4Ied2UwUf8D15l1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072399; c=relaxed/simple;
	bh=CKMMwORL/7e171LK3vZmTi2HBGLdvefbMJzbjzQiBQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1x+TrW3vZ5oKF+/AuaQ4QMtgz6QSFIdhWk0A8yEM63fVX4zuqohCYeWTWQHwYEldi55QQ+VNNEH9BSW2mlfYy2YmqTzZgv9qO31Y2M5Rfi9y1YQrl4xSuwH3ZiO6wbtcbwBFMjsgJMuL18JJ/HIoSz8Aef0RWVSgfUnR8aZUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D9B8268C4E; Thu, 27 Mar 2025 11:46:32 +0100 (CET)
Date: Thu, 27 Mar 2025 11:46:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	brauner@kernel.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] iomap: rework IOMAP atomic flags
Message-ID: <20250327104632.GD10068@lst.de>
References: <20250320120250.4087011-1-john.g.garry@oracle.com> <20250320120250.4087011-4-john.g.garry@oracle.com> <87cye8sv9f.fsf@gmail.com> <20250323063850.GA30703@lst.de> <87bjtrsw2d.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjtrsw2d.fsf@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Mar 23, 2025 at 07:12:02PM +0530, Ritesh Harjani wrote:
> flags in struct iomap is of type u16. So will make core iomap flags
> starting from bit 15, moving downwards. 
> 
> Here is a diff of what I think you meant - let me know if this diff
> looks good to you? 

Yes, this looks good to me.


