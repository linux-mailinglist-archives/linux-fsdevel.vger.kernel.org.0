Return-Path: <linux-fsdevel+bounces-38285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5E29FEC1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 02:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D547118827DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 01:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D17DC8C7;
	Tue, 31 Dec 2024 01:23:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402D224FA;
	Tue, 31 Dec 2024 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735608194; cv=none; b=h8ch27EdFrv1+SM5+Q1K7ZoZ9ov3Cym37L5nqRo1vjyJXiWKdrvupa+rymiu3M3oALUmu13I2xgYFPHGhlP8NuDCzWcL+0Tq164D599GE6y8EIqqBmFOIpG7113eohrErlJLRokrZD8Ld2w8ymq0i4F7GMlVozKffYF/iw/ME48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735608194; c=relaxed/simple;
	bh=ZBL+SkupEXB5vIZIax3BI3gfl2rf7JwdJreL2p3altk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BR1yir4JdRzC6bKh8xw2Fa7WjOiI67DRh63CyufBRlUJ3L7j4uRFvp7SnVwv+sBLtXP1oiimLHLRPVl7Pm1m0ea3lWm7a0Jq6g6Nr3DjDZ+U5aEXUfjl7Zv7KntrHw2lSzcsn0uIj4PBTG+HEMxond8ZN9JpqSukVh0Ezf7368Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YMZw54S6kz4f3lVg;
	Tue, 31 Dec 2024 09:22:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 99E1E1A1253;
	Tue, 31 Dec 2024 09:23:06 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHMYV2R3NncIhxGA--.57590S3;
	Tue, 31 Dec 2024 09:23:04 +0800 (CST)
Message-ID: <c5a04819-e2af-4406-aee6-b5ddec356465@huaweicloud.com>
Date: Tue, 31 Dec 2024 09:23:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xfstests PATCH] generic/567: add partial pages zeroing out case
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: linux-fsdevel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, willy@infradead.org, ojaswin@linux.ibm.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com, fstests@vger.kernel.org, zlang@kernel.org
References: <20241223023930.2328634-1-yi.zhang@huaweicloud.com>
 <7e77d8d1bf4521a727247badd6b6231256abb791.camel@linux.ibm.com>
 <67ae32aa-11e1-4e7f-b911-2546856564c2@huaweicloud.com>
 <a1749e83-9c29-45b7-be4c-bca1a32ee85a@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <a1749e83-9c29-45b7-be4c-bca1a32ee85a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHMYV2R3NncIhxGA--.57590S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFW5Jw17XrWrGF45ZFyUAwb_yoW5AFW7pF
	yfXFyayF4rCr93ur1293WxWryFkw4Syr4UXr13X34rAr4ayw1fKrnFgryvgFykKw48Zw4F
	vws5t34UuF1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/30 12:16, Nirjhar Roy wrote:
> 
> On 12/27/24 13:59, Zhang Yi wrote:
>> On 2024/12/27 13:28, Nirjhar Roy wrote:
>>> On Mon, 2024-12-23 at 10:39 +0800, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> This addresses a data corruption issue encountered during partial
>>>> page
>>>> zeroing in ext4 which the block size is smaller than the page size
>>>> [1].
>>>> Expand this test to include a zeroing range test that spans two
>>>> partial
>>>> pages to cover this case.
>>>>
>>>> Link:
>>>> https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/
>>>>   [1]
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>> ---
>>>>   tests/generic/567     | 50 +++++++++++++++++++++++++--------------
>>>> ----
>>>>   tests/generic/567.out | 18 ++++++++++++++++
>>>>   2 files changed, 47 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/tests/generic/567 b/tests/generic/567
>>>> index fc109d0d..756280e8 100755
>>>> --- a/tests/generic/567
>>>> +++ b/tests/generic/567
>>>> @@ -4,43 +4,51 @@
>>>>   #
>>>>   # FS QA Test No. generic/567
>>>>   #
>>>> -# Test mapped writes against punch-hole to ensure we get the data
>>>> -# correctly written. This can expose data corruption bugs on
>>>> filesystems
>>>> -# where the block size is smaller than the page size.
>>>> +# Test mapped writes against punch-hole and zero-range to ensure we
>>>> get
>>>> +# the data correctly written. This can expose data corruption bugs
>>>> on
>>>> +# filesystems where the block size is smaller than the page size.
>>>>   #
>>>>   # (generic/029 is a similar test but for truncate.)
>>>>   #
>>>>   . ./common/preamble
>>>> -_begin_fstest auto quick rw punch
>>>> +_begin_fstest auto quick rw punch zero
>>>>     # Import common functions.
>>>>   . ./common/filter
>>>>     _require_scratch
>>>>   _require_xfs_io_command "fpunch"
>>>> +_require_xfs_io_command "fzero"
>>>>     testfile=$SCRATCH_MNT/testfile
>>>>     _scratch_mkfs > /dev/null 2>&1
>>> Since this test requires block size < page size, do you think it is a
>>> good idea to hard code the _scratch_mkfs parameters to explicitly pass
>>> the block size to < less than zero? This will require less manipulation
>>> with the local.config file. Or maybe have a _notrun to _notrun the test
>>> if the block size is not less than the page size?
>> Hi, Nirjhar. Thank you for the review!
>>
>> Although the issue we encountered is on the configuration that block
>> size is less than page size, I believe it is also harmless to run this
>> test in an environment where the block size is equal to the page size.
>> This is a quick and basic test.
> Okay makes sense. So with block size equal to page size, the actual functionality that we want to test won't be tested(but the test will pass), is that what you mean?

Yes, this test is very simple and should pass in an environment where
the block size is equal to the page size.

Thanks,
Yi.



