Return-Path: <linux-fsdevel+bounces-4949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D4B8069C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 09:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10911281BBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE55B1A271
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:37:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D71B5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 23:22:54 -0800 (PST)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SlTJK4zBTz14Lmf;
	Wed,  6 Dec 2023 15:17:53 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 15:22:51 +0800
Subject: Re: [PATCH] ubifs: fix kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, <linux-fsdevel@vger.kernel.org>
CC: kernel test robot <lkp@intel.com>, Richard Weinberger <richard@nod.at>,
	<linux-mtd@lists.infradead.org>
References: <20231206024850.31425-1-rdunlap@infradead.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <4e69f73a-3327-681c-ea16-ca1297769f24@huawei.com>
Date: Wed, 6 Dec 2023 15:22:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231206024850.31425-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected

ÔÚ 2023/12/6 10:48, Randy Dunlap Ð´µÀ:
> Fix kernel-doc warnings found when using "W=1".
>
> file.c:1385: warning: Excess function parameter 'time' description in 'ubifs_update_time'
> and 9 warnings like this one:
> file.c:326: warning: No description found for return value of 'allocate_budget'
>
> auth.c:30: warning: expecting prototype for ubifs_node_calc_hash(). Prototype was for __ubifs_node_calc_hash() instead
> and 11 warnings like this one:
> auth.c:30: warning: No description found for return value of '__ubifs_node_calc_hash'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202312030417.66c5PwHj-lkp@intel.com/
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-mtd@lists.infradead.org
> ---
> This does not Close: the report kernel robot report since there is
> also a missing-prototype warning in it.
>
>   fs/ubifs/auth.c |   28 ++++++++++++++++------------
>   fs/ubifs/file.c |   30 +++++++++++++++++++++---------
>   2 files changed, 37 insertions(+), 21 deletions(-)
>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>


