Return-Path: <linux-fsdevel+bounces-68171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 835D0C55593
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 02:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD3414E3932
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC262BE62E;
	Thu, 13 Nov 2025 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="U2vt6KLE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB06299AB5;
	Thu, 13 Nov 2025 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998702; cv=none; b=YtGk7/Qe+Z90d6wUMadHjmJauDOlL7qzRwsZwIjajsn32efeZno1JH8xK7YES1ozRf0vD+G/0Ba1Ankvm27TfSlblRJEp9Q9q6tkF8iIkL4zWlGkT0LW/nrsGzOXVm6c2JVSswOx1mk4k7WeEf1lMHi9aIUJyrM3kkC4nfqq/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998702; c=relaxed/simple;
	bh=Dk0t3yp7I3dbZZKjBgs5rsR9ZTqzpO3u/ShS8k8IPh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jF9yf236F2HwmArXccBOs52TVBdYmAZo14Y1mDEoQRRk69FrXnFirz5o0LTMZSldcGPPOyvzDCz3yYTyAqQfJZ28isL6f6mhKgZzp4/sO0x4fmOGIY6m2nvPnupBi+bWKzmmBAeoRehyWQVmU/kZZDK8hbIxnj03/gY39hXWJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=U2vt6KLE; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qL8ILY1tAoCz6fUcrgnH3Kya3faamKjXzPtGdIrlO08=;
	b=U2vt6KLE58kKcCF+IcP1XgCZ25INIZCxS/CcmGxmznrriRvrdTVZatUM3So/7STn4Td4M4jyQ
	DsDNg9X4Yz4S6wb4h3cjjNj0GYTjScq6hU+AfxdrNzmdceh1tzEMkdjfgsJZpPEFZL4VXDUnO+w
	ZmYs3GW3cJt6n52SLeXDVtQ=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4d6NW172hsz1prKm;
	Thu, 13 Nov 2025 09:49:49 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 861901401E9;
	Thu, 13 Nov 2025 09:51:30 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Nov
 2025 09:51:29 +0800
Message-ID: <b640a61c-6bcb-421e-9dc7-9dff76163dc9@huawei.com>
Date: Thu, 13 Nov 2025 09:51:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.1 04/33] common/rc: skip test if swapon doesn't work
Content-Language: en-GB
To: "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>
CC: <zlang@redhat.com>, <neal@gompa.dev>, <fstests@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<joannelkoong@gmail.com>, <bernd@bsbernd.com>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820051.1433624.4158113392739761085.stgit@frogsfrogsfrogs>
 <016f51ff-6129-4265-827e-3c2ae8314fe1@huawei.com>
 <20251112182617.GH196366@frogsfrogsfrogs> <20251112200540.GD3131573@mit.edu>
 <20251112222920.GO196358@frogsfrogsfrogs>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251112222920.GO196358@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-13 06:29, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>
> In _require_scratch_swapfile, skip the test if swapon fails for whatever
> reason, just like all the other filesystems.  There are certain ext4
> configurations where swapon isn't supported, such as S_DAX files on
> pmem, and (for now) blocksize > pagesize filesystems.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Looks good to me. Thanks for the patch!

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
> v6.1: clobber all the ext-specific stuff
> ---
>  common/rc |   25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/common/rc b/common/rc
> index b62e21f778d938..564235ea2e995c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3268,27 +3268,10 @@ _require_scratch_swapfile()
>  	# Minimum size for mkswap is 10 pages
>  	_format_swapfile "$SCRATCH_MNT/swap" $(($(_get_page_size) * 10)) > /dev/null
>  
> -	# ext* has supported all variants of swap files since their
> -	# introduction, so swapon should not fail.
> -	case "$FSTYP" in
> -	ext2|ext3|ext4)
> -		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> -			if _check_s_dax "$SCRATCH_MNT/swap" 1 >/dev/null; then
> -				_scratch_unmount
> -				_notrun "swapfiles are not supported"
> -			else
> -				_scratch_unmount
> -				_fail "swapon failed for $FSTYP"
> -			fi
> -		fi
> -		;;
> -	*)
> -		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> -			_scratch_unmount
> -			_notrun "swapfiles are not supported"
> -		fi
> -		;;
> -	esac
> +	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> +		_scratch_unmount
> +		_notrun "swapon failed for $FSTYP"
> +	fi
>  
>  	swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
>  	_scratch_unmount
>


