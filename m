Return-Path: <linux-fsdevel+bounces-73523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDFFD1BE52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 02:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B832730383A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 01:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32A122B5A5;
	Wed, 14 Jan 2026 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i+3Olke2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD84827453;
	Wed, 14 Jan 2026 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353391; cv=none; b=fyBNZ7tEDfCAnGg8XM9EpPgcEepmrKOm5v8Oc8PaAhvQkvCee8Y3PQ9BL0cSh4Lv8FJI2b4CZJfDL3vjVih1wZSNR93C/Hbd5HDYTy4ZLkWgPif4MhkZkRJifYpNbKNaD5OHhg3n1WQBjGfYQOWv4FiGsCII5K9DBSHGUbbtg4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353391; c=relaxed/simple;
	bh=jeHqRT/v9Yr3994DElF8+6FtcWBzM3weQ9iMxlw3SZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyNFC0+Nlmn6vtjMZGZ+CsPl5i/EJY47J0Yuk6dbrwcEvj+2esRFKwO1NWZpL/Qg9CiydI3E7pF81R5PJfOyl/v9OhWDGLr7bpprLLJTmolRmXhDSSQ8oqKqRxwVcEaRD+vtp0d1Slt6WaGs5G9vI2lS5jeA1dRNLhP5bpwir7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i+3Olke2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0Aue8vXZn7Yc9Fjo4NRA16qV2onptu563pa/H1kbpyc=; b=i+3Olke2ZMsamEa7gIoN9DXaF+
	xMsY6u/w72Xch8hi2CE3tEIAUwO8TpSNRkcbzBD4speN3r54gedrt2pOmQDsyYBW3frrB8NMOZ3f8
	zfXE+60L4+3wI/84WkcE1mB2fH5gf/pSXkrl4DRrsAeembDRMb82v8Vie8cBxZZu2nV2szsFf9yAT
	QzYFSIz+PDgRv/HCwglJPkTIUlRCYcbrPJtGxKw4R5NIdKegkynL2QJlK8f2fThYty09zD4pb29H9
	3BzPZ6kV0U/K2cyOZmqm7WZ99ewGvS1MG4+zkPefvd7ngL1eDtSPZaBayI9FXp1pw0EhT/TAvQVFv
	FFR1kHWw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfpUf-00000007w06-1614;
	Wed, 14 Jan 2026 01:16:17 +0000
Message-ID: <d36eea96-c017-4217-b406-77758cef28c3@infradead.org>
Date: Tue, 13 Jan 2026 17:16:15 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] exportfs: Some kernel-doc fixes
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/12/26 5:51 PM, André Almeida wrote:
> This short series removes some duplicated documentation and address some
> kernel-doc issues:
> 
> WARNING: ../include/linux/exportfs.h:289 struct member 'get_uuid' not described in 'export_operations'
> WARNING: ../include/linux/exportfs.h:289 struct member 'map_blocks' not described in 'export_operations'
> WARNING: ../include/linux/exportfs.h:289 struct member 'commit_blocks' not described in 'export_operations'
> WARNING: ../include/linux/exportfs.h:289 struct member 'permission' not described in 'export_operations'
> WARNING: ../include/linux/exportfs.h:289 struct member 'open' not described in 'export_operations'
> WARNING: ../include/linux/exportfs.h:289 struct member 'flags' not described in 'export_operations'

For all 4 patches:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!

> ---
> André Almeida (4):
>       exportfs: Fix kernel-doc output for get_name()
>       exportfs: Mark struct export_operations functions at kernel-doc
>       exportfs: Complete kernel-doc for struct export_operations
>       docs: exportfs: Use source code struct documentation
> 
>  Documentation/filesystems/nfs/exporting.rst | 42 ++++-------------------------
>  include/linux/exportfs.h                    | 33 ++++++++++++++++-------
>  2 files changed, 28 insertions(+), 47 deletions(-)
> ---
> base-commit: 9c7ef209cd0f7c1a92ed61eed3e835d6e4abc66c
> change-id: 20260112-tonyk-fs_uuid-973d5fdfc76f
> 
> Best regards,

-- 
~Randy

