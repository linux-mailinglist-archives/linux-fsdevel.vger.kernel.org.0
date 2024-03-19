Return-Path: <linux-fsdevel+bounces-14787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2109B87F500
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 02:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F97F1C211BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 01:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB7C64CE9;
	Tue, 19 Mar 2024 01:35:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1408D612F6;
	Tue, 19 Mar 2024 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812117; cv=none; b=LTyq0hoCXRfMe5LdPPhgm5EgyoAqtGWmuqL3jxTxy/jwdu7qPdVK5+nQPzFT8bidn64oX5dyO9r+hgswsPGs774ErJNoZxDh8aIijXrACoNVrWzYu0wADbbKlOl9Vn3EwPldUvsBVAu2COkxPGkxx37KNF7b+72Lh0/1x7Ivwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812117; c=relaxed/simple;
	bh=Sd8bclQ/7iS9zW3jBrxs2+6SaQEBr8bQ3OMru9SXT94=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Vo5YK+j8bylyvmD/5JOXSPSCpuPRb15gXaMRWpTYGa9haxO6sw0gxpiHpDDmWnaJhI3Qn/F4khlpT2ZV5bPl2g72UYo/BFdXrAGTw+Kt5OnFNm6D4rWhZNy7UQiOO2bUjXTvUabsStK5Db6f8VbobB4NsT0L44FCO4YKSCwtWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TzDkC3xRJz1Q9nH;
	Tue, 19 Mar 2024 09:32:51 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id C14991400F4;
	Tue, 19 Mar 2024 09:35:05 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 09:35:04 +0800
Subject: Re: [linux-next:master] BUILD REGRESSION
 2e93f143ca010a5013528e1cfdc895f024fe8c21
To: kernel test robot <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Linux Memory Management List <linux-mm@kvack.org>,
	<amd-gfx@lists.freedesktop.org>, <bpf@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <linux-omap@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <202403182219.XrvfZx4s-lkp@intel.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e7ca3f69-7052-616b-68db-f29a66b42edc@huawei.com>
Date: Tue, 19 Mar 2024 09:35:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202403182219.XrvfZx4s-lkp@intel.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/18 22:33, kernel test robot Ð´µÀ:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 2e93f143ca010a5013528e1cfdc895f024fe8c21  Add linux-next specific files for 20240318
> 
> Error/Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> |-- arc-allmodconfig
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
> |-- arc-allyesconfig
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
> |-- arm-allmodconfig
> |   |-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
> |   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
> |-- arm-allyesconfig
> |   |-- arch-arm-mach-omap2-prm33xx.c:warning:expecting-prototype-for-am33xx_prm_global_warm_sw_reset().-Prototype-was-for-am33xx_prm_global_sw_reset()-instead
> |   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
> |-- arm64-defconfig
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
> |-- csky-allmodconfig
> |   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead
> |-- csky-allyesconfig
> |   |-- drivers-gpu-drm-amd-amdgpu-amdgpu_vcn.c:warning:.bin-directive-output-may-be-truncated-writing-bytes-into-a-region-of-size-between-and
> |   `-- fs-ubifs-journal.c:warning:expecting-prototype-for-wake_up_reservation().-Prototype-was-for-add_or_start_queue()-instead

Hi, Richard,
I sent out the warning fix patch in 
https://patchwork.ozlabs.org/project/linux-mtd/patch/20240227024204.1080739-1-chengzhihao1@huawei.com/

