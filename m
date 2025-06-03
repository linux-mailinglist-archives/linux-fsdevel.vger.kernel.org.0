Return-Path: <linux-fsdevel+bounces-50401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EEBACBE0D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 03:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE89B7A6A19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 01:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD4C54BC6;
	Tue,  3 Jun 2025 01:09:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFDBA937
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748912979; cv=none; b=isVgfIgf5Zj1TzHbKyxyHyTbOYPrz2Rh+0UYh25KOz/XLEqyyttHWolkNYGzr+kjD/a1HH39gqa1RJSmAZaB3AN1T+bs/6vpeu6qphVFrPjNFS6tbiMN06ignXG5Ba8k3v6xq0uDozBUe2kNt+ay/uGR6M/2HnlSt+gCsLe6mdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748912979; c=relaxed/simple;
	bh=pSq4Bf/k0G5aUPZpviEVMQnEVr4yH/DTTWWxcqANMbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WEQK12eIOm47VsGcBqj9EgoCpZRIwZNYMPwVhUh0aRDAVzXyuQdL+5TXozKHtwOIrR1DPld/+IufLXSgB44dBWr/MP5Fp1rkEkX2gh6tjaoTdweB2dAw8FX0HE4j5htG5J0AqATQw/bDcyc/oizk8Ln1dMPc9fVLTlqULcQGqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bBCLf31Swz27hcD;
	Tue,  3 Jun 2025 09:10:18 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 63FD11A016C;
	Tue,  3 Jun 2025 09:09:27 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Jun 2025 09:09:26 +0800
Message-ID: <d23c6219-e2e1-4550-a2b3-8ce8f193c3f1@huawei.com>
Date: Tue, 3 Jun 2025 09:09:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] f2fs: new mount API conversion
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	<sandeen@redhat.com>, <linux-fsdevel@vger.kernel.org>
References: <20250602090224.485077-1-lihongbo22@huawei.com>
 <aD3Lzsp-u6KuyGRt@google.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <aD3Lzsp-u6KuyGRt@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/6/3 0:05, Jaegeuk Kim wrote:
> Thanks you, Hongbo.
> 
> I just applied this series to the dev-test branch as below, and will
> keep testing with incoming patches together. Let's see. :)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test
> 
Ok, I will keep following up on this work with Eric.

Thanks,
Hongbo

> On 06/02, Hongbo Li wrote:
>> In this version, we have finished the issues pointed in v3.
>> First, I'd like to express my sincere thanks to Jaegeuk and Chao
>> for reviewing this patch series and providing corrections. I also
>> appreciate Eric for rebasing the patches onto the latest branch to
>> ensure forward compatibility.
>>
>> The latest patch series has addressed all the issues mentioned in
>> the previous set. For modified patches, I've re-added Signed-off-by
>> tags (SOB) and uniformly removed all Reviewed-by tags.
>>
>> v4:
>>    - Change is_remount as bool type in patch 2.
>>    - Remove the warning reported by Dan for patch 5.
>>    - Enhance sanity check and fix some coding style suggested by
>>      Jaegeuk in patch 5.
>>    - Change the log info when compression option conflicts in patch 5.
>>    - Fix the issues reported by code-reviewing in patch 5.
>>    - Context modified in patch 7.
>>
>> V3: https://lore.kernel.org/all/20250423170926.76007-1-sandeen@redhat.com/
>> - Rebase onto git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
>>    dev branch
>> - Fix up some 0day robot warnings
>>
>> (Here is the origianl cover letter:)
>>
>> Since many filesystems have done the new mount API conversion,
>> we introduce the new mount API conversion in f2fs.
>>
>> The series can be applied on top of the current mainline tree
>> and the work is based on the patches from Lukas Czerner (has
>> done this in ext4[1]). His patch give me a lot of ideas.
>>
>> Here is a high level description of the patchset:
>>
>> 1. Prepare the f2fs mount parameters required by the new mount
>> API and use it for parsing, while still using the old API to
>> get mount options string. Split the parameter parsing and
>> validation of the parse_options helper into two separate
>> helpers.
>>
>>    f2fs: Add fs parameter specifications for mount options
>>    f2fs: move the option parser into handle_mount_opt
>>
>> 2. Remove the use of sb/sbi structure of f2fs from all the
>> parsing code, because with the new mount API the parsing is
>> going to be done before we even get the super block. In this
>> part, we introduce f2fs_fs_context to hold the temporary
>> options when parsing. For the simple options check, it has
>> to be done during parsing by using f2fs_fs_context structure.
>> For the check which needs sb/sbi, we do this during super
>> block filling.
>>
>>    f2fs: Allow sbi to be NULL in f2fs_printk
>>    f2fs: Add f2fs_fs_context to record the mount options
>>    f2fs: separate the options parsing and options checking
>>
>> 3. Switch the f2fs to use the new mount API for mount and
>> remount.
>>
>>    f2fs: introduce fs_context_operation structure
>>    f2fs: switch to the new mount api
>>
>> [1] https://lore.kernel.org/all/20211021114508.21407-1-lczerner@redhat.com/
>>
>> Hongbo Li (7):
>>    f2fs: Add fs parameter specifications for mount options
>>    f2fs: move the option parser into handle_mount_opt
>>    f2fs: Allow sbi to be NULL in f2fs_printk
>>    f2fs: Add f2fs_fs_context to record the mount options
>>    f2fs: separate the options parsing and options checking
>>    f2fs: introduce fs_context_operation structure
>>    f2fs: switch to the new mount api
>>
>>   fs/f2fs/super.c | 2108 +++++++++++++++++++++++++++--------------------
>>   1 file changed, 1197 insertions(+), 911 deletions(-)
>>
>> -- 
>> 2.33.0

