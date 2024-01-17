Return-Path: <linux-fsdevel+bounces-8167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC228308F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871B91F2598B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139042137D;
	Wed, 17 Jan 2024 15:02:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E701721347;
	Wed, 17 Jan 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503730; cv=none; b=kCmqLwbD9xuENZ03d9duu+EVtrJLGyD8EW9GCFffS5L+m1dmaEuQ5iNkbmAN8Uz7rKXkxCMR5sLtEOJpeUuch0MrHgKvj+L4JhIb++ZoF3LZ4oUdMZGzZqt+NZNnSLYTijnD5RKMeQ2Uuu6+XNLqutVDb2CdmrS+sgT9KOkv2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503730; c=relaxed/simple;
	bh=InjtWWHIK+dxg9+ObW7eBrA9Bb+Q/V/aSLm4A24XvJo=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent; b=IHCP/xoz2BGkkjj42PPn6NVwAcbqKkZb6QyMdvRhuO7d0zn5xgni6odbG92llKC2ATOeGCXfG047qzXEW52JwiAokeORBnlPo5BUpATF5tr7vn+zy3X3TukBG0RDiqf1OcH3vgXIL8BZ0IrDrx19h+buMuNFm9/z3YgsNAbm+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4135968C7B; Wed, 17 Jan 2024 16:02:01 +0100 (CET)
Date: Wed, 17 Jan 2024 16:02:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20240117150200.GA30112@lst.de>
References: <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com> <20231221121925.GB17956@lst.de> <df2b6c6e-6415-489d-be19-7e2217f79098@oracle.com> <20231221125713.GA24013@lst.de> <9bee0c1c-e657-4201-beb2-f8163bc945c6@oracle.com> <20231221132236.GB26817@lst.de> <6135eab3-50ce-4669-a692-b4221773bb20@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6135eab3-50ce-4669-a692-b4221773bb20@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 16, 2024 at 11:35:47AM +0000, John Garry wrote:
> As such, we then need to set atomic write unit max = min(queue max 
> segments, BIO_MAX_VECS) * LBS. That would mean atomic write unit max 256 * 
> 512 = 128K (for 512B LBS). For a DMA controller of max segments 64, for 
> example, then we would have 32K. These seem too low.

I don't see how this would work if support multiple sectors.

>
> Alternative I'm thinking that we should just limit to 1x iovec always, and 
> then atomic write unit max = (min(queue max segments, BIO_MAX_VECS) - 1) * 
> PAGE_SIZE [ignoring first/last iovec contents]. It also makes support for 
> non-enterprise NVMe drives more straightforward. If someone wants, they can 
> introduce support for multi-iovec later, but it would prob require some 
> more iovec length/alignment rules.

Supporting just a single iovec initially is fine with me, as extending
that is pretty easy.  Just talk to your potential users that they can
live with it.

I'd probably still advertise the limits even if it currently always is 1.


