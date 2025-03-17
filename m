Return-Path: <linux-fsdevel+bounces-44163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44387A640A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 07:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969D016E217
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 06:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F20219319;
	Mon, 17 Mar 2025 06:07:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F36A2E3373;
	Mon, 17 Mar 2025 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191630; cv=none; b=EGJou017a1+JMZtwXmSTyEe8ixCtUfi2M5fDo2G1AsUNwVnOYSpUDm5P7ICmZxdltHWoesVxh+dAwaXI53Y6GvTvkb3z3rtC8XLW74QUV1dpk20TMeQCU6dyK7+DH23aXTxLiutGs9OUWWwPEIbukWPtkUHxTBeA+Iu5agBDAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191630; c=relaxed/simple;
	bh=zx0WCrfie+8wN6FuXH+ZrQ9xv/4fTCKfTiNlISIbWTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyYxmODmTjC36P0tNzymbS8/YfjOp8aX7h0HBqkQMcerzCZZ8H78uflfr/rOomJVABYd2Gq8/0+XuZFhA16QAQt0AISCXSscXriNMEJ3AxWGgpFGm0ulA242van8CBkEfOcS782GaPeVJbiY/wBMF/GDy5gbgpdovM4l9gD3H70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4EEA268AFE; Mon, 17 Mar 2025 07:07:03 +0100 (CET)
Date: Mon, 17 Mar 2025 07:07:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 01/13] iomap: inline iomap_dio_bio_opflags()
Message-ID: <20250317060703.GA27019@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 13, 2025 at 05:12:58PM +0000, John Garry wrote:
> It is neater to build blk_opf_t fully in one place, so inline
> iomap_dio_bio_opflags() in iomap_dio_bio_iter().
> 
> Also tidy up the logic in dealing with IOMAP_DIO_CALLER_COMP, in generally
> separate the logic in dealing with flags associated with reads and writes.

No review from me as that would feel weird having draftead this, but
it obviously looks good.


