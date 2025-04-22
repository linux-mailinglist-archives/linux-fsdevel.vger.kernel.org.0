Return-Path: <linux-fsdevel+bounces-46870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DB3A95ACF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 04:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084F23A7382
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 02:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22FB19AD70;
	Tue, 22 Apr 2025 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MuprIwlX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A817A2F6;
	Tue, 22 Apr 2025 02:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745287969; cv=none; b=nqMXkjz5n6Wd68sTMb3IBcHBShFL7f92DV68SosU0YOR6P7LM/46E4zi6dhlYfZSkINFPdd+qX7DHcMUaTEb5z5dolyl7VQyLoM7gLHnX1vQSoPMpqu/DqVMYmkWOUhdyK827eOyOUBIG84J16KHJiLS7PIzNiGBjGippuzl5bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745287969; c=relaxed/simple;
	bh=yEJ886LT/vO8/ZoQLLdlXxwV0nBH2cLO3gCdar/nAnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNjEvkMjkEylDUTtTnmevsjDAhpT70Fn0aOWV/eClzpdFI3v70mwL85JtlO3Yftq9fvqQJxu8dptgVKrS2PG2Tixql0Ax6SGJsbn2w7Eer54Ay8J4BNlTCzkm7pWC4VhkFXjHfDelcSjHqJKf0vIRSPC4xfkVOPzQ+S+9g8aCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MuprIwlX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=wyZ/GIFXWPHTuL2Tu+Fi0aXA2J/TiF9Y2weWF8VNT4I=; b=MuprIwlXMMmaf9/2/jcapMA7I5
	ZopGYeyHm1xekgwyCCVIwo15p8o3Vc2N3rfSMbYziBUV0OIVTUk7JZ9DUOkV2DdTdK+eAHObnhO5N
	oJztEsqs/nDdkQhmM+6dqnSQwO0Dzo5cjaEYcNXkjroNX5zbNqwvLDzxVCDC+SCNjmi5iTJ0VvWok
	hyovOAFrrtw9qAIU9ehansmLxnqXPCIqI9rW9rKSIu9wlmKiK4mWjVlUoBXjmOx3KKTSxmaE13qdB
	hX6odUkTTeh8IYaExLm3N/r3hZtFbBrpkCJ5qk+Xh4SNRNpk6fooMZtYEKbauD1Z47lFYA/GpnldE
	bNoxvSOA==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7361-0000000B7zG-0Q3i;
	Tue, 22 Apr 2025 02:12:17 +0000
Message-ID: <db2415e3-0ee7-4b72-ac6b-4c7cda875dd3@infradead.org>
Date: Mon, 21 Apr 2025 19:10:40 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/19] famfs_fuse: Add documentation
To: John Groves <John@Groves.net>, Dan Williams <dan.j.williams@intel.com>,
 Miklos Szeredi <miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, "Darrick J . Wong"
 <djwong@kernel.org>, Luis Henriques <luis@igalia.com>,
 Jeff Layton <jlayton@kernel.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, Petr Vorel <pvorel@suse.cz>,
 Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-19-john@groves.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250421013346.32530-19-john@groves.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/20/25 6:33 PM, John Groves wrote:
