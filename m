Return-Path: <linux-fsdevel+bounces-11892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E348586B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 21:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E521F23799
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 20:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0588B13958F;
	Fri, 16 Feb 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RRxHNBPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A671135A52;
	Fri, 16 Feb 2024 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115222; cv=none; b=Ie/hys+z4/HpPa4V0R3I736arKK6O4zt51crsbMfamZO8CL6h2P13TFnhiNaM3SdPieJBxsyFFzwjhR182E8r1gVEPL2fjW/Adw59OVK+g3tRiY671O6masv5BbSTP4iHPKoXv4ePwic8h2ES2paefWM36DBpouZYg+hgEDr0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115222; c=relaxed/simple;
	bh=4msKTmkJW7dgdyjzaO++qxlbe/qOaAOivOp2PggqhwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuNYFckE/A0BJY7dq2/p1IL/5ttXroBsJDOn92j918Bxwfmvk60Y3RxqJI+hQPS0vyjUrBqPh4iS1L+idSQv1Yf04h+lXipeKOxPprRdTlqjgC96tlpMbYeJGuMQqYYhbyUrjLj704y4bUO/07ir0N/5K2JgarSYmHqTbzrFLcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=RRxHNBPr; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1708115218;
	bh=4msKTmkJW7dgdyjzaO++qxlbe/qOaAOivOp2PggqhwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RRxHNBPrj8LGz7Z9Jh14gfeYIc57tQQuawpAG5T+0/bLUZ2gVOxZmtqWvWJdkkAp0
	 YvwBEvSxw+gYg/F+iZg0/5ntvxWrGAcGbcywQ60bjIRvrKF2rYi43zWwHhIrKXF1HO
	 jOahTC8AM3Udm230CPordzWcN6SRvRZ9FRJC89ZpSvZwzPBzsM2ymfuLZ2gykLCw/p
	 BMQDLc5AeiN0aNA5MfhPyYVUQjhz5SG5wdzmhC0DBlTJbh5EPTQBD0d1WclweVVjVD
	 L6FbdEkuEMTMWZJdywRnehGsoHuKKrk2PxjrMVuaDn3Gd6gm2TERJZMeXrbnxKICYw
	 bDJwNREpp/WMQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tc3PZ5RySzb14;
	Fri, 16 Feb 2024 15:26:58 -0500 (EST)
Message-ID: <b3ab82c4-0b1c-41d1-ac59-dfd4ef4a2b4e@efficios.com>
Date: Fri, 16 Feb 2024 15:26:57 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dax: add set_dax_nomc() and set_dax_nocache() stub
 helpers
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Jane Chu <jane.chu@oracle.com>, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240216202300.2492566-1-arnd@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240216202300.2492566-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-16 15:22, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In some randconfig builds, the IS_ERR() check appears to not get completely
> eliminated, resulting in the compiler to insert references to these two
> functions that cause a link failure:
> 
> ERROR: modpost: "set_dax_nocache" [drivers/md/dm-mod.ko] undefined!
> ERROR: modpost: "set_dax_nomc" [drivers/md/dm-mod.ko] undefined!
> 
> Add more stub functions for the dax-disabled case here to make it build again.

Hi Arnd,

Note that this is a duplicate of:

https://lore.kernel.org/lkml/20240215144633.96437-2-mathieu.desnoyers@efficios.com/

now present in Andrew's tree.

The only differences are the subject, commit message and a newline between "set_dax_nomc"
and "set_dax_synchronous" in your change.

Thanks,

Mathieu

> 
> Fixes: d888f6b0a766 ("dm: treat alloc_dax() -EOPNOTSUPP failure as non-fatal")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402160420.e4QKwoGO-lkp@intel.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   include/linux/dax.h | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index df2d52b8a245..4527c10016fb 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -64,6 +64,9 @@ void dax_write_cache(struct dax_device *dax_dev, bool wc);
>   bool dax_write_cache_enabled(struct dax_device *dax_dev);
>   bool dax_synchronous(struct dax_device *dax_dev);
>   void set_dax_synchronous(struct dax_device *dax_dev);
> +void set_dax_nocache(struct dax_device *dax_dev);
> +void set_dax_nomc(struct dax_device *dax_dev);
> +
>   size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
>   		void *addr, size_t bytes, struct iov_iter *i);
>   /*
> @@ -108,6 +111,12 @@ static inline bool dax_synchronous(struct dax_device *dax_dev)
>   static inline void set_dax_synchronous(struct dax_device *dax_dev)
>   {
>   }
> +static inline void set_dax_nocache(struct dax_device *dax_dev)
> +{
> +}
> +static inline void set_dax_nomc(struct dax_device *dax_dev)
> +{
> +}
>   static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>   				struct dax_device *dax_dev)
>   {
> @@ -120,9 +129,6 @@ static inline size_t dax_recovery_write(struct dax_device *dax_dev,
>   }
>   #endif
>   
> -void set_dax_nocache(struct dax_device *dax_dev);
> -void set_dax_nomc(struct dax_device *dax_dev);
> -
>   struct writeback_control;
>   #if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
>   int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


