Return-Path: <linux-fsdevel+bounces-69942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F091C8C757
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 01:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13253B6371
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 00:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5A8261B91;
	Thu, 27 Nov 2025 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gqVzMPLJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88252580F9;
	Thu, 27 Nov 2025 00:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204278; cv=none; b=aWx0jjKDp9cNtw4C4XSzDnOqe/2OXTzLC4a4KtIMIMpwLBj022ZAQPSkyi9aGImeyGzGjtJOTVyHKpHziSo8PIPknjbkWAjg90QXqv2TNIeKlOjNVVL7qdMHGiZYn1fxinOFUhAUefHnu/opRxZdnNBigijtp1OuGgWWDaG/TSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204278; c=relaxed/simple;
	bh=7z5IKQFAXUxEN+Oh/VtXe1mg6locxHxjxzSlnVKmKJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWBsC7ICHtwLvlqdGEoIiVsHnJeOAzUSdE+Zv0zzxnoIjatdntGPdfisa/YuKS+mxXHAKopGJ+vdkktRaed2p+DuidSKY5+w754egtaMIuXbg30u/g1W2Q1vfIh8vrFcqfL1WXalTD4I8mc9A8Q4iV0DU76riXYsdLIhqMV6bbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gqVzMPLJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=bZxZLbXg0sjgaoKMLUl6ErzwogRnF1d27IW4jtEMG4k=; b=gqVzMPLJOGskPNCUreBI9UJJQQ
	rwuff5Duv5/v5U43TiPev902xh6A8FI5n0pTKgtZk3s4Lw448TsrSt84lPGwDnUbRpdwIUeZBUJBN
	xCNPPWIu9D3gKDS608kXbHoIxH/8L9dP+5L5tylbdXDz7b3NB+ewFpe/BDj1JFYmPqiD8Eu+6HHb8
	DcwJvnEhKeoQR21CHwrr3syib7aMkjOpYz/tMPNHJyEGRfDA0xuwL5seg7Iti49HMyF9GjwlALCkO
	5KwIhrfnH/FZltECT4fggChqASz0nDZue7lG+tnas0IWtMwHq/YNAQcavWVYf3ilvR+FGXKZaKT4A
	aBPALhUQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOQ7g-0000000FoXf-0Elk;
	Thu, 27 Nov 2025 00:44:36 +0000
Message-ID: <a2c0a723-dbcb-4a43-ba47-c1f06820099a@infradead.org>
Date: Wed, 26 Nov 2025 16:44:35 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] Documentation: zonefs: Format error processing table
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
 <20251126025511.25188-6-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251126025511.25188-6-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/25/25 6:55 PM, Bagas Sanjaya wrote:
> Format zonefs I/O error processing table as reST grid table.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/filesystems/zonefs.rst | 53 +++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 21 deletions(-)
> 

-- 
~Randy

