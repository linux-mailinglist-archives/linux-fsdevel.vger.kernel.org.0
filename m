Return-Path: <linux-fsdevel+bounces-17856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B1D8B2FBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 07:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C33B21F27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 05:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BC613A3EC;
	Fri, 26 Apr 2024 05:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bQBX29ER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948EC1849;
	Fri, 26 Apr 2024 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714109536; cv=none; b=W0Qw0ad7384otbLXYCULapPx1mf2U+d5S1Mvt6uQcP4r+fbBX60nc9iSJELDsP4g41k62WXZ9gXeifg0qVGkraY+lTpnBlRZy+6xD32asKXzrfRLmmmrWK8XeOQCLdhY9dehsLianpdzfhcu67N5nHal3+pPOLU+SA86pclwwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714109536; c=relaxed/simple;
	bh=ykHDYdfW+I3pR9qLK4+0CQxC91lHC0AHO4V52GwfavM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpKXCjEQEhddvOLrsozSrszc9MGPcKb5qi8B1qfoavKwAFmyDBC29WBOC3wNUAZg9prTFFkqhU6XGErkyvRac7B2msX1l/g3kE4pSupwvmy5Mfuh62D4DjJhacYlLpDT0SSFymho66OKheeULrqhuaac7W4duUTjcaKUctUYvcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bQBX29ER; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714109528; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UrSzjICOOeYfI55ilLcClDecrSKT9UOi+NvDXzKPfPM=;
	b=bQBX29ERZE2PTOhhyt3U1LCs9tDHwxI8HwEu9HI+EM2TNhb5AJGtXFZDXUB2egb4pUm4381XD0tUf0UFC8u+VUDf47KqvqBPqy12y1lCzMHEPveSJ3DRoFrX8E1pBNgjQPeEVJIJeeCLZgfdGv87/PYJ6rzcQC6nv18tpyNGTRo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5I3EcV_1714109525;
Received: from 30.97.48.164(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5I3EcV_1714109525)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 13:32:06 +0800
Message-ID: <7ba8c1a3-be59-4a2f-b88a-23b6ab23e1c8@linux.alibaba.com>
Date: Fri, 26 Apr 2024 13:32:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] z_erofs_pcluster_begin(): don't bother with rounding
 position down
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
 brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 yukuai3@huawei.com
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
 <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
 <20240425195641.GJ2118490@ZenIV> <20240425200017.GF1031757@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240425200017.GF1031757@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Al,

On 2024/4/26 04:00, Al Viro wrote:
> ... and be more idiomatic when calculating ->pageofs_in.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   fs/erofs/zdata.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index d417e189f1a0..a4ff20b54cc1 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -868,7 +868,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>   	} else {
>   		void *mptr;
>   
> -		mptr = erofs_read_metabuf(&map->buf, sb, erofs_pos(sb, blknr), EROFS_NO_KMAP);
> +		mptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, EROFS_NO_KMAP);

This patch caused some corrupted failure, since
here erofs_read_metabuf() is EROFS_NO_KMAP and
it's no needed to get a maped-address since only
a page reference is needed.

>   		if (IS_ERR(mptr)) {
>   			ret = PTR_ERR(mptr);
>   			erofs_err(sb, "failed to get inline data %d", ret);
> @@ -876,7 +876,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>   		}
>   		get_page(map->buf.page);
>   		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
> -		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
> +		fe->pcl->pageofs_in = offset_in_page(mptr);

So it's unnecessary to change this line IMHO.

BTW, would you mind routing this series through erofs tree
with other erofs patches for -next (as long as this series
isn't twisted with vfs and block stuffs...)?  Since I may
need to test more to ensure they don't break anything and
could fix them immediately by hand...

Thanks,
Gao Xiang


>   		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
>   	}
>   	/* file-backed inplace I/O pages are traversed in reverse order */

