Return-Path: <linux-fsdevel+bounces-8757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AAE83AB04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA1C1C21B54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A2777F18;
	Wed, 24 Jan 2024 13:38:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4348BE1;
	Wed, 24 Jan 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103535; cv=none; b=BpC/lKyDbkix8qIZfJcsU13PdJ+BtRJnVAnxyaBadd+m1uxLNyqirTQSwBngAMibckKNixGgBbi9bTDaQEGwZTeMHwkczJ1ay382m63dBNsTFU6TWQGfD+fP1scm5S3K/GzbWQO05pU21V2fMjrcuQw9p9IxinPJ+uiyeL12Ktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103535; c=relaxed/simple;
	bh=h18dF1XWNpNzYO06Da4D5AMzQ2A4VrPat2l+QQOyc80=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jcb+/wYRtLjrtprqnVebKY+b4qu4NA7tPJAFVopgm2eYkTOPu9iyIShkJTs5irzAGObzuIctNdStZbKH2l8nlWbec3HOmGaBd241HryzoIzQa2VvKKEhABLnUqutTFppo75u/pZuph8EZL40nT3cSxPCq9JaBvqQVl7ugEMm6CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TKlQF1npKzNlVc;
	Wed, 24 Jan 2024 21:37:57 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 411B0180073;
	Wed, 24 Jan 2024 21:38:50 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 21:38:49 +0800
Message-ID: <098f69f5-524b-9ddd-3d07-5e5c04135fcb@huawei.com>
Date: Wed, 24 Jan 2024 21:38:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [brauner-vfs:vfs.misc 12/13] include/linux/fs.h:911:9: error:
 call to '__compiletime_assert_207' declared with 'error' attribute: Need
 native word sized stores/loads for atomicity.
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot
	<lkp@intel.com>, <sfr@canb.auug.org.au>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, Christian Brauner
	<christianvanbrauner@gmail.com>, yangerkun <yangerkun@huawei.com>, "zhangyi
 (F)" <yi.zhang@huawei.com>, <linux-next@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <202401230837.TXro0PHi-lkp@intel.com>
 <59fae3eb-a125-cd5f-224e-b89d122ecb46@huawei.com>
 <20240123-glatt-langgehegter-a239e588ae2c@brauner>
 <2abc7cc4-72eb-33c9-864a-9f527c0273d3@huawei.com>
 <20240124-abbaggern-oblag-67346f8dee9f@brauner>
 <bf9b8a90-7ace-5f14-e585-8cc467f4d611@huawei.com>
 <20240124-warnhinweis-servolenkung-e482feb8fc43@brauner>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240124-warnhinweis-servolenkung-e482feb8fc43@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/1/24 21:27, Christian Brauner wrote:
>> If CONFIG_SMP is not enabled in include/asm-generic/barrier.h,
>> then smp_load_acquire/smp_store_release is implemented as
>> READ_ONCE/READ_ONCE and barrier() and type checking.
>> READ_ONCE/READ_ONCE already checks the pointer type,
>> but then checks it more stringently outside, but here the
>> more stringent checking seems unnecessary, so it is removed
>> and only the type checking in READ_ONCE/READ_ONCE is kept
>> to avoid compilation errors.
> Maha, brainfart on my end, I missed the !CONFIG_SMP case.
> Sorry about that.
Never mind. 😊
>> When CONFIG_SMP is enabled on 32-bit architectures,
>> smp_load_acquire/smp_store_release is not called in i_size_read/write,
>> so there is no compilation problem. On 64-bit architectures, there
>> is no compilation problem because sizeof(long long) == sizeof(long),
>> regardless of whether CONFIG_SMP is enabled or not.
> Yes, of course.
>
>> Yes, using smp_rmb()/smp_wmb() would also solve the problem, but
>> the initial purpose of this patch was to replace smp_rmb() in filemap_read()
>> with the clearer smp_load_acquire/smp_store_release, and that's where
>> the community is going with this evolution. Later on, buffer and page/folio
>> will also switch to acquire/release, which is why I think Linus' suggestion
>> is better.
> Ah ok, thanks for the context. Can you send an updated series then, please?
>
No problem, I'll send a new version soon!

Cheers!
-- 
With Best Regards,
Baokun Li
.

