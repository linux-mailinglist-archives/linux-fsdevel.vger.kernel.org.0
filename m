Return-Path: <linux-fsdevel+bounces-19808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C68C9E41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 15:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBBFBB22355
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1B13666D;
	Mon, 20 May 2024 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QVpUy6j/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6CA1CABA
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716212108; cv=none; b=aqcXB953BoxOEwvixSwg2FZUeZlB8MURq+F4/z7Z8N++X7WjVnPKhBXyCZvAhtSVxyIp3dJO7xWqMa7cAkNciuTtMmDmxivBtLThRUpDX8nxVBUwl26pEdWEMcxpz85nUEUiHQq57EG7t0TkHURJT6ETv6QBlGiYl/d2MJOIrb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716212108; c=relaxed/simple;
	bh=R/0zG6yLUYRJaCSaEdvkdqZcg4FkuA6onh3IU8OmRfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIv2hjIqTLl3Wfi2uVfRrnnxGSh3vkogS5YQFscTcBL7NkX0VWAPDv4j3+EnB2p1gh4DXRItNGrJYgeV/z7v1WBjuB48A6g6z5nIQjafZbO+2wbKbZDaiAu6udHoTTgkYIeauUbPjdv79qv2/Eg3BPWI4R8yWG7DP69fgVdWEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QVpUy6j/; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lkp@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716212103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gyw5WnWHpJz6E3Mc68G1X1pQFAugA2g3tSqbvj80T9o=;
	b=QVpUy6j/slpeF+8hheYUC0ArIclrwUJUOcg0BMYheBc3WY9jbEzvl8u3m4pJk/cVpU3t0Z
	u3v8gM+fsA8apsOwRvDm0Gz6yNeY4WnNfPQRjo79/+0fs9mbm8be4lf1ywSU7VlAFCWziE
	/VUBDF3ygfeGR5X9TuyANXi8Q6BKEmU=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: oe-kbuild-all@lists.linux.dev
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: hch@lst.de
X-Envelope-To: dylany@fb.com
X-Envelope-To: dwmw@amazon.co.uk
X-Envelope-To: pbonzini@redhat.com
X-Envelope-To: dyoung@redhat.com
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <18ef03df-8313-432f-bf24-aa685d099f3e@linux.dev>
Date: Mon, 20 May 2024 21:34:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] eventfd: introduce ratelimited wakeup for non-semaphore
 eventfd
To: kernel test robot <lkp@intel.com>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Paolo Bonzini <pbonzini@redhat.com>,
 Dave Young <dyoung@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240519144124.4429-1-wen.yang@linux.dev>
 <202405200456.29VvtOKg-lkp@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <202405200456.29VvtOKg-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/5/20 05:18, kernel test robot wrote:
> Hi Wen,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on brauner-vfs/vfs.all]
> [also build test ERROR on linus/master v6.9 next-20240517]
> [cannot apply to vfs-idmapping/for-next hch-configfs/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Wen-Yang/eventfd-introduce-ratelimited-wakeup-for-non-semaphore-eventfd/20240519-224440
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
> patch link:    https://lore.kernel.org/r/20240519144124.4429-1-wen.yang%40linux.dev
> patch subject: [PATCH] eventfd: introduce ratelimited wakeup for non-semaphore eventfd
> config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240520/202405200456.29VvtOKg-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405200456.29VvtOKg-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405200456.29VvtOKg-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     arm-linux-gnueabi-ld: fs/eventfd.o: in function `eventfd_write':
>>> eventfd.c:(.text+0x1740): undefined reference to `__aeabi_uldivmod'
> 

Thanks, we will fix it soon and then send v2.

--
Best wishes,
Wen

