Return-Path: <linux-fsdevel+bounces-19222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 308988C18DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 00:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE721F22FF1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D76129A6B;
	Thu,  9 May 2024 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="n+/oc90g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892991292CC;
	Thu,  9 May 2024 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292007; cv=none; b=Aax4KDamI3X+f9hI0V631I9un9UUupwwpDXJgrb0y0u4yfZY31/84+ADOytPPT5Wg1mdGpsLRc7mzHF2reEwrf7Q7LOmNLwdux/in5qeL5/0awSeRDw9YlCqvzgczMOEFDU2jSClXJT5GLefHMHuN0gJa1z9XdFWJ3cNAwm2qz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292007; c=relaxed/simple;
	bh=fhTJUGDcdOi43Jnd8puKDUnYXo8xg3dyrBSae3d5BFY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=Yu3Bqywk+2hZ7uXShm7ra3JKsY+bbAB3XP7aPK7vsBF09k5APq0jHRsoGWLWdkgNcZhpo6ESNU6IeFFvQTYFC1P4FZQIji4cIbtoNMOVrKAXCusLVqiqzha6tJRBgqfZANtQDVXaSBHsWzRYNTCnrcPZmWW4m8gAjUir4r9r6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=n+/oc90g; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=6ReveTWWElOwm+nOGbREtwyDH8pYqac9yedB8poPIGw=; b=n+/oc90gcMIoirqjRPYU5I+I7c
	jBk0Nz3akXqr9z99aU970UhzNXSLgCnlcK7LnHN+/lW7cpL+5Hiz3MfmYRc6MY55VS71LgnfXZYMy
	zit14EOdpEv/3Qh9w/CjkjyL8XVSzIFBkWpEAt42olr05QNVrWNQmcv33eddLZG5BCD8kq+lMeg4P
	lyRU9T5CFUq8vCTh8O6GSTaYD5Xi8MJJQ7ZGjCWfPece1jKNA+2sfHBqjUG/jAAiK7r82JCXHguRg
	MzUsWIALL2EHT8tx+bKCpU/qj7O1TP0rOm0u2rcm0I3lwI/U+OnKQbsPUDGRMdW05H1VcUKMgvUkG
	FPrQ88mw==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1s5Bnn-00EPCu-8r; Thu, 09 May 2024 15:59:48 -0600
Message-ID: <4393e0d9-28c5-4b85-b603-40e457c9beba@deltatee.com>
Date: Thu, 9 May 2024 15:59:35 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc: david@fromorbit.com, dan.j.williams@intel.com, jhubbard@nvidia.com,
 rcampbell@nvidia.com, willy@infradead.org, jgg@nvidia.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org, hch@lst.de,
 david@redhat.com, ruansy.fnst@fujitsu.com, nvdimm@lists.linux.dev,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, jglisse@redhat.com
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <a443974e64917824e078485d4e755ef04c89d73f.1712796818.git-series.apopple@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <a443974e64917824e078485d4e755ef04c89d73f.1712796818.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: apopple@nvidia.com, linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com, jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org, jgg@nvidia.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org, hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com, nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, jglisse@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [RFC 03/10] pci/p2pdma: Don't initialise page refcount to one
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Hi Alistair,

I was working on testing your patch set, however I'm dealing with some
hardware issues at the moment so I haven't fully tested everything yet.

I managed to find one issue though:

On 2024-04-10 18:57, Alistair Popple wrote:
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index fa7370f..ab7ef18 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -128,6 +128,8 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>  		goto out;
>  	}
>  
> +	get_page(virt_to_page(kaddr));
> +

kaddr may represent more than one page, so this will fail to map
anything if the mapping size is greater than 4KB. There is a loop just
below this that calls vm_insert_page(). Moving a set_page_count() call
just before vm_insert_page() fixes the issue.

Thanks!

Logan

