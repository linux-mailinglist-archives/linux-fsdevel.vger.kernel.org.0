Return-Path: <linux-fsdevel+bounces-60601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 145E4B49D68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 01:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B811BC3E90
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 23:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ACB2F60A2;
	Mon,  8 Sep 2025 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o/yhZAT6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E751DFE0B;
	Mon,  8 Sep 2025 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757373463; cv=none; b=o2yCZT/SwWuT16yOBK3hJvD6NrolM482KwUFdnWkkRa9rBvOwulASl593WpuxXMJfZCqYTyccDb4oQ15rsy7r4x7GPlaHVOZUw9wKZKDzY/1HpwGxFOIQYG/X8IuZbqoI4KlxDkBjs2FM9FO5mNW+0PTu8nPGrDsFMbYExH1cvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757373463; c=relaxed/simple;
	bh=H/1lSf0qRkqLPIS21dDIq6+Jb5KinRAndOcezAcipC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDJr5dXBb4hu2+iXAOXy+igaYSJ2cELzjZcHXJtHDzG7tT+AYXocDmXkrF+WzkCeq401SYrIJz2hVMyAwWfEmT5k2CO5H5MoHle79je7Tbwhxq0c/Q1P3DYG2tagkJOt8mk9Zw0S/tZrV9CyUT2xSPW9HEcu1mOnaIEsvj82Ja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o/yhZAT6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=CMlqYlKj+ILUokIqP1ABAMFD7Ot5oBLbcsJFMFm2zE0=; b=o/yhZAT6Pleqpfj3cap4+Ocr0X
	SQndNm93uEb+a4QqInydfI6lMJSJFzsSu3/0qeMTKdhPtlmWw3TUQRbR6L2wKk2W3Fv+UH9KsOJEg
	9qPRFInLAK8DjwwP3kbclODQZmsO+zdGm2eIzKDYqjx3wV8Z9WwBemPbQiE4A+eNMuh7m64z6qIdV
	KXBfJtcalLtNb7nUQOkOJ5v6vc4bBx6ZTya7R+MDIox9Nxyg/2OCB4wbhLPO78J0Opb4io0rwvic4
	NDpaGlW9vP1blgirQfaegykINHE1UsAXggKwlIZNRbsS5mNDQybb9YhDkcTYBLtgKyHdfGed+PEsS
	przXJOJw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvl6s-00000002unf-1xHe;
	Mon, 08 Sep 2025 23:17:18 +0000
Message-ID: <c0d7df5f-ac43-4e15-8400-155bf87d5e77@infradead.org>
Date: Mon, 8 Sep 2025 16:17:16 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] doc: update porting, vfs documentation for
 mmap_[complete, abort]
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 kexec@lists.infradead.org, kasan-dev@googlegroups.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <1ceb56fec97f891df5070b24344bf2009aca6655.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1ceb56fec97f891df5070b24344bf2009aca6655.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 9/8/25 4:10 AM, Lorenzo Stoakes wrote:
> We have introduced the mmap_complete() and mmap_abort() callbacks, which
> work in conjunction with mmap_prepare(), so describe what they used for.
> 
> We update both the VFS documentation and the porting guide.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  Documentation/filesystems/porting.rst |  9 +++++++
>  Documentation/filesystems/vfs.rst     | 35 +++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 

> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 486a91633474..172d36a13e13 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst

> @@ -1236,6 +1240,37 @@ otherwise noted.
>  	file-backed memory mapping, most notably establishing relevant
>  	private state and VMA callbacks.
>  
> +``mmap_complete``
> +	If mmap_prepare is provided, will be invoked after the mapping is fully

s/mmap_prepare/mmap_complete/ ??

> +	established, with the mmap and VMA write locks held.
> +
> +	It is useful for prepopulating VMAs before they may be accessed by
> +	users.
> +
> +	The hook MUST NOT release either the VMA or mmap write locks. This is

You could also do **bold** above:

	The hook **MUST NOT** release ...


> +	asserted by the mmap logic.
> +
> +	If an error is returned by the hook, the VMA is unmapped and the
> +	mmap() operation fails with that error.
> +
> +	It is not valid to specify this hook if mmap_prepare is not also
> +	specified, doing so will result in an error upon mapping.

-- 
~Randy


