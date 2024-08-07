Return-Path: <linux-fsdevel+bounces-25235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1B594A1E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3991C22624
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A7A1C8FD1;
	Wed,  7 Aug 2024 07:38:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1F57C6D4;
	Wed,  7 Aug 2024 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723016318; cv=none; b=UR/cTadlYAn3YxdupXRHOhUt/KxUTpkLcaZGgwAwIziT8kvWO0FA0AjdE4p6E9HomZu3COLqjHzcU5Kd9NkzX0MK6q11iy+GYd5PHc+DlUXJKSWQ72YiriIu2pELPtXGVcYiHD9Hf9Q4Nv0ClCpNOplUIhOLowsNCsCtsP84mAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723016318; c=relaxed/simple;
	bh=XRA9gxRLFd+aej8AzR4p1woSAT7nCVx80V+h4XrJ6rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIt5P6av5lPWFpta5NWDFOlgfbPLgY5UJQjDPMuTxJmlEnIMYVifV+O4s0aqi89i6x3T4hoKblI1suVmBwHWdxIwFjluSUPD1wybSeDI8jwmFGBxiPFu0b0AfncrOMU6fO66kUblocfOa62RVovmrpK7aVFNBhowtGOkEV3sg9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FBB2FEC;
	Wed,  7 Aug 2024 00:38:55 -0700 (PDT)
Received: from [10.57.81.112] (unknown [10.57.81.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 687A53F5A1;
	Wed,  7 Aug 2024 00:38:25 -0700 (PDT)
Message-ID: <e693ed7a-97bf-486b-84fb-f57e44a399b4@arm.com>
Date: Wed, 7 Aug 2024 08:38:23 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [fs] cdc4ad36a8:
 kernel_BUG_at_include/linux/page-flags.h
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>,
 kernel test robot <oliver.sang@intel.com>,
 Christian Brauner <brauner@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-bcachefs@vger.kernel.org,
 ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, linux-karma-devel@lists.sourceforge.net,
 devel@lists.orangefs.org, reiserfs-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <202408062249.2194d51b-lkp@intel.com>
 <ZrLuBz1eBdgFzIyC@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZrLuBz1eBdgFzIyC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2024 04:46, Matthew Wilcox wrote:
> On Tue, Aug 06, 2024 at 10:26:17PM +0800, kernel test robot wrote:
>> kernel test robot noticed "kernel_BUG_at_include/linux/page-flags.h" on:
>>
>> commit: cdc4ad36a871b7ac43fcc6b2891058d332ce60ce ("fs: Convert aops->write_begin to take a folio")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>> [test failed on linux-next/master 1e391b34f6aa043c7afa40a2103163a0ef06d179]
>>
>> in testcase: boot
> 
> This patch should fix it.
> 
> Christian, can you squash the fix in?
> 
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 7d28304aea0f..66ff87417090 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2904,7 +2904,8 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>  	if (ret)
>  		return ret;
>  
> -	if (folio_test_has_hwpoisoned(folio)) {
> +	if (folio_test_hwpoison(folio) ||
> +	    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio))) {

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Tested-by: Ryan Roberts <ryan.roberts@arm.com>


>  		folio_unlock(folio);
>  		folio_put(folio);
>  		return -EIO;


