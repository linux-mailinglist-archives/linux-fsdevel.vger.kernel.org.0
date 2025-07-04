Return-Path: <linux-fsdevel+bounces-53894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDB5AF87B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3AF542F10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 06:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667E3222561;
	Fri,  4 Jul 2025 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PTk2Oq3y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A31DF756;
	Fri,  4 Jul 2025 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609424; cv=none; b=ky/6EvSLtWhV8tZXVbP0w0fyPG2tkvcvKkhb+7ivKIub19u3e6rfnIIcfhdMNM9CzAFZmflIqjjpE8vIzSuPBECoboPQyCXZA2wXnPvLr1qk7UEeZw+QelUuv9Xxrt8WWTYcT0SzyAkzAzqci1bITE2gvGHYgXBPnuO3RiuerBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609424; c=relaxed/simple;
	bh=CxHAxktoHJAyt0G6QGsxafp1nKxtEgwB3RWi1pJP4bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjC67l+0zEuowFYvBwMhxfzbDz4gCqiBRJaEyRAPq4YzrFcQf6ulaXGad5NtrUpDOOdBrAmLKhhsx148Mt+aaqf72SkYkxWVF33XwGkwNXNlhy32If5vkbHZ6d0ono2WCKP7ttiqZa1dG7K6XrGKqwhMR+O8O0jqR7nWyg8gJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PTk2Oq3y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=kQKcvzRgFOqKKs8mwcVW/CGTdsDvbDbBCI43oUXv5xU=; b=PTk2Oq3yzW5wUfahuvMqEMtn2k
	GghuMT40r9jeqjmT4h1NctLafhvKGd4CbVxJykbRO4v4pXft4/cpWJ3F/Nhjk6NMUt0w1Q0ngAfqj
	CqK1hfuPJHoqJmpdETP3+6raUjM/ROFVBI8paZ0FFeUrK5b0s6v8OAfwWuYGxDV8xDiCEqkj125Bw
	Wd3hx1+/dnm0gwsgU9vQ8cj159oOB5MSu7ejUyvRBlXzg4B7DMdNsQbVpD6edadUCwsuc27H7LzKz
	6GvtrXlT1xHBzboxPPPcS7Aqi/xiOdIOJm7Jfd6vFYtOuNqCMrDGFZTsq+pT3c+a+A0VKHub25FXD
	B40sBv8A==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXZcc-0000000FoJ0-1edk;
	Fri, 04 Jul 2025 06:10:06 +0000
Message-ID: <3dfcf93e-ae48-48b4-bfc5-ff3146908adc@infradead.org>
Date: Thu, 3 Jul 2025 23:09:59 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 18/18] famfs_fuse: Add documentation
To: John Groves <John@Groves.net>, Dan Williams <dan.j.williams@intel.com>,
 Miklos Szeredi <miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, "Darrick J . Wong"
 <djwong@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-19-john@groves.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250703185032.46568-19-john@groves.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/3/25 11:50 AM, John Groves wrote:
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


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.


-- 
~Randy

