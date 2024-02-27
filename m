Return-Path: <linux-fsdevel+bounces-12938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031F5868D8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 11:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01FD288F5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA161384B9;
	Tue, 27 Feb 2024 10:28:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C811384AB;
	Tue, 27 Feb 2024 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029733; cv=none; b=gc8GtmfX5hV7IEomvp+vH55dTYv4o8mzc7mqS8X93jDvYMPwiKoepj4bx5YtMG5+G0sZHONNYkpub7ADXx+uffwDvTeZXCxwJMhHcwLZ5GNbCJdQ3S9cdQQ9yCmjl7bl7dwpbtTIEpHcm5OKw+U8PVxJKALQUOQGEPOWcHE8iwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029733; c=relaxed/simple;
	bh=pdNJE7PK8ndIE4EgOvi6kl0PkvFWesis5Ni5/jxOLfI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFGr1Z5nVPS2f9k13pF6jl0F5vUyuv4dS8g/iMXHob6i8Vewo35Mw3QB9AAn5vKD2NfSYHcF/aBWIvXoFq4qTdd0/0qtY8j22PVCcnuLC/lP0I1rF0+H6rtLfOgXi16uxig8LbIovwnOBXlzcmHOUXF8TNe5idJHVDrvdryi0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TkYWG0Dsrz6K5Wr;
	Tue, 27 Feb 2024 18:24:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 676EE14011D;
	Tue, 27 Feb 2024 18:28:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 10:28:46 +0000
Date: Tue, 27 Feb 2024 10:28:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: John Groves <John@groves.net>
CC: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, "Dan
 Williams" <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <john@jagalactic.com>, Dave Chinner
	<david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>,
	<dave.hansen@linux.intel.com>, <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 08/20] famfs: Add famfs_internal.h
Message-ID: <20240227102846.00003eef@Huawei.com>
In-Reply-To: <u6nfwlidsmmhejsboqdo4r2juox4txkzt4ffjlnlcqzzrwthlt@wsh5eb5xeghj>
References: <cover.1708709155.git.john@groves.net>
	<13556dbbd8d0f51bc31e3bdec796283fe85c6baf.1708709155.git.john@groves.net>
	<20240226124818.0000251d@Huawei.com>
	<u6nfwlidsmmhejsboqdo4r2juox4txkzt4ffjlnlcqzzrwthlt@wsh5eb5xeghj>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 26 Feb 2024 11:35:17 -0600
John Groves <John@groves.net> wrote:

> On 24/02/26 12:48PM, Jonathan Cameron wrote:
> > On Fri, 23 Feb 2024 11:41:52 -0600
> > John Groves <John@Groves.net> wrote:
> >   
> > > Add the famfs_internal.h include file. This contains internal data
> > > structures such as the per-file metadata structure (famfs_file_meta)
> > > and extent formats.
> > > 
> > > Signed-off-by: John Groves <john@groves.net>  
> > Hi John,
> > 
> > Build this up as you add the definitions in later patches.
> > 
> > Separate header patches just make people jump back and forth when trying
> > to review.  Obviously more work to build this stuff up cleanly but
> > it's worth doing to save review time.
> >   
> 
> Ohhhhkaaaaay. I think you're right, just not looking forward to
> all that rebasing.

:)  Patch mangling is half the fun of upstream development :)

> 
> > Generally I'd plumb up Kconfig and Makefile a the beginning as it means
> > that the set is bisectable and we can check the logic of building each stage.
> > That is harder to do but tends to bring benefits in forcing clear step
> > wise approach on a patch set. Feel free to ignore this one though as it
> > can slow things down.  
> 
> I'm not sure that's practical. A file system needs a bunch of different
> kinds of operations
> - super_operations
> - fs_context_operations
> - inode_operations
> - file_operations
> - dax holder_operations, iomap_ops
> - etc.
> 
> Will think about the dependency graph of these entities, but I'm not sure
> it's tractable...

Sure.  There's a difference though between doing something useful (or
even successfully loading) and being able to build it at intermediate steps.
I'm only looking for buildability.

If not possible, even with a few stubs, empty ops structures etc
then fair enough.

Jonathan

