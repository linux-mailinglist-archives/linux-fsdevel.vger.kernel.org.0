Return-Path: <linux-fsdevel+bounces-40487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1476DA23D50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 12:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85522160737
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683DE1C245C;
	Fri, 31 Jan 2025 11:47:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275122AD11;
	Fri, 31 Jan 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738324072; cv=none; b=FITusEDV997mkfKTQYWudv7zTp4jAqH+KEoHpJRL8i1RyzGmxAyahzNy0uVnEG43cl464bHf0xBVqD5LVxm1yAQCSwn0mlNQZHs/LBpapF1ix6ThSWtK3H/BqMIA4oim20+H2tInlVxL2cCEWneiqs8sTheZsCXzJbkcPO2N0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738324072; c=relaxed/simple;
	bh=Hcu268jbi9KzOS6Nhwcix97zLT/su2JH/UWIMRF73gg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KutXQilcOYCJWSuzVbzBcaiSpg4Ggz8hTiOKCkVc0x57GT48x8+mO4PFbtYGenRjN7XlsrInjUs5NEnHgfa0Y6nwSKv/Qx9NNsahZopnMKYyUkIzV1UKQOIBzj+2KQiIy/wtmXZorJVnOUfT1BhiKFhGYUL8AT5c6jwzEq+149Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkvG65SSrz67Ct9;
	Fri, 31 Jan 2025 19:45:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B1512140155;
	Fri, 31 Jan 2025 19:47:40 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 12:47:39 +0100
Date: Fri, 31 Jan 2025 11:47:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: John Groves <John@Groves.net>
CC: <lsf-pc@lists.linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Amir Goldstein <amir73il@gmail.com>, "Miklos
 Szeredi" <miklos@szeredi.hu>, Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: Re: [LSF/MM/BPF TOPIC] Dax, memfd, guest_memfd, cxl, famfs - Is
 there redundancy here?
Message-ID: <20250131114738.00006db2@huawei.com>
In-Reply-To: <hobfuczt5sdnj3acjara2qzv3wvhcugyx34tr6rkxsddzo5gix@ta2ysllb6h2s>
References: <hobfuczt5sdnj3acjara2qzv3wvhcugyx34tr6rkxsddzo5gix@ta2ysllb6h2s>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 30 Jan 2025 16:54:03 -0600
John Groves <John@Groves.net> wrote:

> I have been hearing comments that there might be redundancy between dax and
> memfd - and have recently become aware of the guest_memfd work. A session where
> we discuss these related abstractions, their use cases, and whether there is
> redundancy seems like it would be useful.
> 
> I come at this primarily as the author of famfs [1,2,3,4], which exposes
> disaggregated shared memory as a scale-out fs-dax file system on devdax
> memory (with no block backing store. Famfs is currently dependent on a dax
> instance for each memory device (or each tagged allocation, in the case of
> cxl DCDs (dynamic-capacity devices). DCDs create a "tag namespace" to
> memory/devdax devices (and tags are basically UUIDs).
> 
> Famfs, similar to conventional file systems that live on block devices, uses
> the device abstraction of devdax to identify and access the backing memory
> for a file system. Much like block devices generally have recognizable 
> superblocks at offset 0 (see lsblk etc.), sharable memory devices have UUIDs,
> and may also have superblocks. The device abstraction of tagged memory is a
> very useful property.
> 
> I've been asked a number of times whether famfs could live on a memfd, and
> I currently think the answer is no - but I think we are at a point where these
> abstractions should be examined and discussed in context.
> 
> Brief famfs status: At LSFMM '24 the consensus was that it should be ported
> into fuse. That work is getting close but not quite ready to post patches.
> Those should start to appear this spring.

+1 for the topic, but I need to do a bunch of reading before such a discussion.
I think the coco + famfs thing will eventually bite us so we need to figure
out if we make DAX work with coco or make something else work as well that
provides the same guarantees of VA ordering wrt to underlying storage.
We need userspace on different hosts to see the same data in
the same order!

This also applies below and above whatever we do for virtualizing tagged
capacity as well (I'm taking far too long to get back to a virtio proposal
around that but have a colleague starting to look into it)

Jonathan

> 
> [1] https://github.com/cxl-micron-reskit/famfs
> [2] https://lwn.net/Articles/983105/
> [3] https://lore.kernel.org/linux-cxl/cover.1708709155.git.john@groves.net/
> [4] https://lore.kernel.org/linux-cxl/cover.1714409084.git.john@groves.net/
> 
> Cheers,
> John
> 
> 


