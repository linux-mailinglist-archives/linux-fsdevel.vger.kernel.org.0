Return-Path: <linux-fsdevel+bounces-46487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824CDA8A2E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 17:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7597B1901569
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4912D297A55;
	Tue, 15 Apr 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V8O48bD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BEF1F09AF;
	Tue, 15 Apr 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731365; cv=none; b=apaSVX4tuoSehWoRREHHdOtikrwemhFy/s52gamMELEnM11C02rhf976ZpyXbWpcR2IWHj9z7qV3927bDORU82KIvRowPy4WcgWr6Nvx7E069X9uD5DovZhyph8bSqLfIuMGIkA5tsZxtEoXm3hTQEzAUaeabYXiA9YlkppRMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731365; c=relaxed/simple;
	bh=W/qEKmgYzhiwPl5j8TnuD6Qnqwc+H0JuT1WT0usuDCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tw+HsHeW5rfUOkkSwNHXfjjRnZ/IXhJaJ470D3VfDYdT9fS+t8MdNNA38ialnAzmgJ2yz/9vN528nTA13Mxcx8jTkw3xGA2X3t/WbmWwQxTEE8YqAnbKmORBoshNQkRLog4Vmy6wEonVg2zAq5ftlypqlFZlWaCpWCH3a4d4e6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V8O48bD1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=Y5WRKY0PJcWuc/36tZ7KYhFDUz9cW/oiKnyGh3ryV/Q=; b=V8O48bD1Yfzj7zB/z/ntXm/eoW
	v/gPxeiGNeMQl0++zd5F2Z6yWu64burgeyCuO4vYpoVLnUOzQGlXbkBwl+P22QcFzIWXbD2Wq+vKa
	z+vDh/OozEfMzGeBJktFI7+jLhxtuZk13kR+y2FdKs26WW6SNro13Lesvuq3cCeXY5Ca+JZAxphfh
	OvveyOmjOki8vxVNw85a21+EsTFWgix1bkVwOzGARma1KHIPrcK9B8kYvuEfvMnw9vrKkjRHGdpOQ
	w8vMla1+npAsADURYifIPOl0k2AjW4efrUFv0WMHGiSUqcoIEG9pc0c268PF+O7mI3+YENRMoYtn7
	MPmeJ7sg==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4iKK-00000008kMv-3wcJ;
	Tue, 15 Apr 2025 15:35:57 +0000
Message-ID: <bf2ed5d6-0e15-4e18-898e-317f9885099d@infradead.org>
Date: Tue, 15 Apr 2025 08:35:51 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/14] xfs: allow sysadmins to specify a maximum atomic
 write limit at mount time
To: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
 djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
 cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 ojaswin@linux.ibm.com, ritesh.list@gmail.com, martin.petersen@oracle.com,
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
 catherine.hoang@oracle.com, linux-api@vger.kernel.org
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-15-john.g.garry@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250415121425.4146847-15-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/25 5:14 AM, John Garry wrote:
> diff --git a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
> index b67772cf36d6..715019ec4f24 100644
> --- a/Documentation/admin-guide/xfs.rst
> +++ b/Documentation/admin-guide/xfs.rst
> @@ -143,6 +143,14 @@ When mounting an XFS filesystem, the following options are accepted.
>  	optional, and the log section can be separate from the data
>  	section or contained within it.
>  
> +  max_atomic_write=value
> +	Set the maximum size of an atomic write.  The size may be
> +	specified in bytes, in kilobytes with a "k" suffix, in megabytes
> +	with a "m" suffix, or in gigabytes with a "g" suffix.
> +
> +	The default value is to set the maximum io completion size

Preferably                                      I/O or IO

> +	to allow each CPU to handle one at a time.
> +

-- 
~Randy


