Return-Path: <linux-fsdevel+bounces-68013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B33C50B91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 07:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BD43B3C7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 06:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7B02DC349;
	Wed, 12 Nov 2025 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jK/Gq9Wt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A3A930;
	Wed, 12 Nov 2025 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929346; cv=none; b=CbuFSxQPS10admeSC2VKC/W3qBauQGejzSxSY7MAFxEfGpXLbFiD+UKIo0dOmClacmn6QuCz53xKkJdjLE3o5Rx7FnW0URwKks4ionc5FRYaGalOT9iUrGEYVermoNodDHiTGb5yNDlSw9Sb1t5KnWlErbaZtOfSKeHN8am31dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929346; c=relaxed/simple;
	bh=jf8dwyp0nOX2jtx539Chlac7QL2kjFbV8DV/XwPW/qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ByqlGL3Z26TpockG7VgtReOMcWgMjvQb+2zngmD/wvnXDQ7VW4RB++d4jw3mXEGmbpa43kqguoPXjRx+Z1VLS5KOLQ5T5rdi/saGvB4yxtcxBV+ws5i2ezGfy4U767id6aNVokaNVQR5o+hteYdXDriCOWPK0QvEfpC+qp2DlcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jK/Gq9Wt; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FGO52PsT+0ThsDQnaUxaYwIXlR/u7jOJryOlPZ3yA1M=;
	b=jK/Gq9Wt3zm6Ywf6JCsROBjf/7oriWFSZ8i8GyrnvyC9CYZd6l1KyIoJYWYrW+WHky4PMkdHI
	D0AOvzXxVDlpgEkce1UaAtPCwA3PUiBtUPIJAaUYxLUJivJZE0fMPePU7LaVc1y6agngxGRDFOi
	484uXKPeBZXvBUqeCuGoQu8=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d5tsQ66zvz12LDD;
	Wed, 12 Nov 2025 14:34:02 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 738F2180B63;
	Wed, 12 Nov 2025 14:35:34 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Nov
 2025 14:35:33 +0800
Message-ID: <016f51ff-6129-4265-827e-3c2ae8314fe1@huawei.com>
Date: Wed, 12 Nov 2025 14:35:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/33] common/rc: skip test if swapon doesn't work
Content-Language: en-GB
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <zlang@redhat.com>, <neal@gompa.dev>, <fstests@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<joannelkoong@gmail.com>, <bernd@bsbernd.com>, Baokun Li
	<libaokun1@huawei.com>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820051.1433624.4158113392739761085.stgit@frogsfrogsfrogs>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <176169820051.1433624.4158113392739761085.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Hi Darrick,

On 2025-10-29 09:21, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>
> In _require_scratch_swapfile, skip the test if swapon fails for whatever
> reason, just like all the other filesystems.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/rc |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> diff --git a/common/rc b/common/rc
> index 18d11e2c5cad3a..98609cb6e7a058 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3278,7 +3278,7 @@ _require_scratch_swapfile()
>  				_notrun "swapfiles are not supported"
>  			else
>  				_scratch_unmount
> -				_fail "swapon failed for $FSTYP"
> +				_notrun "swapon failed for $FSTYP"
>  			fi
>  		fi
>  		;;

Could you also clean up the corresponding comments?

    # ext* has supported all variants of swap files since their
    # introduction, so swapon should not fail.

At present, swap files don’t support block sizes greater than the page
size, which means swapon will fail when LBS is enabled.


Thanks,
Baokun


