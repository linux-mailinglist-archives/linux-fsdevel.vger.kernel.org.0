Return-Path: <linux-fsdevel+bounces-69940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E7BC8C73C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 01:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AC0E3525C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 00:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03C1262FF8;
	Thu, 27 Nov 2025 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2boYfm55"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D58226D02;
	Thu, 27 Nov 2025 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204208; cv=none; b=bQqFgJJfUkJAZDSUCns8C1m9pD7Ay1ObP/Ve6mgrX7chVF/8Nw2fSGwT7O3QXiSL6z+cKx24OQWdROA0xPh0VYdPDYlTmWZ63Ofx1oBFqd8MbbU+2uewDj3HmTxrOSeeKgdywfg3thtKnGo+wpfXqlRokmMzAnyDYVU9MfAKcAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204208; c=relaxed/simple;
	bh=E+ipyIJJgS4TGZntAa0NRur89yYSq/Ez/ZiMpfO0lJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tehPRzy2TRwlrO1pp40gOgQJu8pFqcDaMBeJmTP0OD8NMkfBdrxQyr1QcwIdMzwasew0hDIVWl9SzSqG9L2m7XLFmpVlTPzI3BmXOJIOlsBX9dnM3Pu0iAOtE88Rez+6RzVQ8QtAoG+aL6t+QLxgM4ltjtl82awqPmvR6cmM7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2boYfm55; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tMS0kPmSyrmByotNrG3p67BffI2BZCpLPmO/aHPOhM4=; b=2boYfm55s+ptgSFG37CFQk6u98
	+SoEIQEXy0j/uT4tCeL8NT80DbMMQKRM6WCPeJue4q29YvrqV6ofknd9qWESNMeFiCmnaRSAQXTwX
	nFpOy+Ev5B3Y/IijhUO+9j18Rdrk9Nfih1IQ91WU7ZXYYGG+2LQBZPDsKGYPR4ZtbjZICcKZaaBJj
	abzI4RaKehiOFK8SZ4JCz/keOFLNSP/Curciw4Swsfck8UgqqRg1GNrVc3wH/0qwb0RjtAboc4hDV
	jJZu4IN8dCZHEP6Qr2/llUiDWXiTrOVKYk/LRJpozNlh9OrWKF4eE0aeVWL/gUCdpJq0rbYMaqk/e
	1NVEZEZw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOQ6X-0000000Fo95-3UMa;
	Thu, 27 Nov 2025 00:43:25 +0000
Message-ID: <7c2d5c02-3d7b-486c-afe8-d01ef05f8cdb@infradead.org>
Date: Wed, 26 Nov 2025 16:43:25 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] Documentation: dax: Coalesce "See also" filesystem
 pointers into list
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux AFS <linux-afs@lists.infradead.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, Jonathan Corbet <corbet@lwn.net>,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Daniel Palmer <daniel.palmer@sony.com>
References: <20251126025511.25188-1-bagasdotme@gmail.com>
 <20251126025511.25188-3-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251126025511.25188-3-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/25/25 6:55 PM, Bagas Sanjaya wrote:
> Filesystems for DAX implementation inspiration is listed in "See also"
> admonitions, one for each filesystem (ext2, ext4, and xfs). Coalesce
> them into a bullet list.
> 
> While at it, also link to XFS developer documentation in
> Documentation/filesystems/xfs/ instead of user-facing counterpart in
> Docmentation/admin-guide/xfs.rst.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/filesystems/dax.rst | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 

-- 
~Randy

