Return-Path: <linux-fsdevel+bounces-18894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826B08BE0D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 13:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B411A1C2334F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 11:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFED152162;
	Tue,  7 May 2024 11:20:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448261509A6;
	Tue,  7 May 2024 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080819; cv=none; b=L6d5Y6EUazdjkr/CObEF4Or3t/vxhH4t6c4/EQ8JDtoP8+mncI28Kxbii6Pe3XIrjCGC6bPQSgubXWgE9l/QrXULTJuNQtckMYs5E3ZiSFewU2KXc9gy0W+A5nXTrvf9GBOIZoUgSbukTsJolHLWQUnOw9CA3eBbc9mOtB0nbrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080819; c=relaxed/simple;
	bh=XJb5env3w+A8FoPLlKR4k/O4kmKTVVipdBC1VV39X5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkSpr3pyeVa3gSJ5jvCkF3LXTdFkHC5fbHcJZIyR2Sde66P81rmbLb93yiC8Jah4Zgx9/HdMr4IkWLrL20J+W5ge6LaKLVdT5UxhPlCAln+1OzRJn1n7ytTaa2zApb0TP2kDflReE62eDTSje8g+nKdCv8YHBpE5cLN2oraXTtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VYbRC1qdrz4f3kpS;
	Tue,  7 May 2024 19:20:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 86B5A1A0572;
	Tue,  7 May 2024 19:20:12 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBFoDjpmOyUEMA--.18524S3;
	Tue, 07 May 2024 19:20:12 +0800 (CST)
Message-ID: <a6d89482-6f81-29d1-3e9f-4772ffbb56af@huaweicloud.com>
Date: Tue, 7 May 2024 19:20:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/5] cachefiles: some bugfixes for withdraw and xattr
Content-Language: en-US
To: netfs@lists.linux.dev, dhowells@redhat.com, jlayton@kernel.org
Cc: linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun <yangerkun@huawei.com>, libaokun@huaweicloud.com
References: <20240424032732.2711487-1-libaokun@huaweicloud.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240424032732.2711487-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBFoDjpmOyUEMA--.18524S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy5Kr17Wr4fKryUWw4kWFg_yoW8Ww4DpF
	Wayr4ayry8W397Gwn3ArsxJr1rA393JF1vgw17Wr1DAwn5Xr1YqryIyr15ZFyUuryUGws3
	t3WjgFy3Ww1UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
	UUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

Hi David,
Hi Jeff,

Could you please take time to take a look at this series?  I'd 
appreciated it
if I could get some feedback and comments.

Thanks,
Baokun

On 2024/4/24 11:27, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
>
> Hello everyone!
>
> Recently we found some bugs while doing tests on cachefiles ondemand mode,
> and this patchset is a fix for some of those issues. The following is a
> brief overview of the patches, see the patches for more details.
>
> Patch 1-2: Add fscache_try_get_volume() helper function to avoid
> fscache_volume use-after-free on cache withdrawal.
>
> Patch 3: Fix cachefiles_lookup_cookie() and cachefiles_withdraw_cache()
> concurrency causing cachefiles_volume use-after-free.
>
> Patch 4-5: Propagate error codes returned by vfs_getxattr() to avoid
> endless loops.
>
> Comments and questions are, as always, welcome.
>
> Thanks,
> Baokun
>
> Baokun Li (5):
>    netfs, fscache: export fscache_put_volume() and add
>      fscache_try_get_volume()
>    cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
>    cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
>    cachefiles: correct the return value of
>      cachefiles_check_volume_xattr()
>    cachefiles: correct the return value of cachefiles_check_auxdata()
>
>   fs/cachefiles/cache.c          | 45 +++++++++++++++++++++++++++++++++-
>   fs/cachefiles/volume.c         |  1 -
>   fs/cachefiles/xattr.c          |  5 +++-
>   fs/netfs/fscache_volume.c      | 14 +++++++++++
>   fs/netfs/internal.h            |  2 --
>   include/linux/fscache-cache.h  |  6 +++++
>   include/trace/events/fscache.h |  4 +++
>   7 files changed, 72 insertions(+), 5 deletions(-)
>


