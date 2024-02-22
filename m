Return-Path: <linux-fsdevel+bounces-12518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E1F86037F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 21:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF6B1C24A59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 20:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766796E5E0;
	Thu, 22 Feb 2024 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGZlahkU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C086AF9D;
	Thu, 22 Feb 2024 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632537; cv=none; b=jXP684LweuDJRBNzAGXbmB1ypszDmUeqMEVswhXKF8ycH+q6dL1yNrRzxD7LKZNteAo1tNV7kfvBKjSCSmlcsUFQeI5VDSm86fyXvJa8oSaWbWR2IZqifFK0Qr3M0788nNFtkb9Pq2oAB0OERd/5HzWkZv4w26H2h2sJs0C5okM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632537; c=relaxed/simple;
	bh=ODDgjF35NrPnOPh5UsQdm3X39Cv4Un/MqteXmplihbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcqAXFq2Yy9TMYrhkpBlmoiER/3W/chQhCSkWZoJZsWK6E4y4lsX7dEzOelHoOF776QHnGV1X+QgOup4qTltn08w+n56VVszd0fJXT9B8ZSV09qxlVVQjNdQv8RsnuWKCCxu75pL+w1ke0XtZkuTesvGcqlOSStiUPnTuwVTe8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGZlahkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08E1C433F1;
	Thu, 22 Feb 2024 20:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708632537;
	bh=ODDgjF35NrPnOPh5UsQdm3X39Cv4Un/MqteXmplihbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGZlahkURajbySZDKt0JTcONpb/baq3R5TlEo+BM8oc5nkaRHWZWkc86XHHbSHmRi
	 IsnYpdQi+yAJvSOc34fziXx/vY8IuN1uvbBM/4UEiprg/PAh3T/4sZ2ZI2+XWfLfro
	 CZMASoar3AhHiJxj+R9AYzamkaZ5+Kih0n/YBjE8eGLo3gApeVjeafId4y5fKJgWHo
	 pWyYz/B6SSmtMFhVO8ZOboXFyAF+XH+SKQiHHF5zinDqN5EovCMPNU+KcFMUVqwvs1
	 ZBNQ4vPw8l/c5ly1U/iBDLwctAa1LhKbdNnsTJ/Oz8MY49CackDKqsUwmhaZ7r7zyb
	 m2rIx7ZwNXpiQ==
Date: Thu, 22 Feb 2024 13:08:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, josef@toxicpanda.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Message-ID: <Zdep1jEY4kFFxxk8@kbusch-mbp>
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
 <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>

On Fri, Feb 23, 2024 at 01:03:01AM +0530, Kanchan Joshi wrote:
> With respect to the current state of Meta/Block-integrity, there are
> some missing pieces.
> I can improve some of it. But not sure if I am up to speed on the
> history behind the status quo.
> 
> Hence, this proposal to discuss the pieces.
> 
> Maybe people would like to discuss other points too, but I have the 
> following:
> 
> - Generic user interface that user-space can use to exchange meta. A
> new io_uring opcode IORING_OP_READ/WRITE_META - seems feasible for
> direct IO. Buffered IO seems non-trivial as a relatively smaller meta
> needs to be written into/read from the page cache. The related
> metadata must also be written during the writeback (of data).
> 
> 
> - Is there interest in filesystem leveraging the integrity capabilities 
> that almost every enterprise SSD has.
> Filesystems lacking checksumming abilities can still ask the SSD to do
> it and be more robust.
> And for BTRFS - there may be value in offloading the checksum to SSD.
> Either to save the host CPU or to get more usable space (by not
> writing the checksum tree). The mount option 'nodatasum' can turn off
> the data checksumming, but more needs to be done to make the offload
> work.

As I understand it, btrfs's checksums are on a variable extent size, but
offloading it to the SSD would do it per block, so it's forcing a new
on-disk format. It would be cool to use it, though: you could atomically
update data and checksums without stable pages.
 
> NVMe SSD can do the offload when the host sends the PRACT bit. But in
> the driver, this is tied to global integrity disablement using
> CONFIG_BLK_DEV_INTEGRITY.
> So, the idea is to introduce a bio flag REQ_INTEGRITY_OFFLOAD
> that the filesystem can send. The block-integrity and NVMe driver do
> the rest to make the offload work.
> 
> - Currently, block integrity uses guard and ref tags but not application 
> tags.
> As per Martin's paper [*]:
> 
> "Work is in progress to implement support for the data
> integrity extensions in btrfs, enabling the filesystem
> to use the application tag."