> Add Documentation/filesystems/famfs.rst and update MAINTAINERS
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  Documentation/filesystems/famfs.rst | 142 ++++++++++++++++++++++++++++
>  Documentation/filesystems/index.rst |   1 +
>  MAINTAINERS                         |   1 +
>  3 files changed, 144 insertions(+)
>  create mode 100644 Documentation/filesystems/famfs.rst
> 
> diff --git a/Documentation/filesystems/famfs.rst b/Documentation/filesystems/famfs.rst
> new file mode 100644
> index 000000000000..b6b3500b6905
> --- /dev/null
> +++ b/Documentation/filesystems/famfs.rst
> @@ -0,0 +1,142 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _famfs_index:
> +
> +==================================================================
> +famfs: The fabric-attached memory file system
> +==================================================================
> +
> +- Copyright (C) 2024-2025 Micron Technology, Inc.
> +
> +Introduction
> +============
> +Compute Express Link (CXL) provides a mechanism for disaggregated or
> +fabric-attached memory (FAM). This creates opportunities for data sharing;
> +clustered apps that would otherwise have to shard or replicate data can
> +share one copy in disaggregated memory.
> +
> +Famfs, which is not CXL-specific in any way, provides a mechanism for
> +multiple hosts to concurrently access data in shared memory, by giving it
> +a file system interface. With famfs, any app that understands files can
> +access data sets in shared memory. Although famfs supports read and write,
> +the real point is to support mmap, which provides direct (dax) access to
> +the memory - either writable or read-only.
> +
> +Shared memory can pose complex coherency and synchronization issues, but
> +there are also simple cases. Two simple and eminently useful patterns that
> +occur frequently in data analytics and AI are:
> +
> +* Serial Sharing - Only one host or process at a time has access to a file
> +* Read-only Sharing - Multiple hosts or processes share read-only access
> +  to a file
> +
> +The famfs fuse file system is part of the famfs framework; User space

                                                              user

> +components [1] handle metadata allocation and distribution, and provide a
> +low-level fuse server to expose files that map directly to [presumably
> +shared] memory.
> +
> +The famfs framework manages coherency of its own metadata and structures,
> +but does not attempt to manage coherency for applications.
> +
> +Famfs also provides data isolation between files. That is, even though
> +the host has access to an entire memory "device" (as a devdax device), apps
> +cannot write to memory for which the file is read-only, and mapping one
> +file provides isolation from the memory of all other files. This is pretty
> +basic, but some experimental shared memory usage patterns provide no such
> +isolation.
> +
> +Principles of Operation
> +=======================
> +
> +Famfs is a file system with one or more devdax devices as a first-class
> +backing device(s). Metadata maintenance and query operations happen
> +entirely in user space.
> +
> +The famfs low-level fuse server daemon provides file maps (fmaps) and
> +devdax device info to the fuse/famfs kernel component so that
> +read/write/mapping faults can be handled without up-calls for all active
> +files.
> +
> +The famfs user space is responsible for maintaining and distributing
> +consistent metadata. This is currently handled via an append-only
> +metadata log within the memory, but this is orthogonal to the fuse/famfs
> +kernel code.
> +
> +Once instantiated, "the same file" on each host points to the same shared
> +memory, but in-memory metadata (inodes, etc.) is ephemeral on each host
> +that has a famfs instance mounted. Use cases are free to allow or not
> +allow mutations to data on a file-by-file basis.
> +
> +When an app accesses a data object in a famfs file, there is no page cache
> +involvement. The CPU cache is loaded directly from the shared memory. In
> +some use cases, this is an enormous reduction read amplification compared
> +to loading an entire page into the page cache.
> +
> +
> +Famfs is Not a Conventional File System
> +---------------------------------------
> +
> +Famfs files can be accessed by conventional means, but there are
> +limitations. The kernel component of fuse/famfs is not involved in the
> +allocation of backing memory for files at all; the famfs user space
> +creates files and responds as a low-level fuse server with fmaps and
> +devdax device info upon request.
> +
> +Famfs differs in some important ways from conventional file systems:
> +
> +* Files must be pre-allocated by the famfs framework; Allocation is never

                                                         allocation

> +  performed on (or after) write.
> +* Any operation that changes a file's size is considered to put the file
> +  in an invalid state, disabling access to the data. It may be possible to
> +  revisit this in the future. (Typically the famfs user space can restore
> +  files to a valid state by replaying the famfs metadata log.)
> +
> +Famfs exists to apply the existing file system abstractions to shared
> +memory so applications and workflows can more easily adapt to an
> +environment with disaggregated shared memory.


-- 
~Randy


